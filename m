Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72956BC61A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCPGac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:30:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AB9EF45;
        Wed, 15 Mar 2023 23:30:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G25Qcr002833;
        Thu, 16 Mar 2023 06:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=x3CT63H/MNL5C7LmQ01erJeEHAfzFiLYI/OUMyys0Jg=;
 b=orelI1RYHxdLdEPrOi/GtcfOFR2PKkbkzgkY2zm6Mdd0rb0oIELVmWnLx4IMtCd5DKp3
 0wfU246IzEYOvcFqRkjFXVcI9GAuKLlNaC4SsYYjC7u4mouPWJXvw5bongynKE3DTw4f
 qaCJmUnCjSBFHHZNP9qlRgyBZCmvKJ8nB/J08RITWiDSzw17KpkTm3e5fVFeuDTUT5yu
 6wl/ut/NP58QzuCVqggpWaqMIEGZTzqTf0r1nrXzbb/tSz4V+fz042an3Rfq57s7Ou2l
 6AbwCpTZc84+9Bg6/+zwjiAiXGOolaL1/OZznaOQMh/lK7S9eNpbkyad4K1dow92BP6L xg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy8gwj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 06:30:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32G6UH6J013336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 06:30:17 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 23:30:13 -0700
Date:   Thu, 16 Mar 2023 12:00:09 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230316063009.GA29961@varda-linux.qualcomm.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
 <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
 <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
 <365f2609-d3b4-df23-5b6e-7a190815a640@quicinc.com>
 <47b591c0-2f68-429d-6d1b-fa8b701785ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b591c0-2f68-429d-6d1b-fa8b701785ac@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vSM5Xf1dVQIkWupo36QlI3tRGxATnzol
X-Proofpoint-ORIG-GUID: vSM5Xf1dVQIkWupo36QlI3tRGxATnzol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_04,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

On Tue, Mar 07, 2023 at 01:49:40PM +0200, Dmitry Baryshkov wrote:
> On 07/03/2023 08:36, Varadarajan Narayanan wrote:
> >
> >On 3/6/2023 5:21 PM, Dmitry Baryshkov wrote:
> >>On 06/03/2023 13:26, Varadarajan Narayanan wrote:
> >>>Dmitry,
> >>>
> >>>On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
> >>>>On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> >>>><quic_varada@quicinc.com> wrote:
> >>>>>Add USB phy and controller related nodes
> >>>>>
> >>>>>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>---
> >>>>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92
> >>>>>+++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 92 insertions(+)
> >>>>>
> >>>>>diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>index 2bb4053..319b5bd 100644
> >>>>>--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>>>>+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>
> >>[skipped]
> >>
> >>
> >>>>>+               usb3: usb3@8A00000 {
> >>>>You know the drill. This node is in the wrong place.
> >>>>
> >>>>>+                       compatible = "qcom,dwc3";
> >>>>>+                       reg = <0x8AF8800 0x400>;
> >>>>>+                       #address-cells = <1>;
> >>>>>+                       #size-cells = <1>;
> >>>>>+                       ranges;
> >>>>>+
> >>>>>+                       clocks = <&gcc GCC_SNOC_USB_CLK>,
> >>>>>+                               <&gcc GCC_ANOC_USB_AXI_CLK>,
> >>>>>+                               <&gcc GCC_USB0_MASTER_CLK>,
> >>>>>+                               <&gcc GCC_USB0_SLEEP_CLK>,
> >>>>>+                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> >>>>>+
> >>>>>+                       clock-names = "sys_noc_axi",
> >>>>>+                               "anoc_axi",
> >>>>>+                               "master",
> >>>>>+                               "sleep",
> >>>>>+                               "mock_utmi";
> >>>>Please fix the indentation of the lists.
> >>>>
> >>>>>+
> >>>>>+                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
> >>>>>+                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
> >>>>Why do you assign clock rates to the NOC clocks? Should they be set
> >>>>using the interconnect instead?
> >>>
> >>>The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz
> >>>respectively and are not scaled. These clocks are for the interface
> >>>between the USB block and the SNOC/ANOC. Do we still need to use
> >>>interconnect?
> >>
> >>Maybe I misunderstand something here. If the snoc and anoc speeds are at
> >>350 MHz and 342 MHz, why do you assign clock-rates of 200 MHz?
> >>
> >>Is it enough to call clk_prepare_enable() for these clocks or the rate
> >>really needs to be set?
> >
> >The rate of 200MHz is not being set for the SNOC/ANOC. It is for the
> >NIU that connects the USB and SNOC/ANOC. The reason for setting the
> >rate to 200MHz is to configure the RCG parent for these interface
> >clocks. That said can we configure this RCG standalone in the driver
> >and enable these clocks?
>
> We discussed this separately with Georgi Djakov. Let me quote his IRC
> message: "it sounds like this is for USB port that connects to the NOC. if
> bandwidth scaling is not needed (or other interconnect configuration), then
> maybe this can go without interconnect provider driver."
>
> However as we discover more and more about this platform (e.g. PCIe using
> the aggre_noc region to setup some magic registers, see [1]), I'm more and
> more biased towards suggesting implementing the interconnect driver to setup
> all these tiny little things. With the DT tree being an ABI, it is much
> preferable to overestimate the needs rather than underestimating them (and
> having to cope with the backwards compatibility issues).
>
> Generally I think that PCIe/USB/whatever should not poke into NoC registers
> or NoC/NIU clocks directly (because this is a very platform-specific item).
> Rather than that it should tell the icc/opp/whatever subsystem, "please
> configure the SoC for me to work".
>
> [1] https://lore.kernel.org/linux-arm-msm/30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com/

Dmitry,
Can we remove the interconnect clocks in the next patch
version (and assume that the boot loader configures them)?

And add these clocks once the interconnect support is available.

Thanks
Varada

>
> >
> >Thanks
> >Varada
> >
> >
> >>
> >>
> >>>
> >>>>>+ <&gcc GCC_USB0_MASTER_CLK>,
> >>>>>+                                         <&gcc
> >>>>>GCC_USB0_MOCK_UTMI_CLK>;
> >>>>>+                       assigned-clock-rates = <200000000>,
> >>>>>+ <200000000>,
> >>>>>+ <200000000>,
> >>>>>+ <24000000>;
> >>>>>+
> >>>>>+                       resets = <&gcc GCC_USB_BCR>;
> >>>>>+                       status = "disabled";
> >>>>>+
> >>>>>+                       dwc_0: dwc3@8A00000 {
> >>>>>+                               compatible = "snps,dwc3";
> >>>>>+                               reg = <0x8A00000 0xcd00>;
> >>>>>+                               clock-names = "ref";
> >>>>>+                               clocks = <&gcc
> >>>>>GCC_USB0_MOCK_UTMI_CLK>;
> >>>>clocks before clock-names
> >>>>
> >>>>>+ interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>+                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
> >>>>>+                               phy-names = "usb2-phy", "usb3-phy";
> >>>>>+                               tx-fifo-resize;
> >>>>>+                               snps,dis_ep_cache_eviction;
> >>>>>+                               snps,is-utmi-l1-suspend;
> >>>>>+                               snps,hird-threshold = /bits/ 8 <0x0>;
> >>>>>+                               snps,dis_u2_susphy_quirk;
> >>>>>+                               snps,dis_u3_susphy_quirk;
> >>>>>+ snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
> >>>>>+                               dr_mode = "host";
> >>>>>+                       };
> >>>>>+               };
> >>>>>+
> >>>>>                 pcie0_phy: phy@84000 {
> >>>>>                         compatible =
> >>>>>"qcom,ipq9574-qmp-gen3x1-pcie-phy";
> >>>>>                         reg = <0x00084000 0x1bc>; /* Serdes PLL */
> >>>>>--
> >>>>>2.7.4
> >>>
> >>>Will address these and post a new revision.
> >>>
> >>>Thanks
> >>>
> >>>Varada
> >>>
> >>
>
> --
> With best wishes
> Dmitry
>
