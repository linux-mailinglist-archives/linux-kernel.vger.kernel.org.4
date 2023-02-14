Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764BD6964C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBNNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBNNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:34:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8C25951
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:34:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gn39so1786930ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YDjG8Xy/0MEGQMnmLZAWlJucRvYnFZ8YQ5lW5zmslw=;
        b=GnhdJNl5F+dT4f0QPFkWh/HlQW4MdEgELiapEgIsoxLtI5wOrWvRMhVqESl0dS/iDA
         RQ+VSacYW4vO+4q2HtiB/EO00aOXed26ltjbYR/TjW4uXkWbuItLAePmyPN5/3NpeLh2
         McWcZrgEBBoA2XnV201PKdSaGLDcldlo30PMGqkWxHTeaM20a3K9rWG7glzGT+CKR6bI
         i1cr82/Z7ZQDf42R5OvM3l9s0SeUGOD5n/IdsC1yCkZdgUdqb4/msmfo/hCmNWIpXWhF
         h9PKpPDLkGO83KvJJSIFiWVWRHlZygoOl7WRXrgcOkWnj/MXmDotO5Qb7q+ddJPU06SM
         Ym5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YDjG8Xy/0MEGQMnmLZAWlJucRvYnFZ8YQ5lW5zmslw=;
        b=LCmzI7WNms0rH1GcFnTUIUt4h9B6XqyY9/c+EzS2sQDrhfoVtIqJRSWRdFdaw/rbH0
         gEw1gXI4bdGQHNpSbvq06jGKiEIAo3+fRQIBmrzRinu95B61dfVCrlIEgUeB7hz2tDYi
         BtVe9cFMH7ZNWK/lITJ4ybU9K0iROd7/T6nfrAJcYZRpGZdU4OZ9rApXsgh5mWY2SS5M
         7H4FvH3xXIzL2XwDBhG0dHdzZQpcZ8xWWEiJFPH1rHqL04MQFinBYzI78UxTAlBhw4LU
         XM8AuqV/OeC3bgySVjCPHbVw0b6wj/tkfxr1GKsWrwCPXMeW7eG5ptRHqj++PRuHVmo4
         r8sA==
X-Gm-Message-State: AO0yUKXVk0vfelI3/umNkkD09fPfbiBuEak/AL0yfNkO3K7FF/zV3OsW
        sPfIibu5KeGQ6T/t9j9u+DEQnVCdyD0pjstH
X-Google-Smtp-Source: AK7set+TtVJrgWeDvuhsfqFjZbsh0bdYPXw/SoieVG8SaEJjy7PHNIWfX2ZT4PCr5LoDnwWjC7XLsA==
X-Received: by 2002:a17:906:36d7:b0:878:5f35:b8d6 with SMTP id b23-20020a17090636d700b008785f35b8d6mr2652951ejc.51.1676381690000;
        Tue, 14 Feb 2023 05:34:50 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b008af3930c394sm8140578ejb.60.2023.02.14.05.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 05:34:49 -0800 (PST)
Message-ID: <7442b4f8-0560-35ea-4b0e-1f249fc5c902@linaro.org>
Date:   Tue, 14 Feb 2023 14:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214120253.1098426-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.02.2023 13:02, Abel Vesa wrote:
> This takes the already existing duplicated support in both ufs-qcom
> and sdhci-msm drivers and makes it a dedicated driver that can be used
> by both mentioned drivers. The reason for this is because, staring with
> SM8550, the ICE IP block is shared between UFS and SDCC, which means we
> need to probe a dedicated device and share it between those two
> consumers. So let's add the ICE dedicated driver as a soc driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig    |  10 ++
>  drivers/soc/qcom/Makefile   |   1 +
>  drivers/soc/qcom/qcom-ice.c | 315 ++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/ice.h      |  61 +++++++
>  4 files changed, 387 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-ice.c
>  create mode 100644 include/soc/qcom/ice.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a8f283086a21..fa76d3ffb4d3 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -275,4 +275,14 @@ config QCOM_ICC_BWMON
>  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
>  	  memory throughput even with lower CPU frequencies.
>  
> +config QCOM_INLINE_CRYPTO_ENGINE
> +	bool "QCOM UFS & SDCC Inline Crypto Engine driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on SCSI_UFS_CRYPTO || MMC_CRYPTO
> +	select QCOM_SCM
> +	help
> +	  Say yes here to support the Qualcomm Inline Crypto Engine driver,
> +	  providing crypto support to Qualcomm storage drivers like UFS
> +	  and SDCC.
> +
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6e88da899f60..30219c164cb0 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> +obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
> diff --git a/drivers/soc/qcom/qcom-ice.c b/drivers/soc/qcom/qcom-ice.c
> new file mode 100644
> index 000000000000..40c9adbc2666
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom-ice.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm ICE (Inline Crypto Engine) support.
> + *
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/qcom_scm.h>
> +
> +#include <soc/qcom/ice.h>
> +
> +#define AES_256_XTS_KEY_SIZE			64
> +
> +/* QCOM ICE registers */
> +
giga nit: other comments don't have a newline between them and
the defines

> +#define QCOM_ICE_REG_CONTROL			0x0000
> +#define QCOM_ICE_REG_RESET			0x0004
> +#define QCOM_ICE_REG_VERSION			0x0008
> +#define QCOM_ICE_REG_FUSE_SETTING		0x0010
> +#define QCOM_ICE_REG_PARAMETERS_1		0x0014
> +#define QCOM_ICE_REG_PARAMETERS_2		0x0018
> +#define QCOM_ICE_REG_PARAMETERS_3		0x001C
> +#define QCOM_ICE_REG_PARAMETERS_4		0x0020
> +#define QCOM_ICE_REG_PARAMETERS_5		0x0024
> +
> +/* QCOM ICE v3.X only */
> +#define QCOM_ICE_GENERAL_ERR_STTS		0x0040
> +#define QCOM_ICE_INVALID_CCFG_ERR_STTS		0x0030
> +#define QCOM_ICE_GENERAL_ERR_MASK		0x0044
> +
> +/* QCOM ICE v2.X only */
> +#define QCOM_ICE_REG_NON_SEC_IRQ_STTS		0x0040
> +#define QCOM_ICE_REG_NON_SEC_IRQ_MASK		0x0044
> +
> +#define QCOM_ICE_REG_NON_SEC_IRQ_CLR		0x0048
> +#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME1	0x0050
> +#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME2	0x0054
> +#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME1	0x0058
> +#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME2	0x005C
> +#define QCOM_ICE_REG_STREAM1_BIST_ERROR_VEC	0x0060
> +#define QCOM_ICE_REG_STREAM2_BIST_ERROR_VEC	0x0064
> +#define QCOM_ICE_REG_STREAM1_BIST_FINISH_VEC	0x0068
> +#define QCOM_ICE_REG_STREAM2_BIST_FINISH_VEC	0x006C
> +#define QCOM_ICE_REG_BIST_STATUS		0x0070
> +#define QCOM_ICE_REG_BYPASS_STATUS		0x0074
> +#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
> +#define QCOM_ICE_REG_ENDIAN_SWAP		0x1004
> +#define QCOM_ICE_REG_TEST_BUS_CONTROL		0x1010
> +#define QCOM_ICE_REG_TEST_BUS_REG		0x1014
> +
> +/* BIST ("built-in self-test"?) status flags */
> +#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
GENMASK(31, 28)?

btw, most of these defines seem unused?

> +
> +#define QCOM_ICE_FUSE_SETTING_MASK		0x1
> +#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
> +#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
> +
> +#define qcom_ice_writel(engine, val, reg)	\
> +	writel((val), (engine)->base + (reg))
> +
> +#define qcom_ice_readl(engine, reg)	\
> +	readl((engine)->base + (reg))
> +
> +/* Only one ICE instance is supported currently by HW */
s/supported currently/currently supported if you meant
"on current SoCs / this driver revision, only one ICE
instance can be running at the same time but that may
change"

or

s/currently/concurrently/ if you meant "only one ICE
instance can be running simultaneously and that won't
change"

> +static struct qcom_ice *engine;
> +
> +static bool qcom_ice_check_supported(struct qcom_ice *ice)
> +{
> +	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> +	struct device *dev = ice->dev;
> +	int major = regval >> 24;
> +	int minor = (regval >> 16) & 0xFF;
> +	int step = regval & 0xFFFF;
FIELD_GET?

> +
> +	ice->supported = true;
> +
> +	/* For now this driver only supports ICE version 3. */
> +	if (major != 3) {
> +		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> +			 major, minor, step);
> +		ice->supported = false;
> +		goto out;
> +	}
> +
> +	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> +		 major, minor, step);
> +
> +	/* If fuses are blown, ICE might not work in the standard way. */
> +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
> +	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> +		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> +		ice->supported = false;
> +		goto out;
> +	}
> +out:
> +	return ice->supported;
> +}
> +
> +void qcom_ice_low_power_mode_enable(struct qcom_ice *ice)
> +{
> +	u32 regval;
> +
> +	if (!ice)
> +		return;
> +
> +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	/*
> +	 * Enable low power mode sequence
> +	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
Pardon my ignorance, but I have no idea how this comment corresponds
to the value OR'd..

> +	 */
> +	regval |= 0x7000;
> +	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> +}
> +
> +static void qcom_ice_optimization_enable(struct qcom_ice *ice)
> +{
> +	u32 regval;
> +
> +	if (!ice)
> +		return;
> +
> +	/* ICE Optimizations Enable Sequence */
> +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	regval |= 0xD807100;
Please use lowercase hex, or de-magic-ify this if you have the means to.

> +	/* ICE HPG requires delay before writing */
> +	udelay(5);
> +	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	udelay(5);
> +}
> +
> +/* Poll until all BIST bits are reset */
> +static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
> +{
> +	int count;
> +	u32 reg;
> +
> +	if (!ice)
> +		return 0;
> +
> +	for (count = 0; count < 100; count++) {
> +		reg = qcom_ice_readl(ice, QCOM_ICE_REG_BIST_STATUS);
> +		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
> +			break;
> +		udelay(50);
> +	}
> +
> +	if (reg)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +int qcom_ice_resume(struct qcom_ice *ice)
> +{
> +	struct device *dev = ice->dev;
> +	int err;
> +
> +	if (!ice)
> +		return 0;
> +
> +	err = qcom_ice_wait_bist_status(ice);
> +	if (err) {
> +		dev_err(dev, "BIST status error (%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_resume);
> +
> +int qcom_ice_enable(struct qcom_ice *ice)
> +{
> +	if (!ice)
> +		return 0;
> +
> +	qcom_ice_low_power_mode_enable(ice);
> +	qcom_ice_optimization_enable(ice);
> +
> +	return qcom_ice_resume(ice);
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_enable);
> +
> +/*
> + * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
double space before "QC ICE requires"

> + * vendor-specific SCM calls for this; it doesn't support the standard way.
> + */
> +int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
> +			 u8 crypto_cap_idx, u8 algorithm_id,
> +			 u8 key_size, const u8 crypto_key[],
> +			 u8 data_unit_size, int slot)
> +{
> +	struct device *dev = ice->dev;
> +	union {
> +		u8 bytes[AES_256_XTS_KEY_SIZE];
> +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> +	} key;
> +	int i;
> +	int err;
> +
> +	if (!config_enable)
> +		return qcom_scm_ice_invalidate_key(slot);
> +
> +	/* Only AES-256-XTS has been tested so far. */
> +	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> +		dev_err_ratelimited(dev,
> +				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
> +				    algorithm_id, key_size);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
> +
> +	/*
> +	 * The SCM call byte-swaps the 32-bit words of the key.  So we have to
> +	 * do the same, in order for the final key be correct.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> +		__cpu_to_be32s(&key.words[i]);
> +
> +	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> +				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> +				   data_unit_size);
> +
> +	memzero_explicit(&key, sizeof(key));
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_program_key);
> +
> +struct qcom_ice *of_qcom_ice_get(struct device *dev)
> +{
> +	struct qcom_ice *ice = ERR_PTR(-EPROBE_DEFER);
> +	struct device_node *np, *node;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	np = dev->of_node;
> +
> +	node = of_parse_phandle(np, "qcom,ice", 0);
> +
> +	if (engine && engine->supported)
> +		if (node == engine->np)
> +			ice = engine;
> +
> +	of_node_put(node);
> +
> +	return ice;
> +}
> +EXPORT_SYMBOL_GPL(of_qcom_ice_get);
> +
> +int qcom_ice_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	if (!qcom_scm_ice_available()) {
> +		dev_warn(dev, "ICE SCM interface not found\n");
> +		return 0;
> +	}
> +
> +	engine = devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> +	if (!engine)
> +		return -ENOMEM;
> +
> +	engine->dev = dev;
> +	engine->np = np;
> +
> +	engine->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(engine->base))
> +		return PTR_ERR(engine->base);
> +
> +	engine->core_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(engine->core_clk))
> +		return dev_err_probe(dev, PTR_ERR(engine->core_clk),
> +				     "failed to get core clk\n");
> +
> +	if (!qcom_ice_check_supported(engine))
> +		return -EOPNOTSUPP;
> +
> +	dev_set_drvdata(dev, engine);
> +
> +	dev_info(dev, "Registered Qualcomm Inline Crypto Engine\n");
Not sure if we want two lines informing us about the presence of ICE
(the other one prints the hw version).. dev_dbg, perhaps?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_ice_of_match_table[] = {
> +	{
> +		.compatible = "qcom,inline-crypto-engine",
> +	},
I think the common way to go about this is to keep the OF match table
entries in a single line, unless you're adding a long-named match_data
variable, so:

{ .compatible = "qcom,inline-crypto-engine" },

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
> +
> +static struct platform_driver qcom_ice_driver = {
> +	.probe		= qcom_ice_probe,
> +	.driver = {> +		.name	= "qcom-ice",
> +		.of_match_table = qcom_ice_of_match_table,
> +	},
Please use either spaces or tabs, consistently, near the
assignments.

Konrad
> +};
> +
> +module_platform_driver(qcom_ice_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> new file mode 100644
> index 000000000000..3ee8add7aeb9
> --- /dev/null
> +++ b/include/soc/qcom/ice.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef __QCOM_ICE_H__
> +#define __QCOM_ICE_H__
> +
> +#include <linux/err.h>
> +
> +struct qcom_ice {
> +	struct device *dev;
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	struct clk *core_clk;
> +
> +	bool supported;
> +};
> +
> +enum qcom_ice_crypto_key_size {
> +	QCOM_ICE_CRYPTO_KEY_SIZE_INVALID	= 0x0,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_128		= 0x1,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
> +};
> +
> +enum qcom_ice_crypto_alg {
> +	QCOM_ICE_CRYPTO_ALG_AES_XTS		= 0x0,
> +	QCOM_ICE_CRYPTO_ALG_BITLOCKER_AES_CBC	= 0x1,
> +	QCOM_ICE_CRYPTO_ALG_AES_ECB		= 0x2,
> +	QCOM_ICE_CRYPTO_ALG_ESSIV_AES_CBC	= 0x3,
> +};
> +
> +#if IS_ENABLED(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)
> +int qcom_ice_enable(struct qcom_ice *ice);
> +int qcom_ice_resume(struct qcom_ice *ice);
> +struct qcom_ice *of_qcom_ice_get(struct device *dev);
> +int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
> +			 u8 crypto_cap_idx, u8 algorithm_id, u8 key_size,
> +			 const u8 crypto_key[], u8 data_unit_size,
> +			 int slot);
> +#else
> +static int qcom_ice_enable(struct qcom_ice *ice) { return 0; }
> +static int qcom_ice_resume(struct qcom_ice *ice) { return 0; }
> +
> +static struct qcom_ice *of_qcom_ice_get(struct device *dev)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
> +			 u8 crypto_cap_idx, u8 algorithm_id, u8 key_size,
> +			 const u8 crypto_key[], u8 data_unit_size,
> +			 int slot)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_QCOM_INLINE_CRYPTO_ENGINE */
> +#endif /* __QCOM_ICE_H__ */
