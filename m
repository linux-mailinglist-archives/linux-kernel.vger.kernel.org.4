Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9A8686049
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjBAHHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBAHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:07:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0818132;
        Tue, 31 Jan 2023 23:07:29 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31176V3A014693;
        Wed, 1 Feb 2023 07:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2d1m9AVsZa7UosTZCP8MZLtV62QNTY81t8fBssCzMrA=;
 b=Ax7e6UYOd9v14eZ6sFyIIZbF4G0OTwQ4UtOTomVqgl86NVTFFJtbJP85GOHj5IvYi55H
 gwlvCVAcaSv4ccuERgv+4IjrTofK++gbzRG125h16rMtVLIUSwTaNiy74RIgBcONLf4p
 ZbXVTuQWOM36df/SJxlE1ozzazGlzI1+WQb+3EJQ7aDCPIOKZXz/mCwpNiHxwh51c6vz
 CA1uhcD0a0rPS3BdiMkm8ZOryKmaj2q2TGp155NQe+oGVUgPZG+Jt/rahxMXDiNy5v2H
 oX+13vFchZA7CxpLA83Hy88/iTztRyU7av4FFzMNUMlEKqgxxWOHbxxzO9NkexJXCOf3 iA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkdbg024-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 07:07:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31177KkO022456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 07:07:20 GMT
Received: from [10.216.43.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:07:16 -0800
Message-ID: <b1ae5119-423e-1d6a-546a-85b4e212e5f9@quicinc.com>
Date:   Wed, 1 Feb 2023 12:37:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into
 lpass_aon
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>
References: <1674728065-24955-1-git-send-email-quic_srivasam@quicinc.com>
 <1674728065-24955-6-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50y4JEQqW2wgS_qoDkdrqP=bzpC6b_LpA6Q9P+jDc00ZQ@mail.gmail.com>
 <c8d779fe-2508-4aa1-8de9-26d858bc068b@quicinc.com>
 <CAE-0n50fJWqHE0A3R8yawGZAcNb_QDNQ5h2=CXxKAX0eOghegQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50fJWqHE0A3R8yawGZAcNb_QDNQ5h2=CXxKAX0eOghegQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TyddGFluiuRivz_-NbUh4r72UdO4Teaj
X-Proofpoint-GUID: TyddGFluiuRivz_-NbUh4r72UdO4Teaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010061
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 1:56 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2023-01-31 01:29:16)
>> On 1/31/2023 6:34 AM, Stephen Boyd wrote:
>> Thanks for your Time Stephen!!!
>>> Quoting Srinivasa Rao Mandadapu (2023-01-26 02:14:24)
>>>> Merge lpasscc clocks into lpass_aon clk_regmap structure as they
>>>> are using same register space.
>>>> Add conditional check for doing lpasscc clock registration only
>>>> if regname specified in device tree node.
>>>> In existing implementation, lpasscc clocks and lpass_aon clocks are
>>>> being registered exclusively and overlapping if both of them are
>>>> to be used.
>>>> This is required to avoid such overlapping and to register
>>>> lpasscc clocks and lpass_aon clocks simultaneously.
>>> Can you describe the register ranges that are overlapping?
>> Okay. Will add register ranges in description.
> Thanks!
>
>>> Here's what I see in DT right now:
>>>
>>>                   lpasscc: lpasscc@3000000 {
>>>                           compatible = "qcom,sc7280-lpasscc";
>>>                           reg = <0 0x03000000 0 0x40>,
>>>                                 <0 0x03c04000 0 0x4>;
>>>                           ...
>>>                   };
>>>
>>>                   lpass_audiocc: clock-controller@3300000 {
>>>                           compatible = "qcom,sc7280-lpassaudiocc";
>>>                           reg = <0 0x03300000 0 0x30000>,
>>>                                 <0 0x032a9000 0 0x1000>;
>>>                           ...
>>>                   };
>>>
>>>                   lpass_aon: clock-controller@3380000 {
>>>                           compatible = "qcom,sc7280-lpassaoncc";
>>>                           reg = <0 0x03380000 0 0x30000>;
>>>                           ...
>>>                   };
>>>
>>>                   lpass_core: clock-controller@3900000 {
>>>                           compatible = "qcom,sc7280-lpasscorecc";
>>>                           reg = <0 0x03900000 0 0x50000>;
>>>                           ...
>>>                   };
>>>
>>> Presumably lpascc is really supposed to be a node named
>>> 'clock-controller' and is the node that is overlapping with lpass_aon?
>> Okay. As it's been coming previous patches, didn't change the name.
>>
>> May be we need to do it as separate patch.
> Sure, another patch to rename lpasscc to clock-controller would be
> appreciated.
>
>> Yes. It's overlapping with lpass_aon ( <0 0x03380000 0 0x30000>).
>>
>> CC clocks range is <0 0x03389000 0 0x24>;
> Is that a new register range for lpasscc? Why do we have that node at
> all? Can we add different properties to the existing lpass_audiocc,
> lpass_aon, or lpass_core nodes to indicate what clks should or shouldn't
> be registered or provided to the kernel?

It's not new register range. They are actually AHBM and AHBS clock 
registers within lpass_aon regmap range.

Here what I meant lpasscc clocks are not of lpasscc node. I am sorry to 
make you confused.

As the reg-name used as "CC", mentioning it as lpasscc clocks. I will 
rephrase commit message and re-post.

Previously these two clocks are registered separately. Now we are 
merging them into lpass_aon clk reg space.


>
>>>> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/lpassaudiocc-sc7280.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>>>> index 1339f92..8e2f433 100644
>>>> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
>>>> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>>>> @@ -826,10 +829,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
>>>>                   return ret;
>>>>
>>>>           if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
>>>> -               lpass_audio_cc_sc7280_regmap_config.name = "cc";
>>>> -               desc = &lpass_cc_sc7280_desc;
>>>> -               ret = qcom_cc_probe(pdev, desc);
>>>> -               goto exit;
>>>> +               res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
>>> We shouldn't need to check for reg-name property. Instead, the index
>>> should be the only thing that matters.
>> As qcom_cc_probe() function is mapping the zero index reg property, and
>>
>> in next implementation qcom_cc_really_probe() is also probing zero index
>> reg property,
>>
>> unable to map the same region twice.
> Use qcom_cc_probe_by_index()?

With this, if we mention some index and if it's not present in DT, it 
will return error.

Is it okay if error is ignored and proceed?

>
>> Hence all I want here is to skip this cc clock probing by keeping some
>> check.
>>
>> If we remove, it may cause ABI break.
>>
> I'm not sure what you mean here about ABI break, but hopefully just
> using qcom_cc_probe_by_index() works!
