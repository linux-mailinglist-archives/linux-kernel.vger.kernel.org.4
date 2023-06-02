Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89071FC1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjFBIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjFBIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:31:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4AE47;
        Fri,  2 Jun 2023 01:31:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527sDlY011933;
        Fri, 2 Jun 2023 08:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Iq8yfDyuugqiYdvd7XL6TiazAWFn0ZbxppVnsU3Fq74=;
 b=UTeeVMZmvQPYs/wju/3K09w00xyO2Q4Yct3KjXyhGl1mHoiS4UeUUIxvUihILXcJfrS6
 RkRyJKdbfee2GfHtHSDsZA+s8ZZ3lFybCCYZGY54a6ZAENifWEzag53gLzBWvGalQxlu
 3u1SswHM9hT8J6PNWB2xuY64Pdu8+QTq16lOo1N9fiTWo2IuoTr23WjkaNoakV2xoSwu
 U1L+BpCNAXhiGO01Q5hU/kHbc+2fTbcIjd+I9HrZJIaxuM4UUV4oh07Gti+DOzb4FJRN
 QOvrMX+FIu+SvDK6W9wcJdVnwBncNwECeR01SeoF8s6yRAq09ni+jHXeKuAOqH4AzHxy 4g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugrt5kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:31:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528VG8j031633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:31:16 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 01:31:11 -0700
Message-ID: <53af2f66-dce0-511d-2e93-738b78f081d5@quicinc.com>
Date:   Fri, 2 Jun 2023 16:31:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 06/11] coresight-tpdm: Add node to set dsb programming
 mode
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-7-git-send-email-quic_taozha@quicinc.com>
 <4e413a50-001d-cfbf-99a4-7e612f44ed38@arm.com>
 <053da70b-3d01-a3e5-4703-4e5cf23831ed@quicinc.com>
 <222b86c9-2a6f-cb9f-8803-406a724614c7@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <222b86c9-2a6f-cb9f-8803-406a724614c7@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PF-7yRO1rID3N0wCsfvXgbbbZ6aQ0BJ1
X-Proofpoint-GUID: PF-7yRO1rID3N0wCsfvXgbbbZ6aQ0BJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_05,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020064
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2023 4:25 PM, Suzuki K Poulose wrote:
> On 02/06/2023 03:58, Tao Zhang wrote:
>>
>> On 6/1/2023 5:23 PM, Suzuki K Poulose wrote:
>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>> Add node to set and show programming mode for TPDM DSB subunit.
>>>> Once the DSB programming mode is set, it will be written to the
>>>> register DSB_CR.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 62 
>>>> ++++++++++++++++++++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.h       | 16 ++++++
>>>>   3 files changed, 93 insertions(+)
>>>>
>>>> diff --git 
>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> index 77e67f2..348e167 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> @@ -45,3 +45,18 @@ Description:
>>>>           Accepts only one of the 2 values -  0 or 1.
>>>>           0 : Set the DSB trigger type to false
>>>>           1 : Set the DSB trigger type to true
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_mode
>>>> +Date:        March 2023
>>>> +KernelVersion    6.3
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        (Write) Set the mode of DSB tpdm. Read the mode of DSB
>>>> +        tpdm.
>>>> +
>>>> +        Accepts the value needs to be greater than 0. What data
>>>> +        bits do is listed below.
>>>> +        Bit[0:1] : Test mode control bit for choosing the inputs.
>>>> +        Bit[3] : Set to 0 for low performance mode.
>>>> +                 Set to 1 for high performance mode.
>>>> +        Bit[4:8] : Select byte lane for high performance mode.
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> index 14f4352..1bacaa5 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> @@ -4,6 +4,7 @@
>>>>    */
>>>>     #include <linux/amba/bus.h>
>>>> +#include <linux/bitfield.h>
>>>>   #include <linux/bitmap.h>
>>>>   #include <linux/coresight.h>
>>>>   #include <linux/coresight-pmu.h>
>>>> @@ -43,6 +44,32 @@ static void tpdm_reset_datasets(struct 
>>>> tpdm_drvdata *drvdata)
>>>>       }
>>>>   }
>>>>   +static void set_dsb_test_mode(struct tpdm_drvdata *drvdata, u32 
>>>> *val)
>>>> +{
>>>> +    u32 mode;
>>>> +
>>>> +    mode = TPDM_DSB_MODE_TEST(drvdata->dsb->mode);
>>>> +    *val &= ~TPDM_DSB_TEST_MODE;
>>>> +    *val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
>>>> +}
>>>> +
>>>> +static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 
>>>> *val)
>>>> +{
>>>> +    u32 mode;
>>>> +
>>>> +    mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
>>>> +    *val &= ~TPDM_DSB_HPSEL;
>>>> +    *val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
>>>> +}
>>>> +
>>>> +static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
>>>> +{
>>>> +    if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
>>>> +        *val |= TPDM_DSB_CR_MODE;
>>>> +    else
>>>> +        *val &= ~TPDM_DSB_CR_MODE;
>>>> +}
>>>> +
>>>>   static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>>>>   {
>>>>       if (drvdata->dsb->trig_type)
>>>> @@ -64,6 +91,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>>>> *drvdata)
>>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>>>         val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>>> +    /* Set the test accurate mode */
>>>> +    set_dsb_test_mode(drvdata, &val);
>>>> +    /* Set the byte lane for high-performance mode */
>>>> +    set_dsb_hpsel_mode(drvdata, &val);
>>>> +    /* Set the performance mode */
>>>> +    set_dsb_perf_mode(drvdata, &val);
>>>>       /* Set trigger type */
>>>>       set_trigger_type(drvdata, &val);
>>>>       /* Set the enable bit of DSB control register to 1 */
>>>> @@ -252,6 +285,34 @@ static struct attribute_group tpdm_attr_grp = {
>>>>       .attrs = tpdm_attrs,
>>>>   };
>>>>   +static ssize_t dsb_mode_show(struct device *dev,
>>>> +                  struct device_attribute *attr,
>>>> +                  char *buf)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +
>>>> +    return sysfs_emit(buf, "%lx\n",
>>>> +             (unsigned long)drvdata->dsb->mode);
>>>> +}
>>>> +
>>>> +static ssize_t dsb_mode_store(struct device *dev,
>>>> +                   struct device_attribute *attr,
>>>> +                   const char *buf,
>>>> +                   size_t size)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +    unsigned long val;
>>>> +
>>>> +    if ((kstrtoul(buf, 0, &val)) || val < 0)
>>>> +        return -EINVAL;
>>>> +
>>>> +    spin_lock(&drvdata->spinlock);
>>>> +    drvdata->dsb->mode = val & TPDM_MODE_ALL;
>>>> +    spin_unlock(&drvdata->spinlock);
>>>> +    return size;
>>>> +}
>>>> +static DEVICE_ATTR_RW(dsb_mode);
>>>> +
>>>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>>>                        struct device_attribute *attr, char *buf)
>>>>   {
>>>> @@ -323,6 +384,7 @@ static ssize_t dsb_trig_ts_store(struct device 
>>>> *dev,
>>>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>>>     static struct attribute *tpdm_dsb_attrs[] = {
>>>> +    &dev_attr_dsb_mode.attr,
>>>>       &dev_attr_dsb_trig_ts.attr,
>>>>       &dev_attr_dsb_trig_type.attr,
>>>>       NULL,
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> index 68f33bd..79df07e 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> @@ -15,11 +15,25 @@
>>>>     /* Enable bit for DSB subunit */
>>>>   #define TPDM_DSB_CR_ENA        BIT(0)
>>>> +/* Enable bit for DSB subunit perfmance mode */
>>>> +#define TPDM_DSB_CR_MODE        BIT(1)
>>>>   /* Enable bit for DSB subunit trigger type */
>>>>   #define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>>>> +
>>>>   /* Enable bit for DSB subunit trigger timestamp */
>>>>   #define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
>>>>   +/* DSB programming modes */
>>>> +/* Test mode control bit*/
>>>> +#define TPDM_DSB_MODE_TEST(val)    (val & GENMASK(1, 0))
>>>> +/* Perforceman mode */
>>>
>>> minor nit: typo ^^
>> I will update this in the next patch series.
>>>
>>>> +#define TPDM_DSB_MODE_PERF BIT(3)
>>>> +/* High performance mode */
>>>> +#define TPDM_DSB_MODE_HPBYTESEL(val)    (val & GENMASK(8, 4))
>>>> +#define TPDM_MODE_ALL            (0xFFFFFFF)
>>>
>>> GENMASK(27, 0) ?
>>>
>>> Also, why do we cover bits 27-0 ?
>>
>> The TPDM mode is only represented by [0:8]bits.
>>
>> Can I replace it with "#define TPDM_DSB_MODE(val)    (VAL & 
>> GENMASK(8, 0))"?
>
> #define TPDM_DSB_MODE_MASK        GENMASK(8, 0) ?

Sure, I will change it in the next patch series.


Best,

Tao

>
> Suzuki
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
