Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA845F46FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJDPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJDPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:52:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771D5F99D;
        Tue,  4 Oct 2022 08:52:56 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294F9Gr5008314;
        Tue, 4 Oct 2022 15:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+gNcct++e3QrD+yFoVtq5bWnTnE3gOyQiPLdeWVwVyw=;
 b=WdqEZ4wv5Ky2y6c4F5SU2kRb+TshtcltswFAKtvW7rjiiBoWrmfF12q/BFAZdcke3y2M
 xqrbi+xU878UbUv70Ppz2GlpRM54hvRXsquzzBPTnXh2NthopbGVtladnQ/pUTx4czAV
 XC5kZD64wNJU/iDzGVQbg9kuxYSQ8Bc+jalVTtKg7Oz9MVRXizuUMH9fAbQVWHVawsyJ
 oJCrdqX4HbJyYCs1qC3M8Pv1tYtyrj5iLuWg56VszvdIGBk8I5arIuFLBh3D5ODovBPn
 9iKuQXrUp77ck3xI28xY6M4XjUcTvtM9Car79p5oib7mY7PoPUBzz+38DfALOyw660xw kA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0m88gfvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 15:52:53 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294FqrYp002577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 15:52:53 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 08:52:51 -0700
Message-ID: <095742cb-61cc-af5d-848c-48b2ea5528ea@quicinc.com>
Date:   Tue, 4 Oct 2022 10:52:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
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
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJprQoCQzr2x0JA9_b3MDE=oOTODyHD23debEL1MCE1mWBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wTUuXQPcUryu0OaG0Jqm-91IyI17ydlG
X-Proofpoint-ORIG-GUID: wTUuXQPcUryu0OaG0Jqm-91IyI17ydlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040102
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2022 2:36 AM, Dmitry Baryshkov wrote:
> On Tue, 4 Oct 2022 at 09:53, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 04/10/2022 00:14, Dmitry Baryshkov wrote:
>>> On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>>>
>>>> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
>>>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>>>
>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
>>>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>> @@ -51,6 +51,8 @@ properties:
>>>>>>            - qcom,scm-sm8250
>>>>>>            - qcom,scm-sm8350
>>>>>>            - qcom,scm-sm8450
>>>>>> +          - qcom,scm-qdu1000
>>>>>> +          - qcom,scm-qru1000
>>> I think after seeing all the patchsets it's time to ask the following
>>> question. Do we really need a duplicate compatibility families:
>>> qdu1000 vs qru1000? I'd suggest using a single set of compatibile
>>> strings in most of the cases.
>>> Settle down onto a single name (qdu,qru, qdru, whatever) and define
>>> distinct compat strings only when there is an actual difference?
>>>
>>> E.g .we don't have separate compatible strings for all the sda660,
>>> apq8096, etc. unless this is required by the corresponding hardware
>>> block not being compatible with corresponding sdm or msm counterpart.
>>>
>> I am not that fluent in Qualcomm naming, so let me ask - what are the
>> differences between QDU and QRU?
>>
>> For compatible (and/or similar) devices the general recommendation is to
>> have specific compatibles followed by fallback. Even if devices are
>> very, very, very similar, usually the recommendation still stays.
> Well, true. But in some cases we handle this by using a single set of
> compatibles. Consider e.g. sa8155 vs sm8150 (sa8155 overrides just few
> compats that differ). Or qrb5165 vs sm8250 (there is no separate
> qrb5165.dtsi). APQ8096 (#include "msm8996.dtsi"). Etc.
>
> I'd say this really depends on the actual difference between qru and qdu.

To add some clarification, there's pretty little functional difference between the QDU (Distributed Unit) and the QRU (Radio Unit); they're largely the same SoC from the kernel's standpoint. I wasn't sure if it made more sense to separate the compat strings or mash them together (using qdru to specify that it applies to both), so I kept separate compat strings in case there was a separate RU/DU use case down the line and also to avoid some confusion (I guess that didn't work though). It makes the most sense in my mind to just use the qdru compat string for the things that apply to both SoCs (which is most of what's submitted currently) and then we can do qdu/qru specific override strings for more specific drivers.

Thanks,

Melody

