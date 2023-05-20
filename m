Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF570A9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjETSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjETSTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF87E41;
        Sat, 20 May 2023 11:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 343B860909;
        Sat, 20 May 2023 18:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA67C433D2;
        Sat, 20 May 2023 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606736;
        bh=9XuyVdHschitaFjv1IRmhakUiZ7udiWU8DqDINx/jd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/j2ABdH0bNmn4avd7GYmY3ltuWN2xQ0eGHGjVfCjR4sH8Cov4on4Kq6rWFciBITv
         Nn/2+CHYLDXSfPdSPEBQeiG3kJlQxIlaNmbda/a4ObRzE7lqX5kNfVnkiIOar2vXUv
         Dv2g5E+5uttS5KQVcv6SX0jszoJpuG4/aFWUomsHj63SpxMNrSarEb7MRr83FHL/hd
         XYmwaJ6QneyF0ODsYhjF3JfXOM24J185LL1cp2XVroKscTLq48cWoGdj+XWJZpsrnP
         SJmmjNXIvUVsR9qHPt6ZTT3vzi5eAKAXSMd1wvX2W9Gob6HwZd6Xrsa4/XRUBsoEim
         W+f7fmjGEVXfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thong Thai <thong.thai@amd.com>,
        Ruijing Dong <ruijing.dong@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Likun.Gao@amd.com,
        kai.heng.feng@canonical.com, shane.xiao@amd.com,
        veerabadhran.gopalakrishnan@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 12/18] drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution
Date:   Sat, 20 May 2023 14:17:44 -0400
Message-Id: <20230520181750.823365-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520181750.823365-1-sashal@kernel.org>
References: <20230520181750.823365-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Thong Thai <thong.thai@amd.com>

[ Upstream commit 476ac50fc30540e29191615a26aaf5f9dee91c49 ]

Update the maximum resolution reported for HEVC encoding on VCN 3
devices to reflect its 8K encoding capability.

v2: Also update the max height for H.264 encoding to match spec.
(Ruijing)

Signed-off-by: Thong Thai <thong.thai@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ebe0e2d7dbd1b..aa7f82b3fd6a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -98,6 +98,16 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 };
 
 /* Sienna Cichlid */
+static const struct amdgpu_video_codec_info sc_video_codecs_encode_array[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_encode = {
+	.codec_count = ARRAY_SIZE(sc_video_codecs_encode_array),
+	.codec_array = sc_video_codecs_encode_array,
+};
+
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] =
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
@@ -136,8 +146,8 @@ static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 =
 /* SRIOV Sienna Cichlid, not const since data is controlled by host */
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] =
@@ -237,12 +247,12 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 		} else {
 			if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
 				if (encode)
-					*codecs = &nv_video_codecs_encode;
+					*codecs = &sc_video_codecs_encode;
 				else
 					*codecs = &sc_video_codecs_decode_vcn1;
 			} else {
 				if (encode)
-					*codecs = &nv_video_codecs_encode;
+					*codecs = &sc_video_codecs_encode;
 				else
 					*codecs = &sc_video_codecs_decode_vcn0;
 			}
@@ -251,14 +261,14 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	case IP_VERSION(3, 0, 16):
 	case IP_VERSION(3, 0, 2):
 		if (encode)
-			*codecs = &nv_video_codecs_encode;
+			*codecs = &sc_video_codecs_encode;
 		else
 			*codecs = &sc_video_codecs_decode_vcn0;
 		return 0;
 	case IP_VERSION(3, 1, 1):
 	case IP_VERSION(3, 1, 2):
 		if (encode)
-			*codecs = &nv_video_codecs_encode;
+			*codecs = &sc_video_codecs_encode;
 		else
 			*codecs = &yc_video_codecs_decode;
 		return 0;
-- 
2.39.2

