Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7456A6861
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCAHpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:45:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1E30EBD;
        Tue, 28 Feb 2023 23:45:50 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3214kDML004417;
        Wed, 1 Mar 2023 07:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aHnEMQp7evnRUr+B1+RiL92yYBTpDBHQfvhAmxs5KJo=;
 b=d28Sw1v/LVxPxblWN87yE2rYyFfQ68tBFCabTcl5Ikyv/nSRTT4pXyy7KvMi9bTc1iQy
 gcGAcd1n6Q+WVbgkFjiMp5PG15fltUgb+AHqts6pvkNVsoSBv8zX79T9lFra9FWKjuRQ
 KzRrG0RZ1VTwGGdOdazeZn3jyokHMp6X5hBoc9J+ix6t/HCkPVJZ+nesQm0tq1sKSHPQ
 ZraXSUqxml2TsUmYVyiwf8mR7cni/q7xHRjFQVQeHKhVEaihYUVKekykCGaTot8ZfhQg
 dsZFBQ1jKqj3yhb/fXOb3WK/FAKycAnp9CvevHf36A1WJ87lNX4BhuLJg57Hv9TkR+ky 2g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1n0tj23n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 07:45:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3217jX7x008244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 07:45:33 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 23:45:28 -0800
Message-ID: <21ee7183-f661-f6dd-bcc2-c521003ae2ca@quicinc.com>
Date:   Wed, 1 Mar 2023 15:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 5/9] coresight-tpdm: Add nodes to set trigger timestamp
 and type
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
        Tao Zhang <taozha@qti.qualcomm.com>,
        "Bjorn Andersson" <andersson@kernel.org>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
 <fa09722a-b251-bf60-35af-e6dc45ed9ae4@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <fa09722a-b251-bf60-35af-e6dc45ed9ae4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 52do2j87Ex7BqYhD7DlkbLtWk7bqIaIb
X-Proofpoint-GUID: 52do2j87Ex7BqYhD7DlkbLtWk7bqIaIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010061
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 2/28/2023 7:32 PM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> The nodes are needed to set or show the trigger timestamp and
>> trigger type. This change is to add these nodes to achieve these
>> function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 97 
>> ++++++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index c29d667d..1dbb6c4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,6 +20,22 @@
>
>
>> +static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_trig_ts.attr,
>> +    &dev_attr_dsb_trig_type.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_dsb_attr_grp = {
>> +    .attrs = tpdm_dsb_attrs,
>> +    .is_visible = tpdm_dsb_is_visible,
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>> +    &tpdm_dsb_attr_grp,
>>       NULL,
>>   };
>
>
> Please also add documentation of the new sysfs handles under :
>
> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm*
>
Sure, I will add the descriptions of new sysfs in the next of patch series.
> Suzuki
>
Best,

Tao

