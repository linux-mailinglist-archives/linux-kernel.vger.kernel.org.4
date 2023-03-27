Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D916C9E69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjC0Img (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjC0ImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:42:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B37A92;
        Mon, 27 Mar 2023 01:37:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R3g8bq010128;
        Mon, 27 Mar 2023 08:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RQIy2JvdoXqn0+qzm0Zw27EpIjBsbWWGLQt5SS+eSdU=;
 b=UeRV4fl/IMoaCnOSQuigTDbRUFD5xcbOHjREZ6o23GsdMWtUHSh26XhM/VE5oSiybQJW
 ABUkUNZR+C8enyoRldlnCCP6kyz/BOZovvK6raMNFHVNu7P4gKKd6ViyPC3pZBapT1yH
 AfZsYZM0l/Xas4UqX3VImQJO7WE6f4DJT2w3FB6hfjO135D/CqbS4ThhTZvKV2Fz4Mng
 e3SvPQsO+n4rktYqgzqQLzxUfaqov+LV8wyh6f7AAG3HefrQbIu07SgAnVAo+48eGte2
 LE1sQVdAkr/p7rYpGMeyRokU1SF8Zv412jP4fEBmOdWLUoUGG6tp8rfcANUoqMLdwoEF mA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsrauv35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 08:37:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R8bW5s010527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 08:37:32 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 01:37:27 -0700
Message-ID: <4d425700-d6e6-c70b-c7f5-2f64370ecc4e@quicinc.com>
Date:   Mon, 27 Mar 2023 16:37:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/11] coresight-tpdm: Add nodes for timestamp request
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-10-git-send-email-quic_taozha@quicinc.com>
 <859dac2a-8b6b-ba55-f30f-3ac668433a35@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <859dac2a-8b6b-ba55-f30f-3ac668433a35@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9tXSOAHbIkVF1u-2YcUmnbBK68S3tSwN
X-Proofpoint-ORIG-GUID: 9tXSOAHbIkVF1u-2YcUmnbBK68S3tSwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270070
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/24/2023 2:41 AM, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
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
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 172 
>> +++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
>>   3 files changed, 234 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index c06374f..60ff660 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -95,3 +95,51 @@ Description:
>>           Accepts the following two values.
>>           value 1: Index number of XPMR register
>>           value 2: The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt_val
>> +Date:        March 2023
>> +KernelVersion    6.3
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
>> +        0 : Set the DSB pattern timestamp to false
>> +        1 : Set the DSB pattern timestamp to true
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
>
> Sounds a bit strange for "pattern type" to be bool. What does this do ?
> Does it enable/disable something  ?

I think there are two pattern types and controlled by 1 bit in the 
register. It doesn't

really make sense to use Boolean values. I will confirm this and update 
it in the next

patch series.

>
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB pattern type to false
>> +        1 : Set the DSB pattern type to true
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index d6cc6b5..c740681 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -98,6 +98,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>                  drvdata->base + TPDM_DSB_EDCMR(i));
>>         for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        writel_relaxed(drvdata->dsb->patt_val[i],
>> +                drvdata->base + TPDM_DSB_TPR(i));
>> +        writel_relaxed(drvdata->dsb->patt_mask[i],
>> +                drvdata->base + TPDM_DSB_TPMR(i));
>> +    }
>> +
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>
> Why not do all the pattern related writing in one shot, instead
> of two loops ?
I will combine these two loops to one.
>
>> writel_relaxed(drvdata->dsb->trig_patt_val[i],
>>                   drvdata->base + TPDM_DSB_XPR(i));
>>           writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> @@ -105,6 +112,16 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>       }
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> +    /* Set pattern timestamp type and enablement */
>> +    if (drvdata->dsb->patt_ts) {
>> +        val |= TPDM_DSB_TIER_PATT_TSENAB;
>> +        if (drvdata->dsb->patt_type)
>> +            val |= TPDM_DSB_TIER_PATT_TYPE;
>> +        else
>> +            val &= ~TPDM_DSB_TIER_PATT_TYPE;
>> +    } else {
>> +        val &= ~TPDM_DSB_TIER_PATT_TSENAB;
>> +    }
>
> set_dsb_pattern_ts() in line with the other helper functions ?
> Rest looks fine to me.
>
Sure, I will update this in the next patch series.


Tao

> Suzuki
>
>
>>       /* Set trigger timestamp */
>>       if (drvdata->dsb->trig_ts)
>>           val |= TPDM_DSB_TIER_XTRIG_TSENAB;
>> @@ -455,6 +472,157 @@ static ssize_t dsb_edge_ctrl_mask_store(struct 
>> device *dev,
>>       return size;
>>   }
>>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>> +
>> +static ssize_t dsb_patt_val_show(struct device *dev,
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
>> +    spin_unlock(&drvdata->spinlock);
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
>
>> +static ssize_t dsb_patt_ts_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
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
>> +    spin_unlock(&drvdata->spinlock);
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
>
>
>> + */ > +static ssize_t dsb_patt_type_store(struct device *dev,
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
>> +    if (val)
>> +        drvdata->dsb->patt_type = true;
>> +    else
>> +        drvdata->dsb->patt_type = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_patt_type);
>> +
>>   static ssize_t dsb_trig_patt_val_show(struct device *dev,
>>                          struct device_attribute *attr,
>>                          char *buf)
>> @@ -605,6 +773,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
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
>> index 2e8020e..f9d4dd9 100644
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
>>   #define TPDM_DSB_MODE_CYCACC(val)    (val & GENMASK(2, 0))
>> @@ -76,6 +82,10 @@
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
>> @@ -85,6 +95,10 @@ struct dsb_dataset {
>>       u32                mode;
>>       u32                edge_ctrl[TPDM_DSB_MAX_EDCR];
>>       u32                edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
>> +    u32                patt_val[TPDM_DSB_MAX_PATT];
>> +    u32                patt_mask[TPDM_DSB_MAX_PATT];
>> +    bool            patt_ts;
>> +    bool            patt_type;
>>       u32                trig_patt_val[TPDM_DSB_MAX_PATT];
>>       u32                trig_patt_mask[TPDM_DSB_MAX_PATT];
>>       bool            trig_ts;
>
