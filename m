Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B85F4728
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJDQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJDQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:08:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD8C61D6C;
        Tue,  4 Oct 2022 09:08:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294F89FZ005467;
        Tue, 4 Oct 2022 16:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5wHGUbExXthrC888gAXEgN+PenDV5HW5lAUJDffRL/g=;
 b=kSVjGVOLhVqqrlLY3Og6jzgNGzkHlrWJu6Sg7M2R5O9jpfdN8Sq86ZpA5aNHcnih4o72
 FyI3/kKBjlXFyhZc1/SjaJ/Ztwk9zaEJeMNL1kW2nBP5j6ouuPQgyA5t3DCzP4/JL74a
 l3PCtD19NHfE61Ddf76Gsx3GabkWSJM1c2QRa3fbh0L5BCnW2pm++MfsQ9ke30HmrrPd
 5bxpBoig9lYunF/GMUhlc+JIOPVp9Y+IbEArdIrMZgwYEaGoI0QNMgaZLGXUUzU0PHXh
 4AEhWrDVzpk79TjCkSMJswll7Ybl/6MsAWzMRgMiNr/WK8Z5yenjNn4uxziSpCuxvS/1 BQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0m88ghdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:08:33 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294G8X22022199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 16:08:33 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 09:08:31 -0700
Message-ID: <bd50fcb0-f0a4-6552-e9df-c356c32972f1@quicinc.com>
Date:   Tue, 4 Oct 2022 11:08:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <095742cb-61cc-af5d-848c-48b2ea5528ea@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nwtx_dxA0ZrvqOzy_gSGdw-mag7Z23cc
X-Proofpoint-ORIG-GUID: nwtx_dxA0ZrvqOzy_gSGdw-mag7Z23cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040104
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 10:52 AM, Melody Olvera wrote:
> On 10/4/2022 2:36 AM, Dmitry Baryshkov wrote:
>> On Tue, 4 Oct 2022 at 09:53, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 04/10/2022 00:14, Dmitry Baryshkov wrote:
>>>> On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>>>> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
>>>>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>>>>
>>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
>>>>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>> @@ -51,6 +51,8 @@ properties:
>>>>>>>            - qcom,scm-sm8250
>>>>>>>            - qcom,scm-sm8350
>>>>>>>            - qcom,scm-sm8450
>>>>>>> +          - qcom,scm-qdu1000
>>>>>>> +          - qcom,scm-qru1000
>>>> I think after seeing all the patchsets it's time to ask the following
>>>> question. Do we really need a duplicate compatibility families:
>>>> qdu1000 vs qru1000? I'd suggest using a single set of compatibile
>>>> strings in most of the cases.
>>>> Settle down onto a single name (qdu,qru, qdru, whatever) and define
>>>> distinct compat strings only when there is an actual difference?
>>>>
>>>> E.g .we don't have separate compatible strings for all the sda660,
>>>> apq8096, etc. unless this is required by the corresponding hardware
>>>> block not being compatible with corresponding sdm or msm counterpart.
>>>>
>>> I am not that fluent in Qualcomm naming, so let me ask - what are the
>>> differences between QDU and QRU?
>>>
>>> For compatible (and/or similar) devices the general recommendation is to
>>> have specific compatibles followed by fallback. Even if devices are
>>> very, very, very similar, usually the recommendation still stays.
>> Well, true. But in some cases we handle this by using a single set of
>> compatibles. Consider e.g. sa8155 vs sm8150 (sa8155 overrides just few
>> compats that differ). Or qrb5165 vs sm8250 (there is no separate
>> qrb5165.dtsi). APQ8096 (#include "msm8996.dtsi"). Etc.
>>
>> I'd say this really depends on the actual difference between qru and qdu.
> To add some clarification, there's pretty little functional
> difference between the QDU (Distributed Unit) and the QRU
> (Radio Unit); they're largely the same SoC from the kernel's
> standpoint. I wasn't sure if it made more sense to separate
> the compat strings or mash them together (using qdru to
> specify that it applies to both), so I kept separate compat
> strings in case there was a separate RU/DU use case down
> the line and also to avoid some confusion (I guess that
> didn't work though). It makes the most sense in my mind
> to just use the qdru compat string for the things that apply
> to both SoCs (which is most of what's submitted currently) and
> then we can do qdu/qru specific override strings for more
> specific drivers. 
> Thanks, Melody 
Fixed formatting.
