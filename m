Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4201C724044
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjFFK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFFK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96FF1703;
        Tue,  6 Jun 2023 03:55:56 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3569S5u7022237;
        Tue, 6 Jun 2023 10:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cHN0MR6rv7I8UDrHo85o969qF6fGucQSWiRoMaEFFCI=;
 b=aQH605e/l3vUwau5LZ/04VPfK+gpWgXh8XNsdwBbJ0gcKvoMbDhynmqubcwB09UGtpmp
 fAY8s7jmhq8Zx3pEzhdQweePfZMzexdB2gfMLSanAjFB3ITRLiOVUklF+FcEdVAw5Q6H
 oHS6wC7sBTzpE39dbEleYE1Q5le98BSP03trobjpuGBxED5EHxhCojWQ/XTzKxnik/NR
 SuVu2rEYQSbnWBLHbjN5XEDd6dFZB8LOOCmvYVMvEWL89kCToDvUEWv/xkiUAmY81le0
 q/iKc0fmPT8kvl4y9KfVFMA6BXIBCbWDBoPkyGs0ZeB6er12hm+rtrQc9FoTM7iq+auh yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1wgv0s7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 10:55:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356AtbCF001911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 10:55:37 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 03:55:32 -0700
Message-ID: <0f1e6931-b3c6-f7e4-c4fd-bd55e0f286e5@quicinc.com>
Date:   Tue, 6 Jun 2023 18:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 09/11] coresight-tpdm: Add nodes for timestamp request
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-10-git-send-email-quic_taozha@quicinc.com>
 <35b3facc-88bf-189b-513e-9666f4ee1de4@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <35b3facc-88bf-189b-513e-9666f4ee1de4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8U38yvKnGDP5raf8wVWIovsSGCgKuqt_
X-Proofpoint-GUID: 8U38yvKnGDP5raf8wVWIovsSGCgKuqt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/2023 6:19 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> Add nodes to configure the timestamp request based on input
>> pattern match. Each TPDM that support DSB subunit has maximum of
>> n(n<7) TPR registers to configure value for timestamp request
>> based on input pattern match. Eight 32 bit registers providing
>> DSB interface timestamp request  pattern match comparison. And
>> each TPDM that support DSB subunit has maximum of m(m<7) TPMR
>> registers to configure pattern mask for timestamp request. Eight
>> 32 bit registers providing DSB interface timestamp request
>> pattern match mask generation. Add nodes to enable/disable
>> pattern timestamp and set pattern timestamp type.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  48 ++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 182 
>> ++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
>>   3 files changed, 239 insertions(+), 5 deletions(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index c04c735..639b6fb8 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -122,3 +122,51 @@ Description:
>>           Where:
>>           <integer1> : Index number of XPMR register,  the range is 0 
>> to 7
>>           <integer2> : The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt_val
>> +Date:        March 2023
>> +KernelVersion    6.3
>
> Similar to the previous comments, please update this.
Sure, I will update this in the next patch series.
>
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the pattern value of DSB tpdm. Read
>> +        the pattern value of DSB tpdm.
>> +
>> +        Accepts the following two values.
>> +        value 1: Index number of TPR register
>> +        value 2: The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt_mask
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the pattern mask of DSB tpdm. Read
>> +        the pattern mask of DSB tpdm.
>> +
>> +        Accepts the following two values.
>> +        value 1: Index number of TPMR register
>> +        value 2: The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt_ts
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the pattern timestamp of DSB tpdm. Read
>> +        the pattern timestamp of DSB tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Disable DSB pattern timestamp.
>> +        1 : Enable DSB pattern timestamp.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt_type
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the pattern type of DSB tpdm. Read
>> +        the pattern type of DSB tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB pattern type to value.
>> +        1 : Set the DSB pattern type to toggle.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 9387bdf..627de36 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -78,6 +78,27 @@ static void set_trigger_type(struct tpdm_drvdata 
>> *drvdata, u32 *val)
>>           *val &= ~TPDM_DSB_CR_TRIG_TYPE;
>>   }
>>   +static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
>> +{
>> +    /* Set pattern timestamp type and enablement */
>> +    if (drvdata->dsb->patt_ts) {
>> +        *val |= TPDM_DSB_TIER_PATT_TSENAB;
>> +        if (drvdata->dsb->patt_type)
>> +            *val |= TPDM_DSB_TIER_PATT_TYPE;
>> +        else
>> +            *val &= ~TPDM_DSB_TIER_PATT_TYPE;
>> +    } else {
>> +        *val &= ~TPDM_DSB_TIER_PATT_TSENAB;
>> +    }
>> +
>> +    /* Set trigger timestamp */
>> +    if (drvdata->dsb->trig_ts)
>> +        *val |= TPDM_DSB_TIER_XTRIG_TSENAB;
>> +    else
>> +        *val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
>> +
>> +}
>> +
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val, i;
>> @@ -90,6 +111,10 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>                  drvdata->base + TPDM_DSB_EDCMR(i));
>>         for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        writel_relaxed(drvdata->dsb->patt_val[i],
>> +                drvdata->base + TPDM_DSB_TPR(i));
>> +        writel_relaxed(drvdata->dsb->patt_mask[i],
>> +                drvdata->base + TPDM_DSB_TPMR(i));
>>           writel_relaxed(drvdata->dsb->trig_patt_val[i],
>>                   drvdata->base + TPDM_DSB_XPR(i));
>>           writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> @@ -97,11 +122,7 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>       }
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> -    /* Set trigger timestamp */
>> -    if (drvdata->dsb->trig_ts)
>> -        val |= TPDM_DSB_TIER_XTRIG_TSENAB;
>> -    else
>> -        val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
>> +    set_dsb_tier(drvdata, &val);
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> @@ -451,6 +472,153 @@ static ssize_t dsb_edge_ctrl_mask_store(struct 
>> device *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>>   +static ssize_t dsb_patt_val_show(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    int i = 0;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        size += sysfs_emit_at(buf, size,
>> +                  "Index: 0x%x Value: 0x%x\n", i,
>> +                  drvdata->dsb->patt_val[i]);
>> +    }
>
> Similarly here, please check for overflows and stop in case.
Sure, I will update this in the next patch series.
>
>> + spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +/*
>> + * value 1: Index of TPR register
>> + * value 2: Value need to be written
>> + */
>> +static ssize_t dsb_patt_val_store(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       const char *buf,
>> +                       size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long index, val;
>> +
>> +    if (sscanf(buf, "%lx %lx", &index, &val) != 2)
>> +        return -EINVAL;
>> +    if (index >= TPDM_DSB_MAX_PATT)
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->patt_val[index] = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_patt_val);
>> +
>> +static ssize_t dsb_patt_mask_show(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    int i = 0;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        size += sysfs_emit_at(buf, size,
>> +                  "Index: 0x%x Value: 0x%x\n", i,
>> +                  drvdata->dsb->patt_mask[i]);
>
> Same here
Sure, I will update this in the next patch series.
>
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +/*
>> + * value 1: Index of TPMR register
>> + * value 2: Value need to be written
>> + */
>> +static ssize_t dsb_patt_mask_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long index, val;
>> +
>> +    if (sscanf(buf, "%lx %lx", &index, &val) != 2)
>> +        return -EINVAL;
>> +    if (index >= TPDM_DSB_MAX_PATT)
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->patt_mask[index] = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_patt_mask);
>> +
>> +static ssize_t dsb_patt_ts_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>
> minor nit: alignment ?

Is there a criteria for the alignment?

I edit the file by Notepad++, and seems like these lines have been aligned.

>
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->patt_ts);
>> +}
>> +
>> +/*
>> + * value 1: Enable/Disable DSB pattern timestamp
>> + */
>> +static ssize_t dsb_patt_ts_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>
> minor nit: Alignmnet
Same as my previous comment.
>
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->patt_ts = true;
>> +    else
>> +        drvdata->dsb->patt_ts = false;
>
> ultra minor nit:
>
>     drvdata->dsb->patt_ts = !!val;
>
>
>> + spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_patt_ts);
>> +
>> +static ssize_t dsb_patt_type_show(struct device *dev,
>> +                       struct device_attribute *attr, char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->patt_type);
>> +}
>> +
>> +/*
>> + * value 1: Set DSB pattern type
>> + */
>> +static ssize_t dsb_patt_type_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf, size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->patt_type = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_patt_type);
>> +
>>   static ssize_t dsb_trig_patt_val_show(struct device *dev,
>>                          struct device_attribute *attr,
>>                          char *buf)
>> @@ -601,6 +769,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_edge_ctrl.attr,
>>       &dev_attr_dsb_edge_ctrl_mask.attr,
>> +    &dev_attr_dsb_patt_val.attr,
>> +    &dev_attr_dsb_patt_mask.attr,
>> +    &dev_attr_dsb_patt_ts.attr,
>> +    &dev_attr_dsb_patt_type.attr,
>>       &dev_attr_dsb_trig_patt_val.attr,
>>       &dev_attr_dsb_trig_patt_mask.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 55c620f..9ad32a6 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -12,6 +12,8 @@
>>   /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>>   #define TPDM_DSB_TIER        (0x784)
>> +#define TPDM_DSB_TPR(n)        (0x788 + (n * 4))
>> +#define TPDM_DSB_TPMR(n)    (0x7A8 + (n * 4))
>>   #define TPDM_DSB_XPR(n)        (0x7C8 + (n * 4))
>>   #define TPDM_DSB_XPMR(n)    (0x7E8 + (n * 4))
>>   #define TPDM_DSB_EDCR(n)    (0x808 + (n * 4))
>> @@ -24,8 +26,12 @@
>>   /* Enable bit for DSB subunit trigger type */
>>   #define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>>   +/* Enable bit for DSB subunit pattern timestamp */
>> +#define TPDM_DSB_TIER_PATT_TSENAB        BIT(0)
>>   /* Enable bit for DSB subunit trigger timestamp */
>>   #define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
>> +/* Bit for DSB subunit pattern type */
>> +#define TPDM_DSB_TIER_PATT_TYPE        BIT(2)
>>     /* DSB programming modes */
>>   /* Test mode control bit*/
>> @@ -86,6 +92,10 @@
>>    * @mode:             DSB programming mode
>>    * @edge_ctrl:        Save value for edge control
>>    * @edge_ctrl_mask:   Save value for edge control mask
>> + * @patt_val:         Save value for pattern
>> + * @patt_mask:        Save value for pattern mask
>> + * @patt_ts:          Enable/Disable pattern timestamp
>> + * @patt_type:        Set pattern type
>>    * @trig_patt_val:    Save value for trigger pattern
>>    * @trig_patt_mask:   Save value for trigger pattern mask
>>    * @trig_ts:          Enable/Disable trigger timestamp.
>> @@ -95,6 +105,10 @@ struct dsb_dataset {
>>       u32                mode;
>>       u32                edge_ctrl[TPDM_DSB_MAX_EDCR];
>>       u32                edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
>> +    u32                patt_val[TPDM_DSB_MAX_PATT];
>> +    u32                patt_mask[TPDM_DSB_MAX_PATT];
>> +    bool            patt_ts;
>> +    bool            patt_type;
>
> minor nit: Alignment of the bool fields ?
>
> Also, it may be good to move the bool fields together, for better
> packing of the structure.
Sure, I will update in the next patch series.
>
>>       u32 trig_patt_val[TPDM_DSB_MAX_PATT];
>>       u32                trig_patt_mask[TPDM_DSB_MAX_PATT];
>>       bool            trig_ts;
>
> Suzuki
