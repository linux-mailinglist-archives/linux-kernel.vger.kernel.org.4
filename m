Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37549728F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFIGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:02:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B313D;
        Thu,  8 Jun 2023 23:02:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3594bSEJ006123;
        Fri, 9 Jun 2023 06:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Iu45rQ6XWEUxo/b1XJF4iBz3QcaMOpCLGop0Ai9kUw0=;
 b=H+o3ej3VkIk125LeJ9Z4gDWbSSBtMFSRBaOfE4azdSGp6oOayMB//hbqx7KgiYwnKVqA
 d4Zs/Y5iyA/500tUbq6UaEKzKBQB1Hxvp1mKbRobxzzKo4xwnaAaw7zF0+/nD/KIURTA
 Pln9dcmwwPSEkGtEJZ+cKbZZuEXNeIokxhfbqS/mncssnsx5olSAn9+gAKm0w5ht9gdK
 +2zZ/iGOqEiiApmLdgSZt9MogDEI5lCk8mb8keSm8GppQMISR5VdeDIHCLVXgJNAjZGl
 Zy5m7VGBu8YyMiiaNqxrp1oB+46qLVRx+nZFpscrjJu1QiXFuB+dtvIDsfkY48ZkMgVc DQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3nwerstm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 06:02:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35962DAH017167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 06:02:13 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 23:02:08 -0700
Date:   Fri, 9 Jun 2023 11:32:04 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v14 3/5] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230609060203.GA22023@varda-linux.qualcomm.com>
References: <cover.1686217906.git.quic_varada@quicinc.com>
 <2f91eb879daaf9955dc56135d60a4be5e191a44d.1686217906.git.quic_varada@quicinc.com>
 <71960b11-5686-9af5-423b-bfdaec56f3f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71960b11-5686-9af5-423b-bfdaec56f3f9@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K9thgWhAYYyu8mtu1-NM4SZjEHDrgngj
X-Proofpoint-ORIG-GUID: K9thgWhAYYyu8mtu1-NM4SZjEHDrgngj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_03,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 02:06:49PM +0300, Dmitry Baryshkov wrote:
> On 08/06/2023 13:03, Varadarajan Narayanan wrote:
> >Add USB phy and controller related nodes
> >
> >SS PHY need two supplies and HS PHY needs three supplies. 0.925V
> >and 3.3V are from fixed regulators and 1.8V is generated from
> >PMIC's LDO
> >
> >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >---
> >  Changes in v13:
> >	- Move fixed regulator definitions from SoC dtsi to board dts
> >	- Remove 'dr_mode' from SoC dtsi
> >	- Move 'status' property to the end
> >  Changes in v12:
> >	- Rebase
> >  Changes in v11:
> >	- Rename dwc_0 -> usb_0_dwc3
> >  Changes in v10:
> >	- Fix regulator definitions
> >  Changes in v8:
> >	- Change clocks order to match the bindings
> >  Changes in v7:
> >	- Change com_aux -> cfg_ahb
> >  Changes in v6:
> >	- Introduce fixed regulators for the phy
> >	- Resolved all 'make dtbs_check' messages
> >
> >  Changes in v5:
> >	- Fix additional comments
> >	- Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >	- 'make dtbs_check' giving the following messages since
> >	  ipq9574 doesn't have power domains. Hope this is ok
> >
> >		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
> >         	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
> >         	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >
> >  Changes in v4:
> >	- Use newer bindings without subnodes
> >	- Fix coding style issues
> >
> >  Changes in v3:
> >	- Insert the nodes at proper location
> >
> >  Changes in v2:
> >	- Fixed issues flagged by Krzysztof
> >	- Fix issues reported by make dtbs_check
> >	- Remove NOC related clocks (to be added with proper
> >	  interconnect support)
> >---
> >  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 18 ++++++
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 85 +++++++++++++++++++++++++++++
> >  2 files changed, 103 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >index 2b3ed8d..8261a2b 100644
> >--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >@@ -21,6 +21,24 @@
> >  	chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >+
> >+	regulator_fixed_3p3: s3300 {
> >+		compatible = "regulator-fixed";
> >+		regulator-min-microvolt = <3300000>;
> >+		regulator-max-microvolt = <3300000>;
> >+		regulator-boot-on;
> >+		regulator-always-on;
> >+		regulator-name = "fixed_3p3";
> >+	};
> >+
> >+	regulator_fixed_0p925: s0925 {
> >+		compatible = "regulator-fixed";
> >+		regulator-min-microvolt = <925000>;
> >+		regulator-max-microvolt = <925000>;
> >+		regulator-boot-on;
> >+		regulator-always-on;
> >+		regulator-name = "fixed_0p925";
> >+	};
> >  };
>
> Let me repeat from v13, so that it is not lost (please excuse me for the
> spam):
>
> Nit: these two regulators are not references from SoC dtsi. So they don't
> have to be a part of this commit and can be moved to one of the next commits
> (I'd prefer the last one).

Sure. Have posted v15 with the suggested changes.
Please review.

Thanks
Varada

>
> >  &blsp1_uart2 {
> >diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >index 0baeb10..feabc19 100644
> >--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >@@ -465,6 +465,91 @@
> >  			status = "disabled";
> >  		};
> >+		usb_0_qusbphy: phy@7b000 {
> >+			compatible = "qcom,ipq9574-qusb2-phy";
> >+			reg = <0x0007b000 0x180>;
> >+			#phy-cells = <0>;
> >+
> >+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> >+				 <&xo_board_clk>;
> >+			clock-names = "cfg_ahb",
> >+				      "ref";
> >+
> >+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> >+			status = "disabled";
> >+		};
> >+
> >+		usb_0_qmpphy: phy@7d000 {
> >+			compatible = "qcom,ipq9574-qmp-usb3-phy";
> >+			reg = <0x0007d000 0xa00>;
> >+			#phy-cells = <0>;
> >+
> >+			clocks = <&gcc GCC_USB0_AUX_CLK>,
> >+				 <&xo_board_clk>,
> >+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> >+				 <&gcc GCC_USB0_PIPE_CLK>;
> >+			clock-names = "aux",
> >+				      "ref",
> >+				      "cfg_ahb",
> >+				      "pipe";
> >+
> >+			resets = <&gcc GCC_USB0_PHY_BCR>,
> >+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> >+			reset-names = "phy",
> >+				      "phy_phy";
> >+
> >+			#clock-cells = <0>;
> >+			clock-output-names = "usb0_pipe_clk";
> >+
> >+			status = "disabled";
> >+		};
> >+
> >+		usb3: usb@8af8800 {
> >+			compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> >+			reg = <0x08af8800 0x400>;
> >+			#address-cells = <1>;
> >+			#size-cells = <1>;
> >+			ranges;
> >+
> >+			clocks = <&gcc GCC_SNOC_USB_CLK>,
> >+				 <&gcc GCC_USB0_MASTER_CLK>,
> >+				 <&gcc GCC_ANOC_USB_AXI_CLK>,
> >+				 <&gcc GCC_USB0_SLEEP_CLK>,
> >+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+
> >+			clock-names = "cfg_noc",
> >+				      "core",
> >+				      "iface",
> >+				      "sleep",
> >+				      "mock_utmi";
> >+
> >+			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> >+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+			assigned-clock-rates = <200000000>,
> >+					       <24000000>;
> >+
> >+			interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> >+			interrupt-names = "pwr_event";
> >+
> >+			resets = <&gcc GCC_USB_BCR>;
> >+			status = "disabled";
> >+
> >+			usb_0_dwc3: usb@8a00000 {
> >+				compatible = "snps,dwc3";
> >+				reg = <0x8a00000 0xcd00>;
> >+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+				clock-names = "ref";
> >+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> >+				phys = <&usb_0_qusbphy>, <&usb_0_qmpphy>;
> >+				phy-names = "usb2-phy", "usb3-phy";
> >+				tx-fifo-resize;
> >+				snps,is-utmi-l1-suspend;
> >+				snps,hird-threshold = /bits/ 8 <0x0>;
> >+				snps,dis_u2_susphy_quirk;
> >+				snps,dis_u3_susphy_quirk;
> >+			};
> >+		};
> >+
> >  		intc: interrupt-controller@b000000 {
> >  			compatible = "qcom,msm-qgic2";
> >  			reg = <0x0b000000 0x1000>,  /* GICD */
>
> --
> With best wishes
> Dmitry
>
