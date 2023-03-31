Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEF6D1C49
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjCaJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjCaJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F220331;
        Fri, 31 Mar 2023 02:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA6562660;
        Fri, 31 Mar 2023 09:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DD6C433D2;
        Fri, 31 Mar 2023 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254827;
        bh=h8C/nCvQ95GrVt3vhY71TCmgTeCG4/uxqnWpxM7dCvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsTJ8rRVglkyMZumINEy8WnEYodYuNEhZ7bk1k65j6hRSt6A+H6HSIvwtd10Q7Pew
         mDw2gtHjx/Wcbcjzbkz+E4al5QovbvJmBTGuowMkfOeT3uswymaaryDuad3rt3skik
         5V5Bbv3qYCq7vivephtUFBGWG86wnCgaWebo/0f/p2rqGeM9esEDofWzKN7G+RpviI
         uGVW/qs5y+ADztJb7OtXuw83KGVnks7D3LZENOEVzA8BLUVYaq3VNB0jjOaOb5xHKz
         KUcG4WeYIOei20QDLzRmfFPg48kD4AHMaklv91+4SWntbuAwafm2Tk9Hkn2rRjV4B2
         yMfi7F7+H4KBw==
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
Subject: [PATCH 18/19] drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function headers
Date:   Fri, 31 Mar 2023 10:26:06 +0100
Message-Id: <20230331092607.700644-19-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index 40e6b22daa226..efea4ef30a787 100644
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
@@ -933,7 +933,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-/**
+/*
  * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
@@ -1114,7 +1114,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
 }
 
-/**
+/*
  * sdma_v6_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
  *
@@ -1162,7 +1162,7 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
-- 
2.40.0.348.gf938b09366-goog

