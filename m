Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F636C9BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjC0HWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC0HWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:22:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0121715;
        Mon, 27 Mar 2023 00:22:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R36H1K028548;
        Mon, 27 Mar 2023 07:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BFTwjnnLVnMYnWpur9VUyVGY/BDEtMk3go8Je1SFh1c=;
 b=Oo7sMDL1wEA2BfWwsL1lgLhnAq9/HfCaz8uFDMO8mOi5LsN1JTnmZJCgNOaCm7gr2Wxl
 TJt0BJKkVlM7CQWGbSNRU9k+SIthozkzjwwN7dpOa5SwcAMxY9oX7ZKtZXaBKwoT8xv6
 fjeObTBu38zxNXbAfFhnpqFW4sBemNAMtQ8lKTz6EzlB9GPmwE2CBMDFqQU5GJK26vvO
 2g3VdTkRUf6NnxhxrQcQD7GeNs1uLOAcDATn78Kd+CTz8j5r6rUpjwlfgv0+7kJO2y60
 /Ley3DggSvtkaWB3Pwpjie4WVhNjFEum7gEwVJjBsIVOcVd6JbuIY9GRgJpeTT1C2pvy 8A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pht50um5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:21:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R7LuGN023108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:21:56 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 00:21:52 -0700
Message-ID: <1cb86f14-69d8-1654-9d8e-a87d6078ff97@quicinc.com>
Date:   Mon, 27 Mar 2023 15:21:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/11] coresight-tpdm: Add node to set dsb programming
 mode
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-7-git-send-email-quic_taozha@quicinc.com>
 <ab840019-a44c-3d72-1dd5-5ef3071f139a@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <ab840019-a44c-3d72-1dd5-5ef3071f139a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gMRBSFGSs8OrtacD0Aa2xt9NUof9Azrx
X-Proofpoint-ORIG-GUID: gMRBSFGSs8OrtacD0Aa2xt9NUof9Azrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270059
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

On 3/23/2023 10:55 PM, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
>> Add node to set and show programming mode for TPDM DSB subunit.
>> Once the DSB programming mode is set, it will be written to the
>> register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
>> the DSB test mode.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 62 
>> ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       | 13 +++++
>>   3 files changed, 85 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 27ce681..f13e282 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -35,3 +35,13 @@ Description:
>>           Accepts only one of the 2 values -  0 or 1.
>>           0 : Set the DSB trigger type to false
>>           1 : Set the DSB trigger type to true
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_mode
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the mode of DSB tpdm. Read the mode of DSB
>> +        tpdm.
>> +
>> +        Accepts the value needs to be greater than 0.
>
> Please could you document the values ?
I will update this in the next patch series.
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index e28cf10..8cd822f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -4,6 +4,7 @@
>>    */
>>     #include <linux/amba/bus.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/bitmap.h>
>>   #include <linux/coresight.h>
>>   #include <linux/coresight-pmu.h>
>> @@ -51,6 +52,32 @@ static int tpdm_init_datasets(struct tpdm_drvdata 
>> *drvdata)
>>       return 0;
>>   }
>>   +static void set_dsb_cycacc_mode(struct tpdm_drvdata *drvdata, u32 
>> *val)
>> +{
>> +    u32 mode;
>> +
>> +    mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
>> +    *val &= ~TPDM_DSB_TEST_MODE;
>> +    *val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
>> +}
>> +
>> +static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 *val)
>> +{
>> +    u32 mode;
>> +
>> +    mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
>> +    *val &= ~TPDM_DSB_HPSEL;
>> +    *val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
>> +}
>> +
>> +static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
>> +{
>> +    if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
>> +        *val |= TPDM_DSB_CR_MODE;
>> +    else
>> +        *val &= ~TPDM_DSB_CR_MODE;
>> +}
>> +
>>   static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>>   {
>>       if (drvdata->dsb->trig_type)
>> @@ -72,6 +99,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    /* Set the cycle accurate mode */
>> +    set_dsb_cycacc_mode(drvdata, &val);
>> +    /* Set the byte lane for high-performance mode */
>> +    set_dsb_hpsel_mode(drvdata, &val);
>> +    /* Set the performance mode */
>> +    set_dsb_perf_mode(drvdata, &val);
>>       /* Set trigger type */
>>       set_trigger_type(drvdata, &val);
>>       /* Set the enable bit of DSB control register to 1 */
>> @@ -250,6 +283,34 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_mode_show(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%lx\n",
>> +             (unsigned long)drvdata->dsb->mode);
>> +}
>> +
>> +static ssize_t dsb_mode_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf,
>> +                   size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || val < 0)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->mode = val & TPDM_MODE_ALL;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_mode);
>> +
>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>                        struct device_attribute *attr,
>>                        char *buf)
>> @@ -321,6 +382,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>     static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>>       &dev_attr_dsb_trig_type.attr,
>>       NULL,
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 68f33bd..8fee562 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -15,11 +15,22 @@
>>     /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> +/* Enable bit for DSB subunit perfmance mode */
>> +#define TPDM_DSB_CR_MODE        BIT(1)
>>   /* Enable bit for DSB subunit trigger type */
>>   #define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>> +
>>   /* Enable bit for DSB subunit trigger timestamp */
>>   #define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
>>   +/* DSB programming modes */
>> +#define TPDM_DSB_MODE_CYCACC(val)    (val & GENMASK(2, 0))
>
> What do the values for the CYCACC mode mean ?

It means cycle accurate mode.  The targets may no longer have that mode. 
I will

make a final check and update this in the next patch series.

>
>> +#define TPDM_DSB_MODE_PERF        BIT(3)
>> +#define TPDM_DSB_MODE_HPBYTESEL(val)    (val & GENMASK(8, 4))
>> +#define TPDM_MODE_ALL            (0xFFFFFFF)
>> +#define TPDM_DSB_TEST_MODE        GENMASK(11, 9)
>> +#define TPDM_DSB_HPSEL        GENMASK(6, 2)
>
> Again what do the values mean ? Even if the kernel doesn't use them
> it would be good to document it.

I will update this in the next patch series.


Tao

>
> Suzuki
>
>> +
>>   /* TPDM integration test registers */
>>   #define TPDM_ITATBCNTRL        (0xEF0)
>>   #define TPDM_ITCNTRL        (0xF00)
>> @@ -48,10 +59,12 @@
>>     /**
>>    * struct dsb_dataset - specifics associated to dsb dataset
>> + * @mode:             DSB programming mode
>>    * @trig_ts:          Enable/Disable trigger timestamp.
>>    * @trig_type:        Enable/Disable trigger type.
>>    */
>>   struct dsb_dataset {
>> +    u32                mode;
>>       bool            trig_ts;
>>       bool            trig_type;
>>   };
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
