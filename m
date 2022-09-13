Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B45B6BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIMKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiIMKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:52:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCF5E306
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:52:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so8619166pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1jDUmJ+8foq+fRfrH/SDieomTLyd9X2Y+NSWOcN4vCw=;
        b=ZadiryT/cM82fpVakpsZ68HnfwtdTldHLlK3HkjYx/3YBBUnkx50n/nW3a1wAOOxhr
         v4o8tkny9b0KWKf1xqP8FshrgPOKH3g1totYypFDuG/iv829yYUKlt6A7iaEkOZZViYz
         swZijaHtPyN4uvKfqbC8zmCJRRcvG6NSu2ib88p5LS+fbtvcJBqwjn5RI6kaFOB2IXhp
         1GPgTfxsa4sNGZw4xnDEDr0udXwp/umcEGIl674qbxhtYLmAeSBmJAQGs8wOisHZJkb6
         wroSrivYgqmyRANuoVGHKjEgQWL3bzdtrxIy/65ZVFY0KY4Z+9s3XbCfkBXQPbNKOIU5
         RCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1jDUmJ+8foq+fRfrH/SDieomTLyd9X2Y+NSWOcN4vCw=;
        b=uF/5qj3aqXM6Lwj2KdpJphJL/w/9pF839SPI6vWvBf2x9DQFiaga5Vq0Hu+1VXhpZZ
         Pi1v0b7vtcP8KbfBUbAoMh9zNs//HldkadDs7oEfgsPN2DpZP/QbCYOsHRlTRkPdnK12
         mxEmW/Riv4qNEYvoEVaAdRfye7Svb5E4QBzhgLeFqErJGyty134LFekHboQW/kQxMOQD
         QPnYIdpptQvmbFAjM5P+E3XllcRMr5ZMrfwBNiZHRjZJpIqnAlETRwRDjFONW2uAGZji
         9denXp0J7tl6XBfZjaATenLCyRDlf/XHpSF6Jx/MM8wae3MixL3iv6TlbY1QR+eoxoQ/
         TEdQ==
X-Gm-Message-State: ACgBeo3rZsX4y91yIzWF/03dw5J+l2i7ekQYutTfRDvMPv6vpgW4cjCi
        rDgj0CLUmspgzBQ5qIscjZWXKQ==
X-Google-Smtp-Source: AA6agR538RUq0gUdqP78Um9aGmPv5eu/ZqomlxzfV1qPpglkwdqMluJhythI1berMCGcH5yqMqXgKA==
X-Received: by 2002:a17:90b:4a48:b0:202:9bcb:b89c with SMTP id lb8-20020a17090b4a4800b002029bcbb89cmr3427387pjb.161.1663066357895;
        Tue, 13 Sep 2022 03:52:37 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id i123-20020a626d81000000b0053ae018a91esm7665515pfc.173.2022.09.13.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:52:37 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:52:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] coresight: etm4x: Fix crash observed on Qcom ETM
 parts with 'Low power override'
Message-ID: <YyBg8JhNUnsaeKip@leoy-yangtze.lan>
References: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On Thu, Aug 25, 2022 at 10:52:32AM +0530, Bhupesh Sharma wrote:
> Some Qualcomm ETM implementations require skipping powering up
> the trace unit, as the ETMs are in the same power domain as
> their CPU cores.
> 
> Via commit 5214b563588e ("coresight: etm4x: Add support for
> sysreg only devices"), the setting of 'skip_power_up' flag was
> moved after the 'etm4_init_arch_data' function is called, whereas
> the flag value is itself used inside the function. This causes
> a crash when ETM mode 'Low-power state behavior override' is set
> on some Qualcomm parts.
> 
> Fix the same.
> 
> Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  - v1 can be seen here: https://lore.kernel.org/lkml/20220803191236.3037591-1-bhupesh.sharma@linaro.org/
>  - Addressed the review comments from Suzuki.
>  - Rebased on linux-next.
> 
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d39660a3e50c..14c1c7869795 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -977,6 +977,16 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>  	if (!cpu_supports_sysreg_trace())
>  		return false;
>  
> +	/*
> +	 * Some Qualcomm implementations require skipping powering up the trace unit,
> +	 * as the ETMs are in the same power domain as their CPU cores.
> +	 *
> +	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
> +	 * initialize it before the function is called.
> +	 */
> +	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +		drvdata->skip_power_up = true;
> +

I personally think this sentence should be placed in the function
etm4_probe(), you need to move it just before smp call
etm4_init_arch_data(), this can allow DT property "qcom,skip-power-up"
to be respected.

>  	/*
>  	 * ETMs implementing sysreg access must implement TRCDEVARCH.
>  	 */
> @@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  		return -EINVAL;
>  
>  	/* TRCPDCR is not accessible with system instructions. */
> -	if (!desc.access.io_mem ||
> -	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +	if (!desc.access.io_mem)
>  		drvdata->skip_power_up = true;

I prefer to move the condition checking for "desc.access.io_mem" to
etm4_init_sysreg_access(), this can make sure the flag skip_power_up
is set correctly based on property of system register access.

A side topic, in the mainline kernel I found the value
"desc.access.io_mem" is always zero (see the initialized value in
etm4_probe() and etm4_init_sysreg_access()).  Should we initialize
desc.access.io_mem to true in etm4_probe()?

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d39660a3e50c..cf2555c50abb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1939,6 +1939,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
        if (drvdata->cpu < 0)
                return drvdata->cpu;
 
+       desc.access.io_mem = true;
        init_arg.drvdata = drvdata;
        init_arg.csa = &desc.access;
        init_arg.pid = etm_pid;
  
Thanks,
Leo

>  	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
> -- 
> 2.35.3
> 
