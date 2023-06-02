Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97F71FC15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjFBIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjFBIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:30:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DC10EB;
        Fri,  2 Jun 2023 01:29:50 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3528Q0D8027721;
        Fri, 2 Jun 2023 08:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DiQmWtORWemS8uGWt4jZvgPrPUzypZEPv11mHLw6PGQ=;
 b=mfbBWDSNZyLjvVam8dkZK0Bhzijz616xHlvE8ttTyiKaAtSn6WdNNGsTHw8Q+MT0SYKL
 IFMeqS1gjTkfMYSajvRHGcIXqke+f5dLRWuNuZIaMdjyq3EYZJ6SL1a7hViWO5/75yEP
 2dgUhWTjbXg/wuV0DUPcMC9SYPGOn++DsGlGAv4o/t1lH+g4FUayErO5B+Kr8X3vOun0
 3nYauEkw1a/OxN8vilP/xmB21lXDTNyod22i5bVMWQBSgxXEC6yYHIt1LBfO/4Eh3cZ0
 /fjW5TspEAArguNbaq8i/mALdwEEz5bqbDFHzY21udI0R9mj44KTnc9YfuoRKKVsROVZ CA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qycwe808x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:29:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528TXnP000389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:29:33 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 01:29:28 -0700
Message-ID: <e68d528e-186d-4895-4921-0b17f6d1bd12@quicinc.com>
Date:   Fri, 2 Jun 2023 16:29:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 08/11] coresight-tpdm: Add nodes to configure pattern
 match output
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
 <1682586037-25973-9-git-send-email-quic_taozha@quicinc.com>
 <6be47f1a-16ca-76ca-b133-ee453c261c21@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <6be47f1a-16ca-76ca-b133-ee453c261c21@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tY7IpC3-syln8iItw1kXzl6GBiK7YYMU
X-Proofpoint-GUID: tY7IpC3-syln8iItw1kXzl6GBiK7YYMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_05,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020064
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2023 9:28 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> Add nodes to configure trigger pattern and trigger pattern mask.
>> Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
>> configure trigger pattern match output. Eight 32 bit registers
>> providing DSB interface trigger output pattern match comparison.
>> And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
>> configure trigger pattern mask match output. Eight 32 bit
>> registers providing DSB interface trigger output pattern match
>> mask.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 30 ++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 85 
>> ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  8 ++
>>   3 files changed, 123 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index a57f000..c04c735 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -92,3 +92,33 @@ Description:
>>           <integer1> : Start EDCMR register number
>>           <integer2> : End EDCMR register number
>>           <integer3> : The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_val
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger pattern value of DSB tpdm.
>> +        Read the trigger pattern value of DSB tpdm.
>> +
>> +        Expected format is the following:
>> +        <integer1> <integer2>
>> +
>> +        Where:
>> +        <integer1> : Index number of XPR register, the range is 0 to 7
>> +        <integer2> : The value need to be written
>
> I assume the values written to the registers are not special and doesn't
> have meaning and thus need not be documented ?
Sure, I will update this in the next patch series.
>
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_mask
>> +Date:        March 2023
>> +KernelVersion    6.3
>
> Same as the previous one, 6.5 please
Sure, I will update this in the next patch series.
>
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger pattern mask of DSB tpdm.
>> +        Read the trigger pattern mask of DSB tpdm.
>> +
>> +        Expected format is the following:
>> +        <integer1> <integer2>
>> +
>> +        Where:
>> +        <integer1> : Index number of XPMR register,  the range is 0 
>> to 7
>> +        <integer2> : The value need to be written
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index a40e458..9387bdf 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -89,6 +89,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>           writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>>                  drvdata->base + TPDM_DSB_EDCMR(i));
>>   +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>
> Same as the previous, can we safely assume that write to these
> registers won't trigger an Error if not impelemented ?

Yes, it won't trigger an error since these inexistent register's 
addresses are not occupied and safe

for being accessed.

>
>> + writel_relaxed(drvdata->dsb->trig_patt_val[i],
>> +                drvdata->base + TPDM_DSB_XPR(i));
>> +        writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> +                drvdata->base + TPDM_DSB_XPMR(i));
>> +    }
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>>       /* Set trigger timestamp */
>>       if (drvdata->dsb->trig_ts)
>> @@ -444,6 +451,82 @@ static ssize_t dsb_edge_ctrl_mask_store(struct 
>> device *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>>   +static ssize_t dsb_trig_patt_val_show(struct device *dev,
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
>> +                  drvdata->dsb->trig_patt_val[i]);
>
> Please detect the return of 0 and break. Same below.

See my comments in patch #7 mail.


Best,

Tao

>
>
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +static ssize_t dsb_trig_patt_val_store(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        const char *buf,
>> +                        size_t size)
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
>> +    drvdata->dsb->trig_patt_val[index] = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_patt_val);
>> +
>> +static ssize_t dsb_trig_patt_mask_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    int i = 0;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        size += sysfs_emit_at(buf, size,
>> +                  "Index: 0x%x Value: 0x%x\n", i,
>> +                  drvdata->dsb->trig_patt_mask[i]);
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>
> Suzuki
>
