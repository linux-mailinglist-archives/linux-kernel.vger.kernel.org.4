Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E26415F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLCKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:37:32 -0500
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE94F18E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:37:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670063848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMLUb+E2eY8IU4urjjOzs8qfoffBxNSls4NICbVLdyw=;
        b=LuI/WEydRa3watfdJZxlZwsTI4MIH+eVfLj9ZcWdrajWJV+REZUcbt6X7/40x4KAv7HQ/c
        bv71dDPzLSXNck7VVIec005GAbaxPtEoBkO9WKjwOYvb75FcISpiOLFRTB5eaveZovPiAh
        nQtzN8QHzEaXMl9/03tq48vEDaB1abc=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     tzimmermann@suse.de
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Danilo Krummrich <dakr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH linux-next v2 09/10] drm: Remove some obsolete drm pciids(tdfx, mga, i810, savage, r128, sis, via)
Date:   Sat,  3 Dec 2022 18:23:00 +0800
Message-Id: <20221203102502.3185-10-cai.huoqing@linux.dev>
In-Reply-To: <20221203102502.3185-1-cai.huoqing@linux.dev>
References: <20221203102502.3185-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 399516ab0fee ("MAINTAINERS: Add a bunch of legacy (UMS) DRM drivers")
marked these drivers obsolete 7 years ago.
And the mesa UMD of this drm driver already in deprecated list
in the link: https://docs.mesa3d.org/systems.html
3dfx Glide-->driver/gpu/drm/tdfx
Matrox-->driver/gpu/drm/mga
Intel i810-->driver/gpu/drm/i810
S3 Savage-->drivers/gpu/drm/savage
ATI Rage 128->drivers/gpu/drm/r128
Silicon Integrated Systems->drivers/gpu/drm/sis
VIA Unichrome->drivers/gpu/drm/via

It's time to remove these drivers.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 include/drm/drm_pciids.h | 112 ---------------------------------------
 1 file changed, 112 deletions(-)

diff --git a/include/drm/drm_pciids.h b/include/drm/drm_pciids.h
index b7e899ce44f0..90e8abc08653 100644
--- a/include/drm/drm_pciids.h
+++ b/include/drm/drm_pciids.h
@@ -700,115 +700,3 @@
 	{0x1002, 0x99A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARUBA|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP|RADEON_IS_IGP}, \
 	{0x1002, 0x99A4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARUBA|RADEON_NEW_MEMMAP|RADEON_IS_IGP}, \
 	{0, 0, 0}
-
-#define r128_PCI_IDS \
-	{0x1002, 0x4c45, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x4c46, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x4d46, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x4d4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5041, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5042, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5044, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5045, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5046, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5047, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5048, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5049, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x504F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5052, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5054, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5057, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5245, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5246, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5247, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x524b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x524c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x534d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5446, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x544C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1002, 0x5452, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0, 0, 0}
-
-#define mga_PCI_IDS \
-	{0x102b, 0x0520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MGA_CARD_TYPE_G200}, \
-	{0x102b, 0x0521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MGA_CARD_TYPE_G200}, \
-	{0x102b, 0x0525, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MGA_CARD_TYPE_G400}, \
-	{0x102b, 0x2527, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MGA_CARD_TYPE_G550}, \
-	{0, 0, 0}
-
-#define sisdrv_PCI_IDS \
-	{0x1039, 0x0300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1039, 0x5300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1039, 0x6300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1039, 0x6330, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_CHIP_315}, \
-	{0x1039, 0x6351, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1039, 0x7300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x18CA, 0x0040, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_CHIP_315}, \
-	{0x18CA, 0x0042, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_CHIP_315}, \
-	{0, 0, 0}
-
-#define tdfx_PCI_IDS \
-	{0x121a, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x121a, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x121a, 0x0005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x121a, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x121a, 0x0009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x121a, 0x000b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0, 0, 0}
-
-#define viadrv_PCI_IDS \
-	{0x1106, 0x3022, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x3118, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VIA_PRO_GROUP_A}, \
-	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x3108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x3344, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x3343, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x1106, 0x3230, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VIA_DX9_0}, \
-	{0x1106, 0x3157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VIA_PRO_GROUP_A}, \
-	{0, 0, 0}
-
-#define i810_PCI_IDS \
-	{0x8086, 0x7121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x8086, 0x7123, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x8086, 0x7125, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x8086, 0x1132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0, 0, 0}
-
-#define savage_PCI_IDS \
-	{0x5333, 0x8a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE3D}, \
-	{0x5333, 0x8a21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE3D}, \
-	{0x5333, 0x8a22, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE4}, \
-	{0x5333, 0x8a23, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE4}, \
-	{0x5333, 0x8c10, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE_MX}, \
-	{0x5333, 0x8c11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE_MX}, \
-	{0x5333, 0x8c12, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE_MX}, \
-	{0x5333, 0x8c13, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SAVAGE_MX}, \
-	{0x5333, 0x8c22, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c24, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8c2f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_SUPERSAVAGE}, \
-	{0x5333, 0x8a25, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_PROSAVAGE}, \
-	{0x5333, 0x8a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_PROSAVAGE}, \
-	{0x5333, 0x8d01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_TWISTER}, \
-	{0x5333, 0x8d02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_TWISTER}, \
-	{0x5333, 0x8d03, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_PROSAVAGEDDR}, \
-	{0x5333, 0x8d04, PCI_ANY_ID, PCI_ANY_ID, 0, 0, S3_PROSAVAGEDDR}, \
-	{0, 0, 0}
-- 
2.25.1

