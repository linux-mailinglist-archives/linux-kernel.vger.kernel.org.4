Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E86774B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjAWEok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWEoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:44:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA313501;
        Sun, 22 Jan 2023 20:44:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N4djeL005120;
        Mon, 23 Jan 2023 04:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OacOLlrKZ8JwK9orVXA8AsmjPvwSvOiWb+YQJupZdHc=;
 b=pyw1F8UUN/si4ysc9TlU/weUAtxSbN2tsrg8LrHldbCzwTWvyeA1ggYohxtjU9RXNYZ1
 HGH5wYMqCoKuL2j19CDVbaojaouSh269rOV7Ah5Vo1YCo6u77i1oJJreo6YjUBwt7oLl
 fHIaeQgIP0Ob1/o6vSnSCTT5yJ3KGUV6y/c51F9MI1IPPwWO5iYaq1UmtQMLgOsLKalO
 tioMWhq45zTQxxl010pK5aRWo/ForE5Q/902Eh1b5U6hH20Sc6GJzkWnxniusEtjYLDN
 nYw+yiVzjBpRVeQ8Oke4Qe5q81LW5MPT8SqaZ/m+f2OgH5I5CAP6qTFHGSBm3tIRVIx9 nw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89htt6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 04:44:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30N4iW9E025702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 04:44:32 GMT
Received: from [10.50.40.120] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 22 Jan
 2023 20:44:29 -0800
Message-ID: <0b224700-4774-0c34-7ce1-0a984b62b3c0@quicinc.com>
Date:   Mon, 23 Jan 2023 10:14:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
To:     Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230121112358.52216-1-robimarko@gmail.com>
 <20230121112358.52216-2-robimarko@gmail.com>
 <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com>
 <CAOX2RU7p-0ZTx8fkY4hOk=Zmx6RT+1PwVL+CQxkjzVadm0ehTA@mail.gmail.com>
 <29d9de45-1ce7-d6e5-bf02-052e911a067b@quicinc.com>
 <CAOX2RU7BfESmsUdZ5jBfYjWXUnDWmFizT8UiPwgzb_SsrT0jnA@mail.gmail.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAOX2RU7BfESmsUdZ5jBfYjWXUnDWmFizT8UiPwgzb_SsrT0jnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DThyUDSLr-WQp1k0nFCb0SapXD4m6Acz
X-Proofpoint-GUID: DThyUDSLr-WQp1k0nFCb0SapXD4m6Acz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=952 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230044
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/2023 10:39 PM, Robert Marko wrote:
> On Sun, 22 Jan 2023 at 18:05, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>>
>> On 1/22/2023 10:29 PM, Robert Marko wrote:
>>> On Sun, 22 Jan 2023 at 17:57, Kathiravan Thirumoorthy
>>> <quic_kathirav@quicinc.com> wrote:
>>>> On 1/21/2023 4:53 PM, Robert Marko wrote:
>>>>> IPQ8074 has efuses like other Qualcomm SoC-s that are required for
>>>>> determining various HW quirks which will be required later for CPR etc,
>>>>> so lets add the QFPROM node for start.
>>>>>
>>>>> Individidual fuses will be added as they are required.
>>>>>
>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>> ---
>>>>>     arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
>>>>>     1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>>> index 8eba586065a3..f29491f647fe 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>>>> @@ -301,6 +301,13 @@ mdio: mdio@90000 {
>>>>>                         status = "disabled";
>>>>>                 };
>>>>>
>>>>> +             qfprom: efuse@a4000 {
>>>>> +                     compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
>>>>> +                     reg = <0x000a4000 0x1000>;
>>>>    From the HW document, I see the overall size of this region is 0x2000,
>>>> any reason to stick with 0x1000?
>>> Like always, I dont have access to docs and 0x1000 is all I could find
>>> downstream
>>> being used.
>>>
>>> Any chance you can share the regions inside of QFPROM, it would be great to use
>>> the ECC corrected one if available.
>> Sorry, What do you refer by "ECC corrected" here?
> Isnt there a corrected region in the QFPROM meant for reading?
> As far as I understand it's protected by FEC.


Yes, there are two regions for the QFPROM, the region which you used 
here is the one used for reading and there is a error correction logic 
for it and it is size is 8KB not 4KB.

Thanks, Kathiravan T.

>
> Regards,
> Robert
>> Thanks, Kathiravan T.
>>
>>
>>> Regards,
>>> Robert
>>>> Thanks, Kathiravan T.
>>>>
>>>>
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <1>;
>>>>> +             };
>>>>> +
>>>>>                 prng: rng@e3000 {
>>>>>                         compatible = "qcom,prng-ee";
>>>>>                         reg = <0x000e3000 0x1000>;
