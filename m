Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C206C42D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCVGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCVGRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:17:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B859E4E;
        Tue, 21 Mar 2023 23:17:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M42DMI001870;
        Wed, 22 Mar 2023 06:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Mf2d6Sz7wrOJuW1Z0Lbpd9EAjHZgu67+yZwEj7PXPrQ=;
 b=f/Or7ps2bj+ZZy9QvqQAjAWEWIX/GATsacAPtYjUrpcZmt5Ks9aBTXvz3pi/3JWEae5V
 RfAUyajrPfxdaLqxk3RaJV44buGXqlunD3+fAxNGFVb7GJaq/b9I+rYESVykIZvhqvcI
 DwSZckpypwRxTuTpGLdMZ7dDwYb5ORgYd509sXu8gSwspqU914Zi1oaeywJu6cp8pwmx
 ppZCiOgn5h/6xOfBiYFvHKJdrfi/j/tZhmBmlD3WJVcvv7rfGA82ebf3vzHKhePUpuWU
 T30WniQOe539vzCTrxh5GbXm+B5bgisy/zG76VTC6Akj/QaUN1wzyOJQ4F7o0iarKaac rA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbjyakh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:16:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M6GqNL031171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:16:52 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 23:16:46 -0700
Date:   Wed, 22 Mar 2023 11:46:42 +0530
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
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230322061641.GC12808@varda-linux.qualcomm.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
 <644b4b0f17f72e109445a7b31f3e0d2e75dcc361.1679388632.git.quic_varada@quicinc.com>
 <122A5E4F-2794-43AE-8DAC-CC2D51279AC6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <122A5E4F-2794-43AE-8DAC-CC2D51279AC6@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zWCKW203mRt7RafU49ialX_iYSKlphF3
X-Proofpoint-ORIG-GUID: zWCKW203mRt7RafU49ialX_iYSKlphF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220044
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:23:26PM +0300, Dmitry Baryshkov wrote:
>
>
> On 21 March 2023 11:54:25 GMT+03:00, Varadarajan Narayanan <quic_varada@quicinc.com> wrote:
> >Add USB phy and controller related nodes
> >
> >Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >
> >---
> > Changes in v2:
> >	- Fixed issues flagged by Krzysztof
> >	- Fix issues reported by make dtbs_check
> >	- Remove NOC related clocks (to be added with proper
> >	  interconnect support)
> >---
> > arch/arm64/boot/dts/qcom/ipq9574.dtsi | 86 +++++++++++++++++++++++++++++++++++
> > 1 file changed, 86 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >index 2bb4053..513da74 100644
> >--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >@@ -829,6 +829,92 @@
> > 			msi-parent = <&v2m0>;
> > 			status = "disabled";
> > 		};
>
> The last device node is pci@28000000. Thus you are trying to
> add all usb nodes at the wrong place. Please move them so that
> all nodes are still sorted by the address part.

Ok. Will reorder them.

Thanks
Varada

>
>
> >+
> >+		qusb_phy_0: phy@7b000 {
> >+			compatible = "qcom,ipq9574-qusb2-phy";
> >+			reg = <0x07b000 0x180>;
> >+			#phy-cells = <0>;
> >+
> >+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> >+				<&xo_board_clk>;
> >+			clock-names = "cfg_ahb", "ref";
> >+
> >+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> >+			status = "disabled";
> >+		};
> >+
> >+		ssphy_0: phy@7d000 {
> >+			compatible = "qcom,ipq9574-qmp-usb3-phy";
> >+			reg = <0x7d000 0x1c4>;
> >+			#clock-cells = <1>;
> >+			#address-cells = <1>;
> >+			#size-cells = <1>;
> >+			ranges;
> >+
> >+			clocks = <&gcc GCC_USB0_AUX_CLK>,
> >+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> >+			clock-names = "aux", "cfg_ahb";
> >+
> >+			resets =  <&gcc GCC_USB0_PHY_BCR>,
> >+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> >+			reset-names = "phy","common";
> >+			status = "disabled";
> >+
> >+			usb0_ssphy: phy@7d200 {
> >+				reg = <0x0007d200 0x130>,	/* tx */
> >+				      <0x0007d400 0x200>,	/* rx */
> >+				      <0x0007d800 0x1f8>,	/* pcs  */
> >+				      <0x0007d600 0x044>;	/* pcs misc */
> >+				#phy-cells = <0>;
> >+				clocks = <&gcc GCC_USB0_PIPE_CLK>;
> >+				clock-names = "pipe0";
> >+				clock-output-names = "usb0_pipe_clk";
> >+			};
> >+		};
> >+
> >+		usb3: usb3@8a00000 {
> >+			compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> >+			reg = <0x8af8800 0x400>;
> >+			#address-cells = <1>;
> >+			#size-cells = <1>;
> >+			ranges;
> >+
> >+			clocks = <&gcc GCC_SNOC_USB_CLK>,
> >+				 <&gcc GCC_ANOC_USB_AXI_CLK>,
> >+				 <&gcc GCC_USB0_MASTER_CLK>,
> >+				 <&gcc GCC_USB0_SLEEP_CLK>,
> >+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+
> >+			clock-names = "sys_noc_axi",
> >+				      "anoc_axi",
> >+				      "master",
> >+				      "sleep",
> >+				      "mock_utmi";
> >+
> >+			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> >+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+			assigned-clock-rates = <200000000>,
> >+					       <24000000>;
> >+
> >+			resets = <&gcc GCC_USB_BCR>;
> >+			status = "disabled";
> >+
> >+			dwc_0: usb@8a00000 {
> >+				compatible = "snps,dwc3";
> >+				reg = <0x8a00000 0xcd00>;
> >+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >+				clock-names = "ref";
> >+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> >+				phys = <&qusb_phy_0>, <&usb0_ssphy>;
> >+				phy-names = "usb2-phy", "usb3-phy";
> >+				tx-fifo-resize;
> >+				snps,is-utmi-l1-suspend;
> >+				snps,hird-threshold = /bits/ 8 <0x0>;
> >+				snps,dis_u2_susphy_quirk;
> >+				snps,dis_u3_susphy_quirk;
> >+				dr_mode = "host";
> >+			};
> >+		};
> > 	};
> >
> > 	rpm-glink {
>
> --
> With best wishes
> Dmitry
