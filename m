Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2C732648
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFPEm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjFPEmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:42:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1942D5E;
        Thu, 15 Jun 2023 21:42:53 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G3ZROX022462;
        Fri, 16 Jun 2023 04:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BAXd2yjk8OcvSytsAMg0FjZeyy7emml9cZq/OfUk3xU=;
 b=FO7Yehd13Yyyzrz7I7RKsGP3rTFyPQuDpAcoZgBgdR857+nSusucsXcXLBam0Y9eeZ3j
 YvtX1J+s2IB0OJo4dJDAHHgQpCT8VdIVaBsh2p3fHCWgMUAwMrbcrOiNK2C1kLRUUpIP
 0pm48O7EWbVbtk1Hs2bQ6i1qbfUdSNHE3zoRTpV2EYgSg6P8BL9eSoYG+rHWWAgkok9t
 Hg/UF1IHgpwkhLDeCTk2kEQKoeUyh2wRrahFm5pEh86soi8jn+D1MQAFA3zeL79JBwKv
 gSPl6fm3KxL8RfavqedLM8T75Zltn7U/edwXLhPdQgeaSXsJMHAscYmQDy7ddg4KhwU/ Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r81t3hu56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 04:42:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35G4gnxP008574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 04:42:49 GMT
Received: from [10.201.206.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 21:42:46 -0700
Message-ID: <5f8298d5-3379-924e-6c27-a9f54af4bf09@quicinc.com>
Date:   Fri, 16 Jun 2023 10:12:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs
 and Buttons
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230615145311.2776-1-quic_sridsn@quicinc.com>
 <20230615145311.2776-2-quic_sridsn@quicinc.com>
 <db9a6c19-f28d-ce5e-fd47-04eda6da5a91@linaro.org>
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <db9a6c19-f28d-ce5e-fd47-04eda6da5a91@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RidZNmwa99SJG_NH6RoiKvtgv0ezNiQ1
X-Proofpoint-ORIG-GUID: RidZNmwa99SJG_NH6RoiKvtgv0ezNiQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_02,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=991 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160043
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/2023 8:28 PM, Konrad Dybcio wrote:
> On 15.06.2023 16:53, Sridharan S N wrote:
>> Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.
>>
>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>> ---
> This patch references a file that does not exist in -next and does
> not state any dependency on other patches. With the hundreds of
> emails flowing in daily, it's impossible to keep track of it.
>
> For the patch contents, lgtm.
>
> Konrad

will mention dependency in V4

Regards,

Sridharan S N

>> Changes in V2:
>> 	- Updated commit message
>>
>>   .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
>> index 97dc0e5c15f0..a8671a4ac2e4 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
>> @@ -19,6 +19,31 @@
>>   	chosen {
>>   		stdout-path = "serial0";
>>   	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-0 = <&gpio_keys_default>;
>> +		pinctrl-names = "default";
>> +
>> +		button-wps {
>> +			label = "wps";
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <60>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-0 = <&gpio_leds_default>;
>> +		pinctrl-names = "default";
>> +
>> +		led-0 {
>> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "phy0tx";
>> +			default-state = "off";
>> +		};
>> +	};
>>   };
>>   
>>   &blsp1_i2c1 {
>> @@ -52,6 +77,20 @@
>>   /* PINCTRL */
>>   
>>   &tlmm {
>> +	gpio_keys_default: gpio-keys-default-state {
>> +		pins = "gpio35";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	gpio_leds_default: gpio-leds-default-state {
>> +		pins = "gpio36";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-down;
>> +	};
>> +
>>   	i2c_1_pins: i2c-1-state {
>>   		pins = "gpio29", "gpio30";
>>   		function = "blsp1_i2c0";
