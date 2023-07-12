Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610367508F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjGLM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGLM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:59:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080091736;
        Wed, 12 Jul 2023 05:59:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CCnIVo019048;
        Wed, 12 Jul 2023 12:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gYiOiSiY93zMQf1d40yP6iQ9FTq+pjUOQ8cnmkdfnn4=;
 b=kIBsq8aGz9217a5S7oRQ2n+1UIEZE5Z3NG12/pthsVMTfKXD6BblzjFq7fR6FtXfqFY1
 PFWRHu/jbt/WGYt3AyN3dyPa2i4NI96up/d5+ntA4CdMh8dE719MGrBPhg8w+F764agF
 2prQvnKv10NZtqquCo8ZMirSWpktRqDqmS4+3lvK+A0gnk48+lu7v91Biy8PnIqKj8Kf
 07KmH4Wf2UwpvRBTk1M3a+I2Mi2ioEkRzhuzyaT2oPnVnzH3ERKw3k7UwAU8trsXkBJG
 rys7QzaKj1Rcgd9as6DCPsdw/2VtkUSW/OhtoJ3AURlfGXwn6zX3ZODbB+Zxbl6i6/jP YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar9c5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:59:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CCxStr027636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:59:28 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 05:59:23 -0700
Message-ID: <a3dba5d9-918f-159f-161c-444a63d4c5b3@quicinc.com>
Date:   Wed, 12 Jul 2023 18:29:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: ipq5332: Add tsens node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-4-quic_ipkumar@quicinc.com>
 <a95dd01a-943f-e2d4-777f-a139fbc25238@linaro.org>
 <61346e56-3877-37c0-0df5-2436f97064e7@quicinc.com>
 <538c3d99-a404-6847-dd04-f77a35aa6c77@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <538c3d99-a404-6847-dd04-f77a35aa6c77@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T1Z-g5d1QMYtPfv0IL3VJKU8NsDznhuG
X-Proofpoint-ORIG-GUID: T1Z-g5d1QMYtPfv0IL3VJKU8NsDznhuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=908 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120117
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 6:23 PM, Dmitry Baryshkov wrote:
> On 12/07/2023 15:48, Praveenkumar I wrote:
>>
>> On 7/12/2023 5:54 PM, Dmitry Baryshkov wrote:
>>> On 12/07/2023 14:35, Praveenkumar I wrote:
>>>> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
>>>> node with nvmem cells for calibration data.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>> [v2]:
>>>>     Included qfprom nodes only for available sensors and removed
>>>>     the offset suffix.
>>>>
>>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 
>>>> +++++++++++++++++++++++++++
>>>>   1 file changed, 66 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>>>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> index 8bfc2db44624..0eef77e36609 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> @@ -150,6 +150,46 @@ qfprom: efuse@a4000 {
>>>>               reg = <0x000a4000 0x721>;
>>>>               #address-cells = <1>;
>>>>               #size-cells = <1>;
>>>> +
>>>> +            tsens_mode: mode@3e1 {
>>>> +                reg = <0x3e1 0x1>;
>>>> +                bits = <0 3>;
>>>> +            };
>>>> +
>>>> +            tsens_base0: base0@3e1 {
>>>> +                reg = <0x3e1 0x2>;
>>>> +                bits = <3 10>;
>>>> +            };
>>>> +
>>>> +            tsens_base1: base1@3e2 {
>>>> +                reg = <0x3e2 0x2>;
>>>> +                bits = <5 10>;
>>>> +            };
>
> Please order device nodes according to the address. So mode/base 
> should come after sensors data.
Sure, will reorder based on the address.

-- 
Thanks,
Praveenkumar
>
>>>> +
>>>> +            s11: s11@3a5 {
>>>> +                reg = <0x3a5 0x1>;
>>>> +                bits = <4 4>;
>>>> +            };
>>>> +
>>>> +            s12: s12@3a6 {
>>>> +                reg = <0x3a6 0x1>;
>>>> +                bits = <0 4>;
>>>> +            };
>>>> +
>>>> +            s13: s13@3a6 {
>>>> +                reg = <0x3a6 0x1>;
>>>> +                bits = <4 4>;
>>>> +            };
>>>> +
>>>> +            s14: s14@3ad {
>>>> +                reg = <0x3ad 0x2>;
>>>> +                bits = <7 4>;
>>>> +            };
>>>> +
>>>> +            s15: s15@3ae {
>>>> +                reg = <0x3ae 0x1>;
>>>> +                bits = <3 4>;
>>>> +            };
>>>>           };
>>>>             rng: rng@e3000 {
>>>> @@ -159,6 +199,32 @@ rng: rng@e3000 {
>>>>               clock-names = "core";
>>>>           };
>>>>   +        tsens: thermal-sensor@4a9000 {
>>>> +            compatible = "qcom,ipq5332-tsens";
>>>> +            reg = <0x4a9000 0x1000>,
>>>> +                  <0x4a8000 0x1000>;
>>>> +            nvmem-cells = <&tsens_mode>,
>>>> +                      <&tsens_base0>,
>>>> +                      <&tsens_base1>,
>>>> +                      <&s11>,
>>>> +                      <&s12>,
>>>> +                      <&s13>,
>>>> +                      <&s14>,
>>>> +                      <&s15>;
>>>> +            nvmem-cell-names = "mode",
>>>> +                       "base0",
>>>> +                       "base1",
>>>> +                       "s11",
>>>> +                       "s12",
>>>> +                       "s13",
>>>> +                       "s14",
>>>> +                       "s15";
>>>
>>> Previously you had data for other sensors here. Are they not used at 
>>> all, not wired, have no known-good placement? I think it might be 
>>> better to declare all sensors here (and in the driver too) and then 
>>> consider enabling only a pile of them in the thermal-zone node.
>>
>> Remaining sensors are not used at all. It is not wired. Only above 
>> sensors are placed in SoC.
>
> Ack, thanks for the explanation. Then this is good.
>
>>
>> - Praveenkumar
>>
>>>
>>>> +            interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "combined";
>>>> +            #qcom,sensors = <5>;
>>>> +            #thermal-sensor-cells = <1>;
>>>> +        };
>>>> +
>>>>           tlmm: pinctrl@1000000 {
>>>>               compatible = "qcom,ipq5332-tlmm";
>>>>               reg = <0x01000000 0x300000>;
>>>
>
