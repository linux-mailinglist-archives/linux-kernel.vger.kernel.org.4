Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9896BE38E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCQIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCQIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A13D93B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C151B824F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5390FC433A0;
        Fri, 17 Mar 2023 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041424;
        bh=6a8BtlskbP9+bgQcqTudP5Da9xVRBITUVFtK0dF48DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNV0jZq3225L0LcWA5AnesWS7MJGdsuVqYnhxdKZLT5BEC/eRMZg/tWTL4fOY3igt
         bptRhoFxYZybJRbInp44U/7PTFcSjMb9mme/FsFfPpJp67kogKhgTsjEnAGT3IFm+V
         oJM5+BrLanshy4LjPmNrTMBQjGn/OoVI+3sIa7Ut/NksmhIHc1xah4r3VtAEVba4cv
         NFBBnq/5qjk8Qk9lLc8DTQPXmExojlMLJXxYv6zBmc9mBwZnGfFAho7pKyIc5FQxcZ
         0A4Eg5FQ8Zb6+j2e/3rmKrerYpnchCO23m3ttXw0yTo+GKSfLM5STEP7PwFpJfnQvr
         nXlVVt73sI+LA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org
Subject: [PATCH 34/37] =?UTF-8?q?drm/nouveau/nvkm/engine/gr/tu102:=20Compl?= =?UTF-8?q?etely=20remove=20unused=20function=20=E2=80=98tu102=5Fgr=5Fload?= =?UTF-8?q?=E2=80=99?=
Date:   Fri, 17 Mar 2023 08:17:15 +0000
Message-Id: <20230317081718.2650744-35-lee@kernel.org>
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

 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: ‘tu102_gr_load’ defined but not used [-Wunused-function]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
index 10a7e59482a6f..a7775aa185415 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
@@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, struct gf100_gr_pack **ppack)
 	return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
 }
 
-static int
-tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
-{
-	int ret;
-
-	ret = gm200_gr_load(gr, ver, fwif);
-	if (ret)
-		return ret;
-
-	return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, tu102_gr_av_to_init_veid,
-				 &gr->bundle_veid);
-}
-
 static const struct gf100_gr_fwif
 tu102_gr_fwif[] = {
 	{  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpccs_acr },
-- 
2.40.0.rc1.284.g88254d51c5-goog

