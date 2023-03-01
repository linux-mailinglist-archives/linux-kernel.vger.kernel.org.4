Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7D6A67A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCAGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:36:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4226328213;
        Tue, 28 Feb 2023 22:36:14 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3214kSsw011618;
        Wed, 1 Mar 2023 06:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7NsVB4FoS6UbPZUGburrBb4iRVrowgmYEH7O+X/k89k=;
 b=NPT4abWvPWHwyIY1ZkybN9YmOTCaC5rYsrgrIv/56hCr/eYW04RB643KaoXe3E65zW1f
 ESRV4RLqOIb0q63cRnjKjtFLjTaeE0p7aVvQ4GLzqiIHhdb9BvRi1N44mksUGbzkovQK
 c5L5m+9wURsOHufdf5obQ7ITtf1zzR/IF1xz9Jo7LFgc0kYG2Q8xvVwJU2j9or/+6Uvw
 nHPkZDW5JxSKGbfXbrxUJ6oa7I2WwjBQ/6aZxyUIsGzBkW2AR6pfcEgr8Z1Teoe4VeHz
 G0Q1oUBKojE7s8u9z0nGfVSbqVB5huM5syBrqG0Sz/QPsBM+GmfaJ61a0+DsQO2Rsgs4 Fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1ccxkj6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:35:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3216ZuT3025067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 06:35:56 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 22:35:51 -0800
Message-ID: <75b61bc3-fb68-cd6e-8849-055e785ceb72@quicinc.com>
Date:   Wed, 1 Mar 2023 14:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 4/9] coresight-tpdm: Add reset node to TPDM node
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-5-git-send-email-quic_taozha@quicinc.com>
 <89247650-2bff-cb94-eaed-f1d6c343035a@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <89247650-2bff-cb94-eaed-f1d6c343035a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XjvoyTtBpyL68DK8mIAlYy7bE4lcsnsz
X-Proofpoint-ORIG-GUID: XjvoyTtBpyL68DK8mIAlYy7bE4lcsnsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_01,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010049
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2/28/2023 7:22 PM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> TPDM device need a node to reset the configurations and status of
>> it. So as to avoid the previous configurations affecting the
>> current use, the configurations need to be reset first. And in
>> some scenarios, it may be necessary to reset the TPDM
>> configurations to complete the verification of certain function.
>> This change provides a node to reset the configurations and
>> disable the TPDM if it has been enabled.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 32 
>> ++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 6befc87..c29d667d 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -161,6 +161,37 @@ static void tpdm_init_default_data(struct 
>> tpdm_drvdata *drvdata)
>>       }
>>   }
>>   +static ssize_t reset_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    int ret = 0;
>> +    unsigned long val;
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    ret = kstrtoul(buf, 0, &val);
>> +    if (ret || (val != 1))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    /* Reset all datasets to ZERO */
>> +    if (drvdata->dsb != NULL)
>> +        memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
>> +
>> +    /* Init the default data */
>
> Code is self explanatory, don't need a comment here.
OK, got it.
>
>> +    tpdm_init_default_data(drvdata);
>
> Could this be helper be renamed to
>
>     tpdm_reset_dsb_data() ?
>
> Because, that is what it does now.

Sure, I will change its name as "tpdm_reset_data()" since DSB is only 
one of the data type which TPDM supports.

>
>> +
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    /* Disable tpdm if enabled */
>> +    if (drvdata->enable)
>> +        coresight_disable(drvdata->csdev);
>
> Woh, where did that come from ? Don't you have a disable handle ?

The function "coresight_disable" is defined in the file "coresight-core.c".

This is a generic disablement handle.

>
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_WO(reset);
>> +
>
> This looks a bit pointless to me, given we have separate controls for 
> all that is being achieved above.

I will move the function of resetting all datasets to zero to 
"tpdm_disable".

Thanks for your advice.

>
> Suzuki
>
>>   /*
>>    * value 1: 64 bits test data
>>    * value 2: 32 bits test data
>> @@ -201,6 +232,7 @@ static ssize_t integration_test_store(struct 
>> device *dev,
>>   static DEVICE_ATTR_WO(integration_test);
>>     static struct attribute *tpdm_attrs[] = {
>> +    &dev_attr_reset.attr,
>>       &dev_attr_integration_test.attr,
>>       NULL,
>>   };
>
Best,

Tao

