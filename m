Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB86945B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBMMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBMMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:21:40 -0500
Received: from smtp-out-12.comm2000.it (smtp-out-12.comm2000.it [212.97.32.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01C6A71;
        Mon, 13 Feb 2023 04:21:39 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-12.comm2000.it (Postfix) with ESMTPSA id 16CA3BA18C5;
        Mon, 13 Feb 2023 13:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1676290174;
        bh=n9Il5foGHa2UtXhGQ9/RSMLE0lilxSavGW560kN+Rys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tImg4YRkQxMjezY4h3ntoiROxMm/ji6SmVnmL1BV0s+sFT4iaI8epRT6am2kGlsi/
         KJwa4s4tmErcovXCukd2U663dX798RRA9z6PwMefLnVnvGLN1k4fiiqXw0k59iVodi
         yWOjGhsHWfMQMuyF1wFthZSSQMvRRwTPIc219zu6fQKQ7T8YMkEHjtt1/4SnfM6QEV
         AZNlyzI93cAZ6yvn7cWjp+OzC9d9aYllhRFkyBG/vbt4OczRxnLo9T9+FOEQ0YEbDy
         AuuOMXIMk14zAYLUv6Bx7eUFMK8Bvjcrr1rFVZvpsJLKCq4TtCuvbKTQN11g09xdRO
         YQ+Yg23AmIojA==
From:   Francesco Dolcini <francesco@dolcini.it>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 5/5] arm64: dts: imx8mp-verdin: add 88W8997 serdev to uart4
Date:   Mon, 13 Feb 2023 13:09:26 +0100
Message-Id: <20230213120926.8166-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213120926.8166-1-francesco@dolcini.it>
References: <20230213120926.8166-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Use the serdev feature to load the driver for the 88W8997 bluetooth
driver.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v3: no changes
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
index 36289c175e6e..ef94f9a57e20 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
@@ -65,6 +65,11 @@ &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_bt_uart>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "mrvl,88w8997";
+		max-speed = <921600>;
+	};
 };
 
 /* On-module Wi-Fi */
-- 
2.25.1

