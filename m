Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03E73F5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjF0HoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjF0HoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:44:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625B10D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:44:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f957a45b10so5507405e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687851839; x=1690443839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXDjy7JPJ8XrZiw8dYtuA9M7FtFKUmW4GijlGMiZDeo=;
        b=W3StrIEt1NsXEWvdU5avGU95Enq3cbFYCcn4JQnVWeuR2OJCVzshq5XVbRERJWATTj
         a8gTuNq+u+zQTtVHVlxCyJhcjzGRjssWWYa18rsYhWT5uM9hOtRtst7HejvUCbqZ9b6U
         oBLhEK3ey+uadLyH3jqFHft76Hup2g93+m5WYHqveVWRtmePCFkN+4j5sJ9GDFM4Es8X
         OdXG1uZChre1Rw0EPQGwd8DTHS9Tw2mPeNoAlu4qfwnbKprxnJ7GDcvEt9NC5IkZSfrh
         Up8W3fdSXm5G/T2XZcqeOIo6DdRVHrwqkx6R8Eu7VZs1I+uQ9V8bQ4PbTI/hPhZT9Zo8
         eLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851839; x=1690443839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXDjy7JPJ8XrZiw8dYtuA9M7FtFKUmW4GijlGMiZDeo=;
        b=bwPApD/OMl6cD5/Z8V+d50911kcbepagbLv0LCJjyv7scRZWnwVUKOsLaH4ewg0vHz
         kh+oSsfBicI8JRRKBLNRE5bypoz7n/U7aSGskIrADn3xYlEN8Iy82KGHmTWm9Mz7oteu
         OxUcsbZ39wTJie5EGlRAPOBWnW376pgylxApdR57uGMlUkpT/A763pOy4f6K6Zw7fk6T
         1oXRpuarjdo3GAK9pmunyou6n8lPqQWXK6VWvfPirHjZ+xMXsB3jEAPz0ggL/x9903LV
         xBmf7jszBFGVI0RAnXD+esTihdPY2YK7rb4CQp67kceO8UQTosy/pKlsgVY9P+tP7LDc
         0EnA==
X-Gm-Message-State: AC+VfDyQ0f4wavebVQC6GEzJPX39+mi6+Rd8k/ToSndhI1oiCJcNPs8N
        YYV2xSvaz4jxLor0XmL7UZ2NLA==
X-Google-Smtp-Source: ACHHUZ6qtmjN/vi/vgCBazSl8DAEcvTTiaFDRa2Iv5DYB3acC9xLxbjSTFmH5IakkXPbPPvl85v0lA==
X-Received: by 2002:a05:6512:3f1d:b0:4fa:ce08:a9d0 with SMTP id y29-20020a0565123f1d00b004face08a9d0mr4045130lfa.57.1687851838802;
        Tue, 27 Jun 2023 00:43:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f9cb3c8958sm12898448wmg.3.2023.06.27.00.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:43:58 -0700 (PDT)
Message-ID: <82dc5efc-35fe-15ff-d0ea-e1a19da71c5c@linaro.org>
Date:   Tue, 27 Jun 2023 09:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/15] genirq/devres: Add error information printing for
 devm_request_threaded_irq()
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 09:16, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
> 
> There are more than 700 calls to the devm_request_threaded_irq method.
> If error messages are printed everywhere, more than 1000 lines of code
> can be saved by removing the msg in the driver.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  kernel/irq/devres.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index f6e5515ee077..94039a915218 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -58,8 +58,10 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  
>  	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
>  			  GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");

Just like any memory allocation, I don't think we print anything for
devres failures. Why do you think we should start doing it?

>  		return -ENOMEM;
> +	}
>  
>  	if (!devname)
>  		devname = dev_name(dev);
> @@ -67,6 +69,7 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  	rc = request_threaded_irq(irq, handler, thread_fn, irqflags, devname,
>  				  dev_id);
>  	if (rc) {
> +		dev_err(dev, "Failed to request threaded irq\n");

I don't like that one path - devm() managed - prints error, but regular
path does not. Code should be here consistent. Also error message is too
generic. You need to print at least irq number, maybe also devname?

Best regards,
Krzysztof

