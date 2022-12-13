Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDF64BF31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiLMWPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiLMWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:15:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB65117D;
        Tue, 13 Dec 2022 14:15:19 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDM9u06010292;
        Tue, 13 Dec 2022 22:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HktqH1/MaH12z5s3iTHLDwiTzoF8psLLCmkW9dpkjGg=;
 b=Oe1ZAYf+RYOD9IBbr6nMxrDadU1LxEwYD2hi9r6kR9xERhTfMw+5xM27xQ3iFKnQ9iAv
 G/qC0I8ZXCXjWCcwhZ0iGvX9zyy52x0yT/c5bbplV+QTfLX/nlD669kDi7n7mqxwPygR
 OFqSRBp+m/wdcjiFBkvTG51PWCWw/vyCIcig4NryRcr5f7bUx9BEJV3EByvOu48u2WQ1
 9J2wsUOzNXw1aBviSUnI9xospfDLrUkuOunGj7/xeABxuYfhKqw5Zn4q8VR1F85feXp6
 NkeyeSUZQUfwXIURYTCO49shAffnbYbCLO2AaAvgHtl9IoMI5/GYSCxygEVPQH/b9NjG Cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meyf08d7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 22:15:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDMF7a3020713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 22:15:07 GMT
Received: from [10.111.167.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 14:15:03 -0800
Message-ID: <3658fd96-12b6-b478-249f-44fc9bcdb809@quicinc.com>
Date:   Tue, 13 Dec 2022 14:15:02 -0800
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
 <ad7ecffc-3fc9-7859-82b7-9d161fc28cae@quicinc.com>
 <86FA3AF9-5B35-4E27-80DA-8B5BF9E6B3AC@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <86FA3AF9-5B35-4E27-80DA-8B5BF9E6B3AC@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wZj3v5rutIHhnz7xMeHpu1Cxg55DKbAe
X-Proofpoint-GUID: wZj3v5rutIHhnz7xMeHpu1Cxg55DKbAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2022 2:11 PM, Dmitry Baryshkov wrote:
> 
> 
> On 13 December 2022 23:53:48 EET, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>> On 12/1/2022 11:54 AM, Dmitry Baryshkov wrote:
>>> On 30/11/2022 22:09, Adam Skladowski wrote:
>>>> Follow other YAMLs and replace mdss name into display-subystem.
>>>>
>>>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Going to add two fixes tags here as we are touching two chipsets:
>>
>> Fixes: b93bdff44a85 ("dt-bindings: display/msm: add support for SM6115")
>> Fixes: 06097b13ef97 ("dt-bindings: display/msm: split dpu-qcm2290 into DPU and MDSS parts")
> 
> Note, your tag gif wrapped, so patchwork will pick it up incorrectly.

Yes, this is a mail client issue. Am aware of it , will fix it up when i 
apply it.

> 
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>>>
>>> We will pick this into msm-fixes during the next cycle.
>>
>> Yes, we can with the above fixes tags but first, can you please send a MR from msm-next-lumag to msm-next? So that I can send a MR for fixes to msm-next.
> 
> This would create an additional merge commit in msm-next for no particular reason. You can branch -fixes from rc1, or from the msm-next-lumag and then send MR to msm-next.

So msm-next would need to be updated then to rc1 to accept that MR. Rob?

> 
>>
>> ATM, they are out of sync.
>>
>>
>>>
>>>> ---
>>>>    .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
>>>>    .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>>>> index d6f043a4b08d..4795e13c7b59 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
>>>> @@ -72,7 +72,7 @@ examples:
>>>>        #include <dt-bindings/interconnect/qcom,qcm2290.h>
>>>>        #include <dt-bindings/power/qcom-rpmpd.h>
>>>> -    mdss@5e00000 {
>>>> +    display-subsystem@5e00000 {
>>>>            #address-cells = <1>;
>>>>            #size-cells = <1>;
>>>>            compatible = "qcom,qcm2290-mdss";
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>>> index a86d7f53fa84..886858ef6700 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>>> @@ -62,7 +62,7 @@ examples:
>>>>        #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>        #include <dt-bindings/power/qcom-rpmpd.h>
>>>> -    mdss@5e00000 {
>>>> +    display-subsystem@5e00000 {
>>>>            #address-cells = <1>;
>>>>            #size-cells = <1>;
>>>>            compatible = "qcom,sm6115-mdss";
>>>
> 
