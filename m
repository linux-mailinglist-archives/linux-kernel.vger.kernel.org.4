Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B66D3C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjDCE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCE2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:28:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262483F0;
        Sun,  2 Apr 2023 21:28:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3334RW7Y002535;
        Mon, 3 Apr 2023 04:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HeWakqRZs0eSLkfl7NVEQwQvQ1rUnhRuB8uvDie+i5Y=;
 b=MgRxU0jNDeiaTD9ek6UBXosTmprXwfxrlRSDYO+9XVJ01x4zXpgVDI04i+uIy/pvbKeL
 aw1BBE0XABH0gnZcQk0SdfpK7DsS3Hs4LLn1OWqjby/gsQXNEYhl6GsKggPfdO9clbr1
 4UmptU/NG8KNmAv55i1Z3oYe6dSYzl6XYYCJqzA4hHI7212DIGiB7HrPt5FUL53andAc
 Dg4MFAS8fpIvCwPUoacXgkSzUy4MeMhppNLmKD5/9HSDBKsf5UWE0RTxbNiK7hvmr7M8
 JwebdHEsBBpLApJBtP+m6n56gQMGiCmuJ1SGW1NpEbcKFwQai9a2hoUOrHaytp6fbGzg pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ppdswb8bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 04:27:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3334RtSO028150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 04:27:55 GMT
Received: from [10.50.60.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 2 Apr 2023
 21:27:51 -0700
Message-ID: <30c4c8d6-1eaa-99f2-9b47-7e91390cf7f1@quicinc.com>
Date:   Mon, 3 Apr 2023 09:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add few device nodes
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230329053726.14860-1-quic_kathirav@quicinc.com>
 <20230329053726.14860-3-quic_kathirav@quicinc.com>
 <1772ce2e-9a52-7fc6-62bc-990755ca63ab@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1772ce2e-9a52-7fc6-62bc-990755ca63ab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _VUf3Y4jaxjXTY7kEDaVEwjy6dAv2_Vo
X-Proofpoint-GUID: _VUf3Y4jaxjXTY7kEDaVEwjy6dAv2_Vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_01,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030032
X-Spam-Status: No, score=-3.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2023 1:45 AM, Sricharan Ramabadhran wrote:
>
>
> On 3/29/2023 11:07 AM, Kathiravan T wrote:
>> Add QUP(SPI / I2C) peripheral, PRNG, WDOG and the remaining UART nodes.
>> While at it, enable the SPI NOR in RDP433 board.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  21 ++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 202 ++++++++++++++++++++
>>   2 files changed, 223 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts 
>> b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 2ce8e09e7565..7be578017bf7 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -29,6 +29,20 @@
>>       status = "okay";
>>   };
>>   +&blsp1_spi0 {
>> +    pinctrl-0 = <&spi_0_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "micron,n25q128a11", "jedec,spi-nor";
>> +        reg = <0>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        spi-max-frequency = <50000000>;
>> +    };
>> +};
>> +
>>   &sdhc_1 {
>>       pinctrl-0 = <&sdc_default_state>;
>>       pinctrl-names = "default";
>> @@ -77,6 +91,13 @@
>>               bias-pull-down;
>>           };
>>       };
>> +
>> +    spi_0_pins: spi-0-state {
>> +        pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> +        function = "blsp0_spi";
>> +        drive-strength = <8>;
>> +        bias-disable;
>> +    };
>>   };
>>     &xo_board_clk {
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 14a3396b0381..f3da0190284c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -122,6 +122,13 @@
>>           #size-cells = <1>;
>>           ranges = <0 0 0 0xffffffff>;
>>   +        rng: rng@e3000 {
>> +            compatible = "qcom,prng-ee";
>> +            reg = <0x000e3000 0x1000>;
>> +            clocks = <&gcc GCC_PRNG_AHB_CLK>;
>> +            clock-names = "core";
>> +        };
>> +
>>           tlmm: pinctrl@1000000 {
>>               compatible = "qcom,ipq9574-tlmm";
>>               reg = <0x01000000 0x300000>;
>> @@ -184,6 +191,36 @@
>>               status = "disabled";
>>           };
>>   +        blsp_dma: dma-controller@7884000 {
>> +            compatible = "qcom,bam-v1.7.0";
>> +            reg = <0x07884000 0x2b000>;
>
>  Does the size needs to be 0x2b000 really ?


As per the document, BLSP DMA block size is 0x2b000, however the last 
register offset is 0x13934. In most of the places, irrespective of last 
register offset, we covered the entire region as mentioned in the document.


Thanks, Kathiravan T.


>
> Regards,
>  Sricharan
