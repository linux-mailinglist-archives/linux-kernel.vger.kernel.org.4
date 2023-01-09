Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0B6626CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjAINVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbjAINUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:20:45 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABE1581D;
        Mon,  9 Jan 2023 05:20:41 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdpDh-1oXsDy2kzr-00j5YO;
 Mon, 09 Jan 2023 14:20:18 +0100
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
Subject: [PATCH v1 2/4] ARM: dts: colibri-imx6ull: improve wake-up with gpio key
Date:   Mon,  9 Jan 2023 14:19:59 +0100
Message-Id: <20230109132001.43489-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109132001.43489-1-marcel@ziswiler.com>
References: <20230109132001.43489-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iwk28kDmTbG30NxDFZ0mJdTN6LCOY4Ooop7lbpEK6KbsV9r0HnS
 U9STLh8mM1LMsnhkbhrbZrDVrgmFJhpxxGPaHm4IxX+MBPd+G3/eHZhpUTLtCkbSzl9D8t+
 EY2pRhlLTbX9m8/RwyhDuWjkgK96+kNdd4eV8QL5Y7oWAy/up063N3OqY8ETt71TUm4f6cl
 0s9mxjPNquGf5247YMd3Q==
UI-OutboundReport: notjunk:1;M01:P0:NO27kr/GBQs=;elwqcXqF7YvXGCse2NsLoUSEmVL
 v7wOotcM+ZolSiC5C+5ljq8LT4nrWCRCoYRcuLbBtvbB3jpP1DWe0wbNuj8n357h+NvDktepv
 3sIFa4pZ5aD8XxEMdgZpjqJMRI9chi1DwBy/nnPV+kjx+lV/nfqd28yBHOmpspZxFjptG1o0n
 WTGCHJTt1+UlOVockefrRYn0MmUYlZkimUu5lc2Dm1Lr4olWo60zj7BX/o2/g8ptfxYwj2so0
 a/lf5xGtgGHa4ovGHVobeNNMWRKYP7TOmCxjYgfxfC03uZSyFlTBbkYoENG+dR79XAnd4S8IF
 LrOEuvf/VXIv2f/wayj3awvTySuwDu7LllPk+X4l/KN2avCGb4hz6W/9kaj/990ljlCG3fZVh
 zq6jyxyPKDiB4cCnpOoloxUAuQDgFaOJo3nHa2LA8kV6HuLpMZxwkAdGuo3EBq3JD5AFGxyYv
 1m8OQ+DWsbJlpcMxlda3mNNwmDs/H/1esyTw7h0zyk0Bcf+XW6qnzDWmKQVeDCEByLjP87hxh
 TnX9U/MbnwAN7lbNh4ymmiXtGSkQvv6OxJMYjuB8FpgrkDjX2JgnF8408bQqgiEQyIQH74Ad5
 TqNpAQBGT2xGFQVdxV0uIsZbG6Az2HGPKJVIQ9Y+H6XysB8RB7ZKM6BtXUdEAXZYlgXCATaJ+
 ekK90K/XT88jmes9QtpUTPdFuJnm+lLE9kg5e9GCqA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The pin GPIO5_IO01 externally pulls down, it is required to sequentially
connect this pin (signal WAKE_MICO#) to +3v3 and then disconnect it to
trigger a wakeup interrupt.
Adding the flag GPIO_PULL_DOWN allows the system to be woken up just
connecting the pin GPIO5_IO01 to +3v3.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 336ab2e0534c..368d11ae7a8a 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -53,7 +53,7 @@ gpio-keys {
 
 		wakeup {
 			debounce-interval = <10>;
-			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			gpios = <&gpio5 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
 			label = "Wake-Up";
 			linux,code = <KEY_WAKEUP>;
 			wakeup-source;
-- 
2.35.1

