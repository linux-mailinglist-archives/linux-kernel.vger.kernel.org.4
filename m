Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FFD6DD7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDKKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDKKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:20:46 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F0118E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:20:45 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id jNLe2900Q1C8whw01NLef4; Tue, 11 Apr 2023 12:20:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB6J-00Gaa3-Iw;
        Tue, 11 Apr 2023 12:20:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB78-00EHKO-Ky;
        Tue, 11 Apr 2023 12:20:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@rox.of.borg, Xinhui <Xinhui.Pan@amd.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] drm: Spelling s/randevouz/rendez-vouz/
Date:   Tue, 11 Apr 2023 12:20:36 +0200
Message-Id: <fd7c23298f2c62db85abc9114d12059ef5e5f330.1681208396.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <50439958420f91cc97ad929437334bfb19ca4d90.1681208396.git.geert+renesas@glider.be>
References: <50439958420f91cc97ad929437334bfb19ca4d90.1681208396.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "rendez-vouz".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/drm/task_barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
index 217c1cf21c1ab7d5..59ead429acb2afb0 100644
--- a/include/drm/task_barrier.h
+++ b/include/drm/task_barrier.h
@@ -24,7 +24,7 @@
 #include <linux/atomic.h>
 
 /*
- * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
+ * Reusable 2 PHASE task barrier (rendez-vouz point) implementation for N tasks.
  * Based on the Little book of semaphores - https://greenteapress.com/wp/semaphores/
  */
 
-- 
2.34.1

