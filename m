Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE664B7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiLMPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLMPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:03:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA40B7C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:03:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o5so15928649wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QE8TrVlOPagyz/Xf+Vluj5c/1Shf2awMH865U/kgSzo=;
        b=C/D+1izcIet/7EVJRR+V7gM1hheYXcGc9fU6xJvq8OpEfUrdfISAJuzvGCaxG/3gVq
         rmDtB5WFhKizMShvkRA0INKdz9B3LZ9UUyId+2YnixryQO+JQigIkBMgP909XVsQrF05
         v9/xrdgYrXWGZ+CJrkxBe6qcsdWPcXEBaH09Ne847ng0/Qk4N1/30Vv7iqhiLNxnRaEO
         JJOxsDMPP9gtp7/s4OlxHa3v/stCiNDKeqgT9Pgue3fqX8EmFDdB/pOVzFoLfMjcX7uh
         9gG3G/IBY8j7qr0kg8xUy92CEMJAoR93vi8oA1+kBwGsZmfP6UgZQN9m19LHCcSXS2gm
         a82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE8TrVlOPagyz/Xf+Vluj5c/1Shf2awMH865U/kgSzo=;
        b=5VrUNzqcrdZ4pKtnh0O9oV/dZYDSafBORG26VDKCoA1nMukghXcRRkzok/P8lXv3hz
         04RWC+Jx3XqmqdgYeDpjiIx1ENWg5kKL9R3YA07onj44DmkBCfC67isQv0C6cBybJiMb
         JsZvttXjxmcwBvRSBP38QCPKX6MQZAy7TSY5nluyRHUWBZbVbp0t7HSnrUQLTL4B7CQt
         XYMpZwG69x+34JoPuLRCPASP8PX2fE06vjv51GENfcBefph8DMouHia53Eobjwy7U4mV
         6gd/J+KO0pUapRFiEq1SLYpgEUKyjBniIoAXGOTW3nZGQnSxEtKRQqhccI+Gj65SLK7Y
         MVAg==
X-Gm-Message-State: ANoB5pmUHoiNqY+yw7liKQZhHabeoeV255Boti6mb2DINqt87WdJES3a
        InCMzR2+rjlRg4ldK54zHBj7dA==
X-Google-Smtp-Source: AA0mqf4EcXdCATRa0h1bfkO4Qau6rGAOKEKsaonqVOfzHUcWixwCeWZLyX1BCyZnzBymrk8MHvKjlw==
X-Received: by 2002:adf:ee88:0:b0:24a:9b90:b621 with SMTP id b8-20020adfee88000000b0024a9b90b621mr11428556wro.30.1670943795967;
        Tue, 13 Dec 2022 07:03:15 -0800 (PST)
Received: from prec5560.. ([2001:bf7:830:a7a4:b85b:2e8b:7dd0:999e])
        by smtp.gmail.com with ESMTPSA id s16-20020adfecd0000000b00225307f43fbsm15953wro.44.2022.12.13.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:03:15 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v1] drm/bridge: lt9611: Fix PLL being unable to lock
Date:   Tue, 13 Dec 2022 16:03:04 +0100
Message-Id: <20221213150304.4189760-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes PLL being unable to lock, and is derived from an equivalent
downstream commit.

Available LT9611 documentation does not list this register, neither does
LT9611UXC (which is a different chip).

This commit has been confirmed to fix HDMI output on DragonBoard 845c.

Suggested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index ffcdc8dba3798..3ce4e495aee50 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -259,6 +259,7 @@ static int lt9611_pll_setup(struct lt9611 *lt9611, const struct drm_display_mode
 		{ 0x8126, 0x55 },
 		{ 0x8127, 0x66 },
 		{ 0x8128, 0x88 },
+		{ 0x812a, 0x20 },
 	};
 
 	regmap_multi_reg_write(lt9611->regmap, reg_cfg, ARRAY_SIZE(reg_cfg));
-- 
2.34.1

