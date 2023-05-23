Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFF70D247
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjEWDR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjEWDRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:17:20 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2F90;
        Mon, 22 May 2023 20:17:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VjIIOXp_1684811830;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VjIIOXp_1684811830)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 11:17:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Modify mismatched function name
Date:   Tue, 23 May 2023 11:17:09 +0800
Message-Id: <20230523031709.19673-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:426: warning: expecting prototype for sdma_v4_4_2_gfx_stop(). Prototype was for sdma_v4_4_2_inst_gfx_stop() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:457: warning: expecting prototype for sdma_v4_4_2_rlc_stop(). Prototype was for sdma_v4_4_2_inst_rlc_stop() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:470: warning: expecting prototype for sdma_v4_4_2_page_stop(). Prototype was for sdma_v4_4_2_inst_page_stop() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:506: warning: expecting prototype for sdma_v4_4_2_ctx_switch_enable(). Prototype was for sdma_v4_4_2_inst_ctx_switch_enable() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:561: warning: expecting prototype for sdma_v4_4_2_enable(). Prototype was for sdma_v4_4_2_inst_enable() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:798: warning: expecting prototype for sdma_v4_4_2_rlc_resume(). Prototype was for sdma_v4_4_2_inst_rlc_resume() instead.
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:814: warning: expecting prototype for sdma_v4_4_2_load_microcode(). Prototype was for sdma_v4_4_2_inst_load_microcode() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5283
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index bf47eb33c12e..590b08585901 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -415,7 +415,7 @@ static void sdma_v4_4_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
 
 
 /**
- * sdma_v4_4_2_gfx_stop - stop the gfx async dma engines
+ * sdma_v4_4_2_inst_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
  *
@@ -446,7 +446,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 }
 
 /**
- * sdma_v4_4_2_rlc_stop - stop the compute async dma engines
+ * sdma_v4_4_2_inst_rlc_stop - stop the compute async dma engines
  *
  * @adev: amdgpu_device pointer
  *
@@ -459,7 +459,7 @@ static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_device *adev,
 }
 
 /**
- * sdma_v4_4_2_page_stop - stop the page async dma engines
+ * sdma_v4_4_2_inst_page_stop - stop the page async dma engines
  *
  * @adev: amdgpu_device pointer
  *
@@ -494,7 +494,7 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
 }
 
 /**
- * sdma_v4_4_2_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v4_4_2_inst_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs context switch.
@@ -548,7 +548,7 @@ static void sdma_v4_4_2_inst_ctx_switch_enable(struct amdgpu_device *adev,
 }
 
 /**
- * sdma_v4_4_2_enable - stop the async dma engines
+ * sdma_v4_4_2_inst_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs.
@@ -786,7 +786,7 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v4_4_2_rlc_resume - setup and start the async dma engines
+ * sdma_v4_4_2_inst_rlc_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
  *
@@ -802,7 +802,7 @@ static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_device *adev,
 }
 
 /**
- * sdma_v4_4_2_load_microcode - load the sDMA ME ucode
+ * sdma_v4_4_2_inst_load_microcode - load the sDMA ME ucode
  *
  * @adev: amdgpu_device pointer
  *
-- 
2.20.1.7.g153144c

