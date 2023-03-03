Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E76A94EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCCKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:12:23 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD695D773
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:12:21 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:44584.54956302
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id C997C100238;
        Fri,  3 Mar 2023 18:12:18 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-698c9d7bb7-jn5ln with ESMTP id e17eeec910d64beeb9e11491deadb756 for christian.koenig@amd.com;
        Fri, 03 Mar 2023 18:12:19 CST
X-Transaction-ID: e17eeec910d64beeb9e11491deadb756
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   suijingfeng <15330273260@189.cn>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        suijingfeng <suijingfeng@loongson.cn>
Subject: [PATCH] ttm/ttm_device.h: fix a trival typo
Date:   Fri,  3 Mar 2023 18:12:16 +0800
Message-Id: <20230303101216.788971-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 should replace '@' with '*'

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
---
 include/drm/ttm/ttm_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index 4f3e81eac6f3..56e82ba2d046 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -141,7 +141,7 @@ struct ttm_device_funcs {
 	 * the graphics address space
 	 * @ctx: context for this move with parameters
 	 * @new_mem: the new memory region receiving the buffer
-	 @ @hop: placement for driver directed intermediate hop
+	 * @hop: placement for driver directed intermediate hop
 	 *
 	 * Move a buffer between two memory regions.
 	 * Returns errno -EMULTIHOP if driver requests a hop
-- 
2.25.1

