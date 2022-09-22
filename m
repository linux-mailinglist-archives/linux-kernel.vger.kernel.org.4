Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C85E6650
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiIVO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiIVO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:58:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C483DE0E4;
        Thu, 22 Sep 2022 07:58:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y11so10016157pjv.4;
        Thu, 22 Sep 2022 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=QzQeXYB+ja5Y04W2l32Mpg89g8L7HMpl1A3Ka8BQLQg=;
        b=jigkCaMZzo8nGD9G0JrZu1/peyCHS7/glwmJ8i4y09v0Jb/Q33T6tB8pqCG7I/rNwg
         ztYvSmggdOV8TRngdbYBRccG7IM6TsJMaeEj/068tdZgI9LCvkU84GflUui0o7pALFwH
         xhutxefy/Mi0aq9PIhExG25L8o5FBm+MzT0x1mUleWr87WNnj7VZfWKKWFJ5widypqE7
         AtoTsbjszTg9y2LjIoNfOTMTLmNiQfEXnJB6v0IMTR5u6kWCZg5t+aZTScc2EKVZID2r
         i6PXWI2RSJpY1yFDQBadRPscLbEYnx6UpSIZHL38FdnKbtpB2Clg+YjHW7AebwRWi7mv
         qFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=QzQeXYB+ja5Y04W2l32Mpg89g8L7HMpl1A3Ka8BQLQg=;
        b=op+Sfv8yxXrWqVEwWTCh2cAlJhDIfy/2I3L19MxLeZg0l/9WxYYutUriMShisFBXSI
         AVqsh6w1Ynlcoft9sn3XhU3JkFaHhHyTk89GGBWL0FEpJaNpasS4hN9d9c/0Bxn/ZXsM
         wynOdIDxyQCLa90sgpeceqxX6BwCQvyahdr+zpTxZc94h5IDBCIDXRefe2bvroa4athS
         MdSGlHHEJ7XcRYmplxmXUDRukoDNSnvJ1kUZLiOQ8C6ow2wCUwu0FQUtJbzWY7q9GFKG
         YNgCJtyHgJgLXGk9bR7s+4oUFv1S7+lZiBbP6HstgMXyfjkBLXHcrxMce1PsFdhc8Bh6
         HZSA==
X-Gm-Message-State: ACrzQf1krlShr3vFVZyIdHV8VrInvOVLewKsqXnprrNJW2KYBP4f0enF
        duusBKoLHSnE4AYSEIsQyL8=
X-Google-Smtp-Source: AMsMyM5yFh97i7b0qm1ebZw9NONrleZCCmOpLEqI2WEtEuHSFVNjczfx2ns7TZKI0AHltBpTx1mujA==
X-Received: by 2002:a17:902:ea0f:b0:178:23f7:5a30 with SMTP id s15-20020a170902ea0f00b0017823f75a30mr3633027plg.150.1663858727624;
        Thu, 22 Sep 2022 07:58:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e13-20020a63db0d000000b0041cd5ddde6fsm3909320pgg.76.2022.09.22.07.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:58:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f92ded9-8b85-8f90-3a7f-bd246957350a@roeck-us.net>
Date:   Thu, 22 Sep 2022 07:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/8] hwmon/coretemp: Rename indx to index
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        len.brown@intel.com
References: <20220922133800.12918-1-rui.zhang@intel.com>
 <20220922133800.12918-3-rui.zhang@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220922133800.12918-3-rui.zhang@intel.com>
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
> Use variable name 'index' instead of 'indx' for the index in the
> core_data[] array.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/coretemp.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index ccf0af5b988a..bfdcfe8ccb34 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -515,15 +515,15 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
>   		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
>   }
>   
> -static void coretemp_remove_core(struct platform_data *pdata, int indx)
> +static void coretemp_remove_core(struct platform_data *pdata, int index)
>   {
> -	struct temp_data *tdata = pdata->core_data[indx];
> +	struct temp_data *tdata = pdata->core_data[index];
>   
>   	/* Remove the sysfs attributes */
>   	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
>   
> -	kfree(pdata->core_data[indx]);
> -	pdata->core_data[indx] = NULL;
> +	kfree(pdata->core_data[index]);
> +	pdata->core_data[index] = NULL;
>   }
>   
>   static int coretemp_probe(struct platform_device *pdev)
> @@ -647,7 +647,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	struct platform_device *pdev = coretemp_get_pdev(cpu);
>   	struct platform_data *pd;
>   	struct temp_data *tdata;
> -	int indx, target;
> +	int index, target;
>   
>   	/*
>   	 * Don't execute this on suspend as the device remove locks
> @@ -661,12 +661,12 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   		return 0;
>   
>   	/* The core id is too big, just return */
> -	indx = TO_ATTR_NO(cpu);
> -	if (indx > MAX_CORE_DATA - 1)
> +	index = TO_ATTR_NO(cpu);
> +	if (index > MAX_CORE_DATA - 1)
>   		return 0;
>   
>   	pd = platform_get_drvdata(pdev);
> -	tdata = pd->core_data[indx];
> +	tdata = pd->core_data[index];
>   
>   	cpumask_clear_cpu(cpu, &pd->cpumask);
>   
> @@ -677,7 +677,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	 */
>   	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
>   	if (target >= nr_cpu_ids) {
> -		coretemp_remove_core(pd, indx);
> +		coretemp_remove_core(pd, index);
>   	} else if (tdata && tdata->cpu == cpu) {
>   		mutex_lock(&tdata->update_lock);
>   		tdata->cpu = target;

