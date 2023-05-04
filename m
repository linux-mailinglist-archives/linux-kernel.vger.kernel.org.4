Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9296F71B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjEDSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:04:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D51BCC;
        Thu,  4 May 2023 11:04:10 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344BlV63013169;
        Thu, 4 May 2023 18:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dIQM/IxZx2gsJVXsqEYgNIwEqFxDum1d1ZVaPq4CXv4=;
 b=De4imCXjRvkP8hRycq1OUTBeZtouNEV17SaswUr9m0VCP6tetyFPqOr2zaug6rYfS2LR
 /aRy2P0CLAi61z5IlbPL2RNzkivADdLqJlRWWHb6V/cvwclZkVbJdVMWOAHcJsbrzdro
 nY+1T1x3EhQiX4Ik8OWW8fJN+ViHKWvvuNB2P35lCbwUZBqg0rDCj59YoJS+cN2LE4e7
 80UaocMOcEXINwvehSuH1dUNyW8PI5MUeZ/ypvzEjblUn/CBQgm4yqYna8AIFVU3lDXm
 +GRwX9rrV+TxWSSgkdSPSxg62/ZGTFELKJXUptg9ccFIbuxjXTiNAFeLTWc6Ekiz1RRW Jg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc7a41msc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 18:03:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344I3sQq005175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 18:03:54 GMT
Received: from [10.216.20.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 11:03:48 -0700
Message-ID: <50c37e0c-3171-bce2-d97e-371150e1854f@quicinc.com>
Date:   Thu, 4 May 2023 23:33:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: sa8540-ride: Enable first port
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
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-10-quic_kriskura@quicinc.com>
 <0e76a9f6-f062-2802-d9de-3c0b2b897a4e@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <0e76a9f6-f062-2802-d9de-3c0b2b897a4e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5u2iymyeyDmAHLUFP63Y4Y9eE9SwnywN
X-Proofpoint-ORIG-GUID: 5u2iymyeyDmAHLUFP63Y4Y9eE9SwnywN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_12,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=832 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040145
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2023 4:37 PM, Konrad Dybcio wrote:
> 
> 
> On 1.05.2023 16:34, Krishna Kurapati wrote:
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
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
> same comments as patch 8
> 
> Konrad

Hi Konrad,

   Sure, will add a default value for drive-strength for this pinctrl node.

Hi Andrew Halaney,

  I currently don't have a Ride device with me to test this change. Can 
you help test this patch on SA8540-Ride including (drive-strength = 
<2>;) property (which I believe is the default value).

I can test the same on SA8295-ADP and can push the next version quickly.

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
