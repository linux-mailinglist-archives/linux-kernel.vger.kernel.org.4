Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6B5B6339
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiILWAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiILWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:00:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A4474F8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:00:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w8so17060830lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AyY1pS1gIoihV9h/TOHQQzSTghwaQhWl/8N88+vxDvY=;
        b=WQRN/VO2MUAPdhBeT6WWJnL7tyU8NFnCcS90ahHnIrwcx9G1LuvV+3Y498rgIqbKlY
         YmqUqekXgv1zkVD6PzVK2c9iLBNhh1Cm9Iw4EW717UaUYJaZdrP/m5Zl3gpuce0Haca+
         XrHDHoCR/KqzWdeB3iPWpMh6Qx4yZliP1Ma/BiNc+WNhHjnGPFNmcUhIT+HJnX6XYo+i
         lgq2yF+hxPW+3cFtVjerChY2tSBAe2jv1YiTchv/6CZUDXqH1Hqnlozns1FwdbmDCDxc
         qfaOFpD6IModzjrzui8NlB/ktycOlhMXYXnc2oosVtkaNboE4yKK85uxa252LlFB8Ghh
         JL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AyY1pS1gIoihV9h/TOHQQzSTghwaQhWl/8N88+vxDvY=;
        b=wgMKBLFERlOGYgnOtTZZ+VVqLHRbqJQP2r91/l5yj7HiO7TTHxqIqj6jLW6ksZV83C
         z+xW1EqUTZvVnHgqeOx+L3lfu8UKUTXhaKrVmWR7vC6fQulVmMs5RQIZZ61dwwwrFfRi
         +JqVs4yxj+ISLP25dmlwBcNKpkCsd4ZlbQfG/72sBQYwGVL5ne/PkufVyBDmsSjhg76w
         LW9+3OYL/CDgtsDMv5iW+LrQRMCgCnn+2+xcQYADN3rFitzNURmxnwH1N1PrXJq37swe
         7pCx3Fg4vr8QUvAyj/0dFEtbhm+pAv+2wDvp2mNkZvLnA2NX5pCULftlt3xLKkkjlGlO
         lTMQ==
X-Gm-Message-State: ACgBeo2U6JlKzJL3DDujgdWLtFoEyYEZWYTRF9KotNgAwWKSR6c7NFak
        8gRO1hd7kDcOMFFVWGEB2xHbFA==
X-Google-Smtp-Source: AA6agR7EKL31HEne7c+QEs97qL44is6/wEkfX62OvNB/cmAa5ZN6XISKO26CdeTItkKMytdiDGts0w==
X-Received: by 2002:a05:6512:3b20:b0:498:d7bc:28af with SMTP id f32-20020a0565123b2000b00498d7bc28afmr7408563lfv.65.1663020026956;
        Mon, 12 Sep 2022 15:00:26 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o25-20020ac25e39000000b00492d270db5esm1288184lfg.242.2022.09.12.15.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 15:00:26 -0700 (PDT)
Message-ID: <09c3d23a-a6f1-b5ec-bff9-3636fcdfca50@linaro.org>
Date:   Tue, 13 Sep 2022 01:00:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 22:40, Bhupesh Sharma wrote:
> Introduce CONFIG_QCOM_THERMAL to allow better control
> over selection of various Qualcomm Thermal drivers
> available inside qcom/ directory.
> 
> This is a preparatory change to allow new drivers to
> be added inside qcom/ directory in a more structured
> fashion later-on.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - v1 can be viewed here: https://www.spinics.net/lists/kernel/msg4510793.html
> - Fixed review comments from Dmitry received in v1.
> 
>   drivers/thermal/Makefile     |  2 +-
>   drivers/thermal/qcom/Kconfig | 12 ++++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..2506c6c8ca83 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>   obj-y				+= intel/
>   obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>   obj-y				+= st/
> -obj-$(CONFIG_QCOM_TSENS)	+= qcom/
> +obj-y				+= qcom/
>   obj-y				+= tegra/
>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>   obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..ccfd090273c1 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,8 +1,17 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +
> +config QCOM_THERMAL
> +	tristate "Thermal drivers on Qualcomm Snapdragon series of SoCs"
> +	help
> +	  Support for thermal drivers on Qualcomm Snapdragon series of SoCs.
> +	  There are several thermal sensors available on the Qualcomm Socs
> +	  which can be used for thermal mitigation purposes.
> +
>   config QCOM_TSENS
>   	tristate "Qualcomm TSENS Temperature Alarm"
>   	depends on NVMEM_QCOM_QFPROM
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_THERMAL

What's the point of QCOM_THERMAL if other drivers are `select'ing it? 
I'd have understood if it would be a menuconfig guarding all Qualcomm 
thermal drivers.

>   	help
>   	  This enables the thermal sysfs driver for the TSENS device. It shows
>   	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
> @@ -15,6 +24,7 @@ config QCOM_SPMI_ADC_TM5
>   	depends on OF && SPMI && IIO
>   	select REGMAP_SPMI
>   	select QCOM_VADC_COMMON
> +	select QCOM_THERMAL
>   	help
>   	  This enables the thermal driver for the ADC thermal monitoring
>   	  device. It shows up as a thermal zone with multiple trip points.
> @@ -25,6 +35,7 @@ config QCOM_SPMI_TEMP_ALARM
>   	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>   	depends on OF && SPMI && IIO
>   	select REGMAP_SPMI
> +	select QCOM_THERMAL
>   	help
>   	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
>   	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
> @@ -35,6 +46,7 @@ config QCOM_SPMI_TEMP_ALARM
>   config QCOM_LMH
>   	tristate "Qualcomm Limits Management Hardware"
>   	depends on ARCH_QCOM && QCOM_SCM
> +	select QCOM_THERMAL
>   	help
>   	  This enables initialization of Qualcomm limits management
>   	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on

-- 
With best wishes
Dmitry

