Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF86CB7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC1HXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC1HXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:23:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420121FD0;
        Tue, 28 Mar 2023 00:23:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6WeI2018774;
        Tue, 28 Mar 2023 07:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1iwiPPvZ+RggNDZ/ZHbhHRXAw72Q3jrMkr5pYQtJA2Q=;
 b=QGrqVNgRGIswl5eAZJA5KsiPpMBjxH8Yx6yD+7UbRiMKyyEEHUe+ztKgxGLxCPcJzzId
 rUoYnEvE3yTSN9uyRUGxJ1oLgKXWHZJKaZF7VCm66Z4hdjru93vkRuuXpN4lbTXfjqhQ
 FKuN5Zc17AFm7XZQLVEB23dGvAgg5fFkF18BitGSa6NOagZS8L+JRV96kwxP6lOmU7Pb
 Rysvrpaj51oJU6KhteYpBQGPDC+SoCIEab+lNGXldPXqBpVDBPG8xmvIUQ5dja8HOzhl
 Fznud1LtbBySWOi+JcJHQlkJXyVqWGOtLmSMdA9FtqIzivpOGsZdTcNyRSox2T4CenUU RQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk79bawnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:22:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S7MsC4028710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:22:54 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 00:22:48 -0700
Message-ID: <0faff427-1f01-8783-9585-32dca872fe45@quicinc.com>
Date:   Tue, 28 Mar 2023 15:22:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] Coresight: Add coresight dummy driver
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-2-quic_hazha@quicinc.com>
 <CAJ9a7VgAJ25CCGwwdfs2DXKaKYoA-BUQAdyZt5udm4qJf9ZQrA@mail.gmail.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <CAJ9a7VgAJ25CCGwwdfs2DXKaKYoA-BUQAdyZt5udm4qJf9ZQrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oT3fzUzT0Be2hZN-efTTVq0nOlN0Z8nT
X-Proofpoint-GUID: oT3fzUzT0Be2hZN-efTTVq0nOlN0Z8nT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280060
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/27/2023 11:58 PM, Mike Leach wrote:
> Hi,
> 
> On Fri, 24 Mar 2023 at 06:16, Hao Zhang <quic_hazha@quicinc.com> wrote:
>>
>> Some Coresight devices that HLOS don't have permission to access
>> or configure. Such as Coresight sink EUD, some TPDMs etc. So there
>> need driver to register dummy devices as Coresight devices. Provide
>> Coresight API for dummy device operations, such as enabling and
>> disabling dummy devices. Build the Coresight path for dummy sink or
>> dummy source for debugging.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>>   drivers/hwtracing/coresight/Makefile          |   1 +
>>   drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
>>   3 files changed, 188 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 2b5bbfffbc4f..06f0a7594169 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>>
>>            To compile this driver as a module, choose M here: the module will be
>>            called coresight-tpda.
>> +
>> +config CORESIGHT_DUMMY
>> +       tristate "Dummy driver support"
>> +       help
>> +         Enables support for dummy driver. Dummy driver can be used for
>> +         CoreSight sources/sinks that are owned and configured by some
>> +         other subsystem and use Linux drivers to configure rest of trace
>> +         path.
>> +
>> +         To compile this driver as a module, choose M here: the module will be
>> +         called coresight-dummy.
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 33bcc3f7b8ae..995d3b2c76df 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>   coresight-cti-y := coresight-cti-core.o        coresight-cti-platform.o \
>>                     coresight-cti-sysfs.o
>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
>> new file mode 100644
>> index 000000000000..2d4eb3e546eb
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
>> +       struct device                   *dev;
>> +       struct coresight_device         *csdev;
>> +       int                             traceid;
>> +};
>> +
>> +DEFINE_CORESIGHT_DEVLIST(dummy_devs, "dummy");
>> +
>> +static int dummy_source_enable(struct coresight_device *csdev,
>> +                              struct perf_event *event, u32 mode)
>> +{
>> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       dev_info(drvdata->dev, "Dummy source enabled\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static void dummy_source_disable(struct coresight_device *csdev,
>> +                                struct perf_event *event)
>> +{
>> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       dev_info(drvdata->dev, "Dummy source disabled\n");
>> +}
>> +
>> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
>> +                               void *data)
>> +{
>> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       dev_info(drvdata->dev, "Dummy sink enabled\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static int dummy_sink_disable(struct coresight_device *csdev)
>> +{
>> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       dev_info(drvdata->dev, "Dummy sink disabled\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct coresight_ops_source dummy_source_ops = {
>> +       .enable         = dummy_source_enable,
>> +       .disable        = dummy_source_disable,
>> +};
>> +
>> +static const struct coresight_ops_sink dummy_sink_ops = {
>> +       .enable         = dummy_sink_enable,
>> +       .disable        = dummy_sink_disable,
>> +};
>> +
>> +static const struct coresight_ops dummy_cs_ops = {
>> +       .source_ops     = &dummy_source_ops,
>> +       .sink_ops       = &dummy_sink_ops,
>> +};
>> +
>> +static int dummy_probe(struct platform_device *pdev)
>> +{
>> +       int ret, trace_id;
>> +       struct device *dev = &pdev->dev;
>> +       struct coresight_platform_data *pdata;
>> +       struct dummy_drvdata *drvdata;
>> +       struct coresight_desc desc = { 0 };
>> +
>> +       desc.name = coresight_alloc_device_name(&dummy_devs, dev);
>> +       if (!desc.name)
>> +               return -ENOMEM;
>> +
>> +       pdata = coresight_get_platform_data(dev);
>> +       if (IS_ERR(pdata))
>> +               return PTR_ERR(pdata);
>> +       pdev->dev.platform_data = pdata;
>> +
>> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +       if (!drvdata)
>> +               return -ENOMEM;
>> +
>> +       drvdata->dev = &pdev->dev;
>> +       platform_set_drvdata(pdev, drvdata);
>> +
>> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,dummy-source")) {
>> +               desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>> +               desc.subtype.source_subtype =
>> +                                       CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
>> +       } else if (of_property_read_bool(pdev->dev.of_node,
>> +                                        "qcom,dummy-sink")) {
>> +               desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +               desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> 
> This will break the automatic sink selection on a system where perf is
> looking for a default sink and the dummy sink is closest  / first
> discovered.
> 
> i.e. when perf record -e cs_etm// <options>
> is used to trace a program in linux, a dummy sink appearing in the
> coresight tree with this designation may be selected.
> 
> This needs to be corrected, probably with a unique sub-type that
> appears before the CORESIGHT_DEV_SUBTYPE_SINK_BUFFER value in the enum
> as the selection is based on >= CORESIGHT_DEV_SUBTYPE_SINK_BUFFER.
> 
> By implication adding a new value - will possibly affect other code
> using the enum values so will need to be checked
> 
> Regards
> 
> Mike
> 

Thanks for your comments, I will add a new sub-type for dummy sink and 
check the impact of it.

Thanks,
Hao

> 
>> +       } else {
>> +               dev_info(dev, "Device type not set\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       desc.ops = &dummy_cs_ops;
>> +       desc.pdata = pdev->dev.platform_data;
>> +       desc.dev = &pdev->dev;
>> +       drvdata->csdev = coresight_register(&desc);
>> +       if (IS_ERR(drvdata->csdev))
>> +               return PTR_ERR(drvdata->csdev);
>> +
>> +       trace_id = coresight_trace_id_get_system_id();
>> +       if (trace_id < 0) {
>> +               ret = trace_id;
>> +               goto cs_unregister;
>> +       }
>> +       drvdata->traceid = (u8)trace_id;
>> +
>> +       pm_runtime_enable(dev);
>> +       dev_info(dev, "Dummy device initialized\n");
>> +
>> +       return 0;
>> +
>> +cs_unregister:
>> +       coresight_unregister(drvdata->csdev);
>> +
>> +       return ret;
>> +}
>> +
>> +static int dummy_remove(struct platform_device *pdev)
>> +{
>> +       struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
>> +       struct device *dev = &pdev->dev;
>> +
>> +       coresight_trace_id_put_system_id(drvdata->traceid);
>> +       pm_runtime_disable(dev);
>> +       coresight_unregister(drvdata->csdev);
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id dummy_match[] = {
>> +       {.compatible = "qcom,coresight-dummy"},
>> +       {},
>> +};
>> +
>> +static struct platform_driver dummy_driver = {
>> +       .probe  = dummy_probe,
>> +       .remove = dummy_remove,
>> +       .driver = {
>> +               .name   = "coresight-dummy",
>> +               .of_match_table = dummy_match,
>> +       },
>> +};
>> +
>> +static int __init dummy_init(void)
>> +{
>> +       return platform_driver_register(&dummy_driver);
>> +}
>> +module_init(dummy_init);
>> +
>> +static void __exit dummy_exit(void)
>> +{
>> +       platform_driver_unregister(&dummy_driver);
>> +}
>> +module_exit(dummy_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("CoreSight dummy source driver");
>> --
>> 2.17.1
>>
> 
> 
