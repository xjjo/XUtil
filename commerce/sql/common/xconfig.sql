DECLARE
nCount2 NUMBER;
v_sql2 LONG;
v_sql3 LONG;
v_desc VARCHAR2(256);
v_xconf_val VARCHAR2(256);
v_xconf_cc_integration VARCHAR2(256);
v_decidir_to_localhost BOOLEAN;
BEGIN
       --v_xconf_cc_integration:= ('DecidirRestNoPCI' !!  DecidirSOAP);
       v_xconf_cc_integration:='DecidirSOAP';   
       --Mover endpoints de decidir a local?
       v_decidir_to_localhost:=true;
       
       -- payment claro services
       v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/ecom-service/ECommerceService' WHERE NAME LIKE '%CLARO_END%']';
       execute immediate v_sql2;
       
     
         
       -- payment decidir rest nopci services
      -- v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'https://alcalde.claro.amx/webapp/wcs/stores/servlet/FormPaymentAPIView?catalogId=10152&langId=-5&storeId=10051' WHERE NAME LIKE '%DECIDIR_REST_ENDPOINT_NOPCI_GETTOKEN%']';
       -- execute immediate v_sql2;
       
       -- payment veraz services
       v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/WsIDValidator/services/idvalidator' WHERE NAME LIKE '%VERAZ_END%']';
        execute immediate v_sql2;
        
       -- claro dni        
       v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/ecom-service/ECommerceService' WHERE NAME LIKE '%CLARO_ECOMMERCE_SERVICE_SOAP_BINDING%']';
        execute immediate v_sql2;

        -- claro login
        v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/csc-login/LoginService' WHERE  NAME LIKE '%CLARO_LOGIN_SERVICE_ADDRESS%']';
         execute immediate v_sql2;
        
        -- claro errorHandler
        v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/error-handling/ErrorHandlingService?WSDL' WHERE  NAME LIKE '%CLARO_WS_ENDPOINT_ERROR_HANDLING%']';
         execute immediate v_sql2;
        
        -- claro planInfo        
        v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:8089/csc-hiredplan/hired-plan/info-plan' WHERE  NAME LIKE '%CLARO_LEGACY_PLAN_SERVICE_ADDRESS%']';
         execute immediate v_sql2;    
        
        ----------------------------------------------DECIDIR_START------------------------------------------------
         IF (v_decidir_to_localhost) THEN
		         --Decidir Rest Endpoint
		        v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://Administrador01:8079/api/v1/payments' WHERE NAME LIKE '%DECIDIR_REST_EXECUTE_PAYMENT_ENDPOINT%']';
		         execute immediate v_sql2;    
		        
		       -- payment decidir services (SOAP)
		       v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9001/services/t/1.1/Authorize.AuthorizeHttpSoap11Endpoint' WHERE NAME LIKE '%DECIDIR_END%']';
		       execute immediate v_sql2;
		       
		        -- Decidir Operation (SOAP)
		        v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:9002/services/t/1.1/Operation' WHERE NAME = 'DECIDIR_GET_OPERATION_ENDPOINT']';
		        execute immediate v_sql2;   
		        
		         IF (v_xconf_cc_integration ='DecidirRestNoPCI' ) THEN
			         --decidir js for RestNoPCI integration 
			           v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:8080/static/v2/decidir.js' WHERE NAME LIKE '%DECIDIR_JAVASCRIPT%']';
		         ELSE
		           --decidir js for soap integration 
			       v_sql2:=q'[UPDATE COMMERCE.XCONFIG SET VALUE = 'http://localhost:8080/custom/callback/1.1/payment.js' WHERE NAME LIKE '%DECIDIR_JAVASCRIPT%']';
		         END IF; 
			     execute immediate v_sql2;
	    END IF; 
    ----------------------------------------------DECIDIR_END------------------------------------------------
END;

