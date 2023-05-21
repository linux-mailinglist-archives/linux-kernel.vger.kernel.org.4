Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2570AEE6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjEUQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjEUQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:07:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703D10E;
        Sun, 21 May 2023 09:06:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LG10G5031466;
        Sun, 21 May 2023 16:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1qrRImA8rsBlSuKoIz9+67oBdh4h85lUyEHjprVeNHM=;
 b=gmkWGK6DFPeHNcXhOhqDVmBQpkfqAUxFvPmfWlygjpeUC9oty8/ZjphyfxU7pk9MbirZ
 5Y0+Z7Ji4wt4vmba/EIdhKvC9ZNkYV4/h2ZbaKPM6iji3AZQD5GQ9UwU7jsgcCFvCrU6
 jye+/Axj1Ec8jQ0lDm+TQH5ltqTC3hkCn7tJYEV1k9YNJiHXt4ZIkCY523wunZrkRL81
 UWVPrctcyxr1U/xbPY9M+KmSYB9G8vcJrghR0uOgh150brGLnqoIGVx/kThY5tEyNAc2
 dsVhHEqoYwI/uD2mRpm9A/Rgy7ABgLDNYgoi7BAiSDP1j2Du5uTM5qJchsbTjSfsLU6R Yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpn5y214r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 16:05:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LG5lpc025231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 16:05:47 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 09:05:39 -0700
Message-ID: <9526dc43-8c69-b819-af75-02155e60e236@quicinc.com>
Date:   Sun, 21 May 2023 21:35:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 10/11] arm64: dts: qcom: ipq5018: Add MP03.5-c1 board
 support
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
 <b758ac38-27f5-3664-c454-aa0f43592c1b@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <b758ac38-27f5-3664-c454-aa0f43592c1b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sCSa-iQBbusyr5CDbpYJ2ctgxRCBNsNc
X-Proofpoint-GUID: sCSa-iQBbusyr5CDbpYJ2ctgxRCBNsNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210142
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 11:55 AM, Varadarajan Narayanan wrote:
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> Add initial device tree support for the MP03.5-C1 board.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |  1 +
>>   .../arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts | 64 +++++++++++++++++++
>>   2 files changed, 65 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index b77a95e97a56..10d1eafe57e4 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>> apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-ifc6640.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += ipq5018-mp03.1-c2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += ipq5018-mp03.5-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += ipq6018-cp01-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk01.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c1.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts 
>> b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
>> new file mode 100644
>> index 000000000000..51ddd7367ac6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * IPQ5018 CP01 board device tree source
> MP03??
I will change to IPQ5018-RDP432-C1
>> + *
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> 
> Update the year
>  > -Varada
> 
I will update.

Thanks & Regards,
Manikanta.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5018.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.5-C1";
>> +    compatible = "qcom,ipq5018-mp03.5-c1", "qcom,ipq5018";
>> +
>> +    aliases {
>> +        serial0 = &blsp1_uart1;
>> +    };
>> +
>> +    chosen {
>> +        bootargs = "console=ttyMSM0,115200,n8 rw init=/init swiotlb=1 
>> coherent_pool=2M";
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +};
>> +
>> +&tlmm {
>> +    blsp0_uart_pins: uart_pins {
>> +        pins = "gpio20", "gpio21";
>> +        function = "blsp0_uart0";
>> +        bias-disable;
>> +    };
>> +};
>> +
>> +&blsp1_uart1 {
>> +    pinctrl-0 = <&blsp0_uart_pins>;
>> +    pinctrl-names = "default";
>> +    status = "ok";
>> +};
>> +
>> +&q6v5_wcss {
>> +    q6_wcss_pd1: remoteproc_pd1 {
>> +        interrupts-extended = <&wcss_smp2p_in 8 0>,
>> +                <&wcss_smp2p_in 9 0>,
>> +                <&wcss_smp2p_in 12 0>,
>> +                <&wcss_smp2p_in 11 0>;
>> +        interrupt-names = "fatal",
>> +                "ready",
>> +                "spawn-ack",
>> +                "stop-ack";
>> +        qcom,smem-states = <&wcss_smp2p_out 8>,
>> +                <&wcss_smp2p_out 9>,
>> +                <&wcss_smp2p_out 10>;
>> +        qcom,smem-state-names = "shutdown",
>> +                    "stop",
>> +                    "spawn";
>> +    };
>> +    q6_wcss_pd2: remoteproc_pd2 {
>> +        status = "okay";
>> +    };
>> +
>> +    q6_wcss_pd3: remoteproc_pd3 {
>> +        status = "okay";
>> +    };
>> +};
