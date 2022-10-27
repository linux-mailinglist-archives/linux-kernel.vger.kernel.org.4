Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF560F09E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiJ0GxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0GxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:53:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970234455A;
        Wed, 26 Oct 2022 23:53:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R6WEZi005253;
        Thu, 27 Oct 2022 06:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n++FK1S/MLrzIX4SbIKz7RQU7xW4fNuk2RYBn98p4Hw=;
 b=DJ38mZ0dOXEuufn40GHHtnGzkIdJIEE0victp7BTEeDWRp2bzZI9vFSUbnQzHrF3FDGy
 6VOcw7+GfJQBVBaUraEw/iuxOhRhf4EKAM7TWiJ4L9BXRiWs9qEIhFFsRK8/CtOdDK52
 U9p9LmdFjGHiFSQzlMF8QkdYuFAabh5ob1K/Ig/yoUWAJQwKbmLXMkAz7LY5ZR1hdGxa
 b2swHLitYgcC94OabD/aeIhZsKz3763o7pAEVTmZwcuFCEFB0f2SUWUNLdPWdVWowUYG
 IYJHlZNLpz6upaTaoEyEL01Bity1bRNYi4QDPLcSZ94sMxhR7Hd0tTLwH5yEKBjTNkQ5 NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfah4sphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 06:52:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29R6qfHw020308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 06:52:41 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 23:52:37 -0700
Message-ID: <f72dd193-d801-923c-c742-44584d1779c5@quicinc.com>
Date:   Thu, 27 Oct 2022 14:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/9] coresight-tpdm: Add reset node to TPDM node
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-5-git-send-email-quic_taozha@quicinc.com>
 <cbe5813e-337b-6c77-8571-cf400d4abc41@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <cbe5813e-337b-6c77-8571-cf400d4abc41@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EoX_Xp0ApI74IqQ8Ttwd_uL-LQpRX8PT
X-Proofpoint-ORIG-GUID: EoX_Xp0ApI74IqQ8Ttwd_uL-LQpRX8PT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 10/24/2022 6:10 PM, Suzuki K Poulose 写道:
> On 08/09/2022 09:45, Tao Zhang wrote:
>> TPDM device need a node to reset the configurations and status of
>> it. This change provides a node to reset the configurations and
>> disable the TPDM if it has been enabled.
>
> It is not clear to me *why* this is needed. Please could you
> elaborate on the use case of this ? See my questions below.
For example, we usually reset the configuration through the "reset"
node before using a TPDM, so as to avoid the previous configuration
affecting the current use. And in some scenarios, it may be necessary
to reset the TPDM configuration to complete the verification of certain
function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 32 
>> ++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 69ea453..74cc653 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -152,6 +152,37 @@ static void tpdm_init_default_data(struct 
>> tpdm_drvdata *drvdata)
>>       }
>>   }
>>   +static ssize_t reset_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>
> minor nit: Alignment
>
I will update this in the next patch series.
>> +{
>> +    int ret = 0;
>> +    unsigned long val;
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    ret = kstrtoul(buf, 10, &val);
>
> So, any integer value written to the sysfs knob triggers the rest ?
> It may be better to restrict this to "1".
>
Make sense, I will update this in the next patch series.
>
>> +    if (ret)
>> +        return ret;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    /* Reset all datasets to ZERO */
>> +    if (drvdata->dsb != NULL)
>> +        memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
>> +
>> +    /* Init the default data */
>> +    tpdm_init_default_data(drvdata);
>
> Why is this needed ? Does the DSB device configuration change
> on the fly ?
>
We usually reset the configuration through the "reset" node at the
beginning of using a TPDM. DSB related elements need to be initialized
before configuring them.
The TPDM is usually to be used by the following sequence.
Reset(initialization) -> Configure -> Enable to use
>> +
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    /* Disable tpdm if enabled */
>> +    if (drvdata->enable)
>> +        coresight_disable(drvdata->csdev);
>
> Why is this needed ? Isn't this supposed to be triggered from the "path"
> when the trace session is complete ?
>
In some scenarios, it may be necessary to reset the TPDM configuration
in the process of verification and re-configure the TPDM. If this is the
case, we need to disable the TPDM first, and re-configure before enabling
it again.
>
> Suzuki
>
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_WO(reset);
>> +
>>   /*
>>    * value 1: 64 bits test data
>>    * value 2: 32 bits test data
>> @@ -192,6 +223,7 @@ static ssize_t integration_test_store(struct 
>> device *dev,
>>   static DEVICE_ATTR_WO(integration_test);
>>     static struct attribute *tpdm_attrs[] = {
>> +    &dev_attr_reset.attr,
>>       &dev_attr_integration_test.attr,
>>       NULL,
>>   };
>
Best Regards
Tao

