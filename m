Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91C7078B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjEREGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEREGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:06:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E819A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:06:06 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-165.ewe-ip-backbone.de [91.248.191.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DA2E660563D;
        Thu, 18 May 2023 05:06:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684382764;
        bh=rcWZPaJKzQ3T6T0eUuOhtIJeI1tAXIjOjpi3K5L6sRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0AaBN2Bi4RiHe5dO7O/8SE9fY2vHhGKSwEl8xPaa4S2ewP2vcNBf8otvtnB9RMHi
         haiy6l4XQck3WlJzNMBCV/Tmr3+fnYDQmXI4BP3InxzuJMdQgbRKUs8S+Go2XsY1Nt
         g7prL5imQYy+ikmHDmlX5UpYy99/YTA1f7+wQiMZUxdDqfe1CyfQP1yaX0QKxYoYJi
         +ckMy/2sB+oWwWfYudfr5YK1LzJfyu2sk51H2yF7HAsEwtYkgAGKWOh4lVYqjWZQup
         qe0SjpL4Jyg9ZTK6GpQsRDZTN6H2SLXd1yeugGdH43uaNhkYsX6P4BHyYTphb7ntWf
         pS6ayt+AAGd4g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0D3AF4807E2; Thu, 18 May 2023 06:06:02 +0200 (CEST)
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
Subject: [PATCH v8 1/2] arm64: defconfig: update RK8XX MFD config
Date:   Thu, 18 May 2023 06:05:40 +0200
Message-Id: <20230518040541.299189-2-sebastian.reichel@collabora.com>
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

Update the defconfig for the new RK8XX MFD config name,
which got split to add SPI support.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: c20e8c5b1203a ("mfd: rk808: Split into core and i2c")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..cd69c9ced7da 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -688,7 +688,8 @@ CONFIG_MFD_MAX77620=y
 CONFIG_MFD_MT6360=y
 CONFIG_MFD_MT6397=y
 CONFIG_MFD_SPMI_PMIC=y
-CONFIG_MFD_RK808=y
+CONFIG_MFD_RK8XX_I2C=y
+CONFIG_MFD_RK8XX_SPI=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_MFD_TPS65219=y
-- 
2.39.2

