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

import org.aspectj.lang.JoinPoint;

import sim.instrumentation.aop.aspectj.AbstractContextWriter;
import sim.instrumentation.data.ContextManager;

/**
 * @author mcq
 *
 */
public aspect PluginWriteToContext extends AbstractContextWriter {

	public pointcut placeToTriggerTheContextWrite(): within(eu.larkc.plugin.Plugin) && execution(* invoke(..));

	@Override
	protected void beforeInvoke(JoinPoint jp) {
		Object thiz = jp.getThis();
		String pluginName = null;
		try {
			pluginName = thiz.getClass().getMethod("getIdentifier").invoke(thiz).toString();
		} catch (Exception e) {
			pluginName = "unknown";
		}
		ContextManager.getCurrentContext().put("pluginName", pluginName);
	}

	@Override
	protected void afterReturningInvoke(JoinPoint jp, Object result) {}

	@Override
	protected void afterInvoke(JoinPoint jp) {}
}
