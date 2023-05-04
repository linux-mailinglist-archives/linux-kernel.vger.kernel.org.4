Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AC6F6F23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjEDPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjEDPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:35:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E349D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:35:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so18579358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683214546; x=1685806546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejh4crEBOmtG4UC1kk86Qe+Ml+DMERXcjPl1rLzWy/A=;
        b=ls54MAt8vRmbuJ1pN0j4ExdrRZHf+goxJOCk/9QMiAqwRIBARCMMukGq/VbAKOcY78
         VxEyPKBChJVz+IAbsnORgTExobdIYSaeClyyQxx+7vReGRsZCfRj5cKRxvadkGy+9yRL
         GntWHAQPYQCGLp8OH13fWxsDwlbpFqg+c/5APdKPbIZM15PxLigaHs8HGSddisPFzYjl
         7UqxhldoUQlLoR6qcEVmkjXOJra+5fX+s9IBxQo5+yVsqWYvpp6Um3TuGMUPiu8EeVXq
         hWDdoJwjIVQHPnACEgc2n6ldlghABF1CSS29tYYuI3DZR+QX570Nn0Hg0UiXsVmvSmxt
         HN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214546; x=1685806546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejh4crEBOmtG4UC1kk86Qe+Ml+DMERXcjPl1rLzWy/A=;
        b=h+deNW3tZjlaFl5HJzdNKDO1ohNhUMBLN6Odp50e0wByI8FVDeh+6lWFfvSwExurnQ
         3ef5zlzHWxarAzQDc3UrEZs1e6bSiWltHWqltxxdscFC7F6j1yzLyeuhxpm/ufAFf0fq
         ImD+cJBbRjkDbEX9Kv0UVmz9SR1uwM4CYncvnHzx6hdS3bG4kXp81HYF4C/w0SpUqLF9
         ctZFqv2jeNi27blZIVVeUXvza34QPIzSmhEeJD+TXa7jf+kPTltiRxIFdhrLo0uu/HJu
         2ZmH/4PCzciBUpJ3Dv1zkE5LX3ndNfsEhREEJvw1Ijn7m9ENib8idQH4bf6pMOZAtwG0
         38KQ==
X-Gm-Message-State: AC+VfDy0PSvIIsRDrn7HyboC39TgLsMqV8/eRRKRVCVkoKBscWzY89bE
        xt8DlTF7U3IiY2LZFnTb2fx6Vw==
X-Google-Smtp-Source: ACHHUZ7jzfDt06eS0CGkxF6QauQkCZSpGzNA36btONhIeYYIhlGdGvHung1H+PrKfGrXAL7Q3uqFrg==
X-Received: by 2002:a17:907:72d1:b0:94f:1d54:95d2 with SMTP id du17-20020a17090772d100b0094f1d5495d2mr6179188ejc.15.1683214545801;
        Thu, 04 May 2023 08:35:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906230d00b0094f2f1c5ea1sm19210155eja.174.2023.05.04.08.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:35:44 -0700 (PDT)
Message-ID: <62b81216-120b-40c0-bcf4-d3d3867200e0@linaro.org>
Date:   Thu, 4 May 2023 17:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 09/18] soc: qcom: Add qcom's pstore minidump driver
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-10-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-10-git-send-email-quic_mojha@quicinc.com>
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

On 03/05/2023 19:02, Mukesh Ojha wrote:
> This driver was inspired from the fact pstore ram region should be
> fixed and boot firmware need to have awarness about this region,
> so that it will be persistent across boot. But, there are many
> QCOM SoC which does not support warm boot from hardware but they
> have minidump support from the software, and for them, there is
> no need of this pstore ram region to be fixed, but at the same
> time have interest in the pstore frontends. So, this driver
> get the dynamic reserved region from the ram and register the
> ramoops platform device.
> 
>  +---------+     +---------+   +--------+     +---------+
>  | console |     | pmsg    |   | ftrace |     | dmesg   |
>  +---------+     +---------+   +--------+     +---------+
>        |             |             |              |
>        |             |             |              |
>        +------------------------------------------+
>                           |
>                          \ /
>                   +----------------+
>             (1)   |pstore frontends|
>                   +----------------+
>                           |
>                          \ /
>                  +------------------- +
>             (2)  | pstore backend(ram)|
>                  +--------------------+
>                           |
>                          \ /
>                  +--------------------+
>             (3)  |qcom_pstore_minidump|
>                  +--------------------+
>                           |
>                          \ /
>                    +---------------+
>             (4)    | qcom_minidump |
>                    +---------------+
> 
> This driver will route all the pstore front data to the stored
> in qcom pstore reserved region and the reason of showing an
> arrow from (3) to (4) as qcom_pstore_minidump driver will register
> all the available frontends region with qcom minidump driver
> in upcoming patch.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig                |  11 +++
>  drivers/soc/qcom/Makefile               |   1 +
>  drivers/soc/qcom/qcom_pstore_minidump.c | 116 ++++++++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 15c931e..afdc634 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -293,4 +293,15 @@ config QCOM_MINIDUMP
>  	  these selective regions will be dumped instead of the entire DDR.
>  	  This saves significant amount of time and/or storage space.
>  
> +config QCOM_PSTORE_MINIDUMP
> +	tristate "Pstore support for QCOM Minidump"
> +	depends on ARCH_QCOM
> +	depends on PSTORE_RAM
> +	depends on QCOM_MINIDUMP
> +	help
> +	  Enablement of this driver ensures that ramoops region can be anywhere
> +	  reserved in ram instead of being fixed address which needs boot firmware
> +	  awareness. So, this driver creates plaform device and registers available
> +	  frontend region with the Qualcomm's minidump driver.
> +
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 1ebe081..02d30d7 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
>  obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
> +obj-$(CONFIG_QCOM_PSTORE_MINIDUMP) += qcom_pstore_minidump.o
> diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
> new file mode 100644
> index 0000000..8d58500
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_pstore_minidump.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/pstore_ram.h>
> +#include <soc/qcom/qcom_minidump.h>
> +
> +struct qcom_ramoops_config {
> +	unsigned long	record_size;
> +	unsigned long	console_size;
> +	unsigned long	ftrace_size;
> +	unsigned long	pmsg_size;
> +	unsigned int	mem_type;
> +	unsigned int	flags;
> +	int		max_reason;
> +};
> +
> +struct qcom_ramoops_dd {
> +	struct ramoops_platform_data qcom_ramoops_pdata;
> +	struct platform_device *ramoops_pdev;
> +};
> +
> +static struct qcom_ramoops_config default_ramoops_config = {

Cannot this be const?


> +	.mem_type = 2,
> +	.record_size = 0x0,
> +	.console_size = 0x200000,
> +	.ftrace_size = 0x0,
> +	.pmsg_size = 0x0,
> +};
> +
> +static struct qcom_ramoops_dd *qcom_rdd;

Drop file scope variable. It's not even used.

> +static int qcom_ramoops_probe(struct platform_device *pdev)
> +{
> +	struct device_node *of_node = pdev->dev.of_node;
> +	struct device_node *node;
> +	const struct qcom_ramoops_config *cfg;
> +	struct ramoops_platform_data *pdata;
> +	struct reserved_mem *rmem;
> +	long ret;
> +
> +	node = of_parse_phandle(of_node, "memory-region", 0);
> +	if (!node)
> +		return -ENODEV;
> +
> +	rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +	if (!rmem) {
> +		dev_err(&pdev->dev, "failed to locate DT /reserved-memory resource\n");
> +		return -EINVAL;
> +	}
> +
> +	qcom_rdd = devm_kzalloc(&pdev->dev, sizeof(*qcom_rdd), GFP_KERNEL);
> +	if (!qcom_rdd)
> +		return -ENOMEM;
> +
> +	cfg = of_device_get_match_data(&pdev->dev);
> +	if (!cfg) {
> +		dev_err(&pdev->dev, "failed to get supported matched data\n");
> +		return -ENOENT;
> +	}
> +
> +	pdata = &qcom_rdd->qcom_ramoops_pdata;
> +	pdata->mem_size = rmem->size;
> +	pdata->mem_address = rmem->base;
> +	pdata->mem_type = cfg->mem_type;
> +	pdata->record_size = cfg->record_size;
> +	pdata->console_size = cfg->console_size;
> +	pdata->ftrace_size = cfg->ftrace_size;
> +	pdata->pmsg_size = cfg->pmsg_size;
> +	pdata->max_reason = KMSG_DUMP_PANIC;
> +
> +	qcom_rdd->ramoops_pdev = platform_device_register_data(NULL, "ramoops", -1,
> +							       pdata, sizeof(*pdata));
> +	if (IS_ERR(qcom_rdd->ramoops_pdev)) {
> +		ret = PTR_ERR(qcom_rdd->ramoops_pdev);
> +		dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
> +		qcom_rdd->ramoops_pdev = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_ramoops_remove(struct platform_device *pdev)

Use instead .remove_new callback.

> +{
> +	platform_device_unregister(qcom_rdd->ramoops_pdev);
> +	qcom_rdd->ramoops_pdev = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_ramoops_of_match[] = {
> +	{ .compatible = "qcom,sm8450-ramoops-minidump", .data = &default_ramoops_config },

You don't need this entry.

> +	{ .compatible = "qcom,ramoops-minidump", .data = &default_ramoops_config },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, qcom_ramoops_of_match);

Blank line goes after the MODULE_DEVICE_TABLE, not before.


Best regards,
Krzysztof

