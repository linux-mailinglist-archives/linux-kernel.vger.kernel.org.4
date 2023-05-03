Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE36F4F54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjECDzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjECDz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:55:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA622C5;
        Tue,  2 May 2023 20:55:27 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3433PpsC007770;
        Wed, 3 May 2023 03:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OsWgzpu5/2JLIObVKc1qDH/DqW/O0qt5XMWvByGhzrM=;
 b=FS0IM8EfhfAvyux4OTrlROUZY8xm8LldNF1GNA6LSpmoohZNwWp0Jun/pXCMVugDeTY2
 9bBEkTUV9SZfJOsQ8PvY4P2VR2CywYRltPvJNGZBb3QDLV/DMuGy/IwO7e202Kj3MwBf
 xueHTWil7MR/d52dXuQByhjHPv4yViLNcn893v3SQ43y6wIolG3tKs7BNfHYsmb8Y0oS
 hj8oOl/mgVYldroRre55iNGV5bmJ+OKYD9+WePzxv5OANtfDUEp5HKUmBCwGW4CIkzh2
 8kxja7pz6KSw2kkJ/CjT5DxdWCiJ0bdV2GPFpFFkbsv7Fuyc/ZFcl4etCwzxsMSMjyeQ /w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawak2gdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 03:55:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3433tHnh009110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 03:55:17 GMT
Received: from [10.217.216.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 20:55:10 -0700
Message-ID: <c2a747d4-57d3-61e9-69db-c94ccc6fd5cf@quicinc.com>
Date:   Wed, 3 May 2023 09:25:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 8/9] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
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
 <20230501143445.3851-9-quic_kriskura@quicinc.com>
 <8c8a7c25-9eae-7ded-61ce-2ce22b7b76dc@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <8c8a7c25-9eae-7ded-61ce-2ce22b7b76dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SXahuwUfH36mxgHgwaAMnR33Icza60Sa
X-Proofpoint-ORIG-GUID: SXahuwUfH36mxgHgwaAMnR33Icza60Sa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_01,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=860 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030031
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2023 4:36 PM, Konrad Dybcio wrote:
> 
> 
> On 1.05.2023 16:34, Krishna Kurapati wrote:
>> Enable tertiary controller for SA8295P (based on SC8280XP).
>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 47 ++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index fd253942e5e5..7e6061c43835 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -584,6 +584,19 @@ &usb_1_qmpphy {
>>   	status = "okay";
>>   };
>>   
>> +&usb_2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb2_en_state>,
>> +			<&usb3_en_state>,
>> +			<&usb4_en_state>,
>> +			<&usb5_en_state>;
> This is misaligned. Also, please do property-n before property-names.
> 
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
>> +};
>> +
>>   &usb_2_hsphy0 {
>>   	vdda-pll-supply = <&vreg_l5a>;
>>   	vdda18-supply = <&vreg_l7g>;
>> @@ -729,3 +742,37 @@ wake-n-pins {
>>   		};
>>   	};
>>   };
>> +
>> +&pmm8540c_gpios {
>> +	usb2_en_state: usb2-en-state {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
> No drive-strength values?
> 
> Konrad

Hi Konrad,

  TBH, I didn't add the drive strength values as things worked out of 
the box with the current changes (may be the default value of drive 
strength is sufficient for us).

Let me know if it is mandatory, I will add it up in the next version.

Regards,
Krishna,

>> +	};
>> +};
>> +
>> +&pmm8540e_gpios {
>> +	usb3_en_state: usb3-en-state {
>> +		pins = "gpio5";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>> +&pmm8540g_gpios {
>> +	usb4_en_state: usb4-en-state {
>> +		pins = "gpio5";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +
>> +	usb5_en_state: usb5-en-state {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +};
