Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D126B83F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCMVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCMVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:25:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3A2A9A8;
        Mon, 13 Mar 2023 14:25:23 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DJG6f9028052;
        Mon, 13 Mar 2023 21:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mtIbl5E5aEjfnCUTdeThiovCZFU+XhXNyV0568XSXT4=;
 b=O708rpUBNeER/wPuLVDeHnfG3eXnCqkXwvq5dgfpqABXmPsewGPmnvZUlCQH5/CJBwJh
 gtOj7Xax+4yyiDSveTwvSKHz7ZglGuATdOybWujYIPRAc0hgASc82A47TDiG2eqniSkd
 yAIElZZKtqmQS8YX+yH++qBchK78vFRvkVHsKVcMqx6oe3eB7YJVPwoNJ7amrrTj+c18
 uf5yr2MWeMklFZUtE1mLHY9vAjSthez6TeWw3qMYSeFWc7aA4XmWgIHZmxh3tgll730J
 NT6yIJZBhz5V95mn9Oi/48xeKOaeoZRyguQPtZtLAdpht6ZWFxIy6dHL8pOtAAuX54Cl PQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8hvbp7nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 21:25:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32DLPI6l013333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 21:25:18 GMT
Received: from [10.110.77.0] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 14:25:17 -0700
Message-ID: <3ee969ec-faae-fd9f-d583-6a8e2670b567@quicinc.com>
Date:   Mon, 13 Mar 2023 14:25:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS
 nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230306231719.22263-1-quic_molvera@quicinc.com>
 <20230306231719.22263-2-quic_molvera@quicinc.com>
 <af21f499-5895-c564-3e6f-d23ba188544b@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <af21f499-5895-c564-3e6f-d23ba188544b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wAgAt_VK1YoUzEo5AhMkm97GOjMf98J6
X-Proofpoint-GUID: wAgAt_VK1YoUzEo5AhMkm97GOjMf98J6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2023 2:23 AM, Konrad Dybcio wrote:
>
> On 7.03.2023 00:17, Melody Olvera wrote:
>> Add nodes for IPCC, MPSS, and AOSS drivers. Also update
>> the scm node to include its interconnect.
> Quite a bit of stuff in a single commit, this could be
> separated into:
>
> - scm icc
> - aoss+ipcc
> - smp2p+mpss

Hmm ok. Will split this patch into a few patches.

>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 104 ++++++++++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index f234159d2060..6cc96a7c33e8 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -8,6 +8,7 @@
>>  #include <dt-bindings/dma/qcom-gpi.h>
>>  #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>  
>> @@ -141,6 +142,7 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>>  	firmware {
>>  		scm {
>>  			compatible = "qcom,scm-qdu1000", "qcom,scm";
>> +			interconnects = <&system_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>>  		};
>>  	};
>>  
>> @@ -326,6 +328,11 @@ q6_mpss_dtb_mem: q6-mpss-dtb@9ec00000 {
>>  			no-map;
>>  		};
>>  
>> +		mpss_dsm_mem: mpss-dsm@9ec80000 {
>> +			reg = <0x0 0x9ec80000 0x0 0x880000>;
>> +			no-map;
>> +		};
>> +
>>  		tenx_mem: tenx@a0000000 {
>>  			reg = <0x0 0xa0000000 0x0 0x19600000>;
>>  			no-map;
>> @@ -347,6 +354,28 @@ ipa_buffer_mem: ipa-buffer@c3200000 {
>>  		};
>>  	};
>>  
>> +	smp2p-modem {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <435>, <428>;
>> +		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
>> +					   IPCC_MPROC_SIGNAL_SMP2P
>> +					   IRQ_TYPE_EDGE_RISING>;
> Not sure if thunderfox is acting up again or the indentation here
> is not quite right

No you're right; let me fix this.

>
>> +		mboxes = <&ipcc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_SMP2P>;
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <1>;
>> +
>> +		smp2p_modem_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		smp2p_modem_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>>  	soc: soc@0 {
>>  		compatible = "simple-bus";
>>  		#address-cells = <2>;
>> @@ -367,6 +396,15 @@ gcc: clock-controller@80000 {
>>  			#power-domain-cells = <1>;
>>  		};
>>  
>> +		ipcc: mailbox@408000 {
>> +			compatible = "qcom,qdu1000-ipcc", "qcom,ipcc";
>> +			reg = <0x0 0x408000 0x0 0x1000>;
> The address part should be padded to 8 hex digits. I'd appreciate it
> if you could submit a fixup for the other nodes in this dtsi!

Sure thing. Will fix here and fix up the other nodes later.

>
>> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			#mbox-cells = <2>;
>> +		};
>> +
>>  		gpi_dma0: dma-controller@900000  {
>>  			compatible = "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma";
>>  			reg = <0x0 0x900000 0x0 0x60000>;
>> @@ -842,6 +880,49 @@ tcsr_mutex: hwlock@1f40000 {
>>  			#hwlock-cells = <1>;
>>  		};
>>  
>> +		remoteproc_mpss: remoteproc@4080000 {
>> +			compatible = "qcom,qdu1000-mpss-pas";
>> +			reg = <0x0 0x4080000 0x0 0x4040>,
> The address part should be padded to 8 hex digits

Got it.

>
>> +			      <0x0 0x4180000 0x0 0x1000>;
> No reg-names?

No; we don't use reg-names in the driver. Lmk if we should be.

>> +
>> +			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready", "handover",
>> +					  "stop-ack", "shutdown-ack";
> This could be a vertical list, similar to the interrupts-extended itself

Sure thing.

>
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "xo";
>> +
>> +			power-domains = <&rpmhpd QDU1000_CX>,
>> +					<&rpmhpd QDU1000_MSS>;
>> +			power-domain-names = "cx", "mss";
>> +
>> +			memory-region = <&mpss_mem>, <&q6_mpss_dtb_mem>, <&mpss_dsm_mem>;
>> +
>> +			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
>> +
>> +			qcom,qmp = <&aoss_qmp>;
>> +
>> +			qcom,smem-states = <&smp2p_modem_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			status = "disabled";
>> +
>> +			glink-edge {
>> +				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
>> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
>> +							     IRQ_TYPE_EDGE_RISING>;
>> +				mboxes = <&ipcc IPCC_CLIENT_MPSS
>> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +				label = "modem";
>> +				qcom,remote-pid = <1>;
>> +			};
>> +		};
>> +
>>  		pdc: interrupt-controller@b220000 {
>>  			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
>> @@ -852,6 +933,29 @@ pdc: interrupt-controller@b220000 {
>>  			interrupt-controller;
>>  		};
>>  
>> +		aoss_qmp: qmp@c300000 {
>> +			compatible = "qcom,qdu1000-aoss-qmp", "qcom,aoss-qmp";
>> +			reg = <0x0 0xc300000 0x0 0x400>;
> The address part should be padded to 8 hex digits

Got it.

>
>> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
>> +						     IPCC_MPROC_SIGNAL_GLINK_QMP
>> +						     IRQ_TYPE_EDGE_RISING>;
>> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +
>> +			#clock-cells = <0>;
>> +
>> +			cx_cdev: cx {
>> +				#cooling-cells = <2>;
>> +			};
>> +
>> +			mx_cdev: mx {
>> +				#cooling-cells = <2>;
>> +			};
>> +
>> +			ebi_cdev: ebi {
>> +				#cooling-cells = <2>;
>> +			};
> cx
> ebi
> mx
>
> would be alphabetical, unless there's some strong ordering required,
> not sure

Not to my knowledge. Let me reorder.

Thanks,
Melody
>
>
> Konrad
>> +		};
>> +
>>  		spmi_bus: spmi@c400000 {
>>  			compatible = "qcom,spmi-pmic-arb";
>>  			reg = <0x0 0xc400000 0x0 0x3000>,

