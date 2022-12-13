Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAD64BEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiLMV4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiLMVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345C26489;
        Tue, 13 Dec 2022 13:54:04 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDK04DG007911;
        Tue, 13 Dec 2022 21:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U0bHcGZ5jMCQNvUVO0KJzmC5eku0GSm+9Z5Ov0Z3S8s=;
 b=C0IxivsSmG0yPAOfnusAZm2AWkouuLJTBzK67jxG0oa96lmrbTizRXjLBqMoVtpgrDq6
 BR2ILtN4nooFMb3AxuXk9t7W/QK8SOLpANPf2MT90Wnbv4vNtvUWnpf3AB89wKcnNE1Q
 4hWWeYIBdC8xKcpUWD9qQECmfaD6rjKmnD/cr/jkrOmltVhKMJpuFcmUHT5h2hTyhhM0
 p4EZgVVygFbKTGUKDN2+tkh0ldf661jVbtFbKMIzuv16BQtM/a2m8j0nQJiK8LI5uiSS
 WEDKab0F9oNO8W1o4n65W74PrSRJKwPvylOTR+uKeXuczrtWT7xpMYMYlwnSJffPgFvo fQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meyfw0dp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 21:53:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDLrrc7002666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 21:53:53 GMT
Received: from [10.111.167.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 13:53:50 -0800
Message-ID: <ad7ecffc-3fc9-7859-82b7-9d161fc28cae@quicinc.com>
Date:   Tue, 13 Dec 2022 13:53:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 01/12] dt-bindings: display: msm: Rename mdss node name
 in example
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>
CC:     <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-2-a39.skl@gmail.com>
 <19e78a06-2f3d-92af-1988-b22dc3ffc84e@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <19e78a06-2f3d-92af-1988-b22dc3ffc84e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qYalVvqLD40rRT2LHIiWecj1GJBgVGZT
X-Proofpoint-GUID: qYalVvqLD40rRT2LHIiWecj1GJBgVGZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2022 11:54 AM, Dmitry Baryshkov wrote:
> On 30/11/2022 22:09, Adam Skladowski wrote:
>> Follow other YAMLs and replace mdss name into display-subystem.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Going to add two fixes tags here as we are touching two chipsets:

Fixes: b93bdff44a85 ("dt-bindings: display/msm: add support for SM6115")
Fixes: 06097b13ef97 ("dt-bindings: display/msm: split dpu-qcm2290 into 
DPU and MDSS parts")

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> 
> We will pick this into msm-fixes during the next cycle.

Yes, we can with the above fixes tags but first, can you please send a 
MR from msm-next-lumag to msm-next? So that I can send a MR for fixes to 
msm-next.

ATM, they are out of sync.


> 
>> ---
>>   .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
>>   .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml 
>> b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>> index d6f043a4b08d..4795e13c7b59 100644
>> --- 
>> a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>> @@ -72,7 +72,7 @@ examples:
>>       #include <dt-bindings/interconnect/qcom,qcm2290.h>
>>       #include <dt-bindings/power/qcom-rpmpd.h>
>> -    mdss@5e00000 {
>> +    display-subsystem@5e00000 {
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>           compatible = "qcom,qcm2290-mdss";
>> diff --git 
>> a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml 
>> b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>> index a86d7f53fa84..886858ef6700 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>> @@ -62,7 +62,7 @@ examples:
>>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>>       #include <dt-bindings/power/qcom-rpmpd.h>
>> -    mdss@5e00000 {
>> +    display-subsystem@5e00000 {
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>           compatible = "qcom,sm6115-mdss";
> 
