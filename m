Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4011D5F5B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJEVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJEVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:08:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F069F56;
        Wed,  5 Oct 2022 14:08:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295KUeHI029945;
        Wed, 5 Oct 2022 21:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i5CppKjYTcL74zoSy5XGrDawTtB6iQImvmz8wUI5z/Q=;
 b=ehIULqob604XAN0nJg4FNIxo0HjYEdHkOwfA6CIxUvC3xSHxqQd9cnNMrwcvQb/KhSU6
 QXqOVLEQgJWOEIpQxAU7Al6IcBkj6b5N25SKFAaHbygQRh2Gb4jTvn2H9Hh+EEJA6KLs
 DUdPdcOb+tvlKZOy2Uz0bBhzQnpHeZYs3RwnZ+egq9P01NXt0PsI7k6+7eORwwXdGx8A
 Zy7G4py2AXfl7TYe0dAV+0QgddGBoae4wPG96io20ROKbYAGuNyF2JnxXT4zrwlYgMPB
 AFQ8FkZjC+jblqFQAGxqixGcPr6f1RmQRC+j28yLszWkFijTWPF3Jv6qkfinfwJI7aqr NQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escva05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 21:08:03 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 295L82cQ009133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 21:08:02 GMT
Received: from [10.110.81.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 14:08:01 -0700
Message-ID: <33da6d3b-29fb-7f26-0667-419b317d8e11@quicinc.com>
Date:   Wed, 5 Oct 2022 14:08:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com>
 <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
 <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
 <9664a623-3c58-49e8-1b9a-69335d844448@linaro.org>
 <CAA8EJprQoCQzr2x0JA9_b3MDE=oOTODyHD23debEL1MCE1mWBA@mail.gmail.com>
 <095742cb-61cc-af5d-848c-48b2ea5528ea@quicinc.com>
 <CAA8EJpoqKCj4tyX-617YJH5zqkR_C=1LVMeLXcCxZFgOPjRZ=g@mail.gmail.com>
 <14872934-93f1-baab-7f1a-cfc55ffd0531@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <14872934-93f1-baab-7f1a-cfc55ffd0531@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a2_cbYPcYzhRJCTNqio6GYmp56K963Yy
X-Proofpoint-ORIG-GUID: a2_cbYPcYzhRJCTNqio6GYmp56K963Yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050130
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2022 1:27 AM, Krzysztof Kozlowski wrote:
> On 04/10/2022 23:05, Dmitry Baryshkov wrote:
>> On Tue, 4 Oct 2022 at 18:52, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>>
>>>
>>> On 10/4/2022 2:36 AM, Dmitry Baryshkov wrote:
>>>> On Tue, 4 Oct 2022 at 09:53, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>> On 04/10/2022 00:14, Dmitry Baryshkov wrote:
>>>>>> On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>>>>>>
>>>>>>> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>>>>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>>>>> ---
>>>>>>>>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>>> @@ -51,6 +51,8 @@ properties:
>>>>>>>>>             - qcom,scm-sm8250
>>>>>>>>>             - qcom,scm-sm8350
>>>>>>>>>             - qcom,scm-sm8450
>>>>>>>>> +          - qcom,scm-qdu1000
>>>>>>>>> +          - qcom,scm-qru1000
>>>>>> I think after seeing all the patchsets it's time to ask the following
>>>>>> question. Do we really need a duplicate compatibility families:
>>>>>> qdu1000 vs qru1000? I'd suggest using a single set of compatibile
>>>>>> strings in most of the cases.
>>>>>> Settle down onto a single name (qdu,qru, qdru, whatever) and define
>>>>>> distinct compat strings only when there is an actual difference?
>>>>>>
>>>>>> E.g .we don't have separate compatible strings for all the sda660,
>>>>>> apq8096, etc. unless this is required by the corresponding hardware
>>>>>> block not being compatible with corresponding sdm or msm counterpart.
>>>>>>
>>>>> I am not that fluent in Qualcomm naming, so let me ask - what are the
>>>>> differences between QDU and QRU?
>>>>>
>>>>> For compatible (and/or similar) devices the general recommendation is to
>>>>> have specific compatibles followed by fallback. Even if devices are
>>>>> very, very, very similar, usually the recommendation still stays.
>>>> Well, true. But in some cases we handle this by using a single set of
>>>> compatibles. Consider e.g. sa8155 vs sm8150 (sa8155 overrides just few
>>>> compats that differ). Or qrb5165 vs sm8250 (there is no separate
>>>> qrb5165.dtsi). APQ8096 (#include "msm8996.dtsi"). Etc.
>>>>
>>>> I'd say this really depends on the actual difference between qru and qdu.
>>>
>>> To add some clarification, there's pretty little functional difference between the QDU (Distributed Unit) and the QRU (Radio Unit); they're largely the same SoC from the kernel's standpoint. I wasn't sure if it made more sense to separate the compat strings or mash them together (using qdru to specify that it applies to both), so I kept separate compat strings in case there was a separate RU/DU use case down the line and also to avoid some confusion (I guess that didn't work though). It makes the most sense in my mind to just use the qdru compat string for the things that apply to both SoCs (which is most of what's submitted currently) and then we can do qdu/qru specific override strings for more specific drivers.
>>
>> Unless Krzysztof or Bjorn have other opinion, I'd suggest adding a
>> single compat string, It might be qcom,qdru1000-foo or just
>> qcom,qdu1000-foo (with having a separate qcom,qru1000-foo where
>> applicable). But the final decision is from Rob, Krzysztof and Bjorn.
> 
> If qdru1000 is a real SoC name, then it is fine. But it seems it is
> rather a wildcard, which in general is discouraged. Go with qdu1000 and
> optionally prepended with qru1000.

qdru1000 is not a real SOC, so let's not use that. Prefer to use qdu1000 
and qru1000 with whatever approach we decide.

---Trilok Soni
