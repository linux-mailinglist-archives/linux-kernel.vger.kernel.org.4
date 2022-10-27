Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4782360FAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiJ0Ore (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJ0Orc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:47:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB1201A2;
        Thu, 27 Oct 2022 07:47:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R3Goe4019234;
        Thu, 27 Oct 2022 14:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sae4yyIglddsROvp8syuMgBzWAF2p8KXXt/zArfAma4=;
 b=F913nKeP4W1dAcIh45kZ/qdWm945oJ2VMewAzcGouimQXWkrKWV6VEyj1g1Vh/z7uzZK
 mgyllz1KUl2xKcQV5DGymq+xkVEc7CsXLah++9R3DcZ89tmg0z9OhieCaQ/dNuwYkxQu
 zTcT7R4jhnA5nTZSR+FIRGFG5z62VQ2117w13GgnIh3cjKV0jBqEW1K5I8hhhOCxL1Df
 CMFshuoUWOl026YHpsrjbgGbzRvj0CNLrc36VjjlIXCRLEQEkhHqrFNg1isOBs4BV8v5
 UW8rK9Sx6v3ODzj+DhZRe8ro6K2fKwOEECFXicAVYhlxXvy68JYVmcipWhNE2lyD1iWE PQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfah53ha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 14:46:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29REkuHj015942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 14:46:56 GMT
Received: from [10.253.76.98] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 07:46:53 -0700
Message-ID: <8254cb9e-92ca-4e0b-3048-ef1a8383e9d7@quicinc.com>
Date:   Thu, 27 Oct 2022 22:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 9/9] coresight-tpdm: Add nodes for timestamp request
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-10-git-send-email-quic_taozha@quicinc.com>
 <08201626-9998-6327-b5f7-e49ad279fd0f@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <08201626-9998-6327-b5f7-e49ad279fd0f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oFio8kQyZTA20ETmRrXl7oP2Sp2MZDgs
X-Proofpoint-ORIG-GUID: oFio8kQyZTA20ETmRrXl7oP2Sp2MZDgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 10/25/2022 6:00 PM, Suzuki K Poulose wrote:
> On 08/09/2022 09:45, Tao Zhang wrote:
>> Add nodes to configure the timestamp request based on input
>> pattern match. Each TPDM that support DSB subunit has n(0-7) TPR
>> registers to configure value for timestamp request based on input
>> pattern match, and has m(0-7) TPMR registers to configure pattern
>> mask for timestamp request.
>> Add nodes to enable/disable pattern timestamp and set pattern
>> timestamp type.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 189 
>> +++++++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h |  14 ++
>>   2 files changed, 203 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 648bbe6..4212ff4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -32,6 +32,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
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
>>           writel_relaxed(drvdata->dsb->trig_patt_val[i],
>>                   drvdata->base + TPDM_DSB_XPR(i));
>>           writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> @@ -39,6 +46,16 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>       }
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> +    /* Set pattern timestamp type and enablement */
>> +    if (drvdata->dsb->patt_ts) {
>> +        val |= TPDM_DSB_PATT_TSENAB;
>> +        if (drvdata->dsb->patt_type)
>> +            val |= TPDM_DSB_PATT_TYPE;
>> +        else
>> +            val &= ~TPDM_DSB_PATT_TYPE;
>> +    } else {
>> +        val &= ~TPDM_DSB_PATT_TSENAB;
>> +    }
>>       /* Set trigger timestamp */
>>       if (drvdata->dsb->trig_ts)
>>           val |= TPDM_DSB_XTRIG_TSENAB;
>> @@ -411,6 +428,174 @@ static ssize_t dsb_edge_ctrl_mask_store(struct 
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
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        size += scnprintf(buf + size, PAGE_SIZE - size,
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
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
>> +        index >= TPDM_DSB_MAX_PATT)
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
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +        size += scnprintf(buf + size, PAGE_SIZE - size,
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
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
>> +        index >= TPDM_DSB_MAX_PATT)
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
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +        return -EPERM;
>> +
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +             (unsigned int)drvdata->dsb->patt_ts);
>
> Please use sysfs_emit() everywhere (in the previous patches too)
> for such operations.
>
Sure, I will update this in the next patch series.

> I have finished reviewing this series.
>
> Suzuki
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
