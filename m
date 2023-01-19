Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17F673805
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjASMNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:13:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010B6E91;
        Thu, 19 Jan 2023 04:13:34 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JBFiZ8013617;
        Thu, 19 Jan 2023 12:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1BLNPwdD2MIkGCnflVreUOktXJImRH9Nu9SpRY1ajKg=;
 b=cl2EIhNDrbmVNGeTnOw52zuwov7a0mHYxOV+QnF98y/aZnzKg7lRC70ZjT8ybbPtL1Kh
 TK9zmySNRJF2Z+inLDd1dDIcXC9ODyl5aMcigUMRAcCQTOG84I27K/YG0QI/3LYXd93B
 /mxb0eZymaU6jsymDrOmyAS+6zDhoNIdnyt6FNvb6PIeo9vcN+XaRrcRQm8pYnjed29+
 OAf4rwqcd/2hBxmrwyjgp7wSXO8HTCx+dOSbqc0s9uPf4dB1TxRfkUo6ngJU953H8PkX
 Dk3atpX3dz+/lEE3fCXNYxhIutPAqosdqHse6YeHgb5W6MwIaZUk6GEwQ+YPlyezqIUH Fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6ya2s4d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:13:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JCDT08019257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:13:29 GMT
Received: from [10.216.43.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 04:13:25 -0800
Message-ID: <94d64ba8-4a49-5f94-79a0-5b09c6f39f5d@quicinc.com>
Date:   Thu, 19 Jan 2023 17:43:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/8] arm64: dts: qcom: sc7280: audioreach: Add sound
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>, <mka@chromium.org>
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
 <1672925875-2107-3-git-send-email-quic_srivasam@quicinc.com>
 <a6e0fce9-3a59-1014-9ae8-f07b50d122a2@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <a6e0fce9-3a59-1014-9ae8-f07b50d122a2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9MFpG3EPn8hPxc-IpzkqH9dEu15KHocz
X-Proofpoint-GUID: 9MFpG3EPn8hPxc-IpzkqH9dEu15KHocz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=830 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190096
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 4:30 PM, Krzysztof Kozlowski wrote:
Thanks for your time Krzysztof!!!
> On 05/01/2023 14:37, Srinivasa Rao Mandadapu wrote:
>> Add sound node for sc7280 based audioreach platforms.
>>
>> Include audioreach dtsi into crd-rev3 platform specific dts file.
>> Also remove phandle to sound node, as audio routing is same as
>> audioreach specific dtsi file.
>>
> Thank you for your patch. There is something to discuss/improve.
>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>> +
>> +/{
>> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
>> +	sound: sound {
>> +		compatible = "google,sc7280-herobrine";
>> +		model = "SC7280-AUDIOREACH";
>> +		adsp-mode;
> There is no such property. Test DTS against your schema, so make
> dtbs_check DT_SCHEMA_FILES=google,sc7280-herobrine
Okay. Will fix it.
>
>> +		audio-routing =
>> +			"IN1_HPHL", "HPHL_OUT",
>> +			"IN2_HPHR", "HPHR_OUT",
>> +			"AMIC1", "MIC BIAS1",
>> +			"AMIC2", "MIC BIAS2",
>> +			"VA DMIC0", "MIC BIAS1",
>> +			"VA DMIC1", "MIC BIAS1",
>> +			"VA DMIC2", "MIC BIAS3",
>> +			"VA DMIC3", "MIC BIAS3",
>> +			"TX SWR_ADC0", "ADC1_OUTPUT",
>> +			"TX SWR_ADC1", "ADC2_OUTPUT",
>> +			"TX SWR_ADC2", "ADC3_OUTPUT",
>> +			"TX SWR_DMIC0", "DMIC1_OUTPUT",
>> +			"TX SWR_DMIC1", "DMIC2_OUTPUT",
>> +			"TX SWR_DMIC2", "DMIC3_OUTPUT",
>> +			"TX SWR_DMIC3", "DMIC4_OUTPUT",
>> +			"TX SWR_DMIC4", "DMIC5_OUTPUT",
>> +			"TX SWR_DMIC5", "DMIC6_OUTPUT",
>> +			"TX SWR_DMIC6", "DMIC7_OUTPUT",
>> +			"TX SWR_DMIC7", "DMIC8_OUTPUT";
>> +
>> +		qcom,msm-mbhc-hphl-swh = <1>;
>> +		qcom,msm-mbhc-gnd-swh = <1>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		#sound-dai-cells = <0>;
>> +
>> +		dai-link@0 {
>> +			link-name = "WCD9385 Playback";
>> +			reg = <0>;
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
>> +			};
>> +			codec {
>> +				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
>> +			};
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
>> +		dai-link@1 {
>> +			link-name = "WCD9385 Capture";
>> +			reg = <1>;
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
>> +			};
>> +			codec {
>> +				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
>> +			};
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
>> +		dai-link@2 {
>> +			link-name = "Amplifier Playback";
>> +			reg = <3>;
> Missing dtbs W=1 build.
Okay. Will fix it.
>
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai SECONDARY_MI2S_RX>;
>> +			};
>> +
> Use consistent style. Either blank line or not between the
> cpu/codec/platform nodes.
Okay. will fix it.
>
>> +			codec {
>> +				sound-dai = <&max98360a>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
>> +		dai-link@3 {
>> +			link-name = "DMIC";
>> +			reg = <4>;
> Same problem, wrong reg.
Okay.
>
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&lpass_va_macro 0>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +	};
>> +};
> Best regards,
> Krzysztof
>
