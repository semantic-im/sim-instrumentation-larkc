/*
 * This file is part of the LarKC platform http://www.larkc.eu/
 *
 *  Copyright 2010 LarKC project consortium
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package sim.instrumentation.aop.aspectj.larkc;

import java.util.UUID;

import org.aspectj.lang.JoinPoint;

import sim.instrumentation.aop.aspectj.AbstractMethodInterceptor;
import sim.instrumentation.data.ExecutionFlowContext;

/**
 * @author mcq
 *
 */
public aspect InstrumentQuery extends AbstractMethodInterceptor {

	public pointcut methodExecution(): within(eu.larkc.core.endpoint.sparql.SparqlHandler) && execution(* handle(..));
	
	protected void beforeInvoke(JoinPoint jp) {
		ExecutionFlowContext.createNewContext().
			put("queryid", UUID.randomUUID().toString()).
			put("tag", "query").
			put("name", "QueryTotal");
	} 

	protected void afterInvoke() {
		ExecutionFlowContext.destroyCurrentContext();
	} 
}