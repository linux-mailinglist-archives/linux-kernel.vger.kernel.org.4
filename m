Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000996F68B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEDJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:53:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29846BE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:52:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so3205191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683193978; x=1685785978;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/afJh8bH/tuC1t+asdJHb/ezmrayWriLxQ8fMkd3vA=;
        b=Hif8EqmA9C2QMNDyyT3bkRyP6xMg66FXo/miU7RmPJz0fhyPquHk+/uCMfT2AMat4N
         2h6TnKAZG/QJG3TGX/919pSYTUALtt/gD028JGhWC78aAvgSSuBOQfLBrS1XK51gQbiU
         JoWs++glwd86xaAkvH8SEHkecAVteqcykEEiegmnY2NFk7H474d9m6qTe0B1Yg/PydA3
         9WzWdRR+Bx4ZFxlzYcMLQCwAsdLVlzrdxy4M0gxmQkJiGkspzd9R8x9BWamyrL8oXBc+
         H0Dfoy5RfJ6yQ3i9Hp74D2YM2PH8xwTvJNjKVbRo/3KmnkHZbT80Ecn8iuNblq0dKXbr
         vtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193978; x=1685785978;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/afJh8bH/tuC1t+asdJHb/ezmrayWriLxQ8fMkd3vA=;
        b=TdDwD65cA5kBgmUn8zPMPVADve52BST0NLZXA85S9Qyutqtu98xIMq7Rv3mcbEF80e
         209InDIOlnGm6UJjjwBk8je1j+mcqD97jVIlRdZ2DjPDDfNDJ0g+RtxjSpr826FDDUy1
         lh543DJi1LDUVya4QD7hyeEB+GRMabQVRllkbY+LyGGYz8CbzwTRvumhv8uY0fAHYylf
         LITdPy8MlDurrDQhoZerIEzS1qVUmceLSwNWqgvM9odTnVOaRqo91Eju86O9baTwCylh
         y/uA1pEu1ciP9vYYdtMV8QR+ZenFM7N8rL7JaxrS+/a3jw182SW/tXFagN1MgdV0/cZs
         wkLw==
X-Gm-Message-State: AC+VfDw07buzGnAuzAmPYSSGusQ94sIdO/cszkJk0rWhj0SQwYdlcUzG
        sAUQBh+DqKdn3VKOGjlX+thB7A==
X-Google-Smtp-Source: ACHHUZ6Uo2GwzwrnFjQF30xD7dWUUZ6HID8Tpr8OtP9D1dHZ59Uhm25BqIhlRRzs6Dnlr8FRK/EziQ==
X-Received: by 2002:a2e:8445:0:b0:2a7:763e:f158 with SMTP id u5-20020a2e8445000000b002a7763ef158mr729113ljh.19.1683193977716;
        Thu, 04 May 2023 02:52:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id d20-20020a2e96d4000000b002aa42d728d9sm566548ljj.36.2023.05.04.02.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:52:57 -0700 (PDT)
Message-ID: <344b34d8-c69e-bde4-7446-30d32657ee40@linaro.org>
Date:   Thu, 4 May 2023 11:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
 <20230504082644.1461582-4-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 3/5] usb: misc: eud: Add driver support for SM6115 /
 SM4250
In-Reply-To: <20230504082644.1461582-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 10:26, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> 
> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 
> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Since this difference comes from how the firmware is configured, so
> the driver now relies on the presence of an extra boolean DT property
> to identify if secure access is needed.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/usb/misc/Kconfig    |  1 +
>  drivers/usb/misc/qcom_eud.c | 66 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 99b15b77dfd5..fe1b5fec1dfc 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
>  config USB_QCOM_EUD
>  	tristate "QCOM Embedded USB Debugger(EUD) Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_SCM
>  	select USB_ROLE_SWITCH
>  	help
>  	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index b7f13df00764..b4736edcc64c 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -5,12 +5,14 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/err.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> @@ -30,15 +32,22 @@
>  #define EUD_INT_SAFE_MODE	BIT(4)
>  #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>  
> +struct eud_soc_cfg {
> +	u32 tcsr_check_offset;
> +};
Not sure if turning this into a struct is necessary.. can't
we just store the offset, or do we expect more changes?

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
> +	bool				secure_mode_enable;
> +	phys_addr_t			secure_mode_mgr;
>  };
>  
>  static int enable_eud(struct eud_chip *priv)
> @@ -46,7 +55,11 @@ static int enable_eud(struct eud_chip *priv)
>  	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>  	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>  			priv->base + EUD_REG_INT1_EN_MASK);
> -	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, BIT(0));
#define [field name] BIT(0)

> +	else
> +		writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
s/1/[field name]/

>  
>  	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
>  }
> @@ -54,7 +67,11 @@ static int enable_eud(struct eud_chip *priv)
>  static void disable_eud(struct eud_chip *priv)
>  {
>  	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> -	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, 0);
> +	else
> +		writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
>  }
>  
>  static ssize_t enable_show(struct device *dev,
> @@ -178,12 +195,15 @@ static void eud_role_switch_release(void *data)
>  static int eud_probe(struct platform_device *pdev)
>  {
>  	struct eud_chip *chip;
> +	struct resource *res;
> +	phys_addr_t tcsr_base, tcsr_check;
>  	int ret;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
> +
?

>  	chip->dev = &pdev->dev;
>  
>  	chip->role_sw = usb_role_switch_get(&pdev->dev);
> @@ -200,9 +220,40 @@ static int eud_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->base))
>  		return PTR_ERR(chip->base);
>  
> -	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(chip->mode_mgr))
> -		return PTR_ERR(chip->mode_mgr);
> +	chip->secure_mode_enable = of_property_read_bool(chip->dev->of_node,
> +						"qcom,secure-mode-enable");
If we map this region iff it's supposed to be used, we may just check
for its presence and skip the additional property. Then, the address
being non-NULL would invalidate the boolean property.

> +	/*
> +	 * EUD block on a few Qualcomm SoCs need secure register access.
> +	 * Check for the same.
> +	 */
> +	if (chip->secure_mode_enable) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get secure_mode_mgr reg base\n");
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
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
I'd vouch to use _byname, in case we get some EUD impl that needs a
different sort of a register set..

> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get tcsr reg base\n");
> +
> +		tcsr_base = res->start;
> +		tcsr_check = tcsr_base + chip->eud_cfg->tcsr_check_offset;
> +
> +		ret = qcom_scm_io_writel(tcsr_check, BIT(0));
s/BIT(0)/..

Konrad
> +		if (ret)
> +			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
> +	}
>  
>  	chip->irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
> @@ -230,8 +281,13 @@ static int eud_remove(struct platform_device *pdev)
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
