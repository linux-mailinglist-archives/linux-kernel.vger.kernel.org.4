Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325016715B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjARH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:31 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9D38B52;
        Tue, 17 Jan 2023 23:28:26 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lk6Xc-1okLfr2Hko-00c99f; Wed, 18 Jan 2023 08:28:14 +0100
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
Subject: [PATCH v4 15/17] arm64: dts: freescale: apalis-imx8: enable messaging units
Date:   Wed, 18 Jan 2023 08:26:53 +0100
Message-Id: <20230118072656.18845-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kwlDKTxz2LQEsfdQcwLszuVEN7aZfQEMZ6X3zGMdH3EDcz3FqR+
 Ec4Mi/HU+H+NZJlohABP1qljdrhPNVMz32bmUsJfJ6hZ4ToLYGbDsvITJWewwqBxeNRJbvA
 HYDfY68/4tPLVVgV6cOWqY3/zSum2qzagf5NbPUESraLpamq4Na5Vbs1cHBDzHZVROE2Iv/
 OKva3J475z/F+lIUtpyag==
UI-OutboundReport: notjunk:1;M01:P0:KDOwYFoE6aY=;+WB+abvHxXUBe+e9QdV7rQE2u+o
 kqu7RYY4XH7ScO304MjXlte1UBKUC8yiHThFYvsEhBJFwXRe0LKTO1bO0dPhU7tzKCw04QEtG
 tYthO2TlTPv+cebTAH3bnWOIoeTP5ZmwoJygOm5tr5I++emeyVZwBbK9nj3TjWf7SoV1ZEwBF
 itOCul62HmtMlOOhsAMZxjNftwdP9ifoi1NedLVEdoItgwbITUVJVtgVSlaQ22Y0vh3ZePg7u
 6LPpoDbycYdmlfzhahGVeH4H0JD8FCQIPUcQ+YANW/NBIKMIDK6xTXUQdb3MrHrhSCiccz1o9
 raJ+ZwAm8j+OPMSVThAsK0Q/IIAX2Wc4pJmitDdmNr1cm45BEYvOgtGGnHs4VnaWXJFPKrEQ2
 CGpq5h4Jh0rJEXUzEwwqR5BA2vd0D90683qPVYo6w3SgIOrlF57tHD0dvAm/YHewK2i0Kd3p+
 cX4EDcX/MVqvx72FN3bcEutOm3mbtDZCXmFvUyxa5cDKlXUqvUkFNzbXBhkwf+1Mm6Y3nCZ2q
 atp30xf1TEAfHkSuRVHCTwKErXdmd1VDufn3NdWVFpfmATMyEPgblAqoxLPiIIsmt1s2WR8Zs
 TkSTMYxlq5P66Epk8h9pjqhKvkD5gmRsiGLGNQtv6WicDFxIErMjLS3yWq4QjUAApS8kPhWJO
 QiykRkQel6IvPEuz7lZXErF1hHz+/hfS2ot+PHE7nE5hM1mMkRHcIaqsMt2P8sU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable messaging units aka MUs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch enabling messaging units aka MUs.

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 545618799852..70c00b92cb05 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -684,7 +684,18 @@ &lsio_pwm3 {
 	#pwm-cells = <3>;
 };
 
-/* TODO: Messaging Units */
+/* Messaging Units */
+&mu_m0{
+	status = "okay";
+};
+
+&mu1_m0{
+	status = "okay";
+};
+
+&mu2_m0{
+	status = "okay";
+};
 
 /* TODO: Apalis PCIE1 */
 
-- 
2.35.1

