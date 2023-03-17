Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511A6BE37B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjCQI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjCQIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:25:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DEE1913
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D602B82502
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B84C433D2;
        Fri, 17 Mar 2023 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041402;
        bh=RKxRz51sFgOxiDizVtbSEGg/i/1bqJaiTvQ7ot8eUWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0S/Nt5k8fdhUP+o8e92FNQipWDdAcyM++Hg316CKhf6wVSldAVUwjm+Hh3WyH1A9
         lM7DoA0WkYTelO6adTAXEL8UAgvrGbyTACI5Moe4xtgVdRi2JmN4ap5xoJHaTUJI7C
         rAOzp48FAEc8+t5qprHkRjSOEi2TlDjgT4kUSP91LHFwAU69f+YptR7Jv4DOzLZ6Fa
         yXLhBokrMrEFOqF9Mjg/CLcGCdv/BzsZ85G4mz7OC3h9CTAOH45O+J9P1Kiuhm+0q+
         FJ8qnhYM9MRL8k6NDq46UoG0ZqM0x1c5sQpDyX699/EipIxqgV80gM4MvamfgbIOh9
         Z7/A/pMd9pitQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/37] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Move SYNAPTICS_DEVICE_ID into CONFIG_DRM_AMD_DC_DCN ifdef
Date:   Fri, 17 Mar 2023 08:17:07 +0000
Message-Id: <20230317081718.2650744-27-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:48:22: warning: ‘SYNAPTICS_DEVICE_ID’ defined but not used [-Wunused-const-variable=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 330ab036c830f..a8904184673f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -44,9 +44,6 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
-/* MST Dock */
-static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
-
 /* dm_helpers_parse_edid_caps
  *
  * Parse edid caps
@@ -703,6 +700,9 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
 }
 
+/* MST Dock */
+static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
+
 static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 		struct drm_dp_aux *aux,
 		const struct dc_stream_state *stream,
-- 
2.40.0.rc1.284.g88254d51c5-goog

