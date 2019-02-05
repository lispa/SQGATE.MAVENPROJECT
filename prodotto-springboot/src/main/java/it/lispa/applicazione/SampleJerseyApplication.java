/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *    
 *    
 *    www.lispa.it
 */

package it.lispa.applicazione;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
//import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication
public class SampleJerseyApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		new SampleJerseyApplication().configure(new SpringApplicationBuilder(SampleJerseyApplication.class)).run(args);
	}

}
