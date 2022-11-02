Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB207616A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKBRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKBRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:10:27 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958481707A;
        Wed,  2 Nov 2022 10:10:26 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7C67C100004;
        Wed,  2 Nov 2022 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667409025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdwS+mYVi4ML2nO4sgk8gy4I60gyxdMdtfIOvOw4A8M=;
        b=Zh8Q+a2CHaJCLr8+0y4ODpmoIy7Lj7udfg+eeAeopyQEIEV10VtWxDL4LiKs/uWuvybKuw
        /CC1Fvg5Jsg4KppD6bbCnngypqP63D9ygBYHPJfF0vq9VDoR7f5vB+j0Oa4b0mMl5x1H7+
        C+IUHA6OpEd0vzLGnCqIqA/cWlMHhCyshMFztn7naTGStmBcXDE0TF/VC2uogRLrZWFkfn
        ideF8FRW/Zp7qFFVHYObwBkulpV1IhG1jgCLlmzFtTUNLitnnxy4323ABQDLobflEPWzH/
        hx1jRngGpiZRGyZ+x0bFvSvzYATUHEHCL2oYcpMvkqW6+L6/iW+KoT6AwqGgcA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     viresh.kumar@linaro.org, Bhavna Yadav <bhavna.yadav@st.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Vipin Kumar <vipin.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>
Subject: [PATCH v2 1/6] arm: configs: spear6xx: Refresh defconfig
Date:   Wed,  2 Nov 2022 18:10:05 +0100
Message-Id: <20221102171012.49150-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102171012.49150-1-kory.maincent@bootlin.com>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Refresh the defconfig to follow the changes made over the year.
I ensure important options have not gone away.
I drop the gpio sysfs config as it is useless to keep it alone without
CONFIG_EXPERT.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/configs/spear6xx_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 3d631b1f3cfa..1cf0621d2154 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -11,7 +11,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_MTD=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
@@ -28,19 +27,15 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_SMSC is not set
 CONFIG_STMMAC_ETH=y
 # CONFIG_WLAN is not set
-CONFIG_INPUT_FF_MEMLESS=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
-CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-- 
2.25.1

