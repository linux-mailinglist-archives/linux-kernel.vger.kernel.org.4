Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD1721814
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFDO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjFDO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:58:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9A1B4;
        Sun,  4 Jun 2023 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aB3s9QvJ9+7W3dD1Je2JBtOaU9cq6G9le6qbeprpRwY=;
        b=UybgA70aecJvDAhIR9l2pj2aX89XNtZBpO+L7iEjkgjmLJHR67GQanX2Yrwc7+k/ANSqKH
        UgxO9WamlpN05iZANjv8tpNx6ZrzZgblJK6nytJJPQ1EsXGqsM9JQ+vPrU3h1/shMzwxQ7
        rp+jCV4tSop2ENSzmckhGcIBKAWMvfU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 9/9] MIPS: configs: CI20: Enable WiFi / Bluetooth
Date:   Sun,  4 Jun 2023 16:56:42 +0200
Message-Id: <20230604145642.200577-10-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the required drivers for the WiFi / Bluetooth functionality.

I enabled WEXT compatibility as well since the CI20 is typically used
with a very old userspace.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/configs/ci20_defconfig | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index a161387f8fce..920b27977dac 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -40,7 +40,12 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
+CONFIG_BT=m
+# CONFIG_BT_LE is not set
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_CFG80211=m
+CONFIG_CFG80211_WEXT=y
 CONFIG_DEVTMPFS=y
 CONFIG_FW_LOADER=m
 # CONFIG_ALLOW_DEV_COREDUMP is not set
@@ -68,7 +73,25 @@ CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+# CONFIG_WLAN_VENDOR_ATH is not set
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+CONFIG_BRCMFMAC=m
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+# CONFIG_WLAN_VENDOR_MEDIATEK is not set
+# CONFIG_WLAN_VENDOR_MICROCHIP is not set
+# CONFIG_WLAN_VENDOR_PURELIFI is not set
+# CONFIG_WLAN_VENDOR_RALINK is not set
+# CONFIG_WLAN_VENDOR_REALTEK is not set
+# CONFIG_WLAN_VENDOR_RSI is not set
+# CONFIG_WLAN_VENDOR_SILABS is not set
+# CONFIG_WLAN_VENDOR_ST is not set
+# CONFIG_WLAN_VENDOR_TI is not set
+# CONFIG_WLAN_VENDOR_ZYDAS is not set
+# CONFIG_WLAN_VENDOR_QUANTENNA is not set
 CONFIG_KEYBOARD_GPIO=m
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_LEGACY_PTY_COUNT=2
@@ -78,6 +101,7 @@ CONFIG_SERIAL_8250_NR_UARTS=5
 CONFIG_SERIAL_8250_RUNTIME_UARTS=5
 CONFIG_SERIAL_8250_INGENIC=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_SPI=y
@@ -191,6 +215,7 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
+# CONFIG_CRYPTO_AES is not set
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-- 
2.39.2

