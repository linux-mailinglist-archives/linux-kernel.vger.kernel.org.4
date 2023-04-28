Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1F6F1700
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjD1Lp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjD1Lpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:45:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202515BB2;
        Fri, 28 Apr 2023 04:45:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SBUiUB024655;
        Fri, 28 Apr 2023 11:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=eMlmCPXOYlfghcZ5ReYKOmVkdZz0QefrbdVESqio7UY=;
 b=PjjvfSt4brREymp9wrQ8rXvt+2WlZzjVQnJX+5P2vnm7zz0nBG7uwUHnh58YKLY+BYDR
 2saOq+TOG7eH9kW4fLW9qhWQ/+M6tfkJ1mTxFvHcTzZrT5ZpWo+wqV/c0WY18hbo3a+7
 7p8Iab+yukP1sQED/kOWY8tNaeCodcsiNHv9M6/C1kRuRcyS5nrcf55jCrXEBG1yRFHj
 1ldtPsrKASdNdrpeVQ9YXMmmGK06dml75b7DRq9E7utQUpHP4FytIrFFuVEzWjif0cYe
 PmYnLPxwJtGAzpRBMULV4Szoy3aH/tXiQRio0D2IaCTkUIeDyn7ZEuSVIR2MiyWRsUGL Ag== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8db4014n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 11:45:38 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SBjbBF020692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 11:45:37 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 28 Apr 2023 04:45:32 -0700
Date:   Fri, 28 Apr 2023 17:15:28 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230428114527.GA28972@varda-linux.qualcomm.com>
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <55db8487a7cbf3354749dd2d3a35c05bfd9fa4fc.1680693149.git.quic_varada@quicinc.com>
 <e142ff5d-543f-80bb-94f9-3f1fb90f1b83@linaro.org>
 <20230424090402.GB21232@varda-linux.qualcomm.com>
 <CAA8EJprqH5esxQkH3v-1i539OO3jQG9fN-YOqjZTwEqqgUfUyg@mail.gmail.com>
 <20230426095157.GA884@varda-linux.qualcomm.com>
 <8f2eefc5-abc9-4cce-2170-7202b148e9c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f2eefc5-abc9-4cce-2170-7202b148e9c7@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: stgstj_82b58dvM3B7CmkzdV5oGYzpq-
X-Proofpoint-GUID: stgstj_82b58dvM3B7CmkzdV5oGYzpq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 08:50:39PM +0300, Dmitry Baryshkov wrote:
> On 26/04/2023 12:51, Varadarajan Narayanan wrote:
> >On Mon, Apr 24, 2023 at 02:17:06PM +0300, Dmitry Baryshkov wrote:
> >>On Mon, 24 Apr 2023 at 12:04, Varadarajan Narayanan
> >><quic_varada@quicinc.com> wrote:
> >>>
> >>>On Sat, Apr 22, 2023 at 12:07:01AM +0300, Dmitry Baryshkov wrote:
> >>>>On 05/04/2023 14:41, Varadarajan Narayanan wrote:
> >>>>>Add USB phy and controller related nodes
> >>>>>
> >>>>>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>---
> >>>>>  Changes in v8:
> >>>>>     - Change clocks order to match the bindings
> >>>>>  Changes in v7:
> >>>>>     - Change com_aux -> cfg_ahb
> >>>>>  Changes in v6:
> >>>>>     - Introduce fixed regulators for the phy
> >>>>>     - Resolved all 'make dtbs_check' messages
> >>>>>
> >>>>>  Changes in v5:
> >>>>>     - Fix additional comments
> >>>>>     - Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>>>>     - 'make dtbs_check' giving the following messages since
> >>>>>       ipq9574 doesn't have power domains. Hope this is ok
> >>>>>
> >>>>>             /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
> >>>>>             From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>>>>             /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
> >>>>>             From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >>>>>
> >>>>>  Changes in v4:
> >>>>>     - Use newer bindings without subnodes
> >>>>>     - Fix coding style issues
> >>>>>
> >>>>>  Changes in v3:
> >>>>>     - Insert the nodes at proper location
> >>>>>
> >>>>>  Changes in v2:
> >>>>>     - Fixed issues flagged by Krzysztof
> >>>>>     - Fix issues reported by make dtbs_check
> >>>>>     - Remove NOC related clocks (to be added with proper
> >>>>>       interconnect support)
> >>>>>---
> >>>>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 120 ++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 120 insertions(+)
> >>>>>
> >>>>>diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>index 43a3dbe..1242382 100644
> >>>>>--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>@@ -150,6 +150,33 @@
> >>>>>             method = "smc";
> >>>>>     };
> >>>>>+    reg_usb_3p3: s3300 {
> >>>>
> >>>>The node names do not look generic enough. Please take a look at other
> >>>>platforms.
> >>>
> >>>Please see below.
> >>>
> >>>>>+            compatible = "regulator-fixed";
> >>>>>+            regulator-min-microvolt = <3300000>;
> >>>>>+            regulator-max-microvolt = <3300000>;
> >>>>>+            regulator-boot-on;
> >>>>>+            regulator-always-on;
> >>>>>+            regulator-name = "usb-phy-vdd-dummy";
> >>>>
> >>>>This also doesn't look correct. This regulator should not just fill the gap.
> >>>>Does it represent a generic voltage network on the board?
> >>>>
> >>>>Please do not add 'dummy' voltage regulators if there is no real voltage
> >>>>wire.
> >>>
> >>>These are real voltage wires. I used dummy since they are
> >>>always-on and cannot be increased/decreased (i.e. fixed).
> >>>Would something along the following lines be appropriate?
> >>
> >>Still not fully correct. Please use regulator name that corresponds to
> >>the power grid on the board schematics. I don't think that you have a
> >>separate power grids for USB PHY.
> >>
> >>>
> >>>         vreg_ae10_3p3: s3300 {
> >>
> >>Naming suggests that these voltages are generated by some PMIC. Is
> >>this correct? If so, please describe the PMIC instead.
> >
> >SS PHY needs two supplies and HS PHY needs three supplies. 3.3V
> >and 0.925V are from fixed DC - DC regulators and 1.8V is
> >generated from MP5496 PMIC. Would the following node definitions
> >be ok?
> >
> >usb_hs_vreg0: usb_hs_vreg0 {
> >	compatible = "regulator-fixed";
> >	regulator-min-microvolt = <3300000>;
> >	regulator-max-microvolt = <3300000>;
> >	regulator-boot-on;
> >	regulator-always-on;
> >	regulator-name = "usb-phy-vdd";
> >};
> >
> >usb_hs_vreg1: usb_hs_vreg1 {
> >	compatible = "regulator-fixed";
> >	regulator-min-microvolt = <925000>;
> >	regulator-max-microvolt = <925000>;
> >	regulator-boot-on;
> >	regulator-always-on;
> >	regulator-name = "usb-phy";
> >};
>
> Again. The voltage rails on the board are not USB-specific, are they? So why
> are you declaring usb-phy regulators? Would another consumer of 3.3V rail
> use the same usb-phy-vdd regulator?

Ok. Will rename them as follows

	usb_hs_vreg0 -> fixed_3p3
	usb_hs_vreg1 -> fixed_0p925

	regulator-name = "usb-phy-vdd";	-> fixed_3p3
	regulator-name = "usb-phy";	-> fixed_0p925

> >&rpm_requests {
> >	regulators {
> >		compatible = "qcom,rpm-mp5496-regulators";
> >		.
> >		.
> >		.
> >		ipq9574_l2: l2 {
>
> mp5496_l2

Ok.

Thanks
Varada

> >			regulator-min-microvolt = <1800000>;
> >			regulator-max-microvolt = <1800000>;
> >			regulator-boot-on;
> >			regulator-always-on;
> >		};
> >	};
> >};
> >
> >Thanks
> >Varada
> >
> >>>                 compatible = "regulator-fixed";
> >>>                 regulator-min-microvolt = <3300000>;
> >>>                 regulator-max-microvolt = <3300000>;
> >>>                 regulator-boot-on;
> >>>                 regulator-always-on;
> >>>                 regulator-name = "usb-phy-vdd";
> >>>         };
> >>>
> >>>         vreg_ad8_1p8: s1800 {
> >>>                 compatible = "regulator-fixed";
> >>>                 regulator-min-microvolt = <1800000>;
> >>>                 regulator-max-microvolt = <1800000>;
> >>>                 regulator-boot-on;
> >>>                 regulator-always-on;
> >>>                 regulator-name = "usb-phy-pll";
> >>>         };
> >>>
> >>>         vreg_ad9_0p925: s0925 {
> >>>                 compatible = "regulator-fixed";
> >>>                 regulator-min-microvolt = <925000>;
> >>>                 regulator-max-microvolt = <925000>;
> >>>                 regulator-boot-on;
> >>>                 regulator-always-on;
> >>>                 regulator-name = "usb-phy";
> >>>         };
> >>>
> >>>Thanks
> >>>Varada
> >>>
> >>>>>+    };
> >>>>>+
> >>>>>+    reg_usb_1p8: s1800 {
> >>>>>+            compatible = "regulator-fixed";
> >>>>>+            regulator-min-microvolt = <1800000>;
> >>>>>+            regulator-max-microvolt = <1800000>;
> >>>>>+            regulator-boot-on;
> >>>>>+            regulator-always-on;
> >>>>>+            regulator-name = "usb-phy-pll-dummy";
> >>>>>+    };
> >>>>>+
> >>>>>+    reg_usb_0p925: s0925 {
> >>>>>+            compatible = "regulator-fixed";
> >>>>>+            regulator-min-microvolt = <925000>;
> >>>>>+            regulator-max-microvolt = <925000>;
> >>>>>+            regulator-boot-on;
> >>>>>+            regulator-always-on;
> >>>>>+            regulator-name = "usb-phy-dummy";
> >>>>>+    };
> >>>>>+
> >>>>>     reserved-memory {
> >>>>>             #address-cells = <2>;
> >>>>>             #size-cells = <2>;
> >>>>>@@ -179,6 +206,52 @@
> >>>>>             #size-cells = <1>;
> >>>>>             ranges = <0 0 0 0xffffffff>;
> >>>>>+            usb_0_qusbphy: phy@7b000 {
> >>>>>+                    compatible = "qcom,ipq9574-qusb2-phy";
> >>>>>+                    reg = <0x0007b000 0x180>;
> >>>>>+                    #phy-cells = <0>;
> >>>>>+
> >>>>>+                    clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> >>>>>+                             <&xo_board_clk>;
> >>>>>+                    clock-names = "cfg_ahb",
> >>>>>+                                  "ref";
> >>>>>+
> >>>>>+                    vdd-supply = <&reg_usb_0p925>;
> >>>>>+                    vdda-pll-supply = <&reg_usb_1p8>;
> >>>>>+                    vdda-phy-dpdm-supply = <&reg_usb_3p3>;
> >>>>>+
> >>>>>+                    resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> >>>>>+                    status = "disabled";
> >>>>>+            };
> >>>>>+
> >>>>>+            usb_0_qmpphy: phy@7d000 {
> >>>>>+                    compatible = "qcom,ipq9574-qmp-usb3-phy";
> >>>>>+                    reg = <0x0007d000 0xa00>;
> >>>>>+                    #phy-cells = <0>;
> >>>>>+
> >>>>>+                    clocks = <&gcc GCC_USB0_AUX_CLK>,
> >>>>>+                             <&xo_board_clk>,
> >>>>>+                             <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> >>>>>+                             <&gcc GCC_USB0_PIPE_CLK>;
> >>>>>+                    clock-names = "aux",
> >>>>>+                                  "ref",
> >>>>>+                                  "cfg_ahb",
> >>>>>+                                  "pipe";
> >>>>>+
> >>>>>+                    resets = <&gcc GCC_USB0_PHY_BCR>,
> >>>>>+                             <&gcc GCC_USB3PHY_0_PHY_BCR>;
> >>>>>+                    reset-names = "phy",
> >>>>>+                                  "phy_phy";
> >>>>>+
> >>>>>+                    vdda-pll-supply = <&reg_usb_1p8>;
> >>>>>+                    vdda-phy-supply = <&reg_usb_0p925>;
> >>>>>+
> >>>>>+                    status = "disabled";
> >>>>>+
> >>>>>+                    #clock-cells = <0>;
> >>>>>+                    clock-output-names = "usb0_pipe_clk";
> >>>>>+            };
> >>>>>+
> >>>>>             pcie0_phy: phy@84000 {
> >>>>>                     compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> >>>>>                     reg = <0x00084000 0x1000>;
> >>>>>@@ -548,6 +621,53 @@
> >>>>>                     status = "disabled";
> >>>>>             };
> >>>>>+            usb3: usb@8a00000 {
> >>>>>+                    compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> >>>>>+                    reg = <0x08af8800 0x400>;
> >>>>>+                    #address-cells = <1>;
> >>>>>+                    #size-cells = <1>;
> >>>>>+                    ranges;
> >>>>>+
> >>>>>+                    clocks = <&gcc GCC_SNOC_USB_CLK>,
> >>>>>+                             <&gcc GCC_USB0_MASTER_CLK>,
> >>>>>+                             <&gcc GCC_ANOC_USB_AXI_CLK>,
> >>>>>+                             <&gcc GCC_USB0_SLEEP_CLK>,
> >>>>>+                             <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >>>>>+
> >>>>>+                    clock-names = "cfg_noc",
> >>>>>+                                  "core",
> >>>>>+                                  "iface",
> >>>>>+                                  "sleep",
> >>>>>+                                  "mock_utmi";
> >>>>>+
> >>>>>+                    assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> >>>>>+                                      <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >>>>>+                    assigned-clock-rates = <200000000>,
> >>>>>+                                           <24000000>;
> >>>>>+
> >>>>>+                    interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>+                    interrupt-names = "pwr_event";
> >>>>>+
> >>>>>+                    resets = <&gcc GCC_USB_BCR>;
> >>>>>+                    status = "disabled";
> >>>>>+
> >>>>>+                    dwc_0: usb@8a00000 {
> >>>>>+                            compatible = "snps,dwc3";
> >>>>>+                            reg = <0x8a00000 0xcd00>;
> >>>>>+                            clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >>>>>+                            clock-names = "ref";
> >>>>>+                            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>+                            phys = <&usb_0_qusbphy>, <&usb_0_qmpphy>;
> >>>>>+                            phy-names = "usb2-phy", "usb3-phy";
> >>>>>+                            tx-fifo-resize;
> >>>>>+                            snps,is-utmi-l1-suspend;
> >>>>>+                            snps,hird-threshold = /bits/ 8 <0x0>;
> >>>>>+                            snps,dis_u2_susphy_quirk;
> >>>>>+                            snps,dis_u3_susphy_quirk;
> >>>>>+                            dr_mode = "host";
> >>>>>+                    };
> >>>>>+            };
> >>>>>+
> >>>>>             intc: interrupt-controller@b000000 {
> >>>>>                     compatible = "qcom,msm-qgic2";
> >>>>>                     reg = <0x0b000000 0x1000>,  /* GICD */
> >>>>
> >>>>--
> >>>>With best wishes
> >>>>Dmitry
> >>>>
> >>
> >>
> >>
> >>--
> >>With best wishes
> >>Dmitry
>
> --
> With best wishes
> Dmitry
>
