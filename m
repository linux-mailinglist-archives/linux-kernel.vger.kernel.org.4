Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC373C743
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFXHMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFXHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:12:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445542720;
        Sat, 24 Jun 2023 00:12:07 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35O6wKZU011250;
        Sat, 24 Jun 2023 07:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9slJZrGRD94l5YVeMjlqxxdCSHlkyyjTep/49ZplkdY=;
 b=miIuSJcd1ljpInlOZ2FLue5kk4+L36FpwgGXR6s5Nw4IgzgUZTHfenzCzEsHMZ2CK8CO
 yGhglU6MGdworPCQAgU4PZ73PAZ7ZFWGGeWdZ3LzSBFQnV0O1i+3RNitTPUNKmEPoBTx
 Lu/+qonIwGBUqMLJ1/0hdvZ7rBAudkepKSIUdOSULv3ZzvKXSOgoG9Fq2R/vp6gwTRzV
 cBU9EWJ+h94Qr/GV+Dam94fT30Zkbe+loyq6BekcbIf4RluOJZeD7lT37k6VFUl7HfjX
 w5ZhIgBE8wZomA44nlUKGiHQjHBBVA+rJR44PG5UcMCnGuVZHWy2XvNXw6/kxG4txVMp Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqew09bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 07:11:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35O7BiAt019783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 07:11:44 GMT
Received: from [10.216.12.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 24 Jun
 2023 00:11:38 -0700
Message-ID: <5ee7579c-7190-fb0f-0202-297aa0f7fc08@quicinc.com>
Date:   Sat, 24 Jun 2023 12:41:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 10/10] arm64: dts: qcom: sa8540-ride: Enable first port
 of tertiary usb controller
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-11-quic_kriskura@quicinc.com>
 <144c5bff-6d81-b681-57ac-b1e51993c9b3@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <144c5bff-6d81-b681-57ac-b1e51993c9b3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MwjbgO1r-IzDCIaUfuX2TKemUuu7qQ1k
X-Proofpoint-GUID: MwjbgO1r-IzDCIaUfuX2TKemUuu7qQ1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306240066
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 4:12 AM, Konrad Dybcio wrote:
> On 21.06.2023 06:36, Krishna Kurapati wrote:
>> There is now support for the multiport USB controller this uses so
>> enable it.
>>
>> The board only has a single port hooked up (despite it being wired up to
>> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
>> which by default on boot is selected to mux properly. Grab the gpio
>> controlling that and ensure it stays in the right position so USB 2.0
>> continues to be routed from the external port to the SoC.
>>
>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>> [Krishna: Rebased on top of usb-next]
> If that's your only change to this patch, you should have kept the
> Author: field unchanged.
> 
Sure, will do reset-author and resubmit the patch next version.

>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
> Same comments as patch 9
> 
> Konrad

Thanks for the review.

Regards,
Krishna,
>>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
>> index 24fa449d48a6..53d47593306e 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
>> @@ -309,6 +309,19 @@ &usb_2_qmpphy0 {
>>   	status = "okay";
>>   };
>>   
>> +&usb_2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb2_en_state>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
>> +	phy-names = "usb2-port0", "usb3-port0";
>> +	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
>> +};
>> +
>>   &xo_board_clk {
>>   	clock-frequency = <38400000>;
>>   };
>> @@ -401,4 +414,13 @@ wake-pins {
>>   			bias-pull-up;
>>   		};
>>   	};
>> +
>> +	usb2_en_state: usb2-en-state {
>> +		/* TS3USB221A USB2.0 mux select */
>> +		pins = "gpio24";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +		output-low;
>> +	};
>>   };
