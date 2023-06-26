Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9C73DD20
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFZLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:17:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B5101;
        Mon, 26 Jun 2023 04:17:31 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QAYZKt031238;
        Mon, 26 Jun 2023 11:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qap+wPmI/4+wGpj6QeslGGidlg50iUr9wMK2Z0CGYrI=;
 b=iaGbtV6avyOP9diL5BtFS+vazmz20s8owQUZ3fsi8cdmLwbmBpSdc2hQyZeSZyTAhr+7
 TyatBb1KKh/9KJ17GwbUpIbTyiqWopSd7crwl68+2cnlF7YfclnNF15ylCJxLuwTJtPm
 5+EAbRY+wEc6TEovpa997v6g56qnDjGqFQ8DBJiyMZ0MEu8JzxNiqYgBhSlmT2ztJgCT
 /BXRIWl1X97ehaV0SaEUURFYJbxMdl0sSCinEzAzXXZK2tl5080pi6jpDDhq3vE3Tx/Z
 SqpFdv9nW/Dg/7a6XcsQIeF6MavwH5+ZZKFsTao3r2r/KfW7GLyD48A/DAHfnix75p7p Ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqew3uwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:17:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QBHQcw010406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:17:26 GMT
Received: from [10.216.37.195] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 04:17:21 -0700
Message-ID: <20ec31b3-667a-0617-71d4-586789e2c2a4@quicinc.com>
Date:   Mon, 26 Jun 2023 16:47:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v6 8/8] arm64: dts: qcom: sc7280: Add qcom,adsp-pil-mode
 property in clock nodes
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
 <20230616103534.4031331-9-quic_mohs@quicinc.com>
 <b2553058-bd78-6d9f-dcd0-d1c086b4fc3b@linaro.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <b2553058-bd78-6d9f-dcd0-d1c086b4fc3b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RkwcKsH3F9QMLdzy3Oms6uVj14Hr-Cp3
X-Proofpoint-GUID: RkwcKsH3F9QMLdzy3Oms6uVj14Hr-Cp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_08,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260101
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2023 5:06 PM, Konrad Dybcio wrote:
> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>
>> Add "qcom,adsp-pil-mode" property in clock nodes for herobrine
>> crd revision 3 board specific device tree.
>> This is to register clocks conditionally by differentiating ADSP
>> based platforms and legacy path platforms.
>> Also disable lpass_core clock, as it is creating conflict
>> with ADSP clocks and it is not required for ADSP based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>   .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi    | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> index c02ca393378f..876a29178d46 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> @@ -197,6 +197,14 @@ q6prmcc: clock-controller {
>>   	};
>>   };
>>   
>> +&lpass_aon {
>> +	qcom,adsp-pil-mode;
> That's a whole bunch of hacky bindings that makes no sense..
>
> What should have been done from the beginning is:
>
> - all clocks should be registered inside the clock driver, unconditionally
>    as far as .c code is concerned
>
> - the regmap properties within should reflect the actual max register
>    range within the hardware block
>
> - device-tree should contain protected-clocks, which omits registering
>    specified clks (I guess in the ADSP-less case you could probably even
>    register all of them and it wouldn't hurt)
>
For AR solution, it is required to add "qcom,adsp-pil-mode" flag to 
enable ahbm and ahbs clocks.
Please refer: 
https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> +};
>> +
>> +&lpass_core {
>> +	status = "disabled";
> status = "reserved";
>
> Konrad
Okay, will change status flag.

Rafi
>> +};
>> +
>>   &lpass_rx_macro {
>>   	/delete-property/ power-domains;
>>   	/delete-property/ power-domain-names;
>> @@ -239,3 +247,7 @@ &lpass_va_macro {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&lpasscc {
>> +	qcom,adsp-pil-mode;
>> +};
