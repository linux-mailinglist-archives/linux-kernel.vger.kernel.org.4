Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07E74E70D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGKGSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:18:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A7FE49;
        Mon, 10 Jul 2023 23:18:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6DNIK017537;
        Tue, 11 Jul 2023 06:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Yu5PYkkZq/zPAyE4/tuEknipkkUnyHrF4Eyseb37DiY=;
 b=ZVZ2A8jllFrY/qRsiDSxjH91xiFi3QLZMJ1FUAmiyepyrQ0QnQ/yUkVypPYXct1XPPWr
 yT9Tfm6uegZRInz/v6tRhwomqZoC9jeYd0QXMPkf/aSZ27As472G/TrkGkkVpQ5h3DXV
 WkQqYGgIwErQ26muVNRqLqtROpb+JNJ2a2IBNMBfzWX4IZ0YK+47wY7EXdEwwTywhxA2
 ObVcQWtqhvtIAVyoIhzVbuoSxp1kHcs9YiO1frAG877OJdZYymFLqXSalSKicMzEzyfO
 2h3wvwmE6mcoiXmdZze6Qqzyabam5SQOQzUaWWNknKD+Bc6CCksi/+2xiwdtZNn8rxEa OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1hw80jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:18:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B6I5EJ029534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:18:05 GMT
Received: from [10.214.27.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 23:18:01 -0700
Message-ID: <8a3124ce-a11d-2491-eaee-1695cec70b17@quicinc.com>
Date:   Tue, 11 Jul 2023 11:47:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0NxUbBDYfjOae5YsaAz11IyWNGl5S77j
X-Proofpoint-ORIG-GUID: 0NxUbBDYfjOae5YsaAz11IyWNGl5S77j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxlogscore=910 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110054
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 11:22 AM, Krzysztof Kozlowski wrote:
> On 11/07/2023 07:42, Rohit Agarwal wrote:
>> Add Generic RPMh Power Domain indexes that can be used
>> for all the Qualcomm SoC henceforth.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>
>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>> new file mode 100644
>> index 0000000..4da2e04
>> --- /dev/null
>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
> Filename based on compatible.
This is not specific for SDX75. These are generic ones that should be 
used for all other targets.
Konrad suggested in v1 to avoid target specific prefixes everytime and 
to create a new generic
dt-bindings that can be reused.
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +
>> +/* Generic RPMH Power Domain Indexes */
>> +#define CX               0
> These are very generic names, usually not used in global headers. Please
> use some reasonable prefix.
This was based on the suggestion from Konrad in v2 to drop the RPMHPD 
prefix and we can go only with names like CX, etc.

Thanks,
Rohit.
>
>
> Best regards,
> Krzysztof
>
