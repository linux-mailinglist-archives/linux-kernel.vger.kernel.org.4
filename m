Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A247078BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEREGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjEREGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:06:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EF2691
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:06:06 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-165.ewe-ip-backbone.de [91.248.191.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95BBE66056FE;
        Thu, 18 May 2023 05:06:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684382764;
        bh=ykNxebUAm9lDoDJh5eZtPhMFHtJCQ0k/c/q1Qf2g62c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyqvOGyeax8LbtVKN4E4q55CHFDDhNw7Ai7ToGJ8Z5KyCUhNflnLK7b98co7awuMO
         ON60w/gaE4/Gca/RDMNqhwWNBuq1BsjUZAMZK4GN0WKLrg6ui3MbwFVZd0Mo63xduM
         OBTUxWoFMhYbFqELqdR+sxn6QmBvOVY9041fSAxuxAlQ15o0bSlBIrX4uPtJjKJefG
         ifJr/GoVjQEpAvigf3gA/tOZZoXK6jPI7vWDhj2/KFe9Z6cQV/LtmI0Si8BAfdyBcX
         XfOzUxIWe0xMr6VJCQMwps1+6xZeTYn4YrSTo1Fweh8a32iJAb1vt5bb9EFSiEnlUA
         We4nBhqsDayEA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0F4034807E3; Thu, 18 May 2023 06:06:02 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 2/2] ARM: multi_v7_defconfig: update MFD_RK808 name
Date:   Thu, 18 May 2023 06:05:41 +0200
Message-Id: <20230518040541.299189-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518040541.299189-1-sebastian.reichel@collabora.com>
References: <20230518040541.299189-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_RK808 got split into an I2C and SPI part named MFD_RK8XX_I2C and
MFD_RK8XX_SPI. Since there are no known ARMv7 boards using the SPI
connected RK8XX chips (which are new), it is enough to just enable
the I2C option.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: c20e8c5b1203a ("mfd: rk808: Split into core and i2c")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 871fffe92187..f0800f806b5f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -596,7 +596,7 @@ CONFIG_MFD_CPCAP=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
-CONFIG_MFD_RK808=y
+CONFIG_MFD_RK8XX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
-- 
2.39.2

