Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C9739775
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFVG02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:26:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C82113;
        Wed, 21 Jun 2023 23:26:06 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M5NAEv023583;
        Thu, 22 Jun 2023 06:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P2EFfgzAdwxr3yzoWV40orFUBW1EY4sDEyJi3axqpGA=;
 b=abN4PlihoiHqgyppEmlIgsg0cFu6m6aWCSecEAI+EwBku/u66UUrV+HHGmmyA9rwIcGv
 I18smzV3l6O/L/RnJTGZgtjZv+C3xdVu/MwhlX50HrA5uNvDovd9banPZHLLNMNU51m3
 lh5sKA3ai4WTKxlu1b2guniAKLIFH+vJs+EVdXp6AM7gkaQPWC4J03ku1pEFJN/SibJh
 p/r4IUOPZ66H02l8E88xNqKg6AygKuEZL+ULH7ykwpqF/ukDXXG6x1P1pJGyWBSxa3QI
 JPad3Ii/7LI+xFAQeK2BB/RkhIsMh8o0yziO3w5XxJrJL8jYfn9/wxQcPEypHaYgWgng Ig== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbykdj4df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:26:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35M6Q1Fd018528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:26:01 GMT
Received: from [10.216.5.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 23:25:57 -0700
Message-ID: <d05c7b0e-6edb-bc0f-5875-fc5cb8ea6b8a@quicinc.com>
Date:   Thu, 22 Jun 2023 11:55:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: Use assigned-clock-rates for
 QUP I2C core clks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230615084841.12375-1-quic_devipriy@quicinc.com>
 <1ab63d4b-6358-ce08-818a-b5751f88cdde@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <1ab63d4b-6358-ce08-818a-b5751f88cdde@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oE3WsmWfn0CAE7z63tYq6MBVeoNZ4Tt0
X-Proofpoint-GUID: oE3WsmWfn0CAE7z63tYq6MBVeoNZ4Tt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 2:21 PM, Konrad Dybcio wrote:
> On 15.06.2023 10:48, Devi Priya wrote:
>> Use assigned-clock-rates property for configuring the QUP I2C core clocks
>> to operate at nominal frequency.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
> There's probably some logic behind this, and it almost sounds like
> it'd be fitting to introduce an OPP table for I2C hosts, especially
> given the voltage requirements.
> 
> Konrad
The qup i2c core clocks are not scalable and operate at fixed frequency.
The assigned-clock-rates are used to configure the clock frequency
if it is not done by the bootloaders.

Thanks,
Devi Priya
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 0baeb10bbdae..78bf7f9c455a 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -361,6 +361,8 @@
>>   			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
>>   				 <&gcc GCC_BLSP1_AHB_CLK>;
>>   			clock-names = "core", "iface";
>> +			assigned-clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
>> +			assigned-clock-rates = <50000000>;
>>   			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
>>   			dma-names = "tx", "rx";
>>   			status = "disabled";
>> @@ -389,6 +391,8 @@
>>   			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
>>   				 <&gcc GCC_BLSP1_AHB_CLK>;
>>   			clock-names = "core", "iface";
>> +			assigned-clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
>> +			assigned-clock-rates = <50000000>;
>>   			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
>>   			dma-names = "tx", "rx";
>>   			status = "disabled";
>> @@ -417,6 +421,8 @@
>>   			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>>   				 <&gcc GCC_BLSP1_AHB_CLK>;
>>   			clock-names = "core", "iface";
>> +			assigned-clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
>> +			assigned-clock-rates = <50000000>;
>>   			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
>>   			dma-names = "tx", "rx";
>>   			status = "disabled";
>> @@ -446,6 +452,8 @@
>>   			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
>>   				 <&gcc GCC_BLSP1_AHB_CLK>;
>>   			clock-names = "core", "iface";
>> +			assigned-clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
>> +			assigned-clock-rates = <50000000>;
>>   			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
>>   			dma-names = "tx", "rx";
>>   			status = "disabled";
