package com.azure.api;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Iterator;
import java.util.zip.InflaterInputStream;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class AzureML {

    public static String apiurl;
    public static String apikey;
    public static String cluster = "";
    // Calling random Forest model
    public String callDecisionForestService(String json) {
        System.out.println("calling random forest model: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/deb69ad458184ce982bc2650d41d42cc/execute?api-version=2.0&details=true";
        apikey = "HyynDYZmvPAMleO8gb3VxnDDDA3i/n/nNH93XWHHYQeeMAQJWdSDt0AYcrgYAMy81xnAPcaCoDwVlLJ2fOKKbg==";

        String result = rrsHttpPost(json);
        return retrieveOutput(result);
    }

    // Calling Neural network model
    public String callNeuralNetworkService(String json) {
        System.out.println("calling neural network model: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/b13dc49075c24198a32644ba37340356/execute?api-version=2.0&details=true";
        apikey = "72UP4e77UAJTCzqpbwCmRmRUDB5IXeXF9tIFs+mUwy4sXyMg7sRZ1whTXdpmrsxeQEFQTzX0SQE8ypiUEldnOA==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }

    // Calling Logistic Regression model 
    public String callLogisticRegression(String json) {
        System.out.println("calling decision jungle model: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/2eff52dc4030431da44639fc08fa2a2a/execute?api-version=2.0&details=true";
        apikey = "eFlDp+9i+rhZlqQ7L3Fo5n+NKwyP8zHlWONid6ioSbcTbQQvFWB8MyNdpkxXcZLDrRsEW94ljR8IVayu96AnfA==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }

    public String callKnnClassification(String json) {
        System.out.println("calling decision jungle model: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/84ebfefba3d9403ebf9ae67acaff1689/services/6a890cc318824097bb004e11fd7776db/execute?api-version=2.0&details=true";
        apikey = "AlntI39DPDbU7rXTrsszbNPavuJ97homXkDxWfD7yVOIZlD7YPdxUuSeMNE8Wz2YAxqzYCUGppfQbs3gDKN5jA==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }

    public String callRandomForestPred(String json) {
        System.out.println("calling random forest for prediction: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/6b933a8b3999465bac3827fb9e33edd3/execute?api-version=2.0&details=true";
        apikey = "cn7nFj8yYG6+leF44q5Em5iWqs6F/jiRHdCGIqu8VjEUdA9XEkkTMeGZwrT+5NovLzMgSS1+jO5AZdR+UkigCQ==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }

    public String callRegressionTreePred(String json) {
        System.out.println("calling random forest for prediction: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/5235a4243ff545f5904445a2758e8d90/execute?api-version=2.0&details=true";
        apikey = "2Qjx/2bqO/IqUpCmLAsvFgF5enn8JYtz81mxJuBmq/+lWDHz/fqoi/ZYU0KWgmbnIaWR47kFgW3mEpF07WNnOg==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }

    public String callNeuralNetworkPrediction(String json) {
        System.out.println("calling random forest for prediction: ");

        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/186bb90260dc4076828b9eb47a6149b1/execute?api-version=2.0&details=true";
        apikey = "NkvPqSDGCl7gnGA7x2GID+UWWXkdE7Ltw60tBe5eM5KVWCV9YXlQ7ThDkiXwHnt0fBOg9CTyi0jpary4eS5qGA==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }
    
     public String callKMeansClustering(String json) {
        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/8eeae68a4b6f4df09cf8a72c34829b83/execute?api-version=2.0&details=true";
        apikey = "9wOf1El2eTmIrk62hbHdeR7vDPoCMMdD7uaIorOBbB6+p7yHoaztMRYWlu2qGaceo46iKBnELk250kFdXAfZbQ==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }
     public String callKnnPrediction(String json) {
        apiurl = "https://ussouthcentral.services.azureml.net/workspaces/50192ead28c24695aa7ba6c246694fc8/services/186bb90260dc4076828b9eb47a6149b1/execute?api-version=2.0&details=true";
        apikey = "NkvPqSDGCl7gnGA7x2GID+UWWXkdE7Ltw60tBe5eM5KVWCV9YXlQ7ThDkiXwHnt0fBOg9CTyi0jpary4eS5qGA==";

        String input = rrsHttpPost(json);
        return retrieveOutput(input);
    }
    /**
     * Call REST API for retrieving prediction from Azure ML
     *
     * @return response from the REST API
     */
    public String rrsHttpPost(String jsonBody) {

        HttpPost post;
        HttpClient client;
        StringEntity entity;

        try {

            // create HttpPost and HttpClient object
            post = new HttpPost(apiurl);
            client = HttpClientBuilder.create().build();

            // setup output message by copying JSON body into 
            // apache StringEntity object along with content type
            entity = new StringEntity(jsonBody, HTTP.UTF_8);
            entity.setContentEncoding(HTTP.UTF_8);
            entity.setContentType("text/json");

            // add HTTP headers
            post.setHeader("Accept", "text/json");
            post.setHeader("Accept-Charset", "UTF-8");

            // set Authorization header based on the API key
            post.setHeader("Authorization", ("Bearer " + apikey));
            post.setEntity(entity);

            // Call REST API and retrieve response content
            HttpResponse authResponse = client.execute(post);

            return EntityUtils.toString(authResponse.getEntity());

        } catch (Exception e) {
            System.out.println("Error occurred while calling the service!!");
            return e.toString();
        }
    }

    public String retrieveOutput(String input) {

        try {
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(input);

            JSONObject json = (JSONObject) obj;

            JSONObject result = (JSONObject) json.get("Results");
            System.out.println(json.get("Results"));

            JSONObject output1 = (JSONObject) result.get("output1");
            System.out.println(result.get("output1"));

            JSONObject value = (JSONObject) output1.get("value");
            System.out.println(output1.get("value"));

            String res = null;
            JSONArray strArray = (JSONArray) value.get("Values");
            Iterator<Object> itr = strArray.iterator();

            while (itr.hasNext()) {
                res = itr.next().toString();
                break;
            }

            StringBuilder sb = new StringBuilder();
            sb.append(res);

            String s = res.substring(2, sb.indexOf("]"));

            String output = s.substring(0, s.lastIndexOf('"'));

            System.out.println(output);
            return output;
        } catch (Exception e) {
            System.out.println("Error while parsing output!!");
            e.printStackTrace();;
        }

        return null;
    }
}
