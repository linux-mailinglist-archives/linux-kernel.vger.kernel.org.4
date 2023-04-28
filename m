Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304496F1157
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjD1Fga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD1Fg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:36:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58143581;
        Thu, 27 Apr 2023 22:36:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S4wSXY017050;
        Fri, 28 Apr 2023 05:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gV+97s9mO3CoKC30qh5+p/FM5NfCZi8frpBlCRZKE58=;
 b=ZQYP5UEQT58dNaI637Y3xlDHBnrG9jPc9qVP9zwbIxbZKgpiWnqpl4VzLvg4r/BBSNee
 SJDZMF6ZNJ6VkrUg4gc/9mtl/yHjYeuduQPEuMNJp5grQWcHsykLvDsQzEdYvjTDXjhA
 Cy7Spd4BMT3B8mTU15D3g1Xo+1ldDdbdMZw1Nusdxesd9QAdBPobpSH+JZegGfzp/5FS
 NdOwBqUDxAYmKkMrWSAN9Dqtpf8eTbcE8/4jZmTnBQVSkP6XVqleqgJpNnQrGo32ZXFM
 NMKsqtYPbf5Nk5fARseofo7NUaCWteS0ZuKNxts7nr3BS6NHIHASLNPWq5bMgvBzWOVP Qw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7thv1sdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 05:36:00 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33S5ZxoP025523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 05:35:59 GMT
Received: from [10.253.9.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 27 Apr
 2023 22:35:52 -0700
Message-ID: <d0be9671-bb32-e306-0a0f-c706837df994@quicinc.com>
Date:   Fri, 28 Apr 2023 13:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] Coresight: Add coresight dummy driver
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
 <20230422073714.38844-2-quic_hazha@quicinc.com>
 <6ca3de6d-eaba-f9c1-1809-90902a69564a@arm.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <6ca3de6d-eaba-f9c1-1809-90902a69564a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ITz-8bbq86jgnRZCwb7DL9F5gsuStwLT
X-Proofpoint-ORIG-GUID: ITz-8bbq86jgnRZCwb7DL9F5gsuStwLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280045
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 4/24/2023 8:09 PM, Suzuki K Poulose wrote:
> On 22/04/2023 08:37, Hao Zhang wrote:
>> Some Coresight devices that kernel don't have permission to access or
>> configure. So there need driver to register dummy devices as Coresight
>> devices. It may also be used to define components that may not have
>> any programming interfaces (e.g, static links), so that paths can be
>> established in the driver. Provide Coresight API for dummy device
>> operations, such as enabling and disabling dummy devices. Build the
>> Coresight path for dummy sink or dummy source for debugging.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>>   drivers/hwtracing/coresight/Makefile          |   1 +
>>   drivers/hwtracing/coresight/coresight-dummy.c | 179 ++++++++++++++++++
>>   include/linux/coresight.h                     |   1 +
>>   4 files changed, 192 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index 2b5bbfffbc4f..06f0a7594169 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called coresight-tpda.
>> +
>> +config CORESIGHT_DUMMY
>> +    tristate "Dummy driver support"
>> +    help
>> +      Enables support for dummy driver. Dummy driver can be used for
>> +      CoreSight sources/sinks that are owned and configured by some
>> +      other subsystem and use Linux drivers to configure rest of trace
>> +      path.
>> +
>> +      To compile this driver as a module, choose M here: the module 
>> will be
>> +      called coresight-dummy.
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile 
>> b/drivers/hwtracing/coresight/Makefile
>> index 33bcc3f7b8ae..995d3b2c76df 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>   coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c 
>> b/drivers/hwtracing/coresight/coresight-dummy.c
>> new file mode 100644
>> index 000000000000..1fb8b3d1c170
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>> @@ -0,0 +1,179 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/coresight.h>
>> +#include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "coresight-priv.h"
>> +#include "coresight-trace-id.h"
>> +
>> +struct dummy_drvdata {
>> +    struct device            *dev;
>> +    struct coresight_device        *csdev;
>> +    int                traceid;
>> +};
>> +
>> +DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
>> +
>> +static int dummy_source_enable(struct coresight_device *csdev,
>> +                   struct perf_event *event, u32 mode)
>> +{
>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    dev_dbg(drvdata->dev, "Dummy source enabled\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static void dummy_source_disable(struct coresight_device *csdev,
>> +                 struct perf_event *event)
>> +{
>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    dev_dbg(drvdata->dev, "Dummy source disabled\n");
>> +}
>> +
>> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
>> +                void *data)
>> +{
>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    dev_dbg(drvdata->dev, "Dummy sink enabled\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static int dummy_sink_disable(struct coresight_device *csdev)
>> +{
>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    dev_dbg(drvdata->dev, "Dummy sink disabled\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct coresight_ops_source dummy_source_ops = {
>> +    .enable    = dummy_source_enable,
>> +    .disable = dummy_source_disable,
>> +};
>> +
>> +static const struct coresight_ops dummy_source_cs_ops = {
>> +    .source_ops = &dummy_source_ops,
>> +};
>> +
>> +static const struct coresight_ops_sink dummy_sink_ops = {
>> +    .enable    = dummy_sink_enable,
>> +    .disable = dummy_sink_disable,
>> +};
>> +
>> +static const struct coresight_ops dummy_sink_cs_ops = {
>> +    .sink_ops = &dummy_sink_ops,
>> +};
>> +
>> +static int dummy_probe(struct platform_device *pdev)
>> +{
>> +    int trace_id;
>> +    struct device *dev = &pdev->dev;
>> +    struct device_node *node = dev->of_node;
>> +    struct coresight_platform_data *pdata;
>> +    struct dummy_drvdata *drvdata;
>> +    struct coresight_desc desc = { 0 };
>> +
>> +    if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>> +        trace_id = coresight_trace_id_get_system_id();
> 
> Why is this needed ? If at all we need something, this must be
> explicitly asked for. How is this used ?
>  >
>> +        if (trace_id < 0)
>> +            return trace_id;
>> +
>> +        desc.name = coresight_alloc_device_name(&source_devs, dev);
>> +        if (!desc.name)
>> +            return -ENOMEM;
>> +
>> +        desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>> +        desc.subtype.source_subtype =
>> +                    CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
>> +        desc.ops = &dummy_source_cs_ops;
>> +    } else if (of_device_is_compatible(node, 
>> "arm,coresight-dummy-sink")) {
>> +        desc.name = coresight_alloc_device_name(&sink_devs, dev);
>> +        if (!desc.name)
>> +            return -ENOMEM;
>> +
>> +        desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +        desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_DUMMY;
>> +        desc.ops = &dummy_sink_cs_ops;
>> +    } else {
>> +        dev_err(dev, "Device type not set\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    pdata = coresight_get_platform_data(dev);
>> +    if (IS_ERR(pdata))
>> +        return PTR_ERR(pdata);
>> +    pdev->dev.platform_data = pdata;
>> +
>> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +    if (!drvdata)
>> +        return -ENOMEM;
> 
> If we have allocated a traceid, we must clean it up here and/or at 
> device removal.
>  >> +
>> +    drvdata->dev = &pdev->dev;
>> +    platform_set_drvdata(pdev, drvdata);
>> +
>> +    desc.pdata = pdev->dev.platform_data;
>> +    desc.dev = &pdev->dev;
>> +    drvdata->csdev = coresight_register(&desc);
>> +    if (IS_ERR(drvdata->csdev))
>> +        return PTR_ERR(drvdata->csdev);
>> +
>> +    drvdata->traceid = (u8)trace_id;
> 
> Where/how is this used ?
> 
> Suzuki
> 
This is required for ATID filtering funtion which is our HW design for 
ETR, we need to set traceid/atid for etm, stm and tpda. Therefore, it's 
needed if the type of dummy source is etm. This part is waiting for 
upstream. I will remove it now and upstream it as the part of ATID 
filtering in the further.

Thanks,
Hao
