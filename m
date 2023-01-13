Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12034669939
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjAMN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjAMN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:56:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1AE809BF;
        Fri, 13 Jan 2023 05:53:31 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBbaJ3012849;
        Fri, 13 Jan 2023 13:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SCdwrlofA1mXPeZBUwBOeam+HT4cs8ZgSh/+SESt4tk=;
 b=IMdWAwVg2bP5W8PIwDURNuFNLdYbIyTkQ6wYNEAXas2bDM1sliJPM38+LefI7i/upIb8
 vYVJoBhKdDorGim7nMNfk7T6YCATcRzrYhFDusi8b869cbMyP1iYKc4E0da1gKC7PEtI
 uSPP4qSbVShiG+GDXDeLvR6qU3lyKdXp/8pZb9pZyj7BX12ZMUkPx/4zzgDCenbfGIUz
 kxk16T/MObalwUZa5bB+aRwqBIN6dInhTh3mSed9hFNYgwexHJuZ8+S4fN4nf4jheVSv
 bsXA+5CSpp3dcd3zWtUPvanG7OjujBBQRnVL6w6dmw4IcRx0D2RFhiFJohso1+fBOCdw Kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2hum2yex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:52:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDqpUN030629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:52:51 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:52:42 -0800
Message-ID: <de6b509d-fdb7-c9b1-7d4d-551a952f992d@quicinc.com>
Date:   Fri, 13 Jan 2023 19:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <5da7ead743415dfb6d571a6b72a81b08@kernel.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <5da7ead743415dfb6d571a6b72a81b08@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h-zzEUYFLrV7xRUZ7VEox8f_EO1xoVW8
X-Proofpoint-ORIG-GUID: h-zzEUYFLrV7xRUZ7VEox8f_EO1xoVW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=932 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130091
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 7:19 PM, Marc Zyngier wrote:
> On 2023-01-10 12:13, devi priya wrote:
>> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
>>
>> Add initial device tree support for Qualcomm IPQ9574 SoC
>> and AL02 board
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  69 ++++
>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 318 +++++++++++++++++++
>>  3 files changed, 388 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 3e79496292e7..872c62028a0b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += ipq6018-cp01-c1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk01.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += ipq9574-al02-c7.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += msm8916-alcatel-idol347.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += msm8916-asus-z00l.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)    += msm8916-huawei-g7.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> new file mode 100644
>> index 000000000000..ae3c32f3e16a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> 
> [...]
> 
>> +    timer {
>> +        compatible = "arm,armv8-timer";
>> +        interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>;
> 
> Interesting choice for the PPIs...
> 
>> +        clock-frequency = <24000000>;
> 
> Please drop this and fix the firmware. No system built within
> past 10 years should need it.
Sure, will drop!
> 
>          M.
Best Regards,
Devi Priya
