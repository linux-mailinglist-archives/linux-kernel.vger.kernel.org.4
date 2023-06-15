Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F96730EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbjFOGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjFOGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:02:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC02974;
        Wed, 14 Jun 2023 23:02:05 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F57XOp004800;
        Thu, 15 Jun 2023 06:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dImV6OGXSsx2x1yT1KJCeCgruj88IJIxqty0Jdo6NwA=;
 b=oYhV5OxnukaHFp3TFv7Q7yiZbedU95SG3A1DAXVPikc71tDBWiiMahmBz66FCJactRCJ
 0uXNW23NgYZqJdO5yvC6EnCbKM626tk2PqjkrhWiS5neKE4D6Iar3diaYbLSOelyj5XG
 20taRX0uBQlgDyiHkCRKvkcckBV5imEFKOoS7SdFSggAp9ek70H70CeYIAHNj4PxHDRQ
 6fIwy8lwbpaYKeoeoMjjxAJc5B+MNvYX6licc9ohCUs0cKQ4tmdMFFoBv/iO1d70UtU9
 LXUSP3Fhf/JXVGAxlQ51aprjt6qks8oKdUwPiifGfLwvyebrJvhxG9jRgpeEG6FYliZ4 OA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7p4q8krb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:01:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F61YvV010828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:01:34 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 23:01:23 -0700
Date:   Thu, 15 Jun 2023 11:31:19 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 3/9] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <20230615060118.GD22186@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <6bb345c6a57ee27516764f36ba7d34fd1a719b87.1686126439.git.quic_varada@quicinc.com>
 <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
 <cf3c98c1-e283-3fac-3144-5a7354378a6b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf3c98c1-e283-3fac-3144-5a7354378a6b@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: beGEPEbrb_VpMMugIv2KsiqI0rAnPtsr
X-Proofpoint-ORIG-GUID: beGEPEbrb_VpMMugIv2KsiqI0rAnPtsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_02,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:29:18PM +0300, Dmitry Baryshkov wrote:
> Two minor nits on top of the review:
>
> On 07/06/2023 14:54, Konrad Dybcio wrote:
> >On 7.06.2023 12:56, Varadarajan Narayanan wrote:
> >>Add the M31 USB2 phy driver
> >>
> >>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>---
> >>  drivers/phy/qualcomm/phy-qcom-m31.c | 360 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 360 insertions(+)
> >>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> >>
> >>diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> >>new file mode 100644
> >>index 0000000..d29a91e
> >>--- /dev/null
> >>+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> >>@@ -0,0 +1,360 @@
> >>+// SPDX-License-Identifier: GPL-2.0+
> >>+/*
> >>+ * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
> >>+ */
> >>+
> >>+#include <linux/module.h>
> >>+#include <linux/kernel.h>
> >>+#include <linux/err.h>
> >>+#include <linux/slab.h>
> >>+#include <linux/clk.h>
> >>+#include <linux/delay.h>
> >>+#include <linux/io.h>
> >>+#include <linux/of.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/usb/phy.h>
> >>+#include <linux/reset.h>
> >>+#include <linux/of_device.h>
> >Please sort these
> >
> >>+
> >>+enum clk_reset_action {
> >>+	CLK_RESET_DEASSERT	= 0,
> >>+	CLK_RESET_ASSERT	= 1
> >>+};
> >>+
> >>+#define USB2PHY_PORT_POWERDOWN		0xA4
> >>+#define POWER_UP			BIT(0)
> >>+#define POWER_DOWN			0
> >>+
> >>+#define USB2PHY_PORT_UTMI_CTRL1	0x40
> >>+
> >>+#define USB2PHY_PORT_UTMI_CTRL2	0x44
> >>+#define UTMI_ULPI_SEL			BIT(7)
> >>+#define UTMI_TEST_MUX_SEL		BIT(6)
> >>+
> >>+#define HS_PHY_CTRL_REG			0x10
> >>+#define UTMI_OTG_VBUS_VALID             BIT(20)
> >>+#define SW_SESSVLD_SEL                  BIT(28)
> >>+
> >>+#define USB_PHY_CFG0			0x94
> >>+#define USB_PHY_UTMI_CTRL5		0x50
> >>+#define USB_PHY_FSEL_SEL		0xB8
> >>+#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> >>+#define USB_PHY_REFCLK_CTRL		0xA0
> >>+#define USB_PHY_HS_PHY_CTRL2		0x64
> >>+#define USB_PHY_UTMI_CTRL0		0x3c
> >>+#define USB2PHY_USB_PHY_M31_XCFGI_1	0xBC
> >>+#define USB2PHY_USB_PHY_M31_XCFGI_4	0xC8
> >>+#define USB2PHY_USB_PHY_M31_XCFGI_5	0xCC
> >>+#define USB2PHY_USB_PHY_M31_XCFGI_11	0xE4
> >Could you sort them address-wise?
>
> ... and lowercase the hex values, please.

Ok.

> >>+
> >>+#define USB2_0_TX_ENABLE		BIT(2)
> >>+#define HSTX_SLEW_RATE_565PS		3
> >>+#define PLL_CHARGING_PUMP_CURRENT_35UA	(3 << 3)
> >>+#define ODT_VALUE_38_02_OHM		(3 << 6)
> >>+#define ODT_VALUE_45_02_OHM		BIT(2)
> >>+#define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	(1)
> >Weird mix of values, bits, bitfields.. perhaps BIT(n) and
> >GENMASK() (+ FIELD_PREP) would be more suitable?
> >
> >>+
> >>+#define UTMI_PHY_OVERRIDE_EN		BIT(1)
> >>+#define POR_EN				BIT(1)
> >Please associate these with their registers, like
> >
> >#define FOO_REG		0xf00
> >  #define POR_EN		BIT(1)
> >
> >>+#define FREQ_SEL			BIT(0)
> >>+#define COMMONONN			BIT(7)
> >>+#define FSEL				BIT(4)
> >>+#define RETENABLEN			BIT(3)
> >>+#define USB2_SUSPEND_N_SEL		BIT(3)
> >>+#define USB2_SUSPEND_N			BIT(2)
> >>+#define USB2_UTMI_CLK_EN		BIT(1)
> >>+#define CLKCORE				BIT(1)
> >>+#define ATERESET			~BIT(0)
> >>+#define FREQ_24MHZ			(5 << 4)
> >>+#define XCFG_COARSE_TUNE_NUM		(2 << 0)
> >>+#define XCFG_FINE_TUNE_NUM		(1 << 3)
> >same comment
> >
> >>+
> >>+static void m31usb_write_readback(void *base, u32 offset,
> >>+					const u32 mask, u32 val);
> >We don't need this forward-definition, just move the function up.
> >
> >>+
> >>+struct m31usb_phy {
> >>+	struct usb_phy		phy;
> >>+	void __iomem		*base;
> >>+	void __iomem		*qscratch_base;
> >>+
> >>+	struct reset_control	*phy_reset;
> >>+
> >>+	bool			cable_connected;
> >>+	bool			suspended;
> >>+	bool			ulpi_mode;
> >>+};
> >>+
> >>+static void m31usb_reset(struct m31usb_phy *qphy, u32 action)
> >>+{
> >>+	if (action == CLK_RESET_ASSERT)
> >>+		reset_control_assert(qphy->phy_reset);
> >>+	else
> >>+		reset_control_deassert(qphy->phy_reset);
> >>+	wmb(); /* ensure data is written to hw register */
> >Please move the comment above the call.
> >
> >>+}
>
> Or even better just inline the function. I was never a fan of such
> multiplexers.
>
> Also does wmb() make sense here? Doesn't regmap (which is used by reset
> controller) remove the need for it?

Will inline and remove the wmb.

Thanks
Varada

> >>+
> >>+static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
> >>+{
> >>+	/* Enable override ctrl */
> >>+	writel(UTMI_PHY_OVERRIDE_EN, qphy->base + USB_PHY_CFG0);
> >Some of the comments are missing a space before '*/'
> >
> >Also, please consider adding some newlines to logically split the
> >actions.
>
>
> --
> With best wishes
> Dmitry
>
