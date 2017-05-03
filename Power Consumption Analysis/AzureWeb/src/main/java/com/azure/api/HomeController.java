package com.azure.api;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

    final static String apikey = "GeG32HHijMlWdeIa/JcaV7QKFbpoezpaNXHib3+mEep+1xAcyO1vlwSC9GOatsmxfyrt+prrA55+1vbjkyah9g==";
    final static String apiurl = "https://ussouthcentral.services.azureml.net/workspaces/253767f4788549c1baaad7723c456e77/services/27e620cbde5548348d16c1ae1653e560/execute?api-version=2.0&details=true";
    public static String jsonBody;

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        return "index";
    }

    @RequestMapping(value = "/service", method = RequestMethod.POST)
    public ModelAndView service(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        int hour = Integer.parseInt(request.getParameter("hours"));
        int day = Integer.parseInt(request.getParameter("days"));
        int month = Integer.parseInt(request.getParameter("month"));
        Calendar c = Calendar.getInstance();
        //Date date = new Date();
        int year = 2013;
        String desc_cluster = "";
        c.set(year, month - 1, day);
        System.out.println("" + c.getTime());
        int dayofweek = c.get(Calendar.DAY_OF_WEEK);
        System.out.println("" + dayofweek);
        //int consumption = Integer.parseInt(request.getParameter("consumption"));
        //int floor_area_per_meter_sq = Integer.parseInt(request.getParameter("floor_area_per_meter_sq"));
        String temp = request.getParameter("temperature");
        double temperature = Double.parseDouble(temp);
        String model = request.getParameter("classification");
        int monthnumber = -1;         
        String jsonBody = null;
        String jsonBody_cluster = null;
        String model_name = request.getParameter("classification");
        JSONArray allValues = new JSONArray();
        JSONArray value = new JSONArray();
        JSONObject obj = new JSONObject();
        JSONObject inputs = new JSONObject();
        JSONObject input = new JSONObject();
        JSONArray columnName = new JSONArray();
        double kwh_per_sq_meter = 0;
        if (model_name.equals("random_prediction") || model_name.equals("regression_prediction") || model_name.equals("neural_prediction")||
            model_name.equals("knn_prediction")    ) {
             
            columnName.add("hour");
            columnName.add("Month");
            columnName.add("Day");
            columnName.add("Day of Week");
            columnName.add("kwh_per_meter_sq");
            columnName.add("TemperatureF");
            value.add(hour);
            value.add(monthnumber);
            value.add(day);
            value.add(dayofweek);
            value.add(kwh_per_sq_meter);
            value.add(temperature);
        } else {
           double consumption = Double.parseDouble(request.getParameter("consumption"));
            String base_hr_class = "LOW";
            int base_hr_class_int = 0;
            columnName.add("hour");
            columnName.add("Month");
            columnName.add("Day");
            columnName.add("Day of Week");
            columnName.add("base_hr_class");
            columnName.add("TemperatureF");
            columnName.add("Consumption");
            value.add(hour);
            value.add(monthnumber);
            value.add(day);
            value.add(dayofweek);
            if (model_name.equals("knn_class")) {
                value.add(base_hr_class_int);
            } else {
                value.add(base_hr_class);
            }
            value.add(temperature);
            value.add(consumption);
        }

        allValues.add(value);
        input.put("ColumnNames", columnName);
        input.put("Values", allValues);
        inputs.put("input1", input);
        obj.put("Inputs", inputs);

        System.out.println("print the value of json " + obj);

        //converting json to string
        jsonBody = obj.toString();
        //}
        //catch(Exception e) {
        //	System.out.println("Error occurred!!" + e);
        //}		

        //Creating instance of azure class
        AzureML am = new AzureML();

        String res = null;
        System.out.println("Model: " + model);

        if (model.equals("forest_class")) {
            res = am.callDecisionForestService(jsonBody);
        } else if (model.equals("neural_class")) {
            res = am.callNeuralNetworkService(jsonBody);
        } else if (model.equals("logistic_class")) {
            res = am.callLogisticRegression(jsonBody);
        } else if (model.equals("random_prediction")) {
            res = am.callRandomForestPred(jsonBody);
        } else if (model.equals("regression_prediction")) {
            res = am.callRegressionTreePred(jsonBody);
            
        } else if (model.equals("neural_prediction")) {
            res = am.callNeuralNetworkPrediction(jsonBody);
        } else if (model.equals("knn_class")) {
            res = am.callKnnClassification(jsonBody);
        }else if (model.equals("kmeans")){
            res = am.callKMeansClustering(jsonBody);
        }else if (model.equals("knn_prediction")){
            res = am.callKnnPrediction(jsonBody);
        }
        
        if (res != null) {
            System.out.println("Result of web service :" + res);
            String delims = "[,]";
            String[] tokens = res.split(delims);
            String desc = "";
            String output = "";
            if (tokens.length > 1) {
                output = tokens[6];
            } else {
                output = tokens[0];
            }
            
            if (model_name.equals("random_prediction") || model_name.equals("regression_prediction") || model_name.equals("neural_prediction")||
                model_name.equals("knn_prediction")) {
                output = output.replace("\"","");
                output = output.replace("\"","");
                double out = Double.parseDouble(output);
                DecimalFormat df = new DecimalFormat("#.00000");
                String out1 = df.format(out);
                desc = out1;
                kwh_per_sq_meter = Double.parseDouble(output);
                JSONArray allValues_cluster = new JSONArray();
                JSONArray value_cluster = new JSONArray();
                JSONObject obj_cluster = new JSONObject();
                JSONObject inputs_cluster = new JSONObject();
                JSONObject input_cluster = new JSONObject();
                JSONArray columnName_cluster = new JSONArray();
                columnName_cluster.add("hour");
                columnName_cluster.add("Month");
                columnName_cluster.add("Day");
                columnName_cluster.add("Day of Week");
                columnName_cluster.add("kwh_per_meter_sq");
                columnName_cluster.add("TemperatureF");
                value_cluster.add(hour);
                value_cluster.add(monthnumber);
                value_cluster.add(day);
                value_cluster.add(dayofweek);
                value_cluster.add(kwh_per_sq_meter);
                value_cluster.add(temperature);
                allValues_cluster.add(value_cluster);
                input_cluster.put("ColumnNames", columnName_cluster);
                input_cluster.put("Values", allValues_cluster);
                inputs_cluster.put("input1", input_cluster);
                obj_cluster.put("Inputs", inputs_cluster);
                jsonBody_cluster = obj_cluster.toString();
                res = am.callKMeansClustering( jsonBody_cluster);
                delims = "[,]";
                tokens = res.split(delims);
                tokens[7] = tokens[7].replace("\"", "");
                tokens[8] = tokens[8].replace("\"", "");
                tokens[9] = tokens[9].replace("\"", "");
                tokens[7] = tokens[7].replace("\"", "");
                tokens[8] = tokens[8].replace("\"", "");
                tokens[9] = tokens[9].replace("\"", "");
                double cluster_0 = Double.parseDouble(tokens[7]);
                double cluster_1 = Double.parseDouble(tokens[8]);
                double cluster_2 = Double.parseDouble(tokens[9]);
                double min = cluster_0 ;
                 desc_cluster = "Cluster 1";
                  if(min > cluster_1 && cluster_2 > cluster_1)
                {
                    min =  cluster_1;
                    desc_cluster = "Cluster 2";
                 }
                    else
                 {
                    min = cluster_2;
                    desc_cluster = "Cluster 3";
                 }
             
            }
             else{
                 output = tokens[7]; 
                 output = output.replace("\"","");
                 output = output.replace("\"","");
               if (output.equals("HIGH") || output.equals("1")) {
                   desc = "HIGH";
               } else if (output.equals("LOW") || output.equals("0")) {
                   desc = "LOW";
               }
            }
          
            mv.addObject("output", desc);
            mv.addObject("output_cluster",desc_cluster);
        } else {
            System.out.println("Error thrown by web service call!!");
            mv.addObject("error", "invalid");
            return mv;
        }

        return mv;
    }
}
    



