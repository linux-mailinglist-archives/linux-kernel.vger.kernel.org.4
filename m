Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096BC6BE35B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCQIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCQIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61348DCA79
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C28C3B824F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB338C433A0;
        Fri, 17 Mar 2023 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041369;
        bh=Jo9y+Kwbls9gJDU9oXvrQSYrNd+ndpmB5BvTl8Ffkf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6T4rJ29Lz8w6VrmuJTZUsf8JzLyx+ZSK+NrA8Vtnfe0fe/SeI1aBGBYKF1EsIbJ8
         uHzA2FXYGGNVk9zCgM7tGGefAB4XxGXcKaUjLXDwvQpQ/Hw9b/OMb/dfF2oUGExv//
         9ESft/4HbclwPtQnoQhMHvX5y/S8OBdP0Foj+7Z/QJyAiKHIuXy754cpZ4mBqdve64
         i4mkZG66ea2FA6XVkbG8jIuXiByfCDInRKwmXiaWrJjpu8CRlre/qV+jkbpyp2IGE+
         EAgZofKARug+Ygw2oC0AXQ0+Txks2u5p6RFtcWQwH1XPO4DqIYrpS00cTgXJMU6WbX
         ftPmtcuhnI+yQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/37] =?UTF-8?q?drm/amd/amdgpu/amdgpu=5Fucode:=20Remove?= =?UTF-8?q?=20unused=20function=20=E2=80=98amdgpu=5Fucode=5Fprint=5Fimu=5F?= =?UTF-8?q?hdr=E2=80=99?=
Date:   Fri, 17 Mar 2023 08:16:54 +0000
Message-Id: <20230317081718.2650744-14-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous prototype for ‘amdgpu_ucode_print_imu_hdr’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 380b89114341d..a7bffd24ceaf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -126,19 +126,6 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
-{
-	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
-	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
-
-	DRM_DEBUG("IMU\n");
-	amdgpu_ucode_print_common_hdr(hdr);
-
-	if (version_major != 1) {
-		DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
-	}
-}
-
 void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
-- 
2.40.0.rc1.284.g88254d51c5-goog

