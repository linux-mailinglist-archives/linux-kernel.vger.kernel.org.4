Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F86B7B05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCMOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjCMOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:50:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACE6A429;
        Mon, 13 Mar 2023 07:50:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DEnjW1049188;
        Mon, 13 Mar 2023 09:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678718985;
        bh=Cm4fxL8aqP+M/xiJppfBdfZbTdZp5e43WLIPjo0QZ38=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oMKDdwaPvkeQL+WKydMkJyqLIqKzIt0tXvTxGiIKCzPvDngdiO/7WVJAE4u1MFfJ4
         5ijWXb8Algbme+BWU53IA4y2o71R1vBERrfUyoE0uQT1/jgNCDB0iETQIA71yHqtuz
         ZZlhyRqysq1GewOO1nfO+/7fEFQrevkHE3l4UM+k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DEnjwf127745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 09:49:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 09:49:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 09:49:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DEniDJ010691;
        Mon, 13 Mar 2023 09:49:45 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
Date:   Mon, 13 Mar 2023 20:19:34 +0530
Message-ID: <20230313-mcasp_upstream-v5-5-d6844707aa8a@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=8FGf5SMnjUpyVTelFPfg4Qsiky79X6LMQvgpym9Ks7E=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkDzbWhY5Br2DuJyYgMrLp6KbL8hSICDZc4JsI3
 zH7pmFxlkuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZA821gAKCRBD3pH5JJpx
 RY/JEADWFB0xBeszY03V6z82hBrxGooUW5O40v2maBDWV6y6lTl6wV4hFA//qkIAMa5gyCdPVSL
 IejfuBTcs18w3TOgaSOtCwokTtQzR8PN8OQeo5y/gQ3O1efxK1Qub15AY+kKbCy40H+yeLYE86T
 /XoASTnU06VT7PMBlachv0fZjuXAMcKa8vf+Se6s6XqdMgk+dbfGfTJnhkCTQbrEp72HawctSI1
 KtDHHG/0BumtNs58XURTk3wgbTgIMSZzKsPGJkoPXYxhKSqz5dCfCJIwOU42c3gWF5w+mg2c9fp
 D75S/1MpCVCPVg21bFcM13+9nxoIeSva2zOci7yVy0ItxG6znys1PkwJz3OQfVpHvsBW3NMjaUA
 KiXEQI03Y5QUGK2NXqXIUt51uK6fnDQXkEj1u3NoR3SfetsbVvQrUl+CKjnIbo2qCxF0ZbGoX3k
 cQyiKG3O9CZdfm9l99xLF9n2PxsEUF/i5LjLvJGomJmsj1mQTXuUCl0YfSnHdx1Bu/T/xWQ+u0U
 Lh8+lgrS2xdFvkn86ylnadegMsVVEthfi7JeDQNSooIby3t+OpNVmUUJtxcOV/saQMYjIcYoK7g
 1BjKmmVqlMqBnMj8BQFxAfYzS9nVwveQ2KbtwfabxJJc/qWpipf+7//LrFJI4OR5P70OGVwzV63
 9tSsy7EAqDnvzLA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
TPS22965DSGT which produces VCC_3V3_SYS.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 5c9012141ee2..063e69e45163 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -76,10 +76,10 @@ vcc_5v0: regulator-1 {
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
@@ -98,6 +98,17 @@ vdd_mmc1: regulator-3 {
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
2.39.2
