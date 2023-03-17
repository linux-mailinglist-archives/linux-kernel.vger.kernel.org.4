Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113E26BE33C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCQIX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCQIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DF3344A;
        Fri, 17 Mar 2023 01:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B4FB824EE;
        Fri, 17 Mar 2023 08:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C360DC4339E;
        Fri, 17 Mar 2023 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041350;
        bh=8O4QuVXZ8A7FPD2U3Nkc5z3et0F4wiZvDMcIjCSnRrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFRtBGLRKjUcF/Fmcq6iLIf9PZnd5LDpEdzQ9XUtmPUJ6sRagbrGGRXpHaG3imHGH
         Bq3kM6SuDzu3PbLQKYsvXgQ9ZJBXzvILzNflaVdYCFPjyb8eSaZC8pxiVXApiPx0g4
         McOn9BZAEk+AUF2P5lJvaWoLBUqz1ssWQ5etAFp2Wwz/ADI/wifmPBDzTXscksQkQ/
         yFjpejbFkT/DFTau934rCipSLC8TGVDmvUnPK6fVA8+qNQ3AUJdPd3tZNwQf/zgbrk
         U84/OY2UlThW72APAY69ocE46xCcN/HptNhEl0IySSBcRxOliPNW79TLQtGTfA/zA5
         gjipHLcERZYyw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 05/37] drm/ttm/ttm_bo: Provide a missing 'bulk' description and correct misnaming of 'placement'
Date:   Fri, 17 Mar 2023 08:16:46 +0000
Message-Id: <20230317081718.2650744-6-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bulk' description taken from another in the same file.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_bo.c:98: warning: Function parameter or member 'bulk' not described in 'ttm_bo_set_bulk_move'
 drivers/gpu/drm/ttm/ttm_bo.c:768: warning: Function parameter or member 'placement' not described in 'ttm_bo_mem_space'
 drivers/gpu/drm/ttm/ttm_bo.c:768: warning: Excess function parameter 'proposed_placement' description in 'ttm_bo_mem_space'

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 459f1b4440daa..d056d28f8758a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -84,6 +84,7 @@ EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
  * ttm_bo_set_bulk_move - update BOs bulk move object
  *
  * @bo: The buffer object.
+ * @bulk: bulk move structure
  *
  * Update the BOs bulk move object, making sure that resources are added/removed
  * as well. A bulk move allows to move many resource on the LRU at once,
@@ -748,7 +749,7 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
  *
  * @bo: Pointer to a struct ttm_buffer_object. the data of which
  * we want to allocate space for.
- * @proposed_placement: Proposed new placement for the buffer object.
+ * @placement: Proposed new placement for the buffer object.
  * @mem: A struct ttm_resource.
  * @ctx: if and how to sleep, lock buffers and alloc memory
  *
-- 
2.40.0.rc1.284.g88254d51c5-goog

