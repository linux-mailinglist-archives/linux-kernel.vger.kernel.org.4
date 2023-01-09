Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0B6626C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjAINUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjAINUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:20:33 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA07B1F2;
        Mon,  9 Jan 2023 05:20:31 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVNsG-1pGc7M491y-00YgcH;
 Mon, 09 Jan 2023 14:20:15 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v1 1/4] ARM: dts: colibri-imx6: improve wake-up with gpio key
Date:   Mon,  9 Jan 2023 14:19:58 +0100
Message-Id: <20230109132001.43489-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109132001.43489-1-marcel@ziswiler.com>
References: <20230109132001.43489-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6y1cfSpqEZ9wRkfdX3Y020ea3gH+k7UBkwdukIQsHIR2Jr5dVms
 ffe+yN7qTiVCZruM88hL63mbubt0KL1A0MPDAYcW/T/N+du0HFojZu56DWq4aakfsstXjr2
 qAZHQeIXiy9XJhebz503NrVx4KBBVbF2EVAU1tQuo7xEe4QTMlUW0UUeb+etsLEwpe1aA8i
 UW2PJk2cFDBaEgkSv/ueQ==
UI-OutboundReport: notjunk:1;M01:P0:mMzeISvpHW8=;Kiqq4GP+6yZUaqHWbvsd7fLv1iS
 5Ti95blx3G+vVKUCW2gc99JhSCjo8nhVe42x/m2PACVJAFWPKj55TI8AZDZCQTwrjG3s+JBrt
 q9qVdhOHFxMzmZxu5y8WTtKAtXDwiYs7DL71wa+ECmMOWPplEhPaD71Zbds//Vf+JoERrHfFL
 /PLdDm0lYy+bi2MFspO1xRcuh0XqNiusIZKPOtj2kC00iN3730Y09yxgzpg+cqvlrJyizq6b/
 aq2SVW1hyOabE8Nh+laGYOI5CWETvhA6f2N+1cBSxxgNbkA3zPv6HqHUs9LeDC1Kk58xKu9J1
 WJang0UAZuYxAWAGfE5xwRNp031wA4S0ptj4dO1AoYVO6cTfqsz+kiC4bBZ6AWgr7WGSZ4+Yq
 ffXLDRW/dJGvpdHrBKEc6BRc8fqwK6+h4LTq6Ns6i5RSrm3akoWMLiki1lcc4aNwyXHeXc4sb
 gKg+NtexwQ4grBF7RpxebkpTTDPeURfadqk/y2G87TEcggnTODL289P8dBHxc4SuhK2y5e8xj
 BSSgV/leiqKGmYLydmW81koOWFB8zT5ttupEc458lOKDf3TdkR5bdXI5BucZDLjAg/qCEKNU0
 BQyuQMU2l6E4rdjPkhcG3Ou4to8EQqfveeX9QhYr6z38L4alWqb2k6i5jnRMEf5XD97k5Fe9r
 k22GLe07NcWC6Dw9IM84qpdQuak3IhRqMXSlT6hcxg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The pin GPIO2_IO22 externally pulls down, it is required to sequentially
connect this pin (signal WAKE_MICO#) to +3v3 and then disconnect it to
trigger a wakeup interrupt.
Adding the flag GPIO_PULL_DOWN allows the system to be woken up just
connecting the pin GPIO2_IO22 to +3v3.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d8f985f297e4..9abce6bc6dd4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -38,7 +38,7 @@ gpio-keys {
 
 		wakeup {
 			debounce-interval = <10>;
-			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
 			label = "Wake-Up";
 			linux,code = <KEY_WAKEUP>;
 			wakeup-source;
-- 
2.35.1

