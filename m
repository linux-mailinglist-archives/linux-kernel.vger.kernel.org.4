Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A976660480B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiJSNsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiJSNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:46:55 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A6178B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:32:20 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 94314E000E;
        Wed, 19 Oct 2022 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666186337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CehQOdR4v7DxsG/sDIwF8vh4xeli0PmHWYqfNFH0Nwo=;
        b=KGuID9FlBX+Cb7yVGGD5TKDL1LO7FHkk2hV+V+KD5MVKqyFq+/iIMA17P7T4ocgsGdqAph
        l++hQOf/+YEoWWgrI4/WxN0pfOTlS1tTpO2fFmcjqG2Uf4Y2Aosf1bZ4xk0VQfYlTGJVkw
        FpjdiJ9IgzXePSGm45RoEwIDKvFHl4uMI9R+QerPDqHEhtZD6lBTy3VXey7+5yXrgNxsOU
        /FC8+8UASGVvxzWFk0Y4Vm13z0ZDnxeaYt6pmdscqWMxq2RMRTwoBym1uAgnK+IoJmpa9r
        dIQiz9kh70t3HA13YQ8Nc5Kf/EZS4ZGGiB6l6ASNy5jirYUXjq9VOSeMJgGYzA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com,
        Kory Maincent <kory.maincent@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display controller
Date:   Wed, 19 Oct 2022 15:32:05 +0200
Message-Id: <20221019133208.319626-4-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019133208.319626-1-kory.maincent@bootlin.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Enable the PL110 DRM driver, used by the spear600.

CONFIG_I2C is dropped from the defconfig as it is selected by CONFIG_DRM.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/configs/spear6xx_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 1cf0621d2154..231cbd2ac536 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -32,7 +32,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
@@ -40,6 +39,8 @@ CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_DRM=y
+CONFIG_DRM_PL111=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.25.1

