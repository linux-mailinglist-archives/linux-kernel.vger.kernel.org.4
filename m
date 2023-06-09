Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56357292DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjFIIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjFIIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5444B4;
        Fri,  9 Jun 2023 01:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4816549F;
        Fri,  9 Jun 2023 08:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C945C433D2;
        Fri,  9 Jun 2023 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298702;
        bh=bV0AjXaMBOwcPgHZlva/QwT1Ny6xhO6iUTwyI835e2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVmvOWAKHoSKy8W4/gtTWa2vmeBm71dB7jn1ZBGFZkt9iV5nxTuJ1hFNnfsYsiS/g
         oD9ijSARaf23ncovhmQiYacLkhDfx/veUHaqtLYH0J705hOluSpXHCySiObjtwS5eX
         9bMgQlCjF2E3Ejj6z8N/TtXoZ94MAJxZjXdBkMDjkXJSWTaJfX0k4JlXsDymLUn996
         foYeDcypwz1yMgB3H0zt/Ku0Avq17EhTia6d/IMzByP+GP1JCe5xE9uumkIMkHpWUm
         yTOT6xnI6YKKtz0H8QEan94neI4B736hA/SE97cMpEDLXyUSzChc9X4qPLE1AYj/ly
         1rGC7mqgyIB9g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Stanley Yang <Stanley.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RESEND 15/15] drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function headers
Date:   Fri,  9 Jun 2023 09:17:18 +0100
Message-ID: <20230609081732.3842341-16-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'job' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:945: warning: Function parameter or member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1124: warning: Function parameter or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3b03dda854fdc..8cd7abe74e6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -233,7 +233,7 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 			amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
@@ -936,7 +936,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-/**
+/*
  * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
@@ -1118,7 +1118,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
 }
 
-/**
+/*
  * sdma_v6_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
  * @ring: amdgpu ring pointer
@@ -1167,7 +1167,7 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
-- 
2.41.0.162.gfafddb0af9-goog

