Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613D5679933
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjAXNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAXNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:23:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152686EA8;
        Tue, 24 Jan 2023 05:23:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OCn9Wa018703;
        Tue, 24 Jan 2023 13:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wtz1hdsjqAMLjMNgUJM77dIEL44auyeS5Qpr6iBlyFQ=;
 b=gKYXLUXeq01rknBWPtZAM3whq8Ew0wj15Fg/sj/TZEGNLOdQtpxcHUmEhsdSDtykF/n5
 uiYvR4n1enFGylRlPboGfMykS1GT7ggf4/VPbGvQ8CAGj97hjkKj2Sp0NEGm8brc7aHh
 0j58ctsqWZXtuW/2RB9EWTNshvuRukx9CKa+jJm0wYiV2RTITJvrqizovYPdYRRl0aWd
 sSa2xPRpT2CzEG20SmQc8wDlz4OWjQpNS4QSJQDvcO7dgFv1E06QcGatQudB1yMqNZlv
 GnSSe2+LOTq3aJg/ytjqnt00Ivs1aTwNL0d7sY/2XXydub15nmuI3RWGO488Qxey1RTK 8g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fm54ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:22:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ODMXos023669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:22:33 GMT
Received: from [10.216.24.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 05:22:24 -0800
Message-ID: <e9456e31-4608-f933-d636-987c8ec46b42@quicinc.com>
Date:   Tue, 24 Jan 2023 18:52:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <f6ef1834-b629-b76c-9cde-55af56320665@linaro.org>
 <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
 <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
 <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
 <675ed9f7-da31-6206-5089-1db22025ef4b@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <675ed9f7-da31-6206-5089-1db22025ef4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vy4keUEO0Ynvxsmw7KYejT_JDHYGYqgT
X-Proofpoint-GUID: vy4keUEO0Ynvxsmw7KYejT_JDHYGYqgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=800
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240122
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 3:16 PM, Konrad Dybcio wrote:
> 
> 
> On 24.01.2023 08:19, Devi Priya wrote:
>>
>>
>> On 1/13/2023 7:50 PM, Krzysztof Kozlowski wrote:
>>> On 13/01/2023 14:29, Devi Priya wrote:
>>>>>> +
>>>>>> +    soc: soc@0 {
>>>>>> +        #address-cells = <1>;
>>>>>> +        #size-cells = <1>;
>>>>>> +        ranges = <0 0 0 0xffffffff>;
>>>>>> +        compatible = "simple-bus";
>>>>>> +
>>>>>> +        tlmm: pinctrl@1000000 {
>>>>>> +            compatible = "qcom,ipq9574-tlmm";
>>>>>> +            reg = <0x01000000 0x300000>;
>>>>>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +            gpio-controller;
>>>>>> +            #gpio-cells = <2>;
>>>>>> +            gpio-ranges = <&tlmm 0 0 65>;
>>>>>> +            gpio-reserved-ranges = <59 1>;
>>>>>
>>>>> Hm, why reserved ranges are in SoC?
>>>> As the gpio is forbidden on all ipq9574 boards, we have added it in SoC
>>>
>>> Why it is forbidden on all boards? I guess it depends on the firmware
>>> and this can differ, can't it?
>>>
>> This GPIO is protected and used by the TZ firmware and is forbidden on all the boards & firmware
> If it's protected on *all* boards and *all* firmwares (for any
> good reason that you probably have internally), perhaps it
> would be better to describe it in the .c driver.. wdyt?
> 
Sure, okay. Will add the gpio to reserved_gpios entry in the pinctrl driver
> Konrad
>>> Best regards,
>>> Krzysztof
>>>
>> Regards,
>> Devi Priya
