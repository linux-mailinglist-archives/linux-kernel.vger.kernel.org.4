Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978526626CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjAINVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjAINUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:20:44 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DC140A7;
        Mon,  9 Jan 2023 05:20:38 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPF2s-1pASDk1SuO-004Tkx;
 Mon, 09 Jan 2023 14:20:20 +0100
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
Subject: [PATCH v1 3/4] ARM: dts: apalis/colibri-imx6/6ull/7: proper gpio-key node names
Date:   Mon,  9 Jan 2023 14:20:00 +0100
Message-Id: <20230109132001.43489-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109132001.43489-1-marcel@ziswiler.com>
References: <20230109132001.43489-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nPqbuI/C7J1bZSrjg2lXiQsN9kYiWILVyZZvnntx0SbuE5fu1Nq
 K67SR44XDLliyyw+S0NESd3oRS9kEwY7YcgaJ8J6BJz5H7c+R+SSCMuYUCEnEfjIiyBld+V
 vie2LDKKIb4KRhDKxfWWECSnStep3SFbUgiG4T4hfc+ddymjtDUH5/Dc+6AVrlDDr/XpzeV
 cbnxpj7IQCjR6sHtWGTJA==
UI-OutboundReport: notjunk:1;M01:P0:Y+6qlC/z3dk=;8JbTZlnoTV32NhQFWKITsvSwTd/
 5mkvmtzzgiPF95YYl12YLtPFJnzSFkycJJm5WIWgB1TViifn5BuSqdMBkjxz4hyT5hFlxQriK
 qVX3dtLW7nOiTjqIs+f0ZMBtYNaERa2BHglVyB5MIVSlOiFs2seccQcClXgT9T8C07b3SS/jr
 6K2ZU4InkH24ZMbrMOcou8Gec3x8ZmP+y2hhtz3QFVZHNffZ17UTzYUCU510ED6owNPAbdUli
 xY+frF+wAt1K7KNVosJ3r46HWmQPLTe+6eYiltAn0ewfOgFV8hBid20+CyA391TPsbVpj1dMI
 IGa+3sJY8qa4N/LJn5TKzyh8VSHZzAD15UHm+6AJvE72YCcOB8+juHoDZhwQ2FrjOVCtJBDNv
 LY/Uzm5L3mysj6M1XehNAU7pAVC9e7tPaON3qem4sXNMdu9PhOXY4vcUVvBdXyFIXHwruhR4a
 PO7QY6Zmh7XbFCWKeNep4+gwHvaAbcYYcmTHfCf25Wc22JfbujD640KMD4AHbuPhIY18ud3dn
 4n1vAoJDBxXTOx06gqpsEpVm/r0auxhzanuVNYGwaQz17CGVCQHhFCVvQdE6v8WpxpUl41OhL
 M8Jdy9UszJLKLgT3eqgpNsyLPAMj5hXSm2UEqJGMawrmkW1CGVVmL6W3WJpvhwKvzaiOg9Mg2
 abroARIU7GmA58J+LXFMEDP11/JNJPDFDRrclm2i1w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The node names should be generic and DT schema expects certain pattern
(e.g. starting with key/button/switch).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi | 2 +-
 arch/arm/boot/dts/imx7-colibri.dtsi    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 7c17b91f0965..bb9aa5b7f03d 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -41,7 +41,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 			label = "Wake-Up";
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 9abce6bc6dd4..5c647339f8d0 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -36,7 +36,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
 			label = "Wake-Up";
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 368d11ae7a8a..bf64ba84b358 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -51,7 +51,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
 
-		wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			gpios = <&gpio5 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
 			label = "Wake-Up";
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f8b8372b6851..104580d51d74 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -39,7 +39,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 
-		wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
 			label = "Wake-Up";
-- 
2.35.1

