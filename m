Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203B6BE353
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCQIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCQIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C353B843
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379D96221B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5376C433EF;
        Fri, 17 Mar 2023 08:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041362;
        bh=e/el3O/A1UgFfDEmDRZYS7OolJfnj2ACdH8OTNTnlj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9MBk22I4TIw7eMlENbYvYjSjpYCRZmcvQXO2Xg5zyQn4kdQ5M/oShwbToap7MgWZ
         nM2Ff76rkB9dXEa9azdPX7NwbqN8hMM2z9rqOmxkjlLKmp5XQIFsKBsLA72CgOoAIX
         /02PAjVgEwnp9eGC1PEhxuRkqrZBPt5Q2kNnEdSPatUf4F/ziuQxD5kyGM+5KRCfFo
         Fj7tN7La0tGlI6PiU0a57LugS/lMuBc1CisLkXI9JFaHO5Nl/rnvJxd7aOBA1xL/54
         zaov6bknAF90glfzYYQVzwbybQvNd1XTqfvjSo2Uj5egpBjurWf/1a4hFKsz0hykkk
         PRPXTJDGFjdEQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        nouveau@lists.freedesktop.org
Subject: [PATCH 10/37] =?UTF-8?q?drm/nouveau/nvkm/nvfw/acr:=20Make=20local?= =?UTF-8?q?=20function=20=E2=80=98wpr=5Fgeneric=5Fheader=5Fdump=E2=80=99?= =?UTF-8?q?=20static?=
Date:   Fri, 17 Mar 2023 08:16:51 +0000
Message-Id: <20230317081718.2650744-11-lee@kernel.org>
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

 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no previous prototype for ‘wpr_generic_header_dump’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gourav Samaiya <gsamaiya@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
index 83a9c48bc58cb..7ac90c495737a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
@@ -45,7 +45,7 @@ wpr_header_v1_dump(struct nvkm_subdev *subdev, const struct wpr_header_v1 *hdr)
 	nvkm_debug(subdev, "\tstatus        : %d\n", hdr->status);
 }
 
-void
+static void
 wpr_generic_header_dump(struct nvkm_subdev *subdev, const struct wpr_generic_header *hdr)
 {
 	nvkm_debug(subdev, "wprGenericHeader\n");
-- 
2.40.0.rc1.284.g88254d51c5-goog

