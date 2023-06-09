Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652517292D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjFIITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbjFIITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F030ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B71B6546B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ED4C433D2;
        Fri,  9 Jun 2023 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298671;
        bh=Pv1wU5KAiTG2NqIbaiHMThlUj2m+iKFsaTZ+K1VxTYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyyMLY9G9flUQzJlNsCDG4Nrkwef2ebn/lN7hvCXlDzdNZKVM3OWgdlfmV2MYcThy
         D/hPVE25LoNsux3ot4mwpyIF3mGUdK0laqJshhaDONDYhE0NqlJ/BanDNLLI7NrtaI
         5qNpau/9gddwppfKg42n3xVjWR8KH/MmbZXiMTWHlBdGvlXCI/PfEBmcat13te+PbV
         vIXSjLrzGZ43/OyThVwRxFiyFot21x9z6U0Iz7xHEIOo9fqw2RsbTw6ZZvNyIj2Zci
         74YeF/jigBnDn3IItetU8gDHMr/0enPMB+htsHx9KNuvjhtCxp4OygIg8GAcG6eybJ
         6FG8ASYhPNHyQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 03/15] drm/vkms/vkms_composer: Fix a few different kerneldoc formatting
Date:   Fri,  9 Jun 2023 09:17:06 +0100
Message-ID: <20230609081732.3842341-4-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
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

 drivers/gpu/drm/vkms/vkms_composer.c:41: warning: Function parameter or member 'frame_info' not described in 'pre_mul_alpha_blend'
 drivers/gpu/drm/vkms/vkms_composer.c:41: warning: Excess function parameter 'src_frame_info' description in 'pre_mul_alpha_blend'
 drivers/gpu/drm/vkms/vkms_composer.c:72: warning: Cannot understand  * @wb_frame_info: The writeback frame buffer metadata

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 906d3df40cdbe..03fa3eeef678c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -23,7 +23,7 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
 
 /**
  * pre_mul_alpha_blend - alpha blending equation
- * @src_frame_info: source framebuffer's metadata
+ * @frame_info: source framebuffer's metadata
  * @stage_buffer: The line with the pixels from src_plane
  * @output_buffer: A line buffer that receives all the blends output
  *
@@ -90,11 +90,13 @@ static void fill_background(const struct pixel_argb_u16 *background_color,
 }
 
 /**
- * @wb_frame_info: The writeback frame buffer metadata
+ * blend - blend pixels from a given row and calculate CRC
+ * @wb: The writeback frame buffer metadata
  * @crtc_state: The crtc state
  * @crc32: The crc output of the final frame
  * @output_buffer: A buffer of a row that will receive the result of the blend(s)
  * @stage_buffer: The line with the pixels from plane being blend to the output
+ * @row_size: Size of memory taken up by row data (line_width * pixel_size)
  *
  * This function blends the pixels (Using the `pre_mul_alpha_blend`)
  * from all planes, calculates the crc32 of the output from the former step,
-- 
2.41.0.162.gfafddb0af9-goog

