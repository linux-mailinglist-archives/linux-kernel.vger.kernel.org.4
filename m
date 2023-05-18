Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6858707E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjERK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjERK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:28:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3BA1BD2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:28:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso19776961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684405712; x=1686997712;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frqXrLMqxZVJwjXSoXLQ+n8dLupemHAy++vbMKiVPaA=;
        b=mT7kkX7tXn+gC99FWxK5L4oxD8k96/3CLes6vhjWGFP3myN9FaC+zcIGwFoRYkL94E
         agPLyKLlR0R6yThicFoNXjS0etH9d4CqMVgrx/UTnXeqFSU1tgnsOQ9ZfFKsFWl42GDt
         Ag+Ms0fwVSowSH7tjVTCD29Y9QmEMK10NeRzYGhs/I40flIgOdeNHAh9NnRSGGPGOhQt
         ZFeDxGAL1BlWm9q/eeX2PKSUJY2g7Atq34yRYFcm6odeaLfX3SmLvFXdqkrIBcOr1Ymy
         RRKtFu+wCDBPiFh+LMvMlvbAoE2jRr2tjDYIaqL2I22sVN20B8TbZzfB1QETjf0JEKCF
         W90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684405712; x=1686997712;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frqXrLMqxZVJwjXSoXLQ+n8dLupemHAy++vbMKiVPaA=;
        b=Svxzhp1AdJWldC4HRRLcxSAszZaOaadzfcRQe6cmE/mlHfqvGXff3MahipLQ+SY5CQ
         tY2+8VJOZGbe1+q4WQqIkzX39d+v+5qwEk65iWwUuw6vGNrEFc73IQCZ4IyAAjAqceXJ
         vHqAIWf72N8RKQEsuya/FdbBBpzxZsnxH/HUI223c9Fmh2jQNH4/7c3koByr8du29sxZ
         auNyTgUdwU19fl40vm7keIN/HuXTVzIksoPKwrNHL7ek/jdUtUYqmQv2EwhpVz4v1Ayp
         Hmoh3hKNMiDVyt3/YDXpln7T/Og61WB7y0HkCyhL58GUq9K73jYab6R0dPC7zaPbcPer
         +pbg==
X-Gm-Message-State: AC+VfDzwrkwzJ5GZeJrbixnj+O8GOGAMwCbZqxkwSeC4qBsQ3VAQWv/Y
        U/atL7wq+uUwhGFcOGeCW64kcg==
X-Google-Smtp-Source: ACHHUZ5dbMgDMePc5aC61orf8kU39nqumPvu8biLx0YbCipzhC4wQZpYBW/JQ1Vyh2EMp4FZbQN0EQ==
X-Received: by 2002:a2e:9590:0:b0:2a8:a859:b5c7 with SMTP id w16-20020a2e9590000000b002a8a859b5c7mr10115572ljh.0.1684405712531;
        Thu, 18 May 2023 03:28:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id s15-20020a2e9c0f000000b002a9eba29c39sm220858lji.91.2023.05.18.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 03:28:32 -0700 (PDT)
Message-ID: <e3ed8dc6-61f1-e73c-2bc7-4e57e86b8647@linaro.org>
Date:   Thu, 18 May 2023 12:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, quic_schowdhu@quicinc.com,
        gregkh@linuxfoundation.org
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
 <20230517211756.2483552-5-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v6 4/6] usb: misc: eud: Add driver support for SM6115 /
 SM4250
In-Reply-To: <20230517211756.2483552-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 23:17, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> 
> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 
> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/usb/misc/Kconfig    |  2 +-
>  drivers/usb/misc/qcom_eud.c | 65 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 99b15b77dfd5..51eb5140caa1 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -146,7 +146,7 @@ config USB_APPLEDISPLAY
>  
>  config USB_QCOM_EUD
>  	tristate "QCOM Embedded USB Debugger(EUD) Driver"
> -	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
>  	select USB_ROLE_SWITCH
>  	help
>  	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 74f2aeaccdcb..6face21b7fb7 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -11,9 +11,11 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/usb/role.h>
>  
>  #define EUD_REG_INT1_EN_MASK	0x0024
> @@ -30,15 +32,25 @@
>  #define EUD_INT_SAFE_MODE	BIT(4)
>  #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>  
> +#define EUD_EN2_EN		BIT(0)
> +#define EUD_EN2_DISABLE		(0)
> +#define TCSR_CHECK_EN		BIT(0)
> +
> +struct eud_soc_cfg {
> +	u32 tcsr_check_offset;
> +};
> +
>  struct eud_chip {
>  	struct device			*dev;
>  	struct usb_role_switch		*role_sw;
> +	const struct eud_soc_cfg	*eud_cfg;
>  	void __iomem			*base;
>  	void __iomem			*mode_mgr;
>  	unsigned int			int_status;
>  	int				irq;
>  	bool				enabled;
>  	bool				usb_attached;
> +	phys_addr_t			secure_mode_mgr;
>  };
>  
>  static int enable_eud(struct eud_chip *priv)
> @@ -46,7 +58,11 @@ static int enable_eud(struct eud_chip *priv)
>  	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>  	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>  			priv->base + EUD_REG_INT1_EN_MASK);
> -	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_EN);
> +	else
> +		writel(EUD_EN2_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
>  
>  	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
>  }
> @@ -54,7 +70,11 @@ static int enable_eud(struct eud_chip *priv)
>  static void disable_eud(struct eud_chip *priv)
>  {
>  	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> -	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
> +	else
> +		writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
>  }
>  
>  static ssize_t enable_show(struct device *dev,
> @@ -178,6 +198,8 @@ static void eud_role_switch_release(void *data)
>  static int eud_probe(struct platform_device *pdev)
>  {
>  	struct eud_chip *chip;
> +	struct resource *res;
> +	phys_addr_t tcsr_check;
>  	int ret;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> @@ -200,9 +222,37 @@ static int eud_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->base))
>  		return PTR_ERR(chip->base);
>  
> -	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(chip->mode_mgr))
> -		return PTR_ERR(chip->mode_mgr);
> +	/*
> +	 * EUD block on a few Qualcomm SoCs needs secure register access.
> +	 * Check for the same.
> +	 */
> +	if (of_device_is_compatible(chip->dev->of_node, "qcom,sm6115-eud")) {
I didn't notice that this changed between v4 and v5, but in my v4 review
I suggested using

if (of_property_read_bool(chip->dev->of_node, "qcom,secure-mode-enable"))

as this was the only place where the value of that function was checked
and caching it in the driver struct simply made no sense (as of today, anyway)

checking the device compatible does not scale very well for something
generic, as now it'd require adding each qcom,smABCD-eud to this condition
as well.

> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get secure_mode_mgr reg base\n");
This suggests the reg-name is "secure_mode_mgr" which is not true,
according to your binding patch. I thought about adding a separate
entry, but ultimately this would be against the DT philosophy, as it
references the same physical region as "eud-mode-mgr", just that due
to ACL software running at a higher exception level it's not
directly accessible..

I was debating suggesting moving it to SoC configuration, but that
also depends on the software stack (e.g. there are windows and cros
7280 laptops with different security restrictions).. so I think
the dt property is the way to go.

Konrad
> +
> +		chip->secure_mode_mgr = res->start;
> +	} else {
> +		chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(chip->mode_mgr))
> +			return PTR_ERR(chip->mode_mgr);
> +	}
> +
> +	/* Check for any SoC specific config data */
> +	chip->eud_cfg = of_device_get_match_data(&pdev->dev);
> +	if (chip->eud_cfg) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr-base");
> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get tcsr reg base\n");
> +
> +		tcsr_check = res->start + chip->eud_cfg->tcsr_check_offset;
> +
> +		ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
> +		if (ret)
> +			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
> +	}
>  
>  	chip->irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
> @@ -230,8 +280,13 @@ static int eud_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct eud_soc_cfg sm6115_eud_cfg = {
> +	.tcsr_check_offset = 0x25018,
> +};
> +
>  static const struct of_device_id eud_dt_match[] = {
>  	{ .compatible = "qcom,sc7280-eud" },
> +	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_cfg },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, eud_dt_match);
