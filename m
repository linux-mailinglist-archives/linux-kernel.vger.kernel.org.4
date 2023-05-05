Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5A6F80B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjEEKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjEEKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:20:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C39B18854;
        Fri,  5 May 2023 03:20:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3458luUJ014530;
        Fri, 5 May 2023 10:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=aNHgU+0nC7vnaXDt9HRwFXY3R2EPk1kMa3lnhR84wv4=;
 b=SKfGqRYpGNi41XqRxF7oQiR5u2YTHdCYKhGBmQoFAqZBIAmIe6Zqv56n4dlAWbwKr08y
 3nYsY0IDvcjp21H8WKWG182ydhLUCksnW1m9GzubntUTJ+oGOk1z7HdaiRXKbAd61NHE
 JLvL70WXn9Cpt6X86A5N1YpNltwvCZDPoYZw4um1L9HVgJX9Bnl2ebmLUadXriCaMH+U
 HdeX8+WodSU+77wpHYqZjB5g6TT9ZUW6QzQe7sGxAN5o6RI6yCrb4gMsDuJDnu+/5+zr
 d8bRuFQiH91l8ch9wc0v2l9LAQNvvtEclqzo44jjmqcq28gNTxywJJENiOCjkCEdMaOD gg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcb24augd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 10:19:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345AJwwX026871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 10:19:58 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 03:19:52 -0700
Date:   Fri, 5 May 2023 15:49:48 +0530
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
Subject: Re: [PATCH v10 7/9] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230505101947.GB10918@varda-linux.qualcomm.com>
References: <cover.1683183860.git.quic_varada@quicinc.com>
 <efb655fd19354ee77cf03b3b96a2206065106590.1683183860.git.quic_varada@quicinc.com>
 <CAA8EJprrk7+jRWdhz2MWdFj-jf2ehbXrz97KrkZ4NE6FqhiCNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprrk7+jRWdhz2MWdFj-jf2ehbXrz97KrkZ4NE6FqhiCNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 64DwHVbdC2GWT7uYtzJeQul7pfC4LZbj
X-Proofpoint-ORIG-GUID: 64DwHVbdC2GWT7uYtzJeQul7pfC4LZbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_16,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:31:11PM +0300, Dmitry Baryshkov wrote:
> On Fri, 5 May 2023 at 11:23, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Add USB phy and controller related nodes
> >
> > SS PHY need two supplies and HS PHY needs three supplies. 0.925V
> > and 3.3V are from fixed regulators and 1.8V is generated from
> > PMIC's LDO
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Changes in v10:
> >         - Fix regulator definitions
> >  Changes in v8:
> >         - Change clocks order to match the bindings
> >  Changes in v7:
> >         - Change com_aux -> cfg_ahb
> >  Changes in v6:
> >         - Introduce fixed regulators for the phy
> >         - Resolved all 'make dtbs_check' messages
> >
> >  Changes in v5:
> >         - Fix additional comments
> >         - Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >         - 'make dtbs_check' giving the following messages since
> >           ipq9574 doesn't have power domains. Hope this is ok
> >
> >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
> >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
> >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >
> >  Changes in v4:
> >         - Use newer bindings without subnodes
> >         - Fix coding style issues
> >
> >  Changes in v3:
> >         - Insert the nodes at proper location
> >
> >  Changes in v2:
> >         - Fixed issues flagged by Krzysztof
> >         - Fix issues reported by make dtbs_check
> >         - Remove NOC related clocks (to be added with proper
> >           interconnect support)
> > ---
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 104 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > index 93b4ba9..84b80cc 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > @@ -150,6 +150,24 @@
> >                 method = "smc";
> >         };
> >
> > +       fixed_3p3: s3300 {
> > +               compatible = "regulator-fixed";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-name = "fixed_3p3";
> > +       };
> > +
> > +       fixed_0p925: s0925 {
> > +               compatible = "regulator-fixed";
> > +               regulator-min-microvolt = <925000>;
> > +               regulator-max-microvolt = <925000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-name = "fixed_0p925";
> > +       };
> > +
> >         reserved-memory {
> >                 #address-cells = <2>;
> >                 #size-cells = <2>;
> > @@ -191,6 +209,45 @@
> >                         reg = <0x00060000 0x6000>;
> >                 };
> >
> > +               usb_0_qusbphy: phy@7b000 {
> > +                       compatible = "qcom,ipq9574-qusb2-phy";
> > +                       reg = <0x0007b000 0x180>;
> > +                       #phy-cells = <0>;
> > +
> > +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > +                                <&xo_board_clk>;
> > +                       clock-names = "cfg_ahb",
> > +                                     "ref";
> > +
> > +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               usb_0_qmpphy: phy@7d000 {
> > +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> > +                       reg = <0x0007d000 0xa00>;
> > +                       #phy-cells = <0>;
> > +
> > +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> > +                                <&xo_board_clk>,
> > +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > +                                <&gcc GCC_USB0_PIPE_CLK>;
> > +                       clock-names = "aux",
> > +                                     "ref",
> > +                                     "cfg_ahb",
> > +                                     "pipe";
> > +
> > +                       resets = <&gcc GCC_USB0_PHY_BCR>,
> > +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> > +                       reset-names = "phy",
> > +                                     "phy_phy";
> > +
> > +                       status = "disabled";
> > +
> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "usb0_pipe_clk";
> > +               };
> > +
> >                 pcie0_phy: phy@84000 {
> >                         compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> >                         reg = <0x00084000 0x1000>;
> > @@ -560,6 +617,53 @@
> >                         status = "disabled";
> >                 };
> >
> > +               usb3: usb@8a00000 {
> > +                       compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> > +                       reg = <0x08af8800 0x400>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
> > +                                <&gcc GCC_USB0_MASTER_CLK>,
> > +                                <&gcc GCC_ANOC_USB_AXI_CLK>,
> > +                                <&gcc GCC_USB0_SLEEP_CLK>,
> > +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +
> > +                       clock-names = "cfg_noc",
> > +                                     "core",
> > +                                     "iface",
> > +                                     "sleep",
> > +                                     "mock_utmi";
> > +
> > +                       assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> > +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +                       assigned-clock-rates = <200000000>,
> > +                                              <24000000>;
> > +
> > +                       interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +                       interrupt-names = "pwr_event";
> > +
> > +                       resets = <&gcc GCC_USB_BCR>;
> > +                       status = "disabled";
> > +
> > +                       dwc_0: usb@8a00000 {
>
> As I wrote in the other email, this better have the usb_0_dwc3 alias.
> With that fixed:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Sure. Will rename it and send a revised version.

Thanks
Varada

> > +                               compatible = "snps,dwc3";
> > +                               reg = <0x8a00000 0xcd00>;
> > +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +                               clock-names = "ref";
> > +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > +                               phys = <&usb_0_qusbphy>, <&usb_0_qmpphy>;
> > +                               phy-names = "usb2-phy", "usb3-phy";
> > +                               tx-fifo-resize;
> > +                               snps,is-utmi-l1-suspend;
> > +                               snps,hird-threshold = /bits/ 8 <0x0>;
> > +                               snps,dis_u2_susphy_quirk;
> > +                               snps,dis_u3_susphy_quirk;
> > +                               dr_mode = "host";
> > +                       };
> > +               };
> > +
> >                 intc: interrupt-controller@b000000 {
> >                         compatible = "qcom,msm-qgic2";
> >                         reg = <0x0b000000 0x1000>,  /* GICD */
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry
