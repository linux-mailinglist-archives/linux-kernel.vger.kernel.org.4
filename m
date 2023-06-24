Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72CA73CA52
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjFXJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFXJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:55:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042A1FFD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:55:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso167488266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687600511; x=1690192511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ggSn0p3HLo2+unzYGYN7WsdbAce0K2IgCOxTMxE64k=;
        b=BOsZzwLL4CV9Rq/0kY5hQMjmZpBy2HSSYn1/AYZDevXeurEb/EKut7HOg2GqcOlT/f
         FC7O6wFHdARTaSaU4K0kE2z6EJYbKXHmu/+N/H9peF6U5UBL4VIhusM7McbtxA2PT0dF
         uRUmDRSUSedd5Hn8cxxxUsN5jufrzknqJh781rF7aR+VX25puPbbIKQbeJ63BQlpSrQR
         +cbiwlN7XldKE7u+WJawjUO8nGkqqpP+OCF0r8oItERsz1oZRG+iO/r1uVkA35lkwJfH
         hb++YyV3kA7OH3qw+jjEi4EqVjyHyPFQvx7ZuRBSrhPYjJmlBZLkDY6mwvS1dFRl7+pL
         ey1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687600511; x=1690192511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ggSn0p3HLo2+unzYGYN7WsdbAce0K2IgCOxTMxE64k=;
        b=l/p4Vg+5N5IWmsgwR7qB86fjgqGlt5j7OqKVclRoRTJV7hZDPJEN4IrfP4EfHg5Koj
         gVI+2nmgM2GRgV1pLqHuLnAnhW54+OWCQBJTU3Fx+rrrDn+hGeVR6Bn2VzOyqQ6T+F1T
         qcN3xOSwzRpE8HZ9kKPyiPlkX2Exc/94fLPAdvoLn0JHpiX/r6v4bSDAx8WWtc4QC9jz
         V15PjJojuAulaN83r8ueK0sz3eh7mEgioqridaXWLES4lSwBkjSWbfPcqKMLiGKmw0c+
         uXjvfJcuevNmNQ51NMF2tKoPaj6u77RDwf+/yMFQIdFHDkL3iJEMWFAmQq0kR5sIO4VM
         SIXw==
X-Gm-Message-State: AC+VfDwN23hcOMuYWJaq76nJr1BHhxsB/SqURtpM09eAeMvv9hiI46qb
        mrG6BUz42ahn/52zO2FMdKoUwg==
X-Google-Smtp-Source: ACHHUZ5zjRbOThh8j3nf0OBEOpbhjF5ZuZKd06Q6eyvg35DgyG1nnbu1SRSk4HgVy3Pgt3+CbGrmyA==
X-Received: by 2002:a17:907:16a3:b0:98c:e3a1:dbd0 with SMTP id hc35-20020a17090716a300b0098ce3a1dbd0mr7156275ejc.6.1687600511131;
        Sat, 24 Jun 2023 02:55:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709061b4e00b009888b71c368sm696448ejg.152.2023.06.24.02.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:55:10 -0700 (PDT)
Message-ID: <42126265-75b6-83be-c3aa-ee2a16cb26dd@linaro.org>
Date:   Sat, 24 Jun 2023 11:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-4-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621185949.2068-4-quic_amelende@quicinc.com>
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

On 21/06/2023 20:59, Anjelique Melendez wrote:
> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig          |   9 +
>  drivers/soc/qcom/Makefile         |   1 +
>  drivers/soc/qcom/qcom-pbs.c       | 343 ++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/qcom-pbs.h |  36 ++++
>  4 files changed, 389 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..226b668f4690 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -260,6 +260,15 @@ config QCOM_APR
>  	  used by audio driver to configure QDSP6
>  	  ASM, ADM and AFE modules.
>  
> +config QCOM_PBS
> +	tristate "PBS trigger support for Qualcomm PMIC"
> +	depends on SPMI
> +	help
> +	  This driver supports configuring software programmable boot sequencer (PBS)
> +	  trigger event through PBS RAM on Qualcomm Technologies, Inc. PMICs.
> +	  This module provides the APIs to the client drivers that wants to send the
> +	  PBS trigger event to the PBS RAM.
> +
>  config QCOM_ICC_BWMON
>  	tristate "QCOM Interconnect Bandwidth Monitor driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..4e154af3877a 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -31,5 +31,6 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>  obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> +obj-$(CONFIG_QCOM_PBS) += qcom-pbs.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
> new file mode 100644
> index 000000000000..4a2bb7ff8031
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom-pbs.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt)	"PBS: %s: " fmt, __func__
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spmi.h>
> +#include <linux/soc/qcom/qcom-pbs.h>
> +
> +#define PBS_CLIENT_TRIG_CTL		0x42
> +#define PBS_CLIENT_SW_TRIG_BIT		BIT(7)
> +#define PBS_CLIENT_SCRATCH1		0x50
> +#define PBS_CLIENT_SCRATCH2		0x51
> +
> +static LIST_HEAD(pbs_dev_list);
> +static DEFINE_MUTEX(pbs_list_lock);

No file-scope variables. Drop both. You don't even need it.

> +
> +struct pbs_dev {
> +	struct device		*dev;
> +	struct device_node	*dev_node;
> +	struct regmap		*regmap;
> +	struct mutex		lock;
> +	struct list_head	link;
> +
> +	u32			base;
> +};
> +
> +static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
> +{
> +	int ret;
> +
> +	address += pbs->base;
> +	ret = regmap_bulk_read(pbs->regmap, address, val, 1);
> +	if (ret)
> +		pr_err("Failed to read address=%#x sid=%#x ret=%d\n",

dev_err

> +			address, to_spmi_device(pbs->dev->parent)->usid, ret);
> +
> +	return ret;
> +}
> +
> +static int qcom_pbs_write(struct pbs_dev *pbs, u16 address, u8 val)
> +{
> +	int ret;
> +
> +	address += pbs->base;
> +	ret = regmap_bulk_write(pbs->regmap, address, &val, 1);
> +	if (ret < 0)
> +		pr_err("Failed to write address=%#x sid=%#x ret=%d\n",
> +			  address, to_spmi_device(pbs->dev->parent)->usid, ret);
> +	else
> +		pr_debug("Wrote %#x to addr %#x\n", val, address);

No, there is regmap debug for this. Drop such debug statements from the
driver.

Actually the error print is also wrong, IMO.

> +
> +	return ret;
> +}
> +
> +static int qcom_pbs_masked_write(struct pbs_dev *pbs, u16 address, u8 mask, u8 val)
> +{
> +	int ret;
> +
> +	address += pbs->base;
> +	ret = regmap_update_bits(pbs->regmap, address, mask, val);
> +	if (ret < 0)
> +		pr_err("Failed to write address=%#x ret=%d\n", address, ret);
> +	else
> +		pr_debug("Wrote %#x to addr %#x\n", val, address);

Drop

> +
> +	return ret;
> +}
> +
> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
> +{
> +	u16 retries = 2000, delay = 1000;
> +	int ret;
> +	u8 val;
> +
> +	while (retries--) {
> +		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val == 0xFF) {
> +			/* PBS error - clear SCRATCH2 register */
> +			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
> +			if (ret < 0)
> +				return ret;
> +
> +			pr_err("NACK from PBS for bit %u\n", bit_pos);
> +			return -EINVAL;
> +		}
> +
> +		if (val & BIT(bit_pos)) {
> +			pr_debug("PBS sequence for bit %u executed!\n", bit_pos);

dev_dbg

> +			break;
> +		}
> +
> +		usleep_range(delay, delay + 100);
> +	}
> +
> +	if (!retries) {
> +		pr_err("Timeout for PBS ACK/NACK for bit %u\n", bit_pos);

dev_err
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_pbs_trigger_single_event() - Trigger PBS sequence without using bitmap.
> + * @pbs: Pointer to PBS device
> + *
> + * This function is used to trigger the PBS that is hooked on the
> + * SW_TRIGGER directly in PBS client.
> + *
> + * Return: 0 on success, < 0 on failure
> + */
> +int qcom_pbs_trigger_single_event(struct pbs_dev *pbs)
> +{
> +	int ret = 0;
> +
> +	if (IS_ERR_OR_NULL(pbs))
> +		return -EINVAL;
> +
> +	mutex_lock(&pbs->lock);
> +	ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_TRIG_CTL, PBS_CLIENT_SW_TRIG_BIT,
> +				PBS_CLIENT_SW_TRIG_BIT);
> +	if (ret < 0)
> +		pr_err("Failed to write register %x ret=%d\n", PBS_CLIENT_TRIG_CTL, ret);

dev_* everywhere

> +	mutex_unlock(&pbs->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(qcom_pbs_trigger_single_event);
> +

...

> +/**
> + * get_pbs_client_device() - Get the PBS device used by client
> + * @dev: Client device
> + *
> + * This function is used to get the PBS device that is being
> + * used by the client.
> + *
> + * Returns: pbs_dev on success, ERR_PTR on failure
> + */
> +struct pbs_dev *get_pbs_client_device(struct device *dev)
> +{
> +	struct device_node *pbs_dev_node;
> +	struct pbs_dev *pbs;
> +
> +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs-client", 0);
> +	if (!pbs_dev_node) {
> +		pr_err("Missing qcom,pbs-client property\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	mutex_lock(&pbs_list_lock);
> +	list_for_each_entry(pbs, &pbs_dev_list, link) {

It does not make sense. You have the reference to the device, so you
have the pbs (via container_of). Don't add some
global-list-lookup-functions.

Look for example at Abel Vesa's ICE patchset.

> +		if (pbs_dev_node == pbs->dev_node) {
> +			of_node_put(pbs_dev_node);
> +			mutex_unlock(&pbs_list_lock);
> +			return pbs;
> +		}
> +	}
> +	mutex_unlock(&pbs_list_lock);

Where is device_link handling?

> +
> +	pr_debug("Unable to find PBS dev_node\n");
> +	of_node_put(pbs_dev_node);
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL(get_pbs_client_device);
> +
> +static int qcom_pbs_probe(struct platform_device *pdev)
> +{
> +	struct pbs_dev *pbs;
> +	u32 val;
> +	int ret;
> +
> +	pbs = devm_kzalloc(&pdev->dev, sizeof(*pbs), GFP_KERNEL);
> +	if (!pbs)
> +		return -ENOMEM;
> +
> +	pbs->dev = &pdev->dev;
> +	pbs->dev_node = pdev->dev.of_node;

Why do you need to store it?

> +	pbs->regmap = dev_get_regmap(pbs->dev->parent, NULL);
> +	if (!pbs->regmap) {
> +		dev_err(pbs->dev, "Couldn't get parent's regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = device_property_read_u32(pbs->dev, "reg", &val);
> +	if (ret < 0) {
> +		dev_err(pbs->dev, "Couldn't find reg, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	pbs->base = val;
> +	mutex_init(&pbs->lock);
> +
> +	platform_set_drvdata(pdev, pbs);
> +
> +	mutex_lock(&pbs_list_lock);
> +	list_add(&pbs->link, &pbs_dev_list);
> +	mutex_unlock(&pbs_list_lock);
> +
> +	return 0;
> +}
> +
> +static int qcom_pbs_remove(struct platform_device *pdev)
> +{
> +	struct pbs_dev *pbs = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&pbs_list_lock);
> +	list_del(&pbs->link);
> +	mutex_unlock(&pbs_list_lock);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_pbs_match_table[] = {
> +	{ .compatible = "qcom,pbs" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_pbs_match_table);
> +
> +static struct platform_driver qcom_pbs_driver = {
> +	.driver = {
> +		.name		= "qcom-pbs",
> +		.of_match_table	= qcom_pbs_match_table,
> +	},
> +	.probe = qcom_pbs_probe,
> +	.remove = qcom_pbs_remove,
> +};
> +module_platform_driver(qcom_pbs_driver)
> +
> +MODULE_DESCRIPTION("QCOM PBS DRIVER");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:qcom-pbs");

Drop alias. Not needed. If you need it, you have missing ID table.

> diff --git a/include/linux/soc/qcom/qcom-pbs.h b/include/linux/soc/qcom/qcom-pbs.h
> new file mode 100644
> index 000000000000..4b065951686a
> --- /dev/null



Best regards,
Krzysztof

