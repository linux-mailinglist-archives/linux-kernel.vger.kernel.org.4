Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974406CD7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjC2Kbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjC2Kbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935DF4697;
        Wed, 29 Mar 2023 03:31:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVTBW053326;
        Wed, 29 Mar 2023 05:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085889;
        bh=iex5qyliMq2Kt/A4FkjflgasDUlNCyGEwIwcs3aI2A0=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=yE6TyrKuwEwtY3v/tT+euE1VmgWyv/wPAXWY9iyOTcPGzQcAlB/nvOuE7Na6Xp1DS
         rS6FpceQ0T/exBq24wnJPPER2NihKvoUTzADbntmWZFgPyxMgvSGPRo3BSFsdVDFvy
         iUg1qO7XQs1toPjfjRpdpcxbXr/QiDovwTxtCtTI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVTfM050989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVSgl020131;
        Wed, 29 Mar 2023 05:31:29 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 29 Mar 2023 16:01:02 +0530
Subject: [PATCH v9 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v9-5-6d937efe4ec4@ti.com>
References: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=89iMQQ1UzhGpsP8Ub7JZE+Zeru9HloZUwbHrSaYxdwE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBN486rSmIyYtSoC4+gvR4Eb+E3cGi8Z15A1C
 OKjaxD7Gl2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTeAAKCRBD3pH5JJpx
 RY9KEACxspX2GR8tmdwDDZEIzfFkxtNsqztb5vEWHZxgYWfT4ZDTye0S9X+UFHweiFJfujQQ6JI
 DyG6AYuaReuaFoLEs58BU3VSUVJM1qTwlV1kdVnS0FjPGYBAjkHZmabXxaUPlputXw1qvpV5rMs
 KbnFzXYJ43WmdVye6LI/h4QxoWpT6MolnF/q4yNFgFnTIqMK6jscJh3GSjTaSU0iRhRU6v650vl
 j9xKEQs0X+yUHLl7zW7ejFvFPRX37KO+vkcWYEbqZ07qPyOlqcm3AVADdDU2Zdghv5uA15+mN/A
 EoXNpFVgDL7CteffNF7cCIVMl6GcIz8ctIQzAzn9SJPRF6+u6Jd2KRyZ9myeEwYMEu/Jq+yYp/4
 CqV5tVJzbL/EcLT149HrvJn36iWK7G7qUbgJEvJX2B37g3RTTGmG+0u31Co3uGbY4wupR09IUoG
 5vKKgGY2mr46Ddte039s38MBwK3vcCQGLyXItY6dQ5HOzAlNMhRGm0s7x8WTcRSO40Pi8NJtynJ
 hn7Q0GRljUUnwzhVMN6DvOeu6JfW1K44xc9a3v2aE5/wc8AinQ31RitQDsPVJ5QBCr8MgyyscmA
 1uVVK4icPXZRkSexqovdLUpH1M4e+9yyh9s3l7++jHNzNwHHvZ13L5SSUnzb40g6hkoH7ZnicDw
 4EkL9evfRQ4JxsA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
TPS22965DSGT which produces VCC_3V3_SYS. [1]

Link: https://www.ti.com/lit/zip/sprr459 [1]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f6a67f072dca..2296d656323c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -77,10 +77,10 @@ vcc_5v0: regulator-1 {
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: regulator-2 {
+	vcc_3v3_main: regulator-2 {
 		/* output of LM5141-Q1 */
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_sys";
+		regulator-name = "vcc_3v3_main";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vmain_pd>;
@@ -99,6 +99,17 @@ vdd_mmc1: regulator-3 {
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
 
+	vcc_3v3_sys: regulator-4 {
+		/* output of TPS222965DSGT */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";

-- 
2.40.0

