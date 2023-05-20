Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11070A7A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjETMMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:12:08 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E3B9E1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:12:07 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:60862.2032723498
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id C7EB01002B1;
        Sat, 20 May 2023 20:12:04 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id c7a32f856fc44fa5b18de09dc2d1b278 for mripard@kernel.org;
        Sat, 20 May 2023 20:12:05 CST
X-Transaction-ID: c7a32f856fc44fa5b18de09dc2d1b278
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] drm/drm_device.h: fix a typo
Date:   Sat, 20 May 2023 20:12:01 +0800
Message-Id: <20230520121201.332785-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Replace it with if

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 include/drm/drm_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 7cf4afae2e79..8e377857fb01 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -211,7 +211,7 @@ struct drm_device {
 	 * refcount drops to zero, as opposed to via the vblank disable
 	 * timer.
 	 *
-	 * This can be set to true it the hardware has a working vblank counter
+	 * This can be set to true if the hardware has a working vblank counter
 	 * with high-precision timestamping (otherwise there are races) and the
 	 * driver uses drm_crtc_vblank_on() and drm_crtc_vblank_off()
 	 * appropriately. See also @max_vblank_count and
-- 
2.25.1

