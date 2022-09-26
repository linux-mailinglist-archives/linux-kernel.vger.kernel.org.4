Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCC5E9C26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiIZIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiIZIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:36:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D63B21805
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:36:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w20so5553159ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S3YpF0J9PK0ijK5OVv062WDbUS2SECLrB4bPkgAYd/0=;
        b=KYWKxmq162iix/heLHpM0iiyJ+z2PHlMRbsxX3Ie4ZH30ZFBXFnrwTO7nTwzlOggqY
         QaJDsuwxiPBjnApUhY3dAuCjh0SaYozYOw+2n4HdmNs/2kSwYLERAcfnpeIsmd6ka6J/
         P652G+fWhEbPCBow1woX69hmjKg6+sxxBHU/KZX6dqaNLOKBJOPMacTLPGeVhIV2V3zd
         zKwxCTgz/ZlB7vb/P8CwQCcA2xNZZeu6heFHZY77ztqxH9H3YoZc2/xfdGrOBksTi86L
         sU5radxCmYaApM5VHHGhlPfGH9P/6hJCqJWNQAy12RWLHS92Be96CgUJIvBW6JLnFsD/
         DJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S3YpF0J9PK0ijK5OVv062WDbUS2SECLrB4bPkgAYd/0=;
        b=nVUM0pW8PMvVyWmaWKgCoys6EXpKsoCljJSkGb/G71tpdFFyFxVSSJkCbMaQAj6aII
         FaulGivMHz9FehEKmNFvJ17+VXDUXHan3WvcOLQOxtYjTGtm5iHKeZ0m2xeVNZUKSafj
         9N6K1fxvywdlVhQSavID4MrBsa4PKQGEvDRzk7tSdOPzAuYJmNAztys7My4frN3TFk1k
         fpyjwmcwww1SyY5mSa2XusSnDI6lgfGISTBljacXF+sGRzNZMz/S86l0N1ZctEDCghSv
         3vtYLQLhFS4ZFYtoafe8qizGqi0KCKz6K0qCGqWXHAUN5MIBpBImMn9F2wx23J7g+rQA
         OhZg==
X-Gm-Message-State: ACrzQf2lyV3jENoNxnlTyfjj2UUcG/tYRhkON25DBRjUENZNwyrEH3UN
        n7aFZhaZ8IAyLpiBRyAMcGjSmw==
X-Google-Smtp-Source: AMsMyM7vBIo2AShmYXBLpIo583HiDxVFmEiIFH6HyfQjEFHGu4NJprUdzY8gcCKLuYXQiVqcR4r4Ew==
X-Received: by 2002:a17:90b:1b51:b0:203:25f0:c25e with SMTP id nv17-20020a17090b1b5100b0020325f0c25emr24194880pjb.65.1664181368829;
        Mon, 26 Sep 2022 01:36:08 -0700 (PDT)
Received: from localhost ([122.172.85.153])
        by smtp.gmail.com with ESMTPSA id w19-20020aa79553000000b00540fee4a680sm11428866pfq.41.2022.09.26.01.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:36:08 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:06:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, di.shen@unisoc.com
Subject: Re: [PATCH v2] cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh
Message-ID: <20220926083605.b6vjrvg3a4u3rxxi@vireshk-i7>
References: <20220926055130.yr67653e52vyuutv@vireshk-i7>
 <20220926083405.7801-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926083405.7801-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-22, 16:34, Xuewen Yan wrote:
> Before update thermal pressure, the max cpufreq should be limited.
> Add QOS control for Lmh throttle cpufreq.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> v1->v2:
> 	reabse to cpufreq/arm/linux-next;
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index bb32659820ce..833589bc95e4 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/units.h>
> @@ -56,6 +57,8 @@ struct qcom_cpufreq_data {
>  	struct cpufreq_policy *policy;
>  
>  	bool per_core_dcvs;
> +
> +	struct freq_qos_request throttle_freq_req;
>  };
>  
>  static unsigned long cpu_hw_rate, xo_rate;
> @@ -321,6 +324,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  
>  	throttled_freq = freq_hz / HZ_PER_KHZ;
>  
> +	freq_qos_update_request(&data->throttle_freq_req, throttled_freq);
> +
>  	/* Update thermal pressure (the boost frequencies are accepted) */
>  	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
>  
> @@ -413,6 +418,14 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	if (data->throttle_irq < 0)
>  		return data->throttle_irq;
>  
> +	ret = freq_qos_add_request(&policy->constraints,
> +				   &data->throttle_freq_req, FREQ_QOS_MAX,
> +				   FREQ_QOS_MAX_DEFAULT_VALUE);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add freq constraint (%d)\n", ret);
> +		return ret;
> +	}
> +
>  	data->cancel_throttle = false;
>  	data->policy = policy;
>  
> @@ -479,6 +492,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>  	if (data->throttle_irq <= 0)
>  		return;
>  
> +	freq_qos_remove_request(&data->throttle_freq_req);
>  	free_irq(data->throttle_irq, data);
>  }
>  

Applied. Thanks.

-- 
viresh
