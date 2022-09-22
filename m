Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D305E6657
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIVPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiIVPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:00:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276335F44;
        Thu, 22 Sep 2022 08:00:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u69so9404263pgd.2;
        Thu, 22 Sep 2022 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=B4Xk+BIx1noN892+bOS2pADiNJJuJegKYow8CwgOs3I=;
        b=Jba+zR4KKcsD7I9w+UH1acIjWyRstiNuUZRnYd/qSPAnM69nlEWFroc8xjwnJdHY/H
         EkLdMuocfy+Ypf1VrNKR4iM1fD6WOq6mdIrfk+x10ho5hE5TmRp3ii1/6nANt3KgtyNu
         A67IpwXUbqR6KaJX8C2k8OBl/rqXWaYKgMF4FC4zI8CH8rOEIhizWf7ipSkV15jww9k5
         UQf0lGnEDWwK/zP26EMJq2GeJtOC4lCV2aiMIeKFdkKvv+tnIqgd3W8F0styaF2H68bW
         NOE5yNjBnmdKHlhrF9yF34p/bTPFUXOVw+ndzYspIGENXPawuJcxvrcb6KZ5WiDb7/YN
         f+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=B4Xk+BIx1noN892+bOS2pADiNJJuJegKYow8CwgOs3I=;
        b=DeJSfAflm1vMLNlpVrA7++b/cKLIRlc7QFvcitbHIZFzeQezW1O/cCHNd+2Us1/5Pp
         o/EC825bMab0m3NyNLduAqPPAS5Cc38KVEyPRF3KZHnBH8822xDGpx2fZ5kISSk+th6g
         JCQ5oqXZf3ekCt/i3Ighc4oiDtW8o9lqNQ2cHfUJznEsNZVGyLdIP7QJ22vd2YExS0YO
         Wa3dpxNW4VU+FUDxLfI5KNjQzHm1LGDT+BoyLn2uDTzhYeszIeO75Vt3ti+TqcZc+YaU
         5ApqiVRYWy9a6sQtJAyDbN/Pqr2ZQ11rrN/rKtTkzzKk5ogpwYSyBi3iWhXqWCxrzLBu
         F/iQ==
X-Gm-Message-State: ACrzQf0ZgtO3EDjrfhGNtSFzYoF/+gP77PXKLXShUXi3Szl+Aq/uwVMH
        ZRFAOkhgl6rjx3xEkZKV7pQ=
X-Google-Smtp-Source: AMsMyM5+cPlZPu/X2TJbdKICI88VZo9u/xABZdlRtjl6EPnLP3qZhJcQMrJPm61r/PPxrkAOqKWGng==
X-Received: by 2002:a65:58c8:0:b0:438:aecf:5cc8 with SMTP id e8-20020a6558c8000000b00438aecf5cc8mr3393332pgu.18.1663858799514;
        Thu, 22 Sep 2022 07:59:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65-20020a621744000000b005289a50e4c2sm4586414pfx.23.2022.09.22.07.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:59:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <79675c12-00bb-849e-70d2-dca8cce210fe@roeck-us.net>
Date:   Thu, 22 Sep 2022 07:59:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/8] hwmon/coretemp: Handle large core ID value
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        len.brown@intel.com
References: <20220922133800.12918-1-rui.zhang@intel.com>
 <20220922133800.12918-4-rui.zhang@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220922133800.12918-4-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 06:37, Zhang Rui wrote:
> The coretemp driver supports up to a hard-coded limit of 128 cores.
> 
> Today, the driver can not support a core with an ID above that limit.
> Yet, the encoding of core ID's is arbitrary (BIOS APIC-ID) and so they
> may be sparse and they may be large.
> 
> Update the driver to map arbitrary core ID numbers into appropriate
> array indexes so that 128 cores can be supported, no matter the encoding
> of core ID's.
> 
> Acked-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/hwmon/coretemp.c | 56 +++++++++++++++++++++++++++++-----------
>   1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index bfdcfe8ccb34..291566aeb703 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -46,9 +46,6 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>   #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>   #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>   
> -#define TO_CORE_ID(cpu)		(cpu_data(cpu).cpu_core_id)
> -#define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
> -
>   #ifdef CONFIG_SMP
>   #define for_each_sibling(i, cpu) \
>   	for_each_cpu(i, topology_sibling_cpumask(cpu))
> @@ -91,6 +88,8 @@ struct temp_data {
>   struct platform_data {
>   	struct device		*hwmon_dev;
>   	u16			pkg_id;
> +	u16			cpu_map[NUM_REAL_CORES];
> +	struct ida		ida;
>   	struct cpumask		cpumask;
>   	struct temp_data	*core_data[MAX_CORE_DATA];
>   	struct device_attribute name_attr;
> @@ -441,7 +440,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>   							MSR_IA32_THERM_STATUS;
>   	tdata->is_pkg_data = pkg_flag;
>   	tdata->cpu = cpu;
> -	tdata->cpu_core_id = TO_CORE_ID(cpu);
> +	tdata->cpu_core_id = topology_core_id(cpu);
>   	tdata->attr_size = MAX_CORE_ATTRS;
>   	mutex_init(&tdata->update_lock);
>   	return tdata;
> @@ -454,7 +453,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>   	struct platform_data *pdata = platform_get_drvdata(pdev);
>   	struct cpuinfo_x86 *c = &cpu_data(cpu);
>   	u32 eax, edx;
> -	int err, attr_no;
> +	int err, index, attr_no;
>   
>   	/*
>   	 * Find attr number for sysfs:
> @@ -462,14 +461,26 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>   	 * The attr number is always core id + 2
>   	 * The Pkgtemp will always show up as temp1_*, if available
>   	 */
> -	attr_no = pkg_flag ? PKG_SYSFS_ATTR_NO : TO_ATTR_NO(cpu);
> +	if (pkg_flag) {
> +		attr_no = PKG_SYSFS_ATTR_NO;
> +	} else {
> +		index = ida_alloc(&pdata->ida, GFP_KERNEL);
> +		if (index < 0)
> +			return index;
> +		pdata->cpu_map[index] = topology_core_id(cpu);
> +		attr_no = index + BASE_SYSFS_ATTR_NO;
> +	}
>   
> -	if (attr_no > MAX_CORE_DATA - 1)
> -		return -ERANGE;
> +	if (attr_no > MAX_CORE_DATA - 1) {
> +		err = -ERANGE;
> +		goto ida_free;
> +	}
>   
>   	tdata = init_temp_data(cpu, pkg_flag);
> -	if (!tdata)
> -		return -ENOMEM;
> +	if (!tdata) {
> +		err = -ENOMEM;
> +		goto ida_free;
> +	}
>   
>   	/* Test if we can access the status register */
>   	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
> @@ -505,6 +516,9 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>   exit_free:
>   	pdata->core_data[attr_no] = NULL;
>   	kfree(tdata);
> +ida_free:
> +	if (!pkg_flag)
> +		ida_free(&pdata->ida, index);
>   	return err;
>   }
>   
> @@ -524,6 +538,9 @@ static void coretemp_remove_core(struct platform_data *pdata, int index)
>   
>   	kfree(pdata->core_data[index]);
>   	pdata->core_data[index] = NULL;
> +
> +	if (index >= BASE_SYSFS_ATTR_NO)
> +		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
>   }
>   
>   static int coretemp_probe(struct platform_device *pdev)
> @@ -537,6 +554,7 @@ static int coretemp_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	pdata->pkg_id = pdev->id;
> +	ida_init(&pdata->ida);
>   	platform_set_drvdata(pdev, pdata);
>   
>   	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
> @@ -553,6 +571,7 @@ static int coretemp_remove(struct platform_device *pdev)
>   		if (pdata->core_data[i])
>   			coretemp_remove_core(pdata, i);
>   
> +	ida_destroy(&pdata->ida);
>   	return 0;
>   }
>   
> @@ -647,7 +666,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	struct platform_device *pdev = coretemp_get_pdev(cpu);
>   	struct platform_data *pd;
>   	struct temp_data *tdata;
> -	int index, target;
> +	int i, index = -1, target;
>   
>   	/*
>   	 * Don't execute this on suspend as the device remove locks
> @@ -660,12 +679,19 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	if (!pdev)
>   		return 0;
>   
> -	/* The core id is too big, just return */
> -	index = TO_ATTR_NO(cpu);
> -	if (index > MAX_CORE_DATA - 1)
> +	pd = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < NUM_REAL_CORES; i++) {
> +		if (pd->cpu_map[i] == topology_core_id(cpu)) {
> +			index = i + BASE_SYSFS_ATTR_NO;
> +			break;
> +		}
> +	}
> +
> +	/* Too many cores and this core is not populated, just return */
> +	if (index < 0)
>   		return 0;
>   
> -	pd = platform_get_drvdata(pdev);
>   	tdata = pd->core_data[index];
>   
>   	cpumask_clear_cpu(cpu, &pd->cpumask);

