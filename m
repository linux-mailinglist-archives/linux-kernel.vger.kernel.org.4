Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E501663958
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjAJG2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:28:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7CC395D1;
        Mon,  9 Jan 2023 22:28:04 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A44UGd023823;
        Tue, 10 Jan 2023 06:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p7LDM4ETC4g9nquHCDAtm666lp1vxWqVcTJq9/Y0Jgc=;
 b=RjN3bopGd2Hjh8O9TruUew0mpVSIhRQCPHxtjyy6eInPvz2LIrjAHO7wjzPHccTNqYfY
 4GJJQoL463uTjFxR3GS+2H0/d0j4rdnlypyU9I8gQ/pO+DkKammQqvBGZBQhWlM618Jq
 uocNgSIXZ7wEgQ1g/W2EZFPLxSHfy4N2oZPP/WJIgvp+WHIs8JCQ8woUZvqn4F+hB9Ey
 TnhV/dV+LcBeXehXNgL4ICO8ExCv1kMiZ4M5HHibgn6gjmHuA77zx5x8EGSEVvvva4fR
 7Axb6q9h80pRbRZuGCq+ptud5anKNRKAt0wYQlIhM5zIQLG6KF0GuxvwCuU1yw4A7IvV Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0x0jgh3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:27:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A6RKfT017257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:27:20 GMT
Received: from [10.216.32.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 22:27:13 -0800
Message-ID: <1c6ce9e4-b9a4-9252-566a-f48c8e675d6b@quicinc.com>
Date:   Tue, 10 Jan 2023 11:57:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add
 reg-names and power-domain-names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <corbet@lwn.net>
References: <1672991425-898-1-git-send-email-quic_srivasam@quicinc.com>
 <c6ea3f37-fe5a-9a61-3a02-99bc036fd23e@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <c6ea3f37-fe5a-9a61-3a02-99bc036fd23e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -LDfi5XHiq2SAKxP_9qL3TafB4WSO33R
X-Proofpoint-ORIG-GUID: -LDfi5XHiq2SAKxP_9qL3TafB4WSO33R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100041
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2023 9:06 PM, Krzysztof Kozlowski wrote:
Thanks for Your Time Krzyszto!!!
> On 06/01/2023 08:50, Srinivasa Rao Mandadapu wrote:
>> Add reg-names and power-domain-names for remoteproc ADSP pheripheral
>> loader. This is to make compatible with remoteproc ADSP PIL driver.
> I don't understand the reasoning. Before binding was "incompatible"?

Yes. Previous bindings needs fixes. Will add fixes tag for the same. So 
far corresponding device tree not

mainlined and no user till now, hence these missing errors not found.

>
>> Also change power domain from LCX to CX.
> Why? Hardware changed?

No, basically it's a fix. The power domain name wrongly mentioned in 
previous bindings.

The fixes tag mentioned above will be applicable here also.

>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes Since v1:
>>      -- Modify subject line to SoC specific.
>>
>>   .../devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>> index 94ca7a0..b5bee2c 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>> @@ -23,6 +23,11 @@ properties:
>>         - description: qdsp6ss register
>>         - description: efuse q6ss register
>>   
>> +  reg-names:
>> +    items:
>> +      - const: qdsp6ss_base
>> +      - const: lpass_efuse
>> +
>>     iommus:
>>       items:
>>         - description: Phandle to apps_smmu node with sid mask
>> @@ -57,7 +62,11 @@ properties:
>>   
>>     power-domains:
>>       items:
>> -      - description: LCX power domain
>> +      - description: CX power domain
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: cx
>>   
>>     resets:
>>       items:
> Best regards,
> Krzysztof
>
