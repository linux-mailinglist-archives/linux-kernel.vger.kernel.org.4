Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5396163BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKBNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKBNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:18:00 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 06:17:58 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704AF2A97D;
        Wed,  2 Nov 2022 06:17:57 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGTgc-1olngA1i6K-00DIrP;
 Wed, 02 Nov 2022 14:12:18 +0100
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
Subject: [PATCH v1 2/6] arm64: dts: verdin-imx8mp: remove usb_2 over-current detection disabling
Date:   Wed,  2 Nov 2022 14:11:59 +0100
Message-Id: <20221102131203.35648-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:czHBTzCluX/JCivsrSik2Qxz22JKvt9utshS16ntwY02MJhVPsM
 mIuvhaKwK/IIK6tj4t7bbqKI7M79MGBSCZ19d81khW3RGh8TbiSRkpSrLyFRsSZ3Z8goo6P
 Ush1T9cL4GgR5yfxMtVtLIZg6EkxcYE8p8ejb0de8cyHLJngmuUgVf7hC12aUHOa4r1K5CK
 d0Bf7Zq5sX6wmAQcCiXnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OggyC/DFIKc=:fw57hSIdNBh1SkDcCC9YeU
 H0sABP9TtOdCoNz7qTbOnjM3GE3ZQdc6vtYwa0Ylp8LnJc2q5RQ2O+BTQ5DlqvcqvX67mWckp
 XIQHiEjiOnIaS+GkxC9lBvNwKAs2off2jH5xekNVITbMWe9w7KeloeBnPDlbgESe44Pp1qLyf
 wk9mN6mrsAF3u5p9vivR0wMAi5bjOLAxdbB8+I+mugJT6/4w9GEIaEKHAZVaQif7IyYqNlb3M
 tdBaCcGOIH081rJWgTAU5eElr3/O6DDdXo0yuWjU3/z0ku02899pQlcUDYP0HD/EU+OBRDn7r
 vp0KWWvSOvelKyYe7OnlSYDghClliC8JhcLgi0Ll8uzqfiMoqPkEWFVtRtPKickaIZbPTEb3b
 zu+bEnjrp+xxLRqPvB6BT2FbcYf16FW0gO+d4pG1DH+8oViCQ2iBtQiqwSa2G9Uhotj8KQsmp
 PssQPGbZfdt2c1rooftigWENz1BhqZXQVFso7jqXVLFYRZwcAtUjoyXad+XELlgZ2S7XD5bj9
 4N4vgwyo6pqDQ9qf2VDk8nOHrkrdIk5Vvl3Y4h+mxDkldm5Xmv/UU4irXiG4csUvGJii+TauU
 anrp5TgcPL2o7EwcBgK6Xq7QqjP1EfEze9RLJH0NqPX7VbAT6g5UFU8rKETC/rU+ji7OTsId9
 2I1cfKwFQ/JbzGltDBCu7UCQL6AtnnwJt/ZgE+E7G7yjZPgbqAWadWThhA2lNnxQcWA1WdtyR
 T/idc2mxg5H4aPaCGpG/rZovzdaHafHWruAN4Jci6cl1w1HtiTiJdREPMU/mv73A4FmF5PkpR
 a5hFNterHFwQmtaM+FxM+QGfDLKI4JMrzq9kOmss3vP4Ar3rfByy8ZGXOxruYdzzEfQJuOCR7
 thcrOV3FZwo5uIvffcvQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The disable-over-current property is only applicable for the
ci-hdrc-usb2 and dwc2 drivers while the i.MX 8M Plus integrates dwc3
IP. Therefore remove this property which does not really serve any
purpose here.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 97e88440a251..57cddf1bf6b3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -828,7 +828,6 @@ &usb3_phy1 {
 };
 
 &usb_dwc3_1 {
-	disable-over-current;
 	dr_mode = "host";
 };
 
-- 
2.36.1

