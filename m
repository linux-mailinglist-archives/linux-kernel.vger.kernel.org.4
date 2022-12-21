Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BFE6532FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiLUPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiLUPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:11:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E240C240AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:11:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w15so15228818wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw2F6YBCyWT6LrHFf8PAgZA6IxYBs+l4kXWh41DccKU=;
        b=nygxj8xgrHsjfwwGV6oH0HeqGlPTpkeXTB47Z9H8Af/zqFEHuOBweqzlaGkG9dZzLF
         4u+9zjGsQifpSdQnZOCqZVsMcDh4l6p+fzdi1XQNHQljI/rpj1RvpC5WPf6onrkOkCed
         DIlLPyFzCZzABGX0CvD9QykMjvuFmO50B8eaw+xi389TkJ/wMFSIBylYoV1tQRSxPzkQ
         6iu9ubzseQsXbyaRN7HRW1bDTBNE21f0ycRofOmIRkEKhUlMFXAbImd+gX4FfydtEKmr
         N9bpUY2o0+jo1vre87NQW67XI2h3Bk1rJzWPLPHMITfSG0aU5zcYm3awD28bKSezZ7zy
         uB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw2F6YBCyWT6LrHFf8PAgZA6IxYBs+l4kXWh41DccKU=;
        b=Aj3JJneVm/Lmmi0XN8z1q+zoLWP+fCYoFgU8jz+gYCei/frnSvo/lU0+sq6H9sse0N
         5mLOjTu7DbKyKI4amc18yErraDS+JSo0lMTlyO7quDGbUsbB2TZmBilsXvEOGyz0VDt/
         sWhqI9a0ccTXucD2ycVMmiwfasJeZg8t1JxrsTnH52OY8MG//9o0BGXm09JZUQwF3PI3
         NG4ueLIBeDuApXxY0Wfv0v69ZYKu0uB60kx+LjDqBzC1WOd++pPXHTTrHTvHDCr5Fo9Q
         XluiELuhT5c/KlwgK7Ac7sjLJohWSm9Rgk+0LMBs27pZE8wvphMsVxG9MDcq39inUrFy
         smDA==
X-Gm-Message-State: AFqh2kpG/sgJiW/rCKRX+yj7cYG0KIUimWg0Wj1jJlST8jKU9bF1YAaz
        0+x0tknvsFeB4i/qu1xksyELCw==
X-Google-Smtp-Source: AMrXdXsVfiyeWsiMdZoF2anbCkN+kSMwBTexEp3CrlKMRT16xw5Sf6OTugVSJynF7gGyKDkEhjVUhA==
X-Received: by 2002:adf:f781:0:b0:242:1ba0:208b with SMTP id q1-20020adff781000000b002421ba0208bmr1552145wrp.64.1671635461308;
        Wed, 21 Dec 2022 07:11:01 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm15420179wrn.52.2022.12.21.07.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:11:00 -0800 (PST)
Message-ID: <b8ea3995-3f35-3459-4882-ad7c4dcf18db@linaro.org>
Date:   Wed, 21 Dec 2022 16:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] thermal/drivers/intel_cpu_idle_cooling: Introduce
 Intel cpu idle cooling driver
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
 <20221129233419.4022830-5-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221129233419.4022830-5-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 00:34, Srinivas Pandruvada wrote:
> The cpu idle cooling is used to cool down a CPU by injecting idle cycles
> at runtime. The objective is similar to intel_powerclamp driver, which is
> used for system wide cooling by injecting idle on each CPU.
> 
> This driver is modeled after drivers/thermal/cpuidle_cooling.c by reusing
> powercap/idle_inject framework.
> 
> On each CPU online a thermal cooling device is registered. The minimum
> state of the cooling device is 0 and maximum is 100. When user space
> changes the current state to non zero, then register with idle inject
> framework and start idle inject.
> 
> The default idle duration is 24 milli seconds, matching intel_powerclamp,
> which doesn't change based on the current state of cooling device. The
> runtime is changed based on the current state.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Removed callback arguments for idle_inject_register
> 
>   drivers/thermal/intel/Kconfig                 |  10 +
>   drivers/thermal/intel/Makefile                |   1 +
>   .../thermal/intel/intel_cpu_idle_cooling.c    | 261 ++++++++++++++++++
>   3 files changed, 272 insertions(+)
>   create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c
> 
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index 6c2a95f41c81..8c88d6e18414 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -115,3 +115,13 @@ config INTEL_HFI_THERMAL
>   	  These capabilities may change as a result of changes in the operating
>   	  conditions of the system such power and thermal limits. If selected,
>   	  the kernel relays updates in CPUs' capabilities to userspace.
> +
> +config INTEL_CPU_IDLE_COOLING
> +	tristate "Intel CPU idle cooling device"
> +	depends on IDLE_INJECT
> +	help
> +	  This implements the CPU cooling mechanism through
> +	  idle injection. This will throttle the CPU by injecting
> +	  idle cycle.
> +	  Unlike Intel Power clamp driver, this driver provides
> +	  idle injection for each CPU.
> diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
> index 9a8d8054f316..8d5f7b5cf9b7 100644
> --- a/drivers/thermal/intel/Makefile
> +++ b/drivers/thermal/intel/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
>   obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
>   obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
>   obj-$(CONFIG_INTEL_HFI_THERMAL) += intel_hfi.o
> +obj-$(CONFIG_INTEL_CPU_IDLE_COOLING) += intel_cpu_idle_cooling.o
> diff --git a/drivers/thermal/intel/intel_cpu_idle_cooling.c b/drivers/thermal/intel/intel_cpu_idle_cooling.c
> new file mode 100644
> index 000000000000..cdd62756cc3d
> --- /dev/null
> +++ b/drivers/thermal/intel/intel_cpu_idle_cooling.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Per CPU Idle injection cooling device implementation
> + *
> + * Copyright (c) 2022, Intel Corporation.
> + * All rights reserved.
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpufeature.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/idle_inject.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/topology.h>
> +
> +#include <asm/cpu_device_id.h>
> +
> +/* Duration match with intel_powerclamp driver */
> +#define IDLE_DURATION		24000
> +#define IDLE_LATENCY		UINT_MAX
> +
> +static int idle_duration_us = IDLE_DURATION;
> +static int idle_latency_us = IDLE_LATENCY;
> +
> +module_param(idle_duration_us, int, 0644);
> +MODULE_PARM_DESC(idle_duration_us,
> +		 "Idle duration in us.");
> +
> +module_param(idle_latency_us, int, 0644);
> +MODULE_PARM_DESC(idle_latency_us,
> +		 "Idle latency in us.");
> +
> +/**
> + * struct cpuidle_cooling - Per instance data for cooling device
> + * @cpu: CPU number for this cooling device
> + * @ii_dev: Idle inject core instance pointer
> + * @cdev: Thermal core cooling device instance
> + * @state:  Current cooling device state
> + *
> + * Stores per instance cooling device state.
> + */
> +struct cpuidle_cooling {
> +	int cpu;
> +	struct idle_inject_device *ii_dev;
> +	struct thermal_cooling_device *cdev;
> +	unsigned long state;
> +};
> +
> +static DEFINE_PER_CPU(struct cpuidle_cooling, cooling_devs);
> +static cpumask_t cpuidle_cpu_mask;

I don't see where it is used except its affectation

> +/* Used for module unload protection with idle injection operations */
> +static DEFINE_MUTEX(idle_cooling_lock);
> +
> +static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
> +					    unsigned long state)
> +{
> +	if (!state)
> +		return 0;
> +
> +	return ((idle_duration_us * 100) / state) - idle_duration_us;
> +}
> +
> +static int cpuidle_idle_injection_register(struct cpuidle_cooling *cooling_dev)
> +{
> +	struct idle_inject_device *ii_dev;
> +
> +	ii_dev = idle_inject_register((struct cpumask *)cpumask_of(cooling_dev->cpu));
> +	if (!ii_dev) {
> +		/*
> +		 * It is busy as some other device claimed idle injection for this CPU
> +		 * Also it is possible that memory allocation failure.
> +		 */
> +		pr_err("idle_inject_register failed for cpu:%d\n", cooling_dev->cpu);
> +		return -EAGAIN;
> +	}
> +
> +	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
> +	idle_inject_set_latency(ii_dev, idle_latency_us);
> +
> +	cooling_dev->ii_dev = ii_dev;
> +
> +	return 0;
> +}
> +
> +static void cpuidle_idle_injection_unregister(struct cpuidle_cooling *cooling_dev)
> +{
> +	idle_inject_unregister(cooling_dev->ii_dev);
> +}
> +
> +static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +	*state = 100;
> +
> +	return 0;
> +}
> +
> +static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +	struct cpuidle_cooling *cooling_dev = cdev->devdata;
> +
> +	*state = READ_ONCE(cooling_dev->state);
> +
> +	return 0;
> +}
> +
> +static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long state)
> +{
> +	struct cpuidle_cooling *cooling_dev = cdev->devdata;
> +	unsigned int runtime_us;
> +	unsigned long curr_state;
> +	int ret = 0;
> +
> +	mutex_lock(&idle_cooling_lock);
> +
> +	curr_state = READ_ONCE(cooling_dev->state);
> +
> +	if (!curr_state && state > 0) {
> +		/*
> +		 * This is the first time to start cooling, so register with
> +		 * idle injection framework.
> +		 */
> +		if (!cooling_dev->ii_dev) {
> +			ret = cpuidle_idle_injection_register(cooling_dev);
> +			if (ret)
> +				goto unlock_set_state;
> +		}
> +
> +		runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
> +
> +		idle_inject_set_duration(cooling_dev->ii_dev, runtime_us, idle_duration_us);
> +		idle_inject_start(cooling_dev->ii_dev);
> +	} else if (curr_state > 0 && state) {
> +		/* Simply update runtime */
> +		runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
> +		idle_inject_set_duration(cooling_dev->ii_dev, runtime_us, idle_duration_us);
> +	} else if (curr_state > 0 && !state) {
> +		idle_inject_stop(cooling_dev->ii_dev);
> +		cpuidle_idle_injection_unregister(cooling_dev);
> +		cooling_dev->ii_dev = NULL;
> +	}
> +
> +	WRITE_ONCE(cooling_dev->state, state);
> +
> +unlock_set_state:
> +	mutex_unlock(&idle_cooling_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * cpuidle_cooling_ops - thermal cooling device ops
> + */
> +static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
> +	.get_max_state = cpuidle_cooling_get_max_state,
> +	.get_cur_state = cpuidle_cooling_get_cur_state,
> +	.set_cur_state = cpuidle_cooling_set_cur_state,
> +};
> +
> +static int cpuidle_cooling_register(int cpu)
> +{
> +	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
> +	struct thermal_cooling_device *cdev;
> +	char name[14]; /* storage for cpuidle-XXXX */
> +	int ret = 0;

Why not register idle_inject here before calling 
thermal_cooling_device_register() so you get ride of the lock.

Well actually, I'm wondering if you can just have the same code than 
cpuidle_cooling_device and just replace the of_device cpu initialization 
by the cpu hotplug.

> +	mutex_lock(&idle_cooling_lock);
> +
> +	snprintf(name, sizeof(name), "cpuidle-%d", cpu);
> +	cdev = thermal_cooling_device_register(name, cooling_dev, &cpuidle_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		ret = PTR_ERR(cdev);
> +		goto unlock_register;
> +	}
> +
> +	cooling_dev->cdev = cdev;
> +	cpumask_set_cpu(cpu, &cpuidle_cpu_mask);
> +	cooling_dev->cpu = cpu;
> +
> +unlock_register:
> +	mutex_unlock(&idle_cooling_lock);
> +
> +	return ret;
> +}
> +
> +static void cpuidle_cooling_unregister(int cpu)
> +{
> +	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
> +
> +	mutex_lock(&idle_cooling_lock);
> +
> +	if (cooling_dev->state) {
> +		idle_inject_stop(cooling_dev->ii_dev);
> +		cpuidle_idle_injection_unregister(cooling_dev);
> +	}
> +
> +	thermal_cooling_device_unregister(cooling_dev->cdev);
> +	cooling_dev->state = 0;
> +
> +	mutex_unlock(&idle_cooling_lock);
> +}
> +
> +static int cpuidle_cooling_cpu_online(unsigned int cpu)
> +{
> +	cpuidle_cooling_register(cpu);
> +
> +	return 0;
> +}
> +
> +static int cpuidle_cooling_cpu_offline(unsigned int cpu)
> +{
> +	cpuidle_cooling_unregister(cpu);
> +
> +	return 0;
> +}
> +
> +static enum cpuhp_state cpuidle_cooling_hp_state __read_mostly;
> +
> +static const struct x86_cpu_id intel_cpuidle_cooling_ids[] __initconst = {
> +	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_MWAIT, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, intel_cpuidle_cooling_ids);
> +
> +static int __init cpuidle_cooling_init(void)
> +{
> +	int ret;
> +
> +	if (!x86_match_cpu(intel_cpuidle_cooling_ids))
> +		return -ENODEV;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +				"thermal/cpuidle_cooling:online",
> +				cpuidle_cooling_cpu_online,
> +				cpuidle_cooling_cpu_offline);
> +	if (ret < 0)
> +		return ret;
> +
> +	cpuidle_cooling_hp_state = ret;
> +
> +	return 0;
> +}
> +module_init(cpuidle_cooling_init)
> +
> +static void __exit cpuidle_cooling_exit(void)
> +{
> +	cpuhp_remove_state(cpuidle_cooling_hp_state);
> +}
> +module_exit(cpuidle_cooling_exit)
> +
> +MODULE_IMPORT_NS(IDLE_INJECT);
> +
> +MODULE_LICENSE("GPL");

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

