Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C776F6BE36D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCQIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCQIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AD48E00
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B2C6221B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A5CC433D2;
        Fri, 17 Mar 2023 08:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041394;
        bh=6xz1uCbkWtjZs2Q0ANTPzJEjYEFLDL038s8KDW4l2mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSsZWkbUfkRmRmaipEb+M2TM5CfWPNYoOgI+yjn8bECGSQXB4ZTd9VBq+M3wJ3/ho
         gSF6Efo3dy8DGiHOZuCD/F1FzZRYin5R51ZC/VWpwQmyyFHJABxcng0Hw5ZD7Oe4kT
         Y9N693N6/Cb9uKoXvRQFJx+nyc9YX3UrykmYss3aZm5E47DVZwdb0NomCyvCgmXN5F
         3CVUW9/5hLVS4ob+boH+5X3dJ+l5HRFP9cBSOPIfxYam54SERYuSRkCB2rRNlgJMbU
         KgMiJ2Gg/KBGKJ5LiHRh9nFyAH/dlQC2RmqZDwygDZy3H/5ZFRtkmHvsiADImgZ12J
         SidvwpnvHEUQg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org
Subject: [PATCH 23/37] drm/nouveau/nvkm/engine/fifo/gf100: Staticify local function gf100_fifo_nonstall_block()
Date:   Fri, 17 Mar 2023 08:17:04 +0000
Message-Id: <20230317081718.2650744-24-lee@kernel.org>
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

 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:451:1: warning: no previous prototype for ‘gf100_fifo_nonstall_block’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
index 5bb65258c36d8..6c94451d0faad 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
@@ -447,7 +447,7 @@ gf100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
 	spin_unlock_irqrestore(&fifo->lock, flags);
 }
 
-void
+static void
 gf100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
 {
 	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-- 
2.40.0.rc1.284.g88254d51c5-goog

