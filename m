Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DE6626CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjAINVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjAINUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:20:46 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B6F140EF;
        Mon,  9 Jan 2023 05:20:42 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LhPqo-1oSd1j2Fxw-00meCB;
 Mon, 09 Jan 2023 14:20:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v1 4/4] arm64: dts: verdin-imx8mp: unify gpio-key node name
Date:   Mon,  9 Jan 2023 14:20:01 +0100
Message-Id: <20230109132001.43489-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109132001.43489-1-marcel@ziswiler.com>
References: <20230109132001.43489-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9vnF9uJMN7Ya4wOzNxW82Wl+zo12RbC9kQGcna8HKFdryFOYHvN
 8nOzbDSqUfDf6MY2QBlKImT/c0KTVU/FI1TfeQkc9X7AUvmWWisZjDASIPJk6Cc6hSOPxbU
 1AeC63lPz2p4g0havj57EHIAEig+f1OEHiriDRd0FGemoOrao5EyTbQ/FmrdKhRGvTjL2xb
 pJJbJzm1w5d/hkFLEuATg==
UI-OutboundReport: notjunk:1;M01:P0:O5G3HgOHdNc=;a5S54fqnvYJe+4PFuaZCfhev29Y
 g2akxcq5mAXOI9n0Co+jDDyiA9N8xTqv0hggTLSYDno/NdGuYczyxvqRPcdbYdReb/X4mWw0u
 sPaHFj5WLVMUF69U3XX2lc/GQOqpVpW9oB9O82mBGoTCiSPQXhyhK7bmv2VgO+qW6pAl+dgrJ
 zIrtUA3Nw6g4Wwt4O27y+0vY78/GrCEhXXZVYUPpElXeG04oa4OlezP4AnBz0guOhPRNYPPgD
 z6TKPfXoTxsv8e9QNzZVmRdhygxfqc+ucRnAEzPLP/wMV+oDE4+XaRqM+EXUnCXEqZBBrbwOH
 6QEHhAkxZ8emtF6IT1rJxIWuLEToepejIclEOoaF3W09AzKkvHsdtsI1rFnwpkElGmn7iuDgQ
 RuY8BfOurEAdF1wjmy5h4r6HJqHgyApD5+bHiWlpKR+USUqRLwjYMsoyNo/jm+Msn9V7KjnLz
 /oiEo/xmU7GgizRvaggM+KoK3fwxnBZ2vQ2Van02TiGO8NpCvDBC+NNxQ3pnLAJPZ6DmOurQc
 YyG2880gLfHzvQgGHkAlN6iN2mTjrMhUB74nWMEq6JcHFtgNSs25UFwWY1dW4NR+I0FsOkkDv
 S6KgiXZ8mqk4byeauGvkjWJ0jTmYCPlrHUFf7328wZmYLdL5sWgLV1XdINCFFRo30r0B0obFK
 uH/Pasyt3iVn0xErtNtyE1GWNpUiTuXXVOc6vkPdwQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Any other of our modules calls it key-wakeup rather than button-wakeup
so let us stick to that.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 6a1890a4b5d8..0e183c9757f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -50,7 +50,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		button-wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
 			gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
-- 
2.35.1

