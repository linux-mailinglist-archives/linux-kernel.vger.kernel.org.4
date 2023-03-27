Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C726C9C48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjC0HhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjC0HhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:37:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEB4558E;
        Mon, 27 Mar 2023 00:36:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R3aoIC006538;
        Mon, 27 Mar 2023 07:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KDoDOP1Jwy9IgsQQbZALPFVLJTLCRZXS1w5gzGJsXnE=;
 b=W/iKyYqvO19L3G9Ipm85rlvzlkFmJmNPaRaFCO+B1wsCB5i494kCN64Rieyc/uaVz4Bk
 fl8SH9H57BpK5Xr8Xl/x4FtBYAL1L9WC7WGuGnJRsjS7yFbI/Gc+x18TXS5WoA+XpXIG
 a8n/tEDCeNRTi38Qn2lnE1jdeCxooEZqYfT2pXMvraBKiu5ZVhThz5YuT7uHaR8cShQn
 I/xesC5VhILM06UU+KvBkTcAP8rWHyKmQU2Hb99wqYuiVbNrlrSKOe8exNXmYyaqCalq
 DJFr8styTPerOe31pfJqR1Pdq7Nz9K/HmvlxGuMyPHLFGex3IKnxZNQXhMDLHhe5Io3v LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pht50un2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:36:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R7aEqU011794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:36:14 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 00:36:10 -0700
Message-ID: <e4e36906-405e-f69c-02c2-1962efc7474c@quicinc.com>
Date:   Mon, 27 Mar 2023 15:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/11] coresight-tpdm: Add nodes for dsb edge control
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
 <1679551448-19160-8-git-send-email-quic_taozha@quicinc.com>
 <0d6faa00-c630-c739-6a0a-c5cf858a04fa@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <0d6faa00-c630-c739-6a0a-c5cf858a04fa@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8lnScwMrl5b5EsxGRGOY6xhb3i3W26Bs
X-Proofpoint-ORIG-GUID: 8lnScwMrl5b5EsxGRGOY6xhb3i3W26Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270061
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

On 3/24/2023 1:04 AM, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
>> Add the nodes to set value for DSB edge control and DSB edge
>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>> resgisters to configure edge control. DSB edge detection control
>> 00: Rising edge detection
>> 01: Falling edge detection
>> 10: Rising and falling edge detection (toggle detection) > And each 
>> DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>> configure mask. Eight 32 bit registers providing DSB interface
>> edge detection mask control.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  26 ++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 142 
>> ++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
>>   3 files changed, 181 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index f13e282..094d624 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -45,3 +45,29 @@ Description:
>>           tpdm.
>>             Accepts the value needs to be greater than 0.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the edge control of DSB tpdm. Read the
>> +        edge control of DSB tpdm.
>
> Could we not say :
>     Read / Write a set of the edge control registers of the DSB in
>         TPDM
I will update this in the next patch series.
>> +
>> +        Accepts the following three values.
>
> This is a bit confusing, at least to me. This could either mean,
> a single write of values 1-3 are accepted.

Got it. The following three values are required.

>> +        value 1: Start EDCR register number
>> +        value 2: End EDCR register number
>> +        value 3: The value need to be written
>
> But you really mean to say, the writes must be of the following format
>     <integer1> <integer2> <integer3>
>
> where :
>         <integer1> : Start EDCR ...
>         ....
>
I will update this in the next patch series.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the edge control mask of DSB tpdm. Read
>> +        the edge control mask of DSB tpdm.
>> +
>> +        Accepts the following three values.
>> +        value 1: Start EDCMR register number
>> +        value 2: End EDCMR register number
>> +        value 3: The value need to be written
>
> Similarly here.
I will update this in the next patch series.
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 8cd822f..2a0b36c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -88,7 +88,14 @@ static void set_trigger_type(struct tpdm_drvdata 
>> *drvdata, u32 *val)
>>     static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>> -    u32 val;
>> +    u32 val, i;
>> +
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>> +        writel_relaxed(drvdata->dsb->edge_ctrl[i],
>> +               drvdata->base + TPDM_DSB_EDCR(i));
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>> +        writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>> +               drvdata->base + TPDM_DSB_EDCMR(i));
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>>       /* Set trigger timestamp */
>> @@ -311,6 +318,137 @@ static ssize_t dsb_mode_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_mode);
>>   +static ssize_t dsb_edge_ctrl_show(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    int i;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
>> +        size += sysfs_emit_at(buf, size,
>> +                  "Index:0x%x Val:0x%x\n", i,
>> +                  drvdata->dsb->edge_ctrl[i]);
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +/*
>> + * value 1: Start EDCR register number
>> + * value 2: End EDCR register number
>> + * value 3: The value need to be written
>> + * The EDCR registers can include up to 16 32-bit registers, and each
>> + * one can be configured to control up to 16 edge detections(2 bits
>> + * control one edge detection). So a total 256 edge detections can be
>> + * configured. So the starting number(value 1) and ending 
>> number(value 2)
>> + * cannot be greater than 256, and value 1 should be less than value 2.
>> + * The following values are the rage of value 3.
>> + * 0 - Rising edge detection
>> + * 1 - Falling edge detection
>> + * 2 - Rising and falling edge detection (toggle detection)
>> + */
>> +static ssize_t dsb_edge_ctrl_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long start, end, edge_ctrl;
>> +    uint32_t val;
>> +    int i, index, bit, reg;
>> +
>> +    if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
>> +        return -EINVAL;
>> +    if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
>> +        edge_ctrl > 0x2)
>> +        return -EPERM;
>
>     Isn't it an error to provide start > end ?
I will add this check in the next patch series.
>
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = start; i <= end; i++) {
>> +        /*
>> +         * The 32-bit register has 32 bits(NUM_OF_BITS).
>> +         * Each one register can be configured to control 16
>> +         * (NUM_OF_BITS / 2) edge detectioins.
>> +         */
>
>         /*
>          * Each DSB Edge control line requires 2bits.
>          * Thus we have 16 lines in a 32bit word.
>          */
>
> Could we please define something like:
>
> #define EDCRS_PER_WORD            16
> #define EDCR_TO_WORD_IDX(r)        ((r) / EDCRS_PER_WORD)
> #define EDCR_TO_WORD_SHIFT(r)        ((r) % EDCRS_PER_WORD)
> #define EDCR_TO_WORD_MASK(r)        (0x3 << EDCR_TO_WORD_SHIFT((r)))
>
Sure, I will update this in the next patch series.
>> +        reg = i / (NUM_OF_BITS / 2);
>> +        index = i % (NUM_OF_BITS / 2);
>> +        bit = index * 2;
>> +
>
>     reg = EDCR_TO_WORD_IDX(i);
>     mask = EDCR_TO_WORD_MASK(i);
>
>     val &= ~mask;
>     val |= FIELD_PREP(mask, edge_ctrl);
Got it.
>
>> +        val = drvdata->dsb->edge_ctrl[reg];
>> +        val &= ~GENMASK((bit + 1), bit);
>> +        val |= (edge_ctrl << bit);
>
>
>> + drvdata->dsb->edge_ctrl[reg] = val;
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_edge_ctrl);
>> +
>> +static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    int i;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++) {
>
> Why is this not `i < TPDM_DSB_MAX_EDCMR` ?
I will update this in the next patch series.
>
>> +        size += sysfs_emit_at(buf, size,
>> +                  "Index:0x%x Val:0x%x\n", i,
>> +                  drvdata->dsb->edge_ctrl_mask[i]);
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +/*
>> + * value 1: Start EDCMR register number
>> + * value 2: End EDCMR register number
>> + * value 3: The value need to be written
>> + */
>> +static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf,
>> +                         size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long start, end, val;
>> +    u32 set;
>> +    int i, index, reg;
>> +
>> +    if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
>> +        return -EINVAL;
>> +    if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES)
>> +        || (val & ~1UL))
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = start; i <= end; i++) {
>> +        /*
>> +         * The 32-bit register has 32 bits(NUM_OF_BITS).
>> +         * Each one register can be configured to control 32
>> +         * (NUM_OF_BITS) edge detectioin masks.
>
> minor nit: detection.
>
> You could simply say:
>         /*
>          * There is 1 bit per DSB Edge Control line.
>          * Thus we have 32 lines in a 32bit word.
>          */
>          reg = i / 32;
I will update this in the next patch series.
>
>> +        reg = i / NUM_OF_BITS;
>> +        index = (i % NUM_OF_BITS);
>> +
>> +        set = drvdata->dsb->edge_ctrl_mask[reg];
>> +        if (val)
>> +            set |= BIT(index);
>> +        else
>> +            set &= ~BIT(index);
>> +        drvdata->dsb->edge_ctrl_mask[reg] = set;
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>> +
>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>                        struct device_attribute *attr,
>>                        char *buf)
>> @@ -383,6 +521,8 @@ static DEVICE_ATTR_RW(dsb_trig_ts);
>>     static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>> +    &dev_attr_dsb_edge_ctrl.attr,
>> +    &dev_attr_dsb_edge_ctrl_mask.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>>       &dev_attr_dsb_trig_type.attr,
>>       NULL,
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 8fee562..342ef23 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -12,6 +12,8 @@
>>   /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>>   #define TPDM_DSB_TIER        (0x784)
>> +#define TPDM_DSB_EDCR(n)    (0x808 + (n * 4))
>> +#define TPDM_DSB_EDCMR(n)    (0x848 + (n * 4))
>>     /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> @@ -31,6 +33,8 @@
>>   #define TPDM_DSB_TEST_MODE        GENMASK(11, 9)
>>   #define TPDM_DSB_HPSEL        GENMASK(6, 2)
>>   +#define NUM_OF_BITS        32
>
> Please don't use such generic names. Instead define TPDM specific
> helper definitions. See above.
>
I will update this in the next patch series.


Tao

>
> Suzuki
>
>
>> +
>>   /* TPDM integration test registers */
>>   #define TPDM_ITATBCNTRL        (0xEF0)
>>   #define TPDM_ITCNTRL        (0xF00)
>> @@ -57,14 +61,24 @@
>>   #define TPDM_PIDR0_DS_IMPDEF    BIT(0)
>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>   +#define TPDM_DSB_MAX_LINES    256
>> +/* MAX number of EDCR registers */
>> +#define TPDM_DSB_MAX_EDCR    16 > +/* MAX number of EDCMR registers */
>> +#define TPDM_DSB_MAX_EDCMR    8
>> +
>>   /**
>>    * struct dsb_dataset - specifics associated to dsb dataset
>>    * @mode:             DSB programming mode
>> + * @edge_ctrl:        Save value for edge control
>> + * @edge_ctrl_mask:   Save value for edge control mask
>>    * @trig_ts:          Enable/Disable trigger timestamp.
>>    * @trig_type:        Enable/Disable trigger type.
>>    */
>>   struct dsb_dataset {
>>       u32                mode;
>> +    u32                edge_ctrl[TPDM_DSB_MAX_EDCR];
>> +    u32                edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
>>       bool            trig_ts;
>>       bool            trig_type;
>>   };
>
