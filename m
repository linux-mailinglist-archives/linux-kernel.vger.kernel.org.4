Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942C5B8B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiINPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiINPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:10:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5113DC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:10:02 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0754A6600367;
        Wed, 14 Sep 2022 16:09:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663168200;
        bh=uWfhIj94xNpIhpVyASAmYnEvUVFgfYgu4vMvd86qMK4=;
        h=From:To:Cc:Subject:Date:From;
        b=gmZ1Dzs/Bs7mPmuMnbAyGtg0QdhRaQgIF4nyYAPiaIlpuhIRaBUHTKChqY7puyQOE
         SlE5mFgKW9c5WCyhJuOJFLuRhSaZbQ8PGTe2Epo47CZLaR2zGO1GtM9dX8+Hr622I4
         pOi84l1h8n3jtxUXD9Mk+iUKTsPj80R+7PHXeBxS0W5Ox6IX3ps9YyIn3dJJpUKgfc
         Bhunx1aGvppbRJmmlx9HyueJa6n4JK2WFBMoDe3Kw52euJtaZhXWZaxY8GH/TVuk9B
         428GtEYjj0rdV2SQShDeFAGHkNtVzwYY9uZAdJx5lf9dRm36+powNN2T9AwEDoq7F7
         5onuGU7ENympA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: sunxi_defconfig: Enable display framebuffer
Date:   Wed, 14 Sep 2022 18:09:33 +0300
Message-Id: <20220914150933.212182-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
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

The display framebuffer config options changed in kernel awhile ago
and FB isn't enabled anymore using sunxi_defconfig. Add the missing
config options needed by display.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3d14827e0a31..2241e3d037b1 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -112,6 +112,8 @@ CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_SIMPLE_BRIDGE=y
 CONFIG_DRM_LIMA=y
 CONFIG_FB_SIMPLE=y
+CONFIG_FB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_SOUND=y
-- 
2.37.3

