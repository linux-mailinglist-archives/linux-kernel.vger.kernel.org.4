Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D223682A61
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAaKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAaKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:23:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C333B8;
        Tue, 31 Jan 2023 02:22:51 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V88jOV027425;
        Tue, 31 Jan 2023 10:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ooGDWvMmAJQv6/uFVmd1tojNLIC77U8WC0NpSBrNCK0=;
 b=Vi0FnmBW4KDTixMjnkhcGmKGcfFHRki6CBqUeHBRA/sCE1C3Am+bCFiNg7VlpCrvjkuF
 JVymoy0UqOj7O3bes7aluKAwPawuoYZINbVUZKoJOZsdb8W6XIF7uUBnrybu2qkpck01
 hTJulr9dDO3VffRAvYk72840cPnO8GG4ZywhKpKfZkFB5Zu9KMczR99zfpAE7qXPiCOD
 Vcjxso/El0y/FgUX7nbs3+O1XcKSAV9qkAPDjDluwSDOri5V9Q1ZsEaX9PY85/V5tC9G
 vPjvYro15r2ArXCqcll8lj9jpIyZeqVdqxszPSugRSJIgBjpUf5UZ5ln3szhffpdgriJ 2w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexg40cx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 10:22:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VAMkc6017721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 10:22:46 GMT
Received: from [10.50.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 02:22:41 -0800
Message-ID: <dc32d158-d860-54ff-50cd-e1d96c576ed6@quicinc.com>
Date:   Tue, 31 Jan 2023 15:52:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] regulator: qcom_smd: Add PMIC compatible for IPQ9574
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-5-quic_devipriy@quicinc.com>
 <20230117183835.GA3427325-robh@kernel.org>
 <11a5fa34-c438-a567-6364-4bf1d0d369e3@quicinc.com>
 <CAL_JsqKMpW7O_sQ4j+ZBfjGZdJUDosM-kVhcFjaUmXvXCC4L8A@mail.gmail.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAL_JsqKMpW7O_sQ4j+ZBfjGZdJUDosM-kVhcFjaUmXvXCC4L8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AbDZqsHKMtzHG0zfk77MP2ul1DyfGbWu
X-Proofpoint-ORIG-GUID: AbDZqsHKMtzHG0zfk77MP2ul1DyfGbWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301310090
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 1:42 AM, Rob Herring wrote:
> On Fri, Jan 27, 2023 at 10:05 AM Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>>
>>
>> On 1/18/2023 12:08 AM, Rob Herring wrote:
>>> On Fri, Jan 13, 2023 at 08:33:08PM +0530, devi priya wrote:
>>>> Add mp5496 PMIC compatible string for IPQ9574 SoC
>>>>
>>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>>> index 8c45f53212b1..7907d9385583 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>>> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>>> @@ -22,7 +22,7 @@ description:
>>>>      Each sub-node is identified using the node's name, with valid values listed
>>>>      for each of the pmics below.
>>>>
>>>> -  For mp5496, s2
>>>> +  For mp5496, s1, s2
>>>>
>>>>      For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>>>>      l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
>>>> @@ -84,6 +84,7 @@ properties:
>>>>      compatible:
>>>>        enum:
>>>>          - qcom,rpm-mp5496-regulators
>>>> +      - qcom,rpm-ipq9574-mp5496-regulators
>>>
>>> Is this a different part than just mp5496? Or used in a different,
>>> incompatible way?
>> IPQ6018 and IPQ9574 platforms use the same PMIC MP5496 but they have a
>> different power layout.So, we plan to update the compatible:
>> qcom,rpm-mp5496-regulators to
>> qcom,rpm-ipq6018-mp5496-regulators(target-specific) in the next patchset
>> as the regulators serve different purposes
> 
> You can't just change compatibles. It is an ABI.
> 
> This still doesn't make sense to me. The PMIC hasn't changed, so the
> binding shouldn't. It should be flexible enough to be hooked up to
> different platforms. That's why we have all the per regulator
> configuration. What are you missing?
> 
> Rob
Sure got it!
It should be fine to use the existing mp5496 compatible for IPQ9574 too.
Will update this in V2

Best Regards,
Devi Priya
