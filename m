Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EC6BE365
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCQIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCQIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17949C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54956B82501
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E2C433AC;
        Fri, 17 Mar 2023 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041377;
        bh=zleuN72mqtjveYJLiJkgWupGSovQJL7rHgZUKBSDZ5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FT+9zj1yvj5mzSa3LBbimjMH5ifXG3obim/Y1qu0ThCog+ZJgseiycQ9Uuq7oYv0J
         1qcQFyEUM+hQfm4BtiYEg40XIviDInDWAiMmdV4PH2W+VR+V+V3jDr0kU/hhBm9hAq
         1eLAh2JLJRw4WYxNYKttp0HvsjDgJdoKq90ZYW0yuq/E1g9y+5LKKde7RZakA399EB
         cAZXd0/gpASdYzLvVf8D81a5I7NI+w4Y/bRxPPEn+28HND/HXhQO+GYhKx6bA+bzdg
         a1F1RwiBYVNlUgpVqmbblvMkWO8urhexyfj2nieIic2HHsuImyqcjSbK8CWjhLWZV5
         lYtxBJwnN+06g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/37] drm/amd/amdgpu/ih_v6_0: Repair misspelling and provide descriptions for 'ih'
Date:   Fri, 17 Mar 2023 08:16:57 +0000
Message-Id: <20230317081718.2650744-17-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:392: warning: Function parameter or member 'ih' not described in 'ih_v6_0_get_wptr'
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:432: warning: Function parameter or member 'ih' not described in 'ih_v6_0_irq_rearm'
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c:458: warning: Function parameter or member 'ih' not described in 'ih_v6_0_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 7cd79a3844b24..b02e1cef78a76 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -119,7 +119,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
  * ih_v6_0_toggle_ring_interrupts - toggle the interrupt ring buffer
  *
  * @adev: amdgpu_device pointer
- * @ih: amdgpu_ih_ring pointet
+ * @ih: amdgpu_ih_ring pointer
  * @enable: true - enable the interrupts, false - disable the interrupts
  *
  * Toggle the interrupt ring buffer (IH_V6_0)
@@ -381,6 +381,7 @@ static void ih_v6_0_irq_disable(struct amdgpu_device *adev)
  * ih_v6_0_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer.  Also check for
@@ -425,6 +426,7 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
  * ih_v6_0_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  */
 static void ih_v6_0_irq_rearm(struct amdgpu_device *adev,
@@ -450,6 +452,7 @@ static void ih_v6_0_irq_rearm(struct amdgpu_device *adev,
  * ih_v6_0_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.40.0.rc1.284.g88254d51c5-goog

