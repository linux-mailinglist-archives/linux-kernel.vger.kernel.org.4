Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B575E686E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiIVQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiIVQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:12 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269BB3D5B7;
        Thu, 22 Sep 2022 09:30:03 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MKc4m-1opl4T2Mvs-00KwDC;
 Thu, 22 Sep 2022 18:29:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
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
Subject: [PATCH v1 2/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: improve include notation
Date:   Thu, 22 Sep 2022 18:29:19 +0200
Message-Id: <20220922162925.2368577-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PuQRDOR8VvDFg1xI58AeMYki6yUe1I1m6CuCz3h3gxPa1oGMv8o
 aBonZ8xrVJJWAnY8oao/NLzfHk6Rk3ttIXMNSPjQQZAwXII/F/MCouFAK5LWf43F0qSv9VQ
 knmYIw3sIXZWYYQ3X9qK5ef/B0mN0iWtH+1e74U6GtyfNVUEWwMEDbGWjibpXaJKXTz4YT9
 cBOi7KfCKqvbvWwp4MGsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQogiISofKQ=:b7APyHzvPXgMKQzt8sp1/S
 U22ci+ZYzwZSew2LM5LPe8EK+XoKfK9BZeMo80ciGE+fCW6tAbKBmaZZEUZgm/lH25PrydUk7
 v5g1gj4d806UTK1H0ZoOiFRD7vGYqS3OqcdZwX6lqwwsVydJniDARBqRMBascSSUIK6fDMU/r
 LPc0dMxOxCaJYini3ZlunUzlNP6phV0w1NMSyP+lj2xlAGjTXRTQs2KK4B5vUheny+piir+Qk
 7DTtXcbyHtbl6hu08a1jliFMKbSuJptUBnh4OfezDd9rJfbk2386+9Bw/d9PgVeSADEXJB21O
 mDTqflUNjmu/u0mYk+fefCQDNRxY6kko9L1yyh2+ppPELvS9Oxjz07udq4XxUUla9xjfsdadG
 zIySDgbJ8s74+VSDOVVzJh1vVsK7ir2/Dp/4uwJjmh18E0xKO0iSpJYsTWNnwQyteleJjSDQj
 TcXSVOGskJaV5YnIsK06htgAMUTmy5x/6hcyGCoTeunn44z/EVhMJNBn9FB9moF8sQHjV6yG5
 iO3LDd3AXNdg5XfUOB3b+ZaHEtiv8xXNzGAZmwtCDE6l4SahyTLCpouDa/PJ0RvtZVZmxe4ro
 t15dPz+iZ7ecLq0Y1J7r1C1CS/nf7pB0+bCOY82vRM9vcgQN3iij8wDt6v5DrQ+RKbxPMZ+oP
 BhA9wXZNS0e7FKi2Ymz5aDW/1L9fPJdxNlZiSBNXLeMoY3ab7W+y2NAWZlS/VwJlDlrKgpvtp
 EKFMwKbWNvLKSLiJZN1CZb7D9Xy6xB4ttov8U9BF0D1U52VCMB2YxU0OkXR2gwID877LHqLWQ
 xl8xlnF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Improve include notation. Usually only dtsi files from the same location
are included with an absolute path in quotes. Others should use a
relative path enclosed in angle brackets.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index b379c461aa13..a749d063c367 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -3,8 +3,8 @@
  * Copyright 2022 Toradex
  */
 
-#include "dt-bindings/phy/phy-imx8-pcie.h"
-#include "dt-bindings/pwm/pwm.h"
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/pwm/pwm.h>
 #include "imx8mm.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 360be51a3527..ee4231d138fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -3,7 +3,8 @@
  * Copyright 2022 Toradex
  */
 
-#include "dt-bindings/pwm/pwm.h"
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/pwm/pwm.h>
 #include "imx8mp.dtsi"
 
 / {
-- 
2.36.1

