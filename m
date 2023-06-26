Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FE73DCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFZLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjFZLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:13:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82610D;
        Mon, 26 Jun 2023 04:13:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBCK0d002101;
        Mon, 26 Jun 2023 11:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n/tCzJ/TPsbB4DkBwkYoNd2+sff8vVG5XUSOPC59tMo=;
 b=OrMAT2Ec+8GPTt3gNe/5zo+onBRLvs7IEpvdujPCYPq5/JlW1NXjNlEpliFvRPa6q1OO
 pOnUt3Zrmg9oHUEoHCTULCtPMjDUNR+EZxZv5i+JnMpOsi1qlwOeyMWSmNqPb5XQXwFH
 faQtLvlCzAVgtb35N+eCuo9gNiWP8x2R3JfixFoA/ZVyJS9qjAIqoh1q+oT6rHNokbVd
 rcZKEUYhJoj5FMfLyDetTZgHgqtNCQynbYN4KDwmDcYpb6oCHa8irAMDmWfZ1+wuvxuT
 7Q1cNg0eliP8rqPD1dvd7JM2j7FXSxrD/GqKt6Lf2UjOaD+hbDxApDO8sSWxvChvX0Ls tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqtr3tu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:13:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QBDVZ2027406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:13:31 GMT
Received: from [10.216.37.195] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 04:13:26 -0700
Message-ID: <3441b3cb-29dd-691c-1e95-5bddd66c684a@quicinc.com>
Date:   Mon, 26 Jun 2023 16:43:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v6 6/8] arm64: dts: qcom: sc7280: Modify VA/RX/TX macro
 clock nodes for audioreach solution
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <swboyd@chromium.org>,
        <andersson@kernel.org>, <broonie@kernel.org>, <agross@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <quic_visr@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-7-quic_mohs@quicinc.com>
 <7d2e580e-1861-d22f-e67d-726a2a69043e@linaro.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <7d2e580e-1861-d22f-e67d-726a2a69043e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ESAxQ3DE8N8Rsc1l_nNfcMYC9er8yE7g
X-Proofpoint-ORIG-GUID: ESAxQ3DE8N8Rsc1l_nNfcMYC9er8yE7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_07,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306260101
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2023 4:59 PM, Konrad Dybcio wrote:
> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>
>> Modify VA, RX and TX macro and lpass_tlmm clock properties and
>> enable them. For audioreach solution mclk, npl and fsgen clocks
>> are enabled through the q6prm clock driver.
>>
>> Delete the power domain properties from VA, RX and TX macro,
>> for audioreach solution the macro, dcodec power domains enabled
>> through the q6prm clock driver.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
> Maybe sc7280-audioreach.dtsi containing all these changes that could be
> reused by others would be in order?
Thanks for comment,

yes, will create a common sc7280-audioreach.dtsi file, which will 
contain common audioreach changes
and could be reused by others.
>>   .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> index 9daea1b25656..c02ca393378f 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> @@ -196,3 +196,46 @@ q6prmcc: clock-controller {
>>   		};
>>   	};
>>   };
>> +
>> +&lpass_rx_macro {
>> +	/delete-property/ power-domains;
>> +	/delete-property/ power-domain-names;
> Surely they shouldn't cause issues, even if the vote would be
> superfluous? They are still powered by these power domains, I'd assume?
No, In Audioreach case this macro and decodec clocks are not power by 
power domains,
this macro and decodec hw clocks are enrolled by q6prmcc clock voting.
>> +	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&lpass_va_macro>;
>> +	clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> The drivers use clk_get with name-based lookup.. you should be able to
> simply extend the list in the common DTSI. Please test that on both
> audioreach and the other thing though.
>
> Konrad
The clock names are not a extensions, same set of clocks are used in non 
ADSP solutions.
In Audioreach solution these clocks enabling by q6prmcc clock voting.

Rafi.
>> +
>> +	status = "okay";
>> +};
>> +
>> +&lpass_tlmm {
>> +	clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +	clock-names = "core", "audio";
>> +};
>> +
>> +&lpass_tx_macro {
>> +	/delete-property/ power-domains;
>> +	/delete-property/ power-domain-names;
>> +	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&lpass_va_macro>;
>> +	clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&lpass_va_macro {
>> +	/delete-property/ power-domains;
>> +	/delete-property/ power-domain-names;
>> +	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +	clock-names = "mclk", "macro", "dcodec";
>> +
>> +	status = "okay";
>> +};
