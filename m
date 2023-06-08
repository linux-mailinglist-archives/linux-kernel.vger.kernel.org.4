Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D3727911
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjFHHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFHHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:45:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9C1BF7;
        Thu,  8 Jun 2023 00:45:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3585b6Cf006476;
        Thu, 8 Jun 2023 07:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rPsADric/4vzkPQa9Wmz9QLZDn4DXFKJVBsRL0CAJrA=;
 b=CFEVOLQJfkcIj1KIHKxMVTYrLlYf4suMzj7D2rKvutDQSm4TwaO2vuEx7oxjqPKIJ4Kw
 bVoyU4kUsRhGaLOIVD3Ex+RUrRHgmdJzJ6Flx3vXbAtwsHEAc0Fnh6yP889gUFnp8VbT
 g5FOOjJniDquMEIeQc5V6Aipmgs55wIOXt0tszDD5Odpb4PKELFMbK35PCsnj/ZEIsFB
 HAjwI8aBmD1USQih3Qmw6XU5Q5mEv6h/hRXrc4ig8Bdcx58OOXDsx+vCggDdyWadCpF7
 WdLNrGr079USxsBHcgripiqDKq/SmNJWsGFpv7aIMt779VixtvrcOf6zn4WMyprxo8B6 ug== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r34em0kut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 07:44:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3587iqSU018169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 07:44:52 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 00:44:47 -0700
Message-ID: <03a53571-8e87-d187-de7e-b8cdb671d771@quicinc.com>
Date:   Thu, 8 Jun 2023 15:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 1/3] Coresight: Add coresight dummy driver
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
 <20230602084149.40031-2-quic_hazha@quicinc.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <20230602084149.40031-2-quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CQhQG97_X68PB7Ut7QEYGXNnDzLzOdOj
X-Proofpoint-GUID: CQhQG97_X68PB7Ut7QEYGXNnDzLzOdOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_04,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080064
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Could you please help to review this patch?

Thanks
Hao

On 6/2/2023 4:41 PM, Hao Zhang wrote:
> Some Coresight devices that kernel don't have permission to access or
> configure. For these devices, a dummy driver is needed to register them as
> Coresight devices. The module may also be used to define components that
> may not have any programming interfaces, so that paths can be created
> in the driver. It provides Coresight API for operations on dummy devices,
> such as enabling and disabling them. It also provides the Coresight dummy
> sink/source paths for debugging.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>   drivers/hwtracing/coresight/Makefile          |   1 +
>   drivers/hwtracing/coresight/coresight-dummy.c | 163 ++++++++++++++++++
>   include/linux/coresight.h                     |   1 +
>   4 files changed, 176 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 2b5bbfffbc4f..06f0a7594169 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-tpda.
> +
> +config CORESIGHT_DUMMY
> +	tristate "Dummy driver support"
> +	help
> +	  Enables support for dummy driver. Dummy driver can be used for
> +	  CoreSight sources/sinks that are owned and configured by some
> +	  other subsystem and use Linux drivers to configure rest of trace
> +	  path.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-dummy.
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 33bcc3f7b8ae..995d3b2c76df 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> new file mode 100644
> index 000000000000..42125b7a0f39
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/coresight.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "coresight-priv.h"
> +
> +struct dummy_drvdata {
> +	struct device			*dev;
> +	struct coresight_device		*csdev;
> +};
> +
> +DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
> +
> +static int dummy_source_enable(struct coresight_device *csdev,
> +			       struct perf_event *event, u32 mode)
> +{
> +	dev_dbg(csdev->dev.parent, "Dummy source enabled\n");
> +
> +	return 0;
> +}
> +
> +static void dummy_source_disable(struct coresight_device *csdev,
> +				 struct perf_event *event)
> +{
> +	dev_dbg(csdev->dev.parent, "Dummy source disabled\n");
> +}
> +
> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
> +				void *data)
> +{
> +	dev_dbg(csdev->dev.parent, "Dummy sink enabled\n");
> +
> +	return 0;
> +}
> +
> +static int dummy_sink_disable(struct coresight_device *csdev)
> +{
> +	dev_dbg(csdev->dev.parent, "Dummy sink disabled\n");
> +
> +	return 0;
> +}
> +
> +static const struct coresight_ops_source dummy_source_ops = {
> +	.enable	= dummy_source_enable,
> +	.disable = dummy_source_disable,
> +};
> +
> +static const struct coresight_ops dummy_source_cs_ops = {
> +	.source_ops = &dummy_source_ops,
> +};
> +
> +static const struct coresight_ops_sink dummy_sink_ops = {
> +	.enable	= dummy_sink_enable,
> +	.disable = dummy_sink_disable,
> +};
> +
> +static const struct coresight_ops dummy_sink_cs_ops = {
> +	.sink_ops = &dummy_sink_ops,
> +};
> +
> +static int dummy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct coresight_platform_data *pdata;
> +	struct dummy_drvdata *drvdata;
> +	struct coresight_desc desc = { 0 };
> +
> +	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
> +
> +		desc.name = coresight_alloc_device_name(&source_devs, dev);
> +		if (!desc.name)
> +			return -ENOMEM;
> +
> +		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +		desc.subtype.source_subtype =
> +					CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> +		desc.ops = &dummy_source_cs_ops;
> +	} else if (of_device_is_compatible(node, "arm,coresight-dummy-sink")) {
> +		desc.name = coresight_alloc_device_name(&sink_devs, dev);
> +		if (!desc.name)
> +			return -ENOMEM;
> +
> +		desc.type = CORESIGHT_DEV_TYPE_SINK;
> +		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_DUMMY;
> +		desc.ops = &dummy_sink_cs_ops;
> +	} else {
> +		dev_err(dev, "Device type not set\n");
> +		return -EINVAL;
> +	}
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	pdev->dev.platform_data = pdata;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	desc.pdata = pdev->dev.platform_data;
> +	desc.dev = &pdev->dev;
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev))
> +		return PTR_ERR(drvdata->csdev);
> +
> +	pm_runtime_enable(dev);
> +	dev_dbg(dev, "Dummy device initialized\n");
> +
> +	return 0;
> +}
> +
> +static int dummy_remove(struct platform_device *pdev)
> +{
> +	struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_disable(dev);
> +	coresight_unregister(drvdata->csdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id dummy_match[] = {
> +	{.compatible = "arm,coresight-dummy-source"},
> +	{.compatible = "arm,coresight-dummy-sink"},
> +	{},
> +};
> +
> +static struct platform_driver dummy_driver = {
> +	.probe	= dummy_probe,
> +	.remove	= dummy_remove,
> +	.driver	= {
> +		.name   = "coresight-dummy",
> +		.of_match_table = dummy_match,
> +	},
> +};
> +
> +static int __init dummy_init(void)
> +{
> +	return platform_driver_register(&dummy_driver);
> +}
> +module_init(dummy_init);
> +
> +static void __exit dummy_exit(void)
> +{
> +	platform_driver_unregister(&dummy_driver);
> +}
> +module_exit(dummy_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CoreSight dummy driver");
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index f19a47b9bb5a..6db4b49751cf 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -45,6 +45,7 @@ enum coresight_dev_type {
>   };
>   
>   enum coresight_dev_subtype_sink {
> +	CORESIGHT_DEV_SUBTYPE_SINK_DUMMY,
>   	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>   	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>   	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
