Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75561709576
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjESKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjESKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:54:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A0E6B;
        Fri, 19 May 2023 03:54:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J8xPOR015821;
        Fri, 19 May 2023 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MZqqTeAgazlBxSW/67eRcM8c+2RqVeoR2zjTEamx78w=;
 b=UbPnCHEaRH4aq+cdVbN0kZUkFlBDKLkLctBXHqVH+vRbJjVB+fodQ6iO1Y+u3Zs2W4Gg
 zCX6IWWcRdyzRpsTlaipj45HCXRCIDuEeeP4kYnUX/iOxWzcB3xltUCKk0ijl+ditMks
 V/7STh3HdYQCLZO32PhXWx/Uh7N/6YKXJBlOw3Qc6UUYbH14ZoaR7sA/LToGVEDxqH6Q
 0UBp5U+kzic6C9wNFizEBYEhqnt1kdzOPxZ98AuarYAz6MXputHZgNYd6YaWHVn1Ymz0
 Nt9xET3wk8p3pjmpgAm4lOGmEiSUoa3HMiLXxHnNbqRbq6iNtlLO4azNccUK1UY2i8W8 kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnwk4h5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:54:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JAsYOd004534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:54:34 GMT
Received: from [10.216.31.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 03:54:29 -0700
Message-ID: <296befd0-53ab-f6a0-c9a5-db3decf26bfe@quicinc.com>
Date:   Fri, 19 May 2023 16:24:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 3/3] arm64: dts: qcom: sm8450: Add video clock
 controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
References: <20230509172148.7627-1-quic_tdas@quicinc.com>
 <20230509172148.7627-4-quic_tdas@quicinc.com>
 <d95365c2-016a-9f04-3bea-77bb418b9b29@linaro.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <d95365c2-016a-9f04-3bea-77bb418b9b29@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PTWhvw3THyyW3cZGWJvC1Wkhx9Edx7x0
X-Proofpoint-ORIG-GUID: PTWhvw3THyyW3cZGWJvC1Wkhx9Edx7x0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190091
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 5/10/2023 1:47 AM, Konrad Dybcio wrote:
> 
> 
> On 9.05.2023 19:21, Taniya Das wrote:
>> Add device node for video clock controller on Qualcomm SM8450 platform.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>> Changes since V3:
>>   - None.
>>
>> Changes since V2:
>>   - No changes.
>>
>> Changes since V1:
>>   - No changes.
>>
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 595533aeafc4..00ff8efa53c7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -756,6 +756,18 @@
>>   				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
>>   		};
>>   
>> +		videocc: clock-controller@aaf0000 {
> Nodes should be sorted by unit address.
> This one belongs before cci@ac15000.

Yes, my bad, will update in the next patchset.

> 
>> +			compatible = "qcom,sm8450-videocc";
>> +			reg = <0 0x0aaf0000 0 0x10000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
> Older SoCs used to provide a vote on XO_A for videocc ahb_clk_src,
> I'd assume that's now taken care of internally?
> 

Yes, it is taken care internally.

> Konrad
>> +			power-domains = <&rpmhpd SM8450_MMCX>;
>> +			required-opps = <&rpmhpd_opp_low_svs>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>>   		gpi_dma2: dma-controller@800000 {
>>   			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
>>   			#dma-cells = <3>;

-- 
Thanks & Regards,
Taniya Das.
