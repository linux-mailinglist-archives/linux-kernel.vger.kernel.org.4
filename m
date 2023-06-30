Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9274431A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3UOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3UOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:14:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F72D4A;
        Fri, 30 Jun 2023 13:14:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJBJHV026958;
        Fri, 30 Jun 2023 20:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=KSS9/9mG9hkHIfvpGqmGFrM7BdpMNmFNm5iOeC+uS3c=;
 b=di0sOtjmtdyA3hP2ZFx5yT7nxGGv90OJTwmRbFdgQzv5gs4cgbkUklN5wRwP0Af5OlZw
 47EKUvmzWYT88Nj91gV2NoDCZEVCHtk940FIhjg9iMFV8DHs11PHBODJczJ+BQnRG69D
 QMsVJOG+r1XTFePx7t/KPfBN0yCA4bQRZh0wJ/W5AqwrhNJEb2EPDA9AmoKwDKB8EPGg
 g6hAb+9SonVoe5y32JgJSZhEpFQmEugve/6sU16rFUhNlH2x32+8C4UqskifQDieZQVU
 EXXAxmNlMkB4aVeOr59U2elRyGEZch0zbjsfNucCzgN81XnpsvWhbpgmEb8ayrLfGAou MQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhwuts5u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:14:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UKEdFF032325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:14:39 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 13:14:39 -0700
Date:   Fri, 30 Jun 2023 13:14:38 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support.
Message-ID: <20230630201438.GB1059662@hu-bjorande-lv.qualcomm.com>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-4-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230623141806.13388-4-quic_kbajaj@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _2BiXNPUPLR6NpwV1cgM4zHifrpcnPEp
X-Proofpoint-GUID: _2BiXNPUPLR6NpwV1cgM4zHifrpcnPEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300176
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:48:03PM +0530, Komal Bajaj wrote:
> For some of the Qualcomm SoC's, it is possible that
> some of the fuse regions or entire qfprom region is
> protected from non-secure access. In such situations,
> linux will have to use secure calls to read the region.

Linux

> With that motivation, add secure qfprom driver. Ensuring
> the address to read is word aligned since our secure I/O
> only supports word size I/O.

What do you mean with this last sentence? I don't see anything in your
patch demanding this. Perhaps just drop this sentence?

> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/nvmem/Kconfig      |  12 ++++
>  drivers/nvmem/Makefile     |   2 +
>  drivers/nvmem/sec-qfprom.c | 116 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 drivers/nvmem/sec-qfprom.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index b291b27048c7..2b0dd73d899e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -216,6 +216,18 @@ config NVMEM_QCOM_QFPROM
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_qfprom.
>  
> +config NVMEM_QCOM_SEC_QFPROM
> +        tristate "QCOM SECURE QFPROM Support"
> +        depends on ARCH_QCOM || COMPILE_TEST
> +        depends on HAS_IOMEM
> +        select QCOM_SCM
> +        help
> +          Say y here to enable secure QFPROM support. The secure QFPROM provides access
> +          functions for QFPROM data to rest of the drivers via nvmem interface.
> +
> +          This driver can also be built as a module. If so, the module will be called
> +          nvmem_sec_qfprom.
> +
>  config NVMEM_RAVE_SP_EEPROM
>  	tristate "Rave SP EEPROM Support"
>  	depends on RAVE_SP_CORE
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index f82431ec8aef..4b4bf5880488 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
>  nvmem-nintendo-otp-y			:= nintendo-otp.o
>  obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
>  nvmem_qfprom-y				:= qfprom.o
> +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)     += nvmem_sec_qfprom.o
> +nvmem_sec_qfprom-y                          := sec-qfprom.o
>  obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>  nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
>  obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
> new file mode 100644
> index 000000000000..47b2c71593dd
> --- /dev/null
> +++ b/drivers/nvmem/sec-qfprom.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk.h>

Please review your include list, this and a few others doesn't seem to
be used.

> +#include <linux/device.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +
> +/**
> + * struct sec_sec_qfprom_priv - structure holding secure qfprom attributes
> + *
> + * @qfpseccorrected: iomapped memory space for secure qfprom corrected address space.
> + * @dev: qfprom device structure.
> + */
> +struct sec_qfprom_priv {

There no risk of confusion here, so please drop the "_priv" suffix.

> +	phys_addr_t qfpseccorrected;

Same thing here, so "base" or "addr" would suffice.

> +	struct device *dev;
> +};
> +
> +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
> +{
> +	struct sec_qfprom_priv *priv = context;
> +	u8 *val = _val;
> +	u8 *tmp;
> +	u32 read_val;
> +	unsigned int i;
> +
> +	for (i = 0; i < bytes; i++, reg++) {
> +		if (i == 0 || reg % 4 == 0) {
> +			if (qcom_scm_io_readl(priv->qfpseccorrected + (reg & ~3), &read_val)) {
> +				dev_err(priv->dev, "Couldn't access fuse register\n");
> +				return -EINVAL;
> +			}
> +			tmp = (u8 *)&read_val;
> +		}
> +
> +		val[i] = tmp[reg & 3];
> +	}
> +
> +	return 0;
> +}
> +
> +static void sec_qfprom_runtime_disable(void *data)
> +{
> +	pm_runtime_disable(data);
> +}
> +
> +static int sec_qfprom_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config econfig = {
> +		.name = "sec-qfprom",
> +		.stride = 1,
> +		.word_size = 1,
> +		.id = NVMEM_DEVID_AUTO,
> +		.reg_read = sec_qfprom_reg_read,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct nvmem_device *nvmem;
> +	struct sec_qfprom_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->qfpseccorrected = res->start;
> +	if (!priv->qfpseccorrected)
> +		return -ENOMEM;
> +
> +	econfig.size = resource_size(res);
> +	econfig.dev = dev;
> +	econfig.priv = priv;
> +
> +	priv->dev = dev;
> +
> +	pm_runtime_enable(dev);
> +	ret = devm_add_action_or_reset(dev, sec_qfprom_runtime_disable, dev);
> +	if (ret)
> +		return ret;

Please use devm_pm_runtime_enable().

> +
> +	nvmem = devm_nvmem_register(dev, &econfig);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id sec_qfprom_of_match[] = {
> +	{ .compatible = "qcom,sec-qfprom",},
> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
> +
> +static struct platform_driver qfprom_driver = {
> +	.probe = sec_qfprom_probe,
> +	.driver = {
> +		.name = "qcom,sec_qfprom",

No comma here please, qcom_sec_qfprom.

> +		.of_match_table = sec_qfprom_of_match,
> +	},
> +};
> +module_platform_driver(qfprom_driver);
> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
> +MODULE_LICENSE("GPL v2");

Please change this to "GPL".

Regards,
Bjorn
