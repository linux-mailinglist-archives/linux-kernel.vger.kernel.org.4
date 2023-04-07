Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68A6DAB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjDGKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjDGKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:22:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB967ED3;
        Fri,  7 Apr 2023 03:22:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377MXI5013040;
        Fri, 7 Apr 2023 10:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q0vpDgVuiJJwQzilV7Uvd/VJSZtDHMxv30kgg5UkQB0=;
 b=cHa4WkRp32n3m4HroUn/SROrrZlDqhZuR9nC9hfI+6+2iw/EAyUIylF2kwokFpHi6Azx
 h89N3pD6pw1kURyv3IvOE9htGLD+x56cTkVdIOvdNDIrlpnUfumrdBJFKbkbbq2/yfBJ
 0w/P++SJnyhH92fxQN/RHpYWkRMpz5yRQCzp2Q9BEKCl0uEzLoCk/x2eCEjethOEfjCP
 94ArvfeOlqQt6y6wVw4J38ae+P4SNe0I/2BDmGcjXZT0tErWoVcGeMhSdWdaAwVOxDAv
 8tQ5L0BlfEAGBlPI03KtB1cnOyb/8/ZhNryvuz7Ticsa7GtvD+Gn6MPn1skLIy+MKTQr rA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pssmw34th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:21:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337ALP1A015330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 10:21:25 GMT
Received: from [10.216.18.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 03:21:15 -0700
Message-ID: <c74b40fe-92b9-9a53-1a9f-b19a7090a12c@quicinc.com>
Date:   Fri, 7 Apr 2023 15:51:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V11 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <rafal@milecki.pl>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230404101622.5394-1-quic_devipriy@quicinc.com>
 <20230404101622.5394-4-quic_devipriy@quicinc.com>
 <d410c51ee4beeb4dfee80e13d54d598b@kernel.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <d410c51ee4beeb4dfee80e13d54d598b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tyNx0KBWHNmsGSGr_4E5QkhMMB__RRFu
X-Proofpoint-ORIG-GUID: tyNx0KBWHNmsGSGr_4E5QkhMMB__RRFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxlogscore=707 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070095
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2023 4:33 PM, Marc Zyngier wrote:
> On 2023-04-04 11:16, Devi Priya wrote:
>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>> family of SoCs
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>  Changes in V11:
>>     - Dropped the unused backup clock source bias_pll_ubi_nc_clk
>>
>>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 +++++++
>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 263 ++++++++++++++++++++
>>  3 files changed, 348 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
> 
> [...]
> 
>> +        intc: interrupt-controller@b000000 {
>> +            compatible = "qcom,msm-qgic2";
>> +            reg = <0x0b000000 0x1000>,  /* GICD */
>> +                  <0x0b002000 0x1000>,  /* GICC */
> 
> This is definitely wrong. The GICC region cannot be less than
> 8kB, as the GICC_DIR register is in the second 4kB region.
> 
> I'm pretty sure the kernel shouts at you when booting at EL2.
Got it, will update the size to 8kB
> 
>> +                  <0x0b001000 0x1000>,  /* GICH */
>> +                  <0x0b004000 0x1000>;  /* GICV */
> 
> Same thing here.
okay
> 
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <3>;
>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> 
> Missing target CPU encoding.
Okay, will update the interrupts as below. Hope this is the expectation?
Please let us know if we are missing something
interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> 
>          M.
Best Regards,
Devi Priya
