Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE366FEB54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjEKFnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjEKFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:43:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC32724;
        Wed, 10 May 2023 22:42:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B4xNR2003776;
        Thu, 11 May 2023 05:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tqrcFW/Kr4McDM/n3ZZ8jLRl71o2WgEyYzDiI+ikE30=;
 b=FUd0wl+jaMx23QQDD3GgJKgUzRggjSLc7uaLmtnZN67EX2SiFfkdhuiH1vXlCTqqKRMs
 m7FhZov4+925S1s8Th0cWMAQ5G3RTlg73pJJ6yT4rp6MYx1ZmFp7uiNH8UO+BINHThAW
 DFDWjKp33BV62QfBG4HzcS97OKShCGqsQw0sqDBPsj1nfNGNyYDAmyeI2G1YiwRzvilA
 pdZXzVfYY2JVpnE8XjE13QJo6bL/x61GtKc6kAOokMz/sm9lbZwUdEjIMxT8pEwxkRnj
 cqiIwAWreilAN3/+myn6Dt0m9ldpHQ3ZUYVfZCNE78peDA/Pyq5/Rbd9DdOA54CLRpEt sA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgj140thy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:42:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B5gioq023481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:42:44 GMT
Received: from [10.79.141.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 22:42:40 -0700
Message-ID: <d5341357-e0f4-afb1-20db-7c2d926662fe@quicinc.com>
Date:   Thu, 11 May 2023 11:12:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJppkqN6cuYUCC-THb8wb=deRv-01pbS0JgSGf-VXnm8qEg@mail.gmail.com>
 <82fcfc55-2879-2af0-5a91-4e9481d41976@quicinc.com>
 <CAA8EJprKumrq=Zy0gBqSZ9Dga5mZuauCC4U0GpTs0T4YADrSoA@mail.gmail.com>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <CAA8EJprKumrq=Zy0gBqSZ9Dga5mZuauCC4U0GpTs0T4YADrSoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RtzTWPkLBjdWOjvtQZgRmx6OQArL97WO
X-Proofpoint-ORIG-GUID: RtzTWPkLBjdWOjvtQZgRmx6OQArL97WO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110047
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 6:31 PM, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 15:27, Souradeep Chowdhury
> <quic_schowdhu@quicinc.com> wrote:
>>
>>
>>
>> On 5/9/2023 5:09 PM, Dmitry Baryshkov wrote:
>>> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
>>> <quic_schowdhu@quicinc.com> wrote:
> 
> 
>>>> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
>>>> new file mode 100644
>>>> index 000000000000..ca67b6b5d8eb
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/boot_stats.c
>>>> @@ -0,0 +1,100 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
>>>
>>> Quoting v4 question, which got no answer:
>>>
>>> Some of the platforms DTs define 32KHz clock instead of 32.768 KHz
>>> What should be the divisor in this case?
>>
>> This is the standard divisor used to calculate the pre_abl and abl times
>> across most QCOM SoCs. Can you give an example where the sleep_stat
>> counter has a different frequency?
> 
> Following SoCs declare 37000 as sleep_clk frequency:
> ipq6018, qdu1000, qru1000, sc7280, sm6125, sm6375, sm8350, sm8450, sm8550.
> 
> This might be an error in the dtsi, or might be not.

This sleep_clk is different from the sleep_stats counter of the module 
power manager(MPM) which is used to log the timestamps. This driver is 
tested and verified with sm8450(waipio) which uses the same
frequency(32768).


> 
>>
>>>
>>>> +
>>>> +/**
>>>> + *  struct boot_stats - timestamp information related to boot stats
>>>> + *  @abl_start: Time for the starting point of the abl
>>>> + *  @abl_end: Time when the kernel starts loading from abl
>>>> + */
>>>> +struct boot_stats {
>>>> +       u32 abl_start;
>>>> +       u32 abl_end;
>>>> +} __packed;
>>>> +
>>>> +struct bs_data {
>>>> +       struct boot_stats __iomem *b_stats;
>>>> +       struct dentry *dbg_dir;
>>>> +};
>>>> +
>>>> +static void populate_boot_stats(char *abl_str, char *pre_abl_str, struct bs_data *drvdata)
>>>> +{
>>>> +        u32 abl_time, pre_abl_time;
>>>> +
>>>> +        abl_time = TO_MS(drvdata->b_stats->abl_end) - TO_MS(drvdata->b_stats->abl_start);
>>>> +        sprintf(abl_str, "%u ms", abl_time);
>>>> +
>>>> +        pre_abl_time =  TO_MS(drvdata->b_stats->abl_start);
>>>> +        sprintf(pre_abl_str, "%u ms", pre_abl_time);
>>>
>>> Another point from v4:
>>>
>>> It would be better to move the unit to the file name and include just
>>> the number.
>>
>> Clarified from your first comment
>>
>>>
>>>> +}
>>>> +
>>>> +static int boot_stats_probe(struct platform_device *pdev)
>>>> +{
>>>> +       char abl_str[20], pre_abl_str[20], *abl, *pre_abl;
>>>> +       struct device *bootstat_dev = &pdev->dev;
>>>> +       struct bs_data *drvdata;
>>>> +
>>>> +       drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
>>>> +       if (!drvdata)
>>>> +               return dev_err_probe(bootstat_dev, -ENOMEM, "failed to allocate memory");
>>>> +       platform_set_drvdata(pdev, drvdata);
>>>> +
>>>> +       drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
>>>> +       if (IS_ERR(drvdata->b_stats))
>>>> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->b_stats),
>>>> +                                    "failed to map imem region");
>>>> +
>>>> +       drvdata->dbg_dir = debugfs_create_dir("qcom_boot_stats", NULL);
>>>> +       if (IS_ERR(drvdata->dbg_dir))
>>>> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->dbg_dir),
>>>> +                                    "failed to create debugfs directory");
>>>> +
>>>> +       populate_boot_stats(abl_str, pre_abl_str, drvdata);
>>>> +       abl = abl_str;
>>>> +       pre_abl = pre_abl_str;
>>>> +
>>>> +       debugfs_create_str("pre_abl_time", 0400, drvdata->dbg_dir, (char **)&pre_abl);
>>>> +       debugfs_create_str("abl_time", 0400, drvdata->dbg_dir, (char **)&abl);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +void boot_stats_remove(struct platform_device *pdev)
>>>> +{
>>>> +       struct bs_data *drvdata = platform_get_drvdata(pdev);
>>>> +
>>>> +       debugfs_remove_recursive(drvdata->dbg_dir);
>>>> +}
>>>> +
>>>> +static const struct of_device_id boot_stats_dt_match[] = {
>>>> +       { .compatible = "qcom,imem-bootstats" },
>>>> +       { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>>>> +
>>>> +static struct platform_driver boot_stat_driver = {
>>>> +       .probe  = boot_stats_probe,
>>>> +       .remove_new = boot_stats_remove,
>>>> +       .driver = {
>>>> +               .name = "qcom-boot-stats",
>>>> +               .of_match_table = boot_stats_dt_match,
>>>> +       },
>>>> +};
>>>> +module_platform_driver(boot_stat_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>>>> +MODULE_LICENSE("GPL");
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
> 
