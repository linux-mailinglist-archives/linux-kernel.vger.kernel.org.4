Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5250D73DCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFZLHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFZLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:07:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05985B1;
        Mon, 26 Jun 2023 04:07:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QAXHkl006120;
        Mon, 26 Jun 2023 11:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=02S7KVcuMIS6uq/1fBTS0MdWia7542ZJxd/Il/VqxyY=;
 b=Z4qXAvJJBGZRsWjwvIzo4Ju/3f/MIg6fAQcbml392XooVSrejiBL1nWmgw5qQmhdb3WV
 14/EKfylqQC6cJdxZqpo2rv+Wbcde5g/Rnl0wW7a1nUjVZXUo/IOhSsCo0LMm6g4KJTu
 AL2HzHcUH0PpLsthiE8kZL4f8PhYjriWkYj0+wAawPsib2pb1CIJQNMXtkFl/JEh6YTg
 VH+SCJjQNqjxcXVLaifEY54J9dsBY+3/QjVfmKuHcwejUuutTJsVPyQpQTNM5ZsiGE/n
 RZ2DHJY5kuOXAAwWuW6pCx9gpgBq3BWp7aYr56982ui3cZ+yCrJEq0a98RsBN4HdH+2Q dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqgdbtyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:07:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QB7CSp030385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:07:12 GMT
Received: from [10.216.37.195] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 04:07:07 -0700
Message-ID: <c875c617-25d2-04d8-0ab7-f7e8380348c9@quicinc.com>
Date:   Mon, 26 Jun 2023 16:37:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v6 5/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
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
 <20230616103534.4031331-6-quic_mohs@quicinc.com>
 <353fe482-62f7-6252-5123-6907f84762b9@linaro.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <353fe482-62f7-6252-5123-6907f84762b9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ENHafY9QjUSafQ2FCxSPzIwrrjfNiI0B
X-Proofpoint-GUID: ENHafY9QjUSafQ2FCxSPzIwrrjfNiI0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260101
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2023 4:55 PM, Konrad Dybcio wrote:
> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>
>> Add LPASS PIL node for sc7280 based audioreach platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
> The node should reside in the SoC DTSI, ideally the bindings should
> be compatible with the PAS setup to the point where only a compatible
> swap is needed..
>
> Konrad
Thanks for comment,

The base SOC DTSI file already has an entry with the same physical base 
address which is using for ADSP BYPASS solution.
For Audioreach solution required the same base address for the 
remoteproc device tree node.

Will create a new common dtsi file for Audioreach as suggested by you in 
previous patch and add this in that common dtsi file.

Please confirm is it okay ?

Rafi.

>>   .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 90 +++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> index 95d3aa08ebde..9daea1b25656 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>> @@ -7,6 +7,8 @@
>>    */
>>   
>>   #include <dt-bindings/sound/qcom,q6afe.h>
>> +#include <dt-bindings/clock/qcom,lpass-sc7280.h>
>> +#include <dt-bindings/soc/qcom,gpr.h>
>>   
>>   /{
>>   	/* BOARD-SPECIFIC TOP LEVEL NODES */
>> @@ -105,4 +107,92 @@ platform {
>>   			};
>>   		};
>>   	};
>> +
>> +	remoteproc_adsp: remoteproc@3000000 {
>> +		compatible = "qcom,sc7280-adsp-pil";
>> +		reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
>> +		reg-names = "qdsp6ss_base", "lpass_efuse";
>> +
>> +		interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
>> +				      <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		interrupt-names = "wdog", "fatal", "ready",
>> +				  "handover", "stop-ack",
>> +				  "shutdown-ack";
>> +
>> +		qcom,qmp = <&aoss_qmp>;
>> +
>> +		clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +			 <&gcc GCC_CFG_NOC_LPASS_CLK>;
>> +		clock-names = "xo", "gcc_cfg_noc_lpass";
>> +
>> +		iommus = <&apps_smmu 0x1800 0x0>;
>> +
>> +		power-domains =	<&rpmhpd SC7280_CX>;
>> +		power-domain-names = "cx";
>> +
>> +		required-opps = <&rpmhpd_opp_nom>;
>> +
>> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
>> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
>> +		reset-names =  "pdc_sync", "cc_lpass";
>> +
>> +		qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
>> +
>> +		memory-region = <&adsp_mem>;
>> +
>> +		qcom,smem-states = <&adsp_smp2p_out 0>;
>> +		qcom,smem-state-names = "stop";
>> +
>> +		glink-edge {
>> +			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
>> +					      IPCC_MPROC_SIGNAL_GLINK_QMP
>> +					      IRQ_TYPE_EDGE_RISING>;
>> +
>> +			mboxes = <&ipcc IPCC_CLIENT_LPASS
>> +				 IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +
>> +			label = "lpass";
>> +			qcom,remote-pid = <2>;
>> +
>> +			gpr {
>> +				compatible = "qcom,gpr";
>> +				qcom,glink-channels = "adsp_apps";
>> +				qcom,domain = <GPR_DOMAIN_ID_ADSP>;
>> +				qcom,intents = <512 20>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				q6apm: service@1 {
>> +					compatible = "qcom,q6apm";
>> +					reg = <GPR_APM_MODULE_IID>;
>> +					#sound-dai-cells = <0>;
>> +
>> +					q6apmdai: dais {
>> +						compatible = "qcom,q6apm-dais";
>> +						iommus = <&apps_smmu 0x1801 0x0>;
>> +					};
>> +
>> +					q6apmbedai: bedais {
>> +						compatible = "qcom,q6apm-lpass-dais";
>> +						#sound-dai-cells = <1>;
>> +					};
>> +				};
>> +
>> +				q6prm: service@2 {
>> +					compatible = "qcom,q6prm";
>> +					reg = <GPR_PRM_MODULE_IID>;
>> +
>> +					q6prmcc: clock-controller {
>> +						compatible = "qcom,q6prm-lpass-clocks";
>> +						#clock-cells = <2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>>   };
