Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1BB716D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjE3TV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjE3TV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:21:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57445107;
        Tue, 30 May 2023 12:21:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UIhd6q025114;
        Tue, 30 May 2023 19:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5QQJHA1Wb5UJLf+Ixtjsa61IfFR6lSMgqnWzgB6eA9s=;
 b=D76FdEPGzmWwSpJSIPyd8bJLhls5SrbpA5LapIcE9oJl5UhbGcuPCBUYW2xdHvkfRt+9
 VtnINEWwisiEFQtJLQmPzHnGji9kj0VJkJL2fbGT4EsJaWXTbikBcXhIYm+SoIFxs/xF
 r3ij3E9aC2yeQo8gRlcY60sOqOlL6PYr04lY8c0KFcu5PddEnEc5Jut4wEqda7fahi57
 +Dzm2lTdtwg5dHFORqI1RGgGmHtyqCJBK0QK2rpJe8i22XwsrmAIM+2O1gVYaQLj4OkM
 hzd2m3Cqh5VQZCHXhPvHANw4ZyXAuDQ0dyLB2ljRmBbxY5MPpeVYmmXuAC5qI7uFzqUX gA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw7rtt1dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 19:21:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UJL7n0003659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 19:21:07 GMT
Received: from [10.110.116.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 12:21:05 -0700
Message-ID: <b51c8f75-97f8-604d-cf1a-770cca4078aa@quicinc.com>
Date:   Tue, 30 May 2023 12:21:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] Coresight: Add driver to support for CSR
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
 <20230526153508.6208-2-quic_jinlmao@quicinc.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230526153508.6208-2-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XD3sDP0-3bjaeLOm9jlS1cos6TMswgrU
X-Proofpoint-ORIG-GUID: XD3sDP0-3bjaeLOm9jlS1cos6TMswgrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300155
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/2023 8:35 AM, Mao Jinlong wrote:
> This driver provides support for CoreSight Slave Register block
> that hosts miscellaneous configuration registers. Those
> configuration registers can be used to control, various coresight
> configurations.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig         |  12 ++
>   drivers/hwtracing/coresight/Makefile        |   1 +
>   drivers/hwtracing/coresight/coresight-csr.c | 142 ++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-csr.h |  54 ++++++++
>   4 files changed, 209 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-csr.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-csr.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 2b5bbfffbc4f..e769ea3709d9 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -236,4 +236,16 @@ config CORESIGHT_TPDA
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-tpda.
> +
> +config CORESIGHT_CSR
> +	tristate "CoreSight Slave Register driver"
> +	help
> +	  This driver provides support for CoreSight Slave Register block
> +	  that hosts miscellaneous configuration registers.
> +	  Those configuration registers can be used to control, various
> +	  coresight configurations.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-csr.
> +
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 33bcc3f7b8ae..956c642d05f6 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> +obj-$(CONFIG_CORESIGHT_CSR) += coresight-csr.o
> diff --git a/drivers/hwtracing/coresight/coresight-csr.c b/drivers/hwtracing/coresight/coresight-csr.c
> new file mode 100644
> index 000000000000..a1403e8531ee
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-csr.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-csr.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
> +
> +static LIST_HEAD(csr_list);
> +
> +/*
> + * Get the CSR by name.
> + */
> +struct coresight_csr *coresight_csr_get(const char *name)
> +{
> +	struct coresight_csr *csr;
> +
> +	list_for_each_entry(csr, &csr_list, link) {
> +		if (!strcmp(csr->name, name))
> +			return csr;
> +	}
> +	return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL(coresight_csr_get);

EXPORT_SYMBOL_GPL everywhere in this driver please.

> +
> +/*
> + * Get the device node's name from device tree.
> + */
> +int of_get_coresight_csr_name(struct device_node *node, const char **csr_name)
> +{
> +	struct device_node *csr_node;
> +
> +	csr_node = of_parse_phandle(node, "coresight-csr", 0);
> +	if (!csr_node)
> +		return -EINVAL;
> +
> +	*csr_name = csr_node->full_name;
> +	of_node_put(csr_node);
> +	return 0;
> +}
> +EXPORT_SYMBOL(of_get_coresight_csr_name);

---Trilok Soni
