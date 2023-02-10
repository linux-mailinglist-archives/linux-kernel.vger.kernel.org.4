Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E74692014
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBJNsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjBJNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:48:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694F34F7B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:48:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so4140446wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgX1/zqimi/YLqc0ROTjcTpl2PIFnD1dAnCrk5r/m5U=;
        b=pgpP3es6XyDBan70UlIhRinUQaDlKfIJoKHjs+Dblw9qmX20Y7du+QACZj+wX73XPv
         +aOnS7z0uKcKvSPVJH8IGQxNpqNqfNCzZiM8nwUUGsPnUmhuKL8PnkrV12wZaNJNiKja
         RpshlKvShYt2dnjI6y32FooWVcF41WOwwnHTIIw7oU0Bmql+fwnmMatS3sIUmXysWQkD
         DTJRUaqHUn2vwFMgLPP9fW1uZ/c9j3LGF+qbpCGdQIM+4RtPqbXwpVCtM+dfP0lrgims
         YuaFbck+0feUTfMLBghyGRWV8eiQEQZ5u+wD3vzRk7HhkKQy1kNjaPw+9gYS86auie0H
         At8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgX1/zqimi/YLqc0ROTjcTpl2PIFnD1dAnCrk5r/m5U=;
        b=K16uCJyx2AypzBMHSEcVkyV2l7rj4KRhQIeUaKwtN9VRbh6VEQrA7tBv5aA9rgr8g5
         fB49iois0K5Mc6/L3sTXvVO8eqYDG8nqRJ9gXm1mXS1D1Jmn+coPgvb0Bcwv3idVtmf8
         XsttSKPFVn5a1YmXbEeuW0sby/ebwoQtlcIzX29mDI7xEyucPNchR3EZKvZALNv8KV4S
         5cUkKa61YBIBEwE1A6BSGK+jSdlVdDZy7Q5DELkphOKtmXb9H44CoQUcMNsiZAxteun2
         H2jxEYwnRVuqjk1Le969HVyMqxsTGjvIIOVcPm2AYyUpHIIheZIVFDU9anvzBHdM7EdO
         cBZw==
X-Gm-Message-State: AO0yUKUvQ3sZyw1DhFMncBBK6F+6R00+Aeu0dt+kBeB7HQLppLA70umA
        S9eYaRikTom9IaE3A6VsAMtY5g==
X-Google-Smtp-Source: AK7set+wCpWmrcrA+BnOSJaSi1jOtj8FGpwUPGWJxV7mIKYA2FHgmLYCrTsknLK4f6wOi+tvOJEo+Q==
X-Received: by 2002:a05:600c:450b:b0:3df:9858:c03b with SMTP id t11-20020a05600c450b00b003df9858c03bmr9896080wmo.16.1676036926504;
        Fri, 10 Feb 2023 05:48:46 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm7948569wmc.10.2023.02.10.05.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:48:46 -0800 (PST)
Message-ID: <3b215d83-9b8e-d881-44c4-ee1301bb9044@linaro.org>
Date:   Fri, 10 Feb 2023 14:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/4] thermal: qoriq: add i.MX93 TMU support
Content-Language: en-US
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
 <20230105101748.6714-3-alice.guo@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230105101748.6714-3-alice.guo@oss.nxp.com>
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

On 05/01/2023 11:17, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> The procedure to program the calibration table of i.MX93 TMU:
> 1. disable monitoring mode
> 2. configure TCMCFG
> 3. write TTCFGR with TTCFGR[CAL_PT] = n
> 4. write TSCFGR with the sensor value of the calibration point n
> 5. write TTRCRn associated with the calibration point n
> Need to repeat steps 3—5 for all calibration points from the calibration
> table provided by the TMU device node.
> 
> When TRITSR[V] = 1 and TRITSR[TP5] = 1, need to add 0.5K to
> TRITSR[TEMP].
> 
> IPBRR0s of lx2160ardb, lx2162aqds and i.MX93 have the same value
> 0x01900201 so that use the compatible to determine whether the current
> TMU belongs to i.MX93 or not.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> ---

[ ... ]

> @@ -369,6 +416,7 @@ static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>   static const struct of_device_id qoriq_tmu_match[] = {
>   	{ .compatible = "fsl,qoriq-tmu", },
>   	{ .compatible = "fsl,imx8mq-tmu", },
> +	{ .compatible = "fsl,imx93-tmu", },
>   	{},

Now that you have more than 2, I suggest the pass a ops structure to 
.data, so you can call them directly instead of checking the TMU version 
in the calibration, the initialization and get the temperature.

>   };
>   MODULE_DEVICE_TABLE(of, qoriq_tmu_match);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

