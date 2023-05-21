Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488B70AF04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjEUQRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEUQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:17:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50396DD;
        Sun, 21 May 2023 09:17:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LG353F013157;
        Sun, 21 May 2023 16:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r3J0J3+JKlJvSQnRD6AA2epLYW6N67Fjohpa9F9hU0o=;
 b=dcnZmY98ABVwyW3Vg/TbzyaJB37kOovWWnaRf/bzREWSlzlQ2fAizfdayVuoSkcT6SiM
 htERy+Q//iRym6hsjQbKNJuVoOSSHSGxfFQ8Z/Ge1XeKGeK0f2vQy/DY5jV9LaHJuvn6
 Pre9aYTylh853IVH2suMUoAdvV+6d0L+kdyiTFFtf6+j/yJPwYRV8DCiujGbCETYPB/F
 tDkDSGq57CHC/wg2pYlT3dSuiRXuAgN076qZ0plFPTmHJMLTKbGgsK13KuGHXMb43ZZS
 93oGMHb3EECSMGIeQDUyQrqtjvO7m+ki4O/YHGMq0FYYJI/Yp6khhh7Rw6L6nteQO3dH Kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmt5a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 16:17:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LGHEKF002523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 16:17:14 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 09:17:07 -0700
Message-ID: <5dc21700-193f-685f-a7ac-e3fa529d4399@quicinc.com>
Date:   Sun, 21 May 2023 21:47:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 11/11] arm64: dtsi: qcom: ipq9574: Add nodes to bring up
 multipd
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-12-git-send-email-quic_mmanikan@quicinc.com>
 <619878c3-25a8-3875-efc3-3cf1c6bc262e@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <619878c3-25a8-3875-efc3-3cf1c6bc262e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9RdqJqFVbspdVKewx7vp_0CGrHPigH5_
X-Proofpoint-ORIG-GUID: 9RdqJqFVbspdVKewx7vp_0CGrHPigH5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=780 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210144
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 7:57 PM, Kathiravan T wrote:
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> Enable nodes required for multipd remoteproc bring up.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 145 ++++++++++++++++++++++++++
>>   1 file changed, 145 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 2bb4053641da..e0645bc39db4 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -201,6 +201,11 @@ tz_region: tz@4a600000 {
>>               no-map;
>>           };
>> +        q6_region: wcnss@4ab00000 {
>> +            reg = <0x0 0x4ab00000 0x0 0x02b00000>;
> 
> 
> No need to pad the size
> 
> 
Sure, i will do it.
>> +            no-map;
>> +        };
>> +
>>           smem@4aa00000 {
>>               compatible = "qcom,smem";
>>               reg = <0x0 0x4aa00000 0x0 0x00100000>;
>> @@ -209,6 +214,30 @@ smem@4aa00000 {
>>           };
>>       };
>> +    wcss: wcss-smp2p {
>> +        compatible = "qcom,smp2p";
>> +        qcom,smem = <435>, <428>;
>> +
>> +        interrupt-parent = <&intc>;
>> +        interrupts = <GIC_SPI 322 IRQ_TYPE_EDGE_RISING>;
>> +
>> +        mboxes = <&apcs_glb 9>;
>> +
>> +        qcom,local-pid = <0>;
>> +        qcom,remote-pid = <1>;
>> +
>> +        wcss_smp2p_out: master-kernel {
>> +            qcom,entry-name = "master-kernel";
>> +            #qcom,smem-state-cells = <1>;
>> +        };
>> +
>> +        wcss_smp2p_in: slave-kernel {
>> +            qcom,entry-name = "slave-kernel";
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +    };
>> +
>>       soc: soc@0 {
>>           compatible = "simple-bus";
>>           #address-cells = <1>;
>> @@ -829,6 +858,122 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>>               msi-parent = <&v2m0>;
>>               status = "disabled";
>>           };
>> +
>> +        q6v5_wcss: remoteproc@cd00000 {
>> +            compatible = "qcom,ipq9574-q6-mpd";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            reg = <0x0cd00000 0x4040>;
> 
> 
> reg should go after compatible
> 
> 
Sure, i will do it.
>> +            interrupts-extended = <&intc GIC_SPI 325 
>> IRQ_TYPE_EDGE_RISING>,
>> +                          <&wcss_smp2p_in 0 0>,
>> +                          <&wcss_smp2p_in 1 0>,
>> +                          <&wcss_smp2p_in 2 0>,
>> +                          <&wcss_smp2p_in 3 0>;
>> +            interrupt-names = "wdog",
>> +                      "fatal",
>> +                      "ready",
>> +                      "handover",
>> +                      "stop-ack";
>> +
>> +            clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
>> +                 <&gcc GCC_WCSS_AHB_S_CLK>,
>> +                 <&gcc GCC_WCSS_ECAHB_CLK>,
>> +                 <&gcc GCC_WCSS_ACMT_CLK>,
>> +                 <&gcc GCC_WCSS_AXI_M_CLK>,
>> +                 <&gcc GCC_Q6_AXIM_CLK>,
>> +                 <&gcc GCC_Q6_AXIM2_CLK>,
>> +                 <&gcc GCC_Q6_AHB_CLK>,
>> +                 <&gcc GCC_Q6_AHB_S_CLK>,
>> +                 <&gcc GCC_Q6SS_BOOT_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_APB_BDG_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_ATB_BDG_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_NTS_BDG_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_APB_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_ATB_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_CLK>,
>> +                 <&gcc GCC_WCSS_DBG_IFC_NTS_CLK>,
>> +                 <&gcc GCC_Q6_TSCTR_1TO2_CLK>,
>> +                 <&gcc GCC_Q6SS_ATBM_CLK>,
>> +                 <&gcc GCC_Q6SS_PCLKDBG_CLK>,
>> +                 <&gcc GCC_Q6SS_TRIG_CLK>,
>> +                 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
>> +                 <&gcc GCC_WCSS_Q6_TBU_CLK>,
>> +                 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
>> +
>> +            clock-names = "anoc_wcss_axi_m",
>> +                      "wcss_ahb_s",
>> +                      "wcss_ecahb",
>> +                      "wcss_acmt",
>> +                      "wcss_axi_m",
>> +                      "q6_axim",
>> +                      "q6_axim2",
>> +                      "q6_ahb",
>> +                      "q6_ahb_s",
>> +                      "q6ss_boot",
>> +                      "dbg-apb-bdg",
>> +                      "dbg-atb-bdg",
>> +                      "dbg-dapbus-bdg",
>> +                      "dbg-nts-bdg",
>> +                      "dbg-apb",
>> +                      "dbg-atb",
>> +                      "dbg-dapbus",
>> +                      "dbg-nts",
>> +                      "q6_tsctr_1to2_clk",
>> +                      "q6ss_atbm_clk",
>> +                      "q6ss_pclkdbg_clk",
>> +                      "q6ss_trig_clk",
>> +                      "mem_noc_q6_axi",
>> +                      "wcss_q6_tbu",
>> +                      "sys_noc_wcss_ahb";
>> +
>> +            assigned-clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
>> +                 <&gcc GCC_WCSS_AHB_S_CLK>,
> 
> 
> please take care of the alignment
> 
> 
Sure, i will do it.
>> +                 <&gcc GCC_WCSS_ECAHB_CLK>,
>> +                 <&gcc GCC_WCSS_ACMT_CLK>,
>> +                 <&gcc GCC_WCSS_AXI_M_CLK>,
>> +                 <&gcc GCC_Q6_AXIM_CLK>,
>> +                 <&gcc GCC_Q6_AXIM2_CLK>,
>> +                 <&gcc GCC_Q6_AHB_CLK>,
>> +                 <&gcc GCC_Q6_AHB_S_CLK>,
>> +                 <&gcc GCC_Q6SS_BOOT_CLK>,
>> +                 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
>> +                 <&gcc GCC_WCSS_Q6_TBU_CLK>,
>> +                 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
>> +
>> +            assigned-clock-rates = <266666667>,
>> +                        <133333333>,
> 
> 
> same here
> 
> 
Sure, i will do it.

Thanks & Regards,
Manikanta.
>> +                        <133333333>,
>> +                        <133333333>,
>> +                        <266666667>,
>> +                        <533000000>,
>> +                        <342857143>,
>> +                        <133333333>,
>> +                        <133333333>,
>> +                        <342857143>,
>> +                        <533000000>,
>> +                        <533000000>,
>> +                        <133333333>;
>> +
>> +            qcom,smem-states = <&wcss_smp2p_out 0>,
>> +                       <&wcss_smp2p_out 1>;
>> +            qcom,smem-state-names = "shutdown",
>> +                        "stop";
>> +
>> +            memory-region = <&q6_region>;
>> +
>> +            glink-edge {
>> +                interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
>> +                label = "rtr";
>> +                qcom,remote-pid = <1>;
>> +                mboxes = <&apcs_glb 8>;
>> +            };
>> +
>> +            q6_wcss_pd1: remoteproc_pd1 {
>> +                compatible = "qcom,ipq9574-wcss-ahb-mpd";
>> +            };
>> +        };
>>       };
>>       rpm-glink {
