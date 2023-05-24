Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981370EDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjEXGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:13:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC0186;
        Tue, 23 May 2023 23:13:14 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5JYAZ030688;
        Wed, 24 May 2023 06:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O/W1yv0NOGlFkTeOusQRDJ3iNnwAnBc14lLfGXWU75E=;
 b=mGSEGKtLeQE6Y+K7EvC5YKbz7lqIxff4bpsH/IW2TyvJLNoR+hyp1SKIYielDRsUeB03
 zKeq3XJHCO2dxh6dI4ivUDgoUz9AMFMnZDbvwY71CGFY/EEkXIdHM45XhPPZwmCT+QL0
 mZfiFGXOIyn4k0vKqafd248na7jkY5Q9jpyJwBmKfHvK9SGK77fDwBkBcEd1FbCWWY5x
 zF9hKIx2SRNTQpvAp9psqqKIpCA2RE2kDcbp00ZgPgJ2YqagIJ0kibGNaj1TUEU5hpZA
 +xPnt9voCT6jVeYx8liU0bhsDkmW502vqus3yE7k/297D/LEQKCl/Z3wOoKwxU7QH/7W WA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscaur2qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:12:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O6CcxZ010461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:12:38 GMT
Received: from [10.253.37.214] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 23:12:32 -0700
Message-ID: <0be9ea3f-d48c-c475-8081-b80cf2cd50dd@quicinc.com>
Date:   Wed, 24 May 2023 14:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/3] Coresight: Add coresight dummy driver
Content-Language: en-US
From:   Hao Zhang <quic_hazha@quicinc.com>
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
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-2-quic_hazha@quicinc.com>
 <2b02fc8e-4234-30d2-a8dc-3847c574655f@arm.com>
 <c815d436-85aa-be07-e224-4d5d042c847d@quicinc.com>
In-Reply-To: <c815d436-85aa-be07-e224-4d5d042c847d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I9NWGyis-OW6o5fQsstH2-hArAsfkg6q
X-Proofpoint-GUID: I9NWGyis-OW6o5fQsstH2-hArAsfkg6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240052
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 10:56 AM, Hao Zhang wrote:
> Hi Suzuki,
> 
> On 5/5/2023 5:57 PM, Suzuki K Poulose wrote:
>> On 05/05/2023 10:24, Hao Zhang wrote:
>>> Some Coresight devices that kernel don't have permission to access or
>>> configure. So there need driver to register dummy devices as Coresight
>>> devices. It may also be used to define components that may not have
>>> any programming interfaces (e.g, static links), so that paths can be
>>> established in the driver. Provide Coresight API for dummy device
>>> operations, such as enabling and disabling dummy devices. Build the
>>> Coresight path for dummy sink or dummy source for debugging.
>>>
>>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>>>   drivers/hwtracing/coresight/Makefile          |   1 +
>>>   drivers/hwtracing/coresight/coresight-dummy.c | 171 ++++++++++++++++++
>>>   include/linux/coresight.h                     |   1 +
>>>   4 files changed, 184 insertions(+)
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
>>>
>>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>>> b/drivers/hwtracing/coresight/Kconfig
>>> index 2b5bbfffbc4f..06f0a7594169 100644
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>>>         To compile this driver as a module, choose M here: the module 
>>> will be
>>>         called coresight-tpda.
>>> +
>>> +config CORESIGHT_DUMMY
>>> +    tristate "Dummy driver support"
>>> +    help
>>> +      Enables support for dummy driver. Dummy driver can be used for
>>> +      CoreSight sources/sinks that are owned and configured by some
>>> +      other subsystem and use Linux drivers to configure rest of trace
>>> +      path > +
>>> +      To compile this driver as a module, choose M here: the module 
>>> will be
>>> +      called coresight-dummy.
>>>   endif
>>> diff --git a/drivers/hwtracing/coresight/Makefile 
>>> b/drivers/hwtracing/coresight/Makefile
>>> index 33bcc3f7b8ae..995d3b2c76df 100644
>>> --- a/drivers/hwtracing/coresight/Makefile
>>> +++ b/drivers/hwtracing/coresight/Makefile
>>> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>>   coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>>              coresight-cti-sysfs.o
>>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c 
>>> b/drivers/hwtracing/coresight/coresight-dummy.c
>>> new file mode 100644
>>> index 000000000000..ee9881ff4754
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>>> @@ -0,0 +1,171 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/coresight.h>
>>> +#include <linux/of.h>
>>> +#include <linux/pm_runtime.h>
>>
>> Please follow the alphabetical order for the header files ^
>>
> Sure, I will update this in the next patch series.
> 
>>> +
>>> +#include "coresight-priv.h"
>>> +
>>> +struct dummy_drvdata {
>>> +    struct device            *dev;
>>
>> nit: We don't need this really. And that completely removes the need for
>> drvdata too. See below.
>>
>>> +    struct coresight_device        *csdev;
>>> +};
>>> +
>>> +DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
>>> +
>>> +static int dummy_source_enable(struct coresight_device *csdev,
>>> +                   struct perf_event *event, u32 mode)
>>> +{
>>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +    dev_dbg(drvdata->dev, "Dummy source enabled\n");
>>
>>      dev_dbg(csdev->dev.parent, ..");
>>
>> Similarly for all instances below.
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void dummy_source_disable(struct coresight_device *csdev,
>>> +                 struct perf_event *event)
>>> +{
>>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +    dev_dbg(drvdata->dev, "Dummy source disabled\n");
>>> +}
>>> +
>>> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
>>> +                void *data)
>>> +{
>>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +    dev_dbg(drvdata->dev, "Dummy sink enabled\n");
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int dummy_sink_disable(struct coresight_device *csdev)
>>> +{
>>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +    dev_dbg(drvdata->dev, "Dummy sink disabled\n");
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct coresight_ops_source dummy_source_ops = {
>>> +    .enable    = dummy_source_enable,
>>> +    .disable = dummy_source_disable,
>>> +};
>>> +
>>> +static const struct coresight_ops dummy_source_cs_ops = {
>>> +    .source_ops = &dummy_source_ops,
>>> +};
>>> +
>>> +static const struct coresight_ops_sink dummy_sink_ops = {
>>> +    .enable    = dummy_sink_enable,
>>> +    .disable = dummy_sink_disable,
>>> +};
>>> +
>>> +static const struct coresight_ops dummy_sink_cs_ops = {
>>> +    .sink_ops = &dummy_sink_ops,
>>> +};
>>> +
>>> +static int dummy_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct device_node *node = dev->of_node;
>>> +    struct coresight_platform_data *pdata;
>>> +    struct dummy_drvdata *drvdata;
>>> +    struct coresight_desc desc = { 0 };
>>> +
>>> +    if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>>> +
>>> +        desc.name = coresight_alloc_device_name(&source_devs, dev);
>>> +        if (!desc.name)
>>> +            return -ENOMEM;
>>> +
>>> +        desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>>> +        desc.subtype.source_subtype =
>>> +                    CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
>>> +        desc.ops = &dummy_source_cs_ops;
>>> +    } else if (of_device_is_compatible(node, 
>>> "arm,coresight-dummy-sink")) {
>>> +        desc.name = coresight_alloc_device_name(&sink_devs, dev);
>>> +        if (!desc.name)
>>> +            return -ENOMEM;
>>> +
>>> +        desc.type = CORESIGHT_DEV_TYPE_SINK;
>>> +        desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_DUMMY;
>>> +        desc.ops = &dummy_sink_cs_ops;
>>> +    } else {
>>> +        dev_err(dev, "Device type not set\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    pdata = coresight_get_platform_data(dev);
>>> +    if (IS_ERR(pdata))
>>> +        return PTR_ERR(pdata);
>>> +    pdev->dev.platform_data = pdata;
>>> +
>>> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>> +    if (!drvdata)
>>> +        return -ENOMEM; > +
>>> +    drvdata->dev = &pdev->dev;
>>> +    platform_set_drvdata(pdev, drvdata);
>>
>> As above, you may remove the drvdata entirely.
>>
> For some dummy sources, it's needed to allocate traceid for them in 
> kernel driver, so this struct would be useful for that case.
> 
> I will remove it now and upstream it in the further.
> 

Hi Suzuki,

After checking, I find the drvdata struct is required for csdev which 
would store the pointer of coresight_device, and it is also required for 
traceid in the further. So I will keep drvdata in the next patch series.

Thanks,
Hao

> Thanks,
> Hao
> 
>> Otherwise looks good to me
>>
>> Suzuki
>>
