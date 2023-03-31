Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0F6D1C56
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjCaJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCaJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:29:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2320329;
        Fri, 31 Mar 2023 02:28:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V71VCR028951;
        Fri, 31 Mar 2023 09:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=wADGV9ohsLxooovRp55AnlQ0R+8//pVBhx4ZNqV6Sxw=;
 b=WtMU2VU708ob4UmXcQsgJmPRL9Ql7Up19UClcN6kPqvPI6AL//H7hoOUJoP5ZayMqXVJ
 pOicoa6L8aa2w1Rk6w2jy8dquYE3tYKQjc2UZyf0SrCg7d3tMmNSbMQ6RoLghQ6NQmq6
 v+dOA7Eq5IsClaQ5JOlUyrwTJaOIzSfJ9m3zht67CWCNhIDaNzm+tACbq9ijuuVrqOfg
 3lRkH/SmySEOkSGoJ1Exx7EU1tjo76ICMowEAPieTdApqaMVV2D9B/EpxTyLaak67YJj
 UwVSJdRF4hZGROs5qZ1cqxk1rHKvl58YAyEIuXJGLcJmNkqbWUH+57bHoifTAS3hPKzN cw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn8wnk8w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 09:27:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32V9RLr8030853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 09:27:21 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 02:27:15 -0700
Date:   Fri, 31 Mar 2023 14:57:11 +0530
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
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230331092710.GB19162@varda-linux.qualcomm.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
 <c46b542b112b59002ab965be1d3fcae8c372d545.1680162377.git.quic_varada@quicinc.com>
 <CAA8EJpo_ckJtYV4aU613X5L6+wj-1i9vZkud5p72PLdCSnj5ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpo_ckJtYV4aU613X5L6+wj-1i9vZkud5p72PLdCSnj5ng@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SOXOlmDUi2gqVqtZVG6RxCC6qzePn-wd
X-Proofpoint-GUID: SOXOlmDUi2gqVqtZVG6RxCC6qzePn-wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_04,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310078
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:44:40PM +0300, Dmitry Baryshkov wrote:
> On Thu, 30 Mar 2023 at 11:42, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Add USB phy and controller related nodes
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
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
>
> No, I think it is not.

There are no GDSCs in IPQ9574. Can you suggest how to proceed.

Thanks
Varada

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
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 120 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > index 2bb4053..8fa9e1a 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > @@ -186,6 +186,33 @@
> >                 method = "smc";
> >         };
> >
> > +       reg_usb_3p3: s3300 {
> > +               compatible = "regulator-fixed";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-name = "usb-phy-vdd-dummy";
> > +       };
> > +
> > +       reg_usb_1p8: s1800 {
> > +               compatible = "regulator-fixed";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-name = "usb-phy-pll-dummy";
> > +       };
> > +
> > +       reg_usb_0p925: s0925 {
> > +               compatible = "regulator-fixed";
> > +               regulator-min-microvolt = <925000>;
> > +               regulator-max-microvolt = <925000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-name = "usb-phy-dummy";
> > +       };
> > +
> >         reserved-memory {
> >                 #address-cells = <2>;
> >                 #size-cells = <2>;
> > @@ -215,6 +242,52 @@
> >                 #size-cells = <1>;
> >                 ranges = <0 0 0 0xffffffff>;
> >
> > +               qusb_phy_0: phy@7b000 {
> > +                       compatible = "qcom,ipq9574-qusb2-phy";
> > +                       reg = <0x0007b000 0x180>;
> > +                       #phy-cells = <0>;
> > +
> > +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > +                                <&xo_board_clk>;
> > +                       clock-names = "cfg_ahb",
> > +                                     "ref";
> > +
> > +                       vdd-supply = <&reg_usb_0p925>;
> > +                       vdda-pll-supply = <&reg_usb_1p8>;
> > +                       vdda-phy-dpdm-supply = <&reg_usb_3p3>;
> > +
> > +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               ssphy_0: phy@7d000 {
>
> Nit: usually the label usb_0_qmpphy
>
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
> > +                                     "com_aux",
> > +                                     "pipe";
> > +
> > +                       resets = <&gcc GCC_USB0_PHY_BCR>,
> > +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> > +                       reset-names = "phy",
> > +                                     "phy_phy";
> > +
> > +                       vdda-pll-supply = <&reg_usb_1p8>;
> > +                       vdda-phy-supply = <&reg_usb_0p925>;
> > +
> > +                       status = "disabled";
> > +
> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "usb0_pipe_clk";
> > +               };
> > +
> >                 pcie0_phy: phy@84000 {
> >                         compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> >                         reg = <0x00084000 0x1bc>; /* Serdes PLL */
> > @@ -436,6 +509,53 @@
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
> > +                                <&gcc GCC_ANOC_USB_AXI_CLK>,
> > +                                <&gcc GCC_USB0_MASTER_CLK>,
> > +                                <&gcc GCC_USB0_SLEEP_CLK>,
> > +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +
> > +                       clock-names = "sys_noc_axi",
> > +                                     "anoc_axi",
> > +                                     "master",
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
> > +                               compatible = "snps,dwc3";
> > +                               reg = <0x8a00000 0xcd00>;
> > +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +                               clock-names = "ref";
> > +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > +                               phys = <&qusb_phy_0>, <&ssphy_0>;
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
