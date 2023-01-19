Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE0673407
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjASIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjASIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:54:55 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389016E96;
        Thu, 19 Jan 2023 00:54:54 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N33hJ-1oZIlF0O2H-013PPj;
 Thu, 19 Jan 2023 09:54:36 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v1 2/2] dt-bindings: imx8ulp: clock: no spaces before tabs
Date:   Thu, 19 Jan 2023 09:54:21 +0100
Message-Id: <20230119085421.102804-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230119085421.102804-1-marcel@ziswiler.com>
References: <20230119085421.102804-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3lsqMvUjg840JDNVAxsVGyJ9oYSECeJt/YcR4tz5LlvH0MyIZ5M
 8Npt2lmIuRVcgtf1FuK5eoaiXKMvRPsy03Q6VVJH3lsSLnN2gYdZEAWQsDbTE/2rTJmN8Ny
 mDYkTeBq2CZQToy+ImK2B61bskOsXQpfclANoSvv8huslrBWc4l+TwjcPLtnViecnxUt0z0
 YO+I3Wm/IbA8cJEvn3NNA==
UI-OutboundReport: notjunk:1;M01:P0:qsOGRUs7uxk=;6Y32JOM4qSFqYSkH2hCZz0y+qvq
 mJ1LkLzyZYA+62RRpTLon8dPQHTEM7kcQ+Uv3MRxpmGOBfgeNEVd+8Syfg3NOk9xQhdynx6Qn
 SJuPimdg1WPk6B1Gq/aUEOGKeTPVEdT6xIGKhJV3fZIcP1Fa7Dx8heZ8Hwz2EWq5QEW6HEGul
 4pEAcwI+fZmRr9ZQ8q2Qs0VBCkIHd0U8uHWQOFJeVaEamUSQ6WY5pUMHmilzF50Xei9u8OeJC
 qYXrPGjAYUoHl8LA+gDtjBEz1+vgLaE1xB9Z8ONGx/vwXQGOiGAtBnhfxDY8C8P90coxp8PLO
 t8uM8/IDT+7JO0thjFGhiPh6lQwAI3ku/wIcUo1XGLRWZ8qqYP2EyOOpoeUPwj71CL3JfOTQ/
 N8n0FkCRtr7CylHZcl9aeQ+cr+BDnjJylct0Q/r4jPXXfgWYThHgi2hly7kQpwvowLQqIQ8Ls
 cm6sn3cwt1Zg6EGO9DwVQwCHltnL0eD6TK9PXo73Y6r1DqTH9YOmm8bNfP7HezVeOP4c0nq5V
 pq9AoBjgHsodfRxqcwIdEZNJ7qltqSwsYALorkFz7xHGVcy2V/eYzM9sRStMEas2hucfVwq14
 vZ3c66eMjzUYhqNkO4QYBEBcpFCychHW+krZ52AkJhNl0N11gGR0f9c12ERUB8/VG16ZZlxLE
 rzmpa/o3lIQwy6b6Z1CTXqqsOEYoWUpAi/sw6Ssbfw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following warnings:

include/dt-bindings/clock/imx8ulp-clock.h:204: warning: please, no space
 before tabs
include/dt-bindings/clock/imx8ulp-clock.h:215: warning: please, no space
 before tabs

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 include/dt-bindings/clock/imx8ulp-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
index 953ecfe8ebcc..827404fadf5c 100644
--- a/include/dt-bindings/clock/imx8ulp-clock.h
+++ b/include/dt-bindings/clock/imx8ulp-clock.h
@@ -201,7 +201,7 @@
 #define IMX8ULP_CLK_SAI7		2
 #define IMX8ULP_CLK_SPDIF		3
 #define IMX8ULP_CLK_ISI			4
-#define IMX8ULP_CLK_CSI_REGS 		5
+#define IMX8ULP_CLK_CSI_REGS		5
 #define IMX8ULP_CLK_PCTLD		6
 #define IMX8ULP_CLK_CSI			7
 #define IMX8ULP_CLK_DSI			8
@@ -212,7 +212,7 @@
 #define IMX8ULP_CLK_GPU2D		13
 #define IMX8ULP_CLK_GPU3D		14
 #define IMX8ULP_CLK_DC_NANO		15
-#define IMX8ULP_CLK_CSI_CLK_UI 		16
+#define IMX8ULP_CLK_CSI_CLK_UI		16
 #define IMX8ULP_CLK_CSI_CLK_ESC		17
 #define IMX8ULP_CLK_RGPIOD		18
 #define IMX8ULP_CLK_DMA2_MP		19
-- 
2.36.1

