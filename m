Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50E96BE337
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCQIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCQIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8F10272;
        Fri, 17 Mar 2023 01:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 824E462229;
        Fri, 17 Mar 2023 08:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE92C433D2;
        Fri, 17 Mar 2023 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041345;
        bh=g04ZINvTEUjQva4N99+CPauyQdfUwEB0MhvaHIAapKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc2dZ7hmNkJXZcLAH4xdxUhtozrQARLpG00GRVEo8lrR/265Zwy+QVjRBN0WlDl1Z
         5b83rLlgcL5FqU0BF5yn8ker+hLM6JH6rr1ltl1B1b4lNxjCCpa9m5I6gvJXLWHOg5
         SseUWNOX92/4i3VazKURF9Oou5Odhqjpk3tIruCH5a47qwdhBzFOza7zMtSD8fsvle
         wDAgg5UGRjhQLa7j7LmEsKCaueoTsA33oz/6dlh4EZtjV0K2XogJoze8evjemc2cMm
         apqkoKz0MMtvvNOj9M6kER2y0z80ZQrFMM1mcKphlixj3IXN8hsAJ5i/eqjSI+S0W3
         fVeUtc21SSyEw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 03/37] drm/amd/amdgpu/amdgpu_device: Provide missing kerneldoc entry for 'reset_context'
Date:   Fri, 17 Mar 2023 08:16:44 +0000
Message-Id: <20230317081718.2650744-4-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5152:
   warning: Function parameter or member 'reset_context' not described in 'amdgpu_device_gpu_recover'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4519fbd526f2..ef0b2787796da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5145,6 +5145,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @job: which job trigger hang
+ * @reset_context: amdgpu reset context pointer
  *
  * Attempt to reset the GPU if it has hung (all asics).
  * Attempt to do soft-reset or full-reset and reinitialize Asic
-- 
2.40.0.rc1.284.g88254d51c5-goog

