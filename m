Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0372801D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjFHMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjFHMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:33:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B3E43;
        Thu,  8 Jun 2023 05:33:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358BnPG2006117;
        Thu, 8 Jun 2023 12:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H1FK3RhZTcUhqJjR63H2zmKhnRjDVzFQ1gagnb5dBis=;
 b=pjrNJsJOSzBRtzvcD8CLd87jOj+MFTeaCM/E2/bTPkvRlcB46pkzsHbXJyJiIBRTxFvc
 45oycvaNKk6sXF+YNZHcmgterr4cvI2HGDYqhEKR3HN1ZXL5NtMXmtW9d7wfNLCPN4bO
 kxHhNrRQpU6GQ6m4HDZcqx7qCRh8pzdaR0P6JEw8uzMlcKW/SC9JU6w3ys1048SB3vE6
 3nNuZ/9bSik0K8tzIVD5oIzzfcPJFhFdZGTlf9FmlndHxuc/5YWx3tti3YVknWF/5eOV
 jX00/hLjIeH6/FJjdet9xRo17FlB32xKK4JTSyp1nnJhw7HB/Mi7K3vf1YOOtNokyNqw Og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r31rghdum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:33:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358CXRox020622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 12:33:27 GMT
Received: from [10.216.21.154] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 05:33:19 -0700
Message-ID: <05abb4e0-80c8-eb53-2d07-973ac7618aa8@quicinc.com>
Date:   Thu, 8 Jun 2023 18:03:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 12/13] arm64: dts: qcom: ipq5018: Add RDP432-c1 board
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-13-quic_mmanikan@quicinc.com>
 <ea6d31cc-68b2-3b73-ae12-dad122a85857@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <ea6d31cc-68b2-3b73-ae12-dad122a85857@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FJqy9Y5iVWq4B_KZ9V-Cn-GvLXMCdSoD
X-Proofpoint-GUID: FJqy9Y5iVWq4B_KZ9V-Cn-GvLXMCdSoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080108
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 4:36 PM, Krzysztof Kozlowski wrote:
> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>> Add initial device tree support for the RDP432-C1 board.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Renamed mp03.5-c1 to RDP432-c1
>> 	- Removed boot-args
>> 	- Resolved dt-binding error's
>>
>>   arch/arm64/boot/dts/qcom/Makefile             |  1 +
>>   .../arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts | 49 +++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 259bd57c6064..bb9164de75b0 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
>> new file mode 100644
>> index 000000000000..7fe28d9859b0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * IPQ5018 RDP432-C1 board device tree source
>> + *
>> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5018.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C1";
>> +	compatible = "qcom,ipq5018-rdp432-c1", "qcom,ipq5018";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&blsp1_uart1 {
>> +	pinctrl-0 = <&uart1_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&q6v5_wcss {
>> +	pd-2 {
>> +		firmware-name = "IPQ5018/q6_fw.mdt";
> 
> Does not look like correct paths. Please open firmware and look there.
> Or open other DTS files and check example. Missing qcom, lowercase,
> that's minimum of fixes needed.
> 
> Best regards,
> Krzysztof
> 

IPQ5018 firmware files are available here
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k/IPQ5018/hw1.0
I will use 'ath11k/IPQ5018/hw1.0' path.

Thanks & Regards,
Manikanta.
