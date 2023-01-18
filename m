Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A381D6715B9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjARH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923D38B45;
        Tue, 17 Jan 2023 23:28:22 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LufTy-1oa0tn2Zgu-00zoob; Wed, 18 Jan 2023 08:28:04 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 12/17] arm64: dts: freescale: apalis-imx8: analogue audio comment
Date:   Wed, 18 Jan 2023 08:26:50 +0100
Message-Id: <20230118072656.18845-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xgilT84UosodsS/XUyvQ3O92wRUDbt8tA9Ngr6iFoa/LXapun83
 90RSGsFvFvypfkGN42wFr7N5XqEt0cNGcyHh2+2Keu1xNrJCxll0Z6ZYa+h1puRZ8JuU/15
 mWaU6HRt5e2EkJPlkndFyrLztuSfxzn2KanjPHhAZ1tXsvi/xFjb8s18sEcO05p3NKKJ80c
 AeKnqYbi53UvXZTHtXwEA==
UI-OutboundReport: notjunk:1;M01:P0:Yr/c8WmhEuI=;rhrGNJC2Bp4MK1VXTs3RoOi+H8N
 OYiszrwJXGqwAjqUh22ejKacsWZwo9y/TRcSXGPYa9CJrW2xHXOB7sOlbT2Br6WdpdHGJ2YlH
 pdqm4vq4y4+K4u5mf+u8jyIVE/8JrxPSz4gxTLAUIMw4HYZIMqOBc72AvoR5ioyTSLubjElTC
 bvWCQDJ7/mfhxdqeQu62E/qP/N8l2RFlcROvwsOy2KE3sgHEEaUfTwgZJYH6wifLILPU8c/nq
 iIMRB0StJ264+1RuBMzEYJ9KzSA8YTf8r+BEXbNN+jfAxASc5+V4rvbMSyk0tWYNeSnTbNIxG
 UpbhbLkXDv5V/7dOlUnjRsYFSWI/y5/QDQylcCPrmFi45LxbR+xJ8KJxnWpLOWKLBT5mZOsLx
 NvjvcH5ajIzIF57KWrxa9T9IffHCiUiOU1IzAZ79G2SkWoy1HmzlyC2b8WXQejxOdjIFCOZq3
 Bjxy9i5RAQN+7UuRLh8tdFnuOLab+GtQ/5s3IoZlNMIDrPDNUDsq42y8yOmAwfJibO7mxF34y
 dFHyHO5ShJQZ/hTs86ytqq2gLbxY1Py90rwthhyv0cNH4edBzznIK+LKmWSwt+GjTihNvXieX
 rC2gK8nT+a6HXVdcG/2mUIS8fYM4PGgE98Jt5cLoc73yXf+eETqcPlpZ+mwC2lZTZLIyLtHOI
 ke9sEkSWBf+X2yVi93E9t+fcg993tg0YrgHOZAuyr8yoJxsj053bK7byqMv2O2I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Added a comment about Apalis analogue audio being another todo.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch adding comment about analogue audio being another todo.

 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi       | 2 ++
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi       | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 25342c886144..060454f25c98 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -110,6 +110,8 @@ &lsio_pwm3 {
 
 /* TODO: Apalis DAP1 */
 
+/* TODO: Apalis Analogue Audio */
+
 /* TODO: Apalis SATA1 */
 
 /* TODO: Apalis SPDIF1 */
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index e720644d6892..caaafc9900a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -186,6 +186,8 @@ &lsio_pwm3 {
 
 /* TODO: Apalis DAP1 */
 
+/* TODO: Analogue Audio */
+
 /* TODO: Apalis SATA1 */
 
 /* TODO: Apalis SPDIF1 */
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index d33c841515ca..5bc55a58db97 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -231,6 +231,8 @@ &lsio_pwm3 {
 
 /* TODO: Apalis DAP1 */
 
+/* TODO: Analogue Audio */
+
 /* TODO: Apalis SATA1 */
 
 /* TODO: Apalis SPDIF1 */
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 12ab749cc949..4c88678e2bc7 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -682,6 +682,8 @@ &lsio_pwm3 {
 
 /* TODO: Apalis DAP1 */
 
+/* TODO: Analogue Audio */
+
 /* TODO: Apalis SATA1 */
 
 /* TODO: Apalis SPDIF1 */
-- 
2.35.1

