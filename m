Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8E6D9E59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbjDFRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbjDFRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E86A24B;
        Thu,  6 Apr 2023 10:18:25 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B0EE66031C8;
        Thu,  6 Apr 2023 18:18:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801503;
        bh=iPoOGVI0NPGMRksIN5FgAEe90yrWeul7So9tDiTWunw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0UEvyxWgXK+xlhyFK+rykswWjx4HC7FaJCFzDKdHPxhs3jJBW8ta1crGasexRz6v
         km0usz6dHX/Va4qMD4KKl8ox0TNPmT+H1JAOTExiJvMB5/J5N3nLZ7Gz6JhDSWXReP
         ICyh3PFZ73wD6UiEiBRvHN7GFzB5OqHdr7jHkKIGnE4mQ4ZlH2PMVOfFCbZA1h2jKf
         5GeitLYgQhfIsUqyDeTHfD0/6OOqm4/xBaZ3xi2xCkfm9QDvZ0VYR/VfD8KUbNzQel
         dwxxbW3t387Za1FNQESm1tSLYJDGAWMn3bliax/hHcmK658RPR6N3c1BypKnho2pEj
         E6TvKx9iLnGGA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 4/8] regulator: fan53555: Remove unused *_SLEW_SHIFT definitions
Date:   Thu,  6 Apr 2023 20:18:02 +0300
Message-Id: <20230406171806.948290-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b61ac767db4d ("regulator: fan53555: Convert to use
regulator_set_ramp_delay_regmap") removed the slew_shift member from
struct fan53555_device_info, hence the {CTL,TCS}_SLEW_SHIFT definitions
remained unused.  Drop them.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 4d2104c3a077..68ebcd4ccef7 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -49,7 +49,6 @@
 /* Control bit definitions */
 #define CTL_OUTPUT_DISCHG	(1 << 7)
 #define CTL_SLEW_MASK		(0x7 << 4)
-#define CTL_SLEW_SHIFT		4
 #define CTL_RESET			(1 << 2)
 #define CTL_MODE_VSEL0_MODE	BIT(0)
 #define CTL_MODE_VSEL1_MODE	BIT(1)
@@ -60,7 +59,6 @@
 #define TCS_VSEL0_MODE		(1 << 7)
 #define TCS_VSEL1_MODE		(1 << 6)
 
-#define TCS_SLEW_SHIFT		3
 #define TCS_SLEW_MASK		GENMASK(4, 3)
 
 enum fan53555_vendor {
-- 
2.40.0

