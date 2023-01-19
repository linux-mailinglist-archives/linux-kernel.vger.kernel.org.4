Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66376737EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjASMJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjASMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:08:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2B2BEC3;
        Thu, 19 Jan 2023 04:08:53 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5Fmes017643;
        Thu, 19 Jan 2023 12:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gfTqnOTWGqZDemDVHdu2Cs2qANt8WoEK/JLQa6iXSAY=;
 b=HdylZ1tpR0zZFAkhsT3OUoR9qt6HANDa6jZ7EKe/eeiQuLxae/VxQXVpplG85yhK/cgb
 V0M80CaoAOzszRKVFFtEZiBNvfN5G0bOXnKqHJlmw54P0D1NqIQL8YfS/pNvFqU6t5rV
 lWzw1DFhbv2OcIynrpW3jkaBuweJSe0PfYmwhEC9q5sIces1qPk/nOyLQb04v6+BHWv2
 yxYdnIM9k4mDiFH3iZdYR3FQZxsnxE9TxS7sLKHdbeu4miq/zINTUQfvNjoJ647QVDPT
 VpvMtNORygCkrYQqCorh0TIZpus5vzxlbF2FNXhnMpaCEZq3Jyb/qMmpnnZRqilZSe8R pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6wbs9asr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:08:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JC8k49017768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:08:46 GMT
Received: from [10.216.43.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 04:08:41 -0800
Message-ID: <77d4cb35-aff1-e35d-f1bf-957d17970714@quicinc.com>
Date:   Thu, 19 Jan 2023 17:38:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sc7280: Extract audio nodes from
 common idp dtsi file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>, <mka@chromium.org>
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
 <1672925875-2107-2-git-send-email-quic_srivasam@quicinc.com>
 <6a0b4fff-e012-92df-c2fb-82184eba8aef@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <6a0b4fff-e012-92df-c2fb-82184eba8aef@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5KXhCBnl6Dtc7vRx4_i7VbR8a8QUvyBC
X-Proofpoint-GUID: 5KXhCBnl6Dtc7vRx4_i7VbR8a8QUvyBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190096
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 4:27 PM, Krzysztof Kozlowski wrote:
Thanks for your time Krzysztof!!!
> On 05/01/2023 14:37, Srinivasa Rao Mandadapu wrote:
>> Split common idp dtsi file into audio specific dtsi and common
>> idp dtsi file.
>>
>> It is required to isolate idp and crd-rev3 platform device tree nodes
>> and convert crd-rev3 platform device tree nodes into audioreach specific
>> device tree nodes.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
> Please include a changelog - either per patch or in cover letter.
Okay. Will include and re post it.
>
>>   arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 135 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |   1 +
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 126 -----------------------
>>   3 files changed, 136 insertions(+), 126 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
>> new file mode 100644
>> index 0000000..d1aea28
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
>> @@ -0,0 +1,135 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * sc7280 Audio IDP board device tree source (common between SKU1 and SKU2)
>> + *
>> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/{
>> +   /* BOARD-SPECIFIC TOP LEVEL NODES */
> Still wrong indentation.
Okay. Will fix it.
>
>> +	sound: sound {
>> +		compatible = "google,sc7280-herobrine";
>> +		model = "sc7280-wcd938x-max98360a-1mic";
>> +
>
>
>
> Best regards,
> Krzysztof
>
