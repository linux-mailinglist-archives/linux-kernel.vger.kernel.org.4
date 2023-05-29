Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C672B714556
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjE2HTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjE2HTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:19:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D67AF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:19:17 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3X9eqYgEzMDzt3X9vq4QNv; Mon, 29 May 2023 09:19:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685344755;
        bh=QHA/Y0t0+ZEe+OD0y5zfwImt3ZyVK3OrMC3Z9s2pa1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W7r6xtOwhhzprrKfnZGh0T9qW6D98nODcTPYdrrsDy8UKp9fEcacSAXQkx7QVuWsz
         vE44t8MRi8+dK7gLek1AWrWxPl2qATJxc8HrbjAGOwLvfuSOuHMg8DP6xMcVD+Q/hF
         /zkkum9tvQek+TK7Z7XtphlqTNEWEXI55kvwobij7TzAVfmh+PJgyMsTYhyjUXYimY
         Evlsvd/Mq++SUL8fVPRhVdmAdbSLzHn0uzjvyRgyt9LioGM/9JBO4zihT7xxKHZ/If
         NW7ybU0zzERVByEtGA9ueYwMHYxdLYXlp9F7FUWyRqUTynkURq6ySZq3E7kKqkpFHx
         sSecbvRt+wSiw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:19:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/display: Use USEC_PER_SEC
Date:   Mon, 29 May 2023 09:18:56 +0200
Message-Id: <c168fac9fdde872a4f4d047f12a6a7c19185f47c.1685342739.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
References: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use USEC_PER_SEC instead of defining an equivalent local 'us_in_sec'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT compile tested. Because of some BROKEN in KConfig files.
Some header may be missing for USEC_PER_SEC!
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index eafe8561e55e..9b82ee3e06d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -678,7 +678,6 @@ static uint32_t get_dmif_switch_time_us(
 	uint32_t pixels_per_second;
 	uint32_t pixels_per_frame;
 	uint32_t refresh_rate;
-	const uint32_t us_in_sec = 1000000;
 	const uint32_t min_single_frame_time_us = 30000;
 	/*return double of frame time*/
 	const uint32_t single_frame_time_multiplier = 2;
@@ -691,8 +690,7 @@ static uint32_t get_dmif_switch_time_us(
 	pixels_per_frame = h_total * v_total;
 
 	refresh_rate = pixels_per_second / pixels_per_frame;
-
-	frame_time = us_in_sec / refresh_rate;
+	frame_time = USEC_PER_SEC / refresh_rate;
 
 	if (frame_time < min_single_frame_time_us)
 		frame_time = min_single_frame_time_us;
-- 
2.34.1

