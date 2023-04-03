Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209B76D438B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjDCLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjDCLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:32:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E659E1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:32:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q19so25920461wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680521542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oxN6OsSAvDJ/9XUkNDJfOZTdcdSQucx06S047EyHBQ=;
        b=C6gWZp40tfEpPfYSrgRrnFTseXhT17/N3/Rd1XTWX8SljHQdb+j8qyQzRCnxitNxkA
         mGbwHFXQb5ITNf+w/UsK+tl7GA4WaEklHtP2Gk9OwGoV3bsBkLWXg6+vzsu+xjPFbcKq
         istoMqkmpzZZTsjxCqMlUNeuaV+wM4NiuoKM26cYhKEeXGORCVFktJRSeXU6tkQRb9U1
         fTHAQpbiSbu2xdOJqzmannTP/O0Dmjj025fN1OI4ac9mQVEmT+vQLQuhMcUE5nvLMEYd
         wWrJ1fH+ucZjqsu2MSSndsASCTdtDEyv8opVMnDUijCXg5DG/y1MPRlxQHr3wfMr1A+h
         +W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oxN6OsSAvDJ/9XUkNDJfOZTdcdSQucx06S047EyHBQ=;
        b=kZiHIS1Vecwapi090qrx445od/RzWRNXXmPD/92x3a7f34fWkhdXuhHb/d5weZrx2X
         c35qeHIUlLX6DnccnZC7aNZXbpk6UamEmcXSFpBEjglFJcgdD1MiqZXZi0NZxRIBPE2V
         pcTzzjbFxygM2FEfXFS/KNXCASh6Z1q04jKMO6JVmN7Zo98u/Ntb1zY84F8P31ileM79
         oc9B3MfWJ5RbZLOSQ0mRMlxsXOak9dwLbK3O2l2WcweBZ45+qAFy6uIyWLieUPafGJ8V
         EId12q4eMI8uDN2bM1IOPCpxJ6MR4+2r+0S8n+PXPcJNmMTYj6DGdziD9anGZ9nVlPSA
         +R3Q==
X-Gm-Message-State: AAQBX9eGOSvd35zRIpBMT/drGeyYhnNYpiT8uZf2miaiHuAxVaMshLwm
        N16hfqbz86DIyFOqCY3an8vSIg==
X-Google-Smtp-Source: AKy350bJaiA62l9quKwVmDV9foxfGXFovA3zqzv8sR+okw5JpFGfalk8OYcb0L9rxeEC7w5V9ffF/w==
X-Received: by 2002:a5d:4848:0:b0:2ce:a9e9:490b with SMTP id n8-20020a5d4848000000b002cea9e9490bmr24826782wrs.31.1680521542472;
        Mon, 03 Apr 2023 04:32:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8052:c9eb:6b69:e69a? ([2a05:6e02:1041:c10:8052:c9eb:6b69:e69a])
        by smtp.googlemail.com with ESMTPSA id r1-20020a5d4941000000b002cfefa50a8esm9527094wrs.98.2023.04.03.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 04:32:22 -0700 (PDT)
Message-ID: <6e3c59c3-8ad0-9c53-62a4-7be6f55a7c02@linaro.org>
Date:   Mon, 3 Apr 2023 13:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drivers: thermal: mediatek: fix of_iomap leak in
 mtk_thermal_probe
Content-Language: en-US
To:     Kang Chen <void0red@hust.edu.cn>, dzm91@hust.edu.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        daniel@makrotopia.org, rdunlap@infradead.org, bchihi@baylibre.com,
        henry.yen@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        hust-os-kernel-patches@googlegroups.com, void0red@gmail.com,
        error27@gmail.com
References: <20230403103855.3601901-1-void0red@hust.edu.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230403103855.3601901-1-void0red@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 12:38, Kang Chen wrote:
> Smatch reports:
> 1. mtk_thermal_probe() warn: 'apmixed_base' from of_iomap() not released.
> 2. mtk_thermal_probe() warn: 'auxadc_base' from of_iomap() not released.
> 
> The original code forgets to release iomap resource when handling errors,
> fix it through unified error handling code at the end of mtk_thermal_probe.
> 
> Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
> Signed-off-by: Kang Chen <void0red@hust.edu.cn>
> ---
> I think the this should be released on the success path but I was too
> scared of breaking things. Let me know and I will resend if people want
> me to do that.
> 
>   drivers/thermal/mediatek/auxadc_thermal.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index ab730f9552d0..741c7d8151bd 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1149,13 +1149,15 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	if (auxadc_phys_base == OF_BAD_ADDR) {
>   		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_iounmap_auxadc;
>   	}

Better to use the devm_of_iomap() variant

And also take the opportunity to use devm_clk_get_enabled(), remove 
clk_prepare_enable() and the rollbacking in the err_disable_clk_per*: 
label sections.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

