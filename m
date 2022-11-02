Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E526163B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKBNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiKBNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:18:00 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26262AC4E;
        Wed,  2 Nov 2022 06:17:59 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lkw9T-1pQvL20RwD-00anec;
 Wed, 02 Nov 2022 14:12:25 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] arm64: dts: verdin-imx8mp: disable usb port power control
Date:   Wed,  2 Nov 2022 14:12:01 +0100
Message-Id: <20221102131203.35648-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ezSwXDhrGUhbO41+Hg5e7FqLOXhDA9Lo/PmMeLS1/Z3DrwzK2PZ
 OcWAB7cixj3ZVWQg3eQjk0FRRJ0lyMUHbItra6p8/BU1V/ABQNGHWc5BuID39PbzLEkg/cg
 i4W5STJ93CobpkH/eNXkyXF0FDsWnt5EGKgZ5ipR78e4/YwoPV1HMw9cetho5IJjH3hPNGg
 cnN94Ew2C2leFWZtlf3pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1NDYnwyTszc=:z1x7q1Ea8Qwjikh2SLyqBh
 49eZBXI7pum6ahcONCmBsm0gtqqIMH8AhIvZPZIPTtXcgA17Tu8uBJyvkZL/KYCANjwZFU1Oo
 wwqo8aRqw4DEyl2hOPO4jyXaL6JmUuXH6uA+p/ROyLGlixplQ2Dlf1udccz+M1VUgIB+UTdB0
 DGkr+Qh1KAKAjb9cbqhHHZ3UqI3FFM5fVYyUkemZJuSDVVAQHG/UDZpd5q4fDCnWnJ1oLv9Kr
 nnZMz1KpqM0Mz3Jn5SdSmgzkZ+zydOVZzf1y7X+GmUsv2sJX8NLrUI9/MWz0yVguGUlwW64nd
 8l3cBnZwcNxYLfudI80dGB4UYhXY/4YXrm7FzNpNRrvRWGCvSRlteXDJqCkObPdJZUpPumkAh
 C/N4vf33F1WucDxS5k/1kK7wYEeQ4JO6+HiCStyzqzP+1UYEu+Fs8RSCHYlAWDqwUN1KpT4VY
 9fpkz79++0HDUduOSAshwzdPPTCD7xVQPFXDbRfL0rNFJu1uDvW/nhYct1rmQ83QcedxcMN6e
 pnlxrYe9inITgIlYlSDj5uRmeJVy0ydxIKTs0Lyj/rMeA8RuUe/AQKA8tlPXtWicdSvw2SQDt
 EFdmn2HsIOiyrSbX9j6jKQC38RKrFSPm0AtNpw5NyMDFOpeuadXzglKDO0EVcO+5eBbc48Q3F
 kLN+ISDqqtOkGOG6/pZuyCf77kN/N7jrtYyLhWuNSPDoxRV100UvIeqlH49gCdqKEpAS7Vcev
 BGba7+W9cfauI83Irtfn374i+J/32mSAEm15yG4WN9p54KyOdYZXRpu7wXxhErgUzbH6MkeC7
 Q1dvhKu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Disable port power control on Verdin USB_1/2 as we use regular
fixed-regulators with Verdin USB_1/2_EN as enable GPIOs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 85af2875fb70..795e02df9f29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -808,6 +808,7 @@ &uart4 {
 
 /* Verdin USB_1 */
 &usb3_0 {
+	fsl,disable-port-power-control;
 	fsl,over-current-active-low;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb_1_oc_n>;
@@ -828,6 +829,10 @@ &usb_dwc3_0 {
 };
 
 /* Verdin USB_2 */
+&usb3_1 {
+	fsl,disable-port-power-control;
+};
+
 &usb3_phy1 {
 	vbus-supply = <&reg_usb2_vbus>;
 };
-- 
2.36.1

