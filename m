Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9B73B506
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjFWKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFWKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:15 -0400
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 03:17:05 PDT
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55EBD3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687514922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01N/gRTBxFgDNySxI5l/vzBYcJURpU1c4PTDBFkFenU=;
        b=iVE+wCfu7F1lZw+i7xvth7KefJ7Fm0oVwOc9HakWxSE9euLod3n30C5QVkXV6rKMhBxr1G
        +VOhlWdHF0NLJA3SnKxhtza3ph0hpg1Po2K7X20cGpnrLvOHU/uHBEdEoumWsGLlW+ftGg
        +hyqHMoIZRSDBrjbQxiPCkoo3P6haeo=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v1 6/8] drm/etnaviv: No indentation by double tabs
Date:   Fri, 23 Jun 2023 18:08:20 +0800
Message-Id: <20230623100822.274706-7-sui.jingfeng@linux.dev>
In-Reply-To: <20230623100822.274706-1-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Single tab should be enough.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index cef97bb9c99f..14c2e9690ce1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -231,11 +231,11 @@ static int show_each_gpu(struct seq_file *m, void *arg)
 }
 
 static struct drm_info_list etnaviv_debugfs_list[] = {
-		{"gpu", show_each_gpu, 0, etnaviv_gpu_debugfs},
-		{"gem", show_unlocked, 0, etnaviv_gem_show},
-		{ "mm", show_unlocked, 0, etnaviv_mm_show },
-		{"mmu", show_each_gpu, 0, etnaviv_mmu_show},
-		{"ring", show_each_gpu, 0, etnaviv_ring_show},
+	{"gpu", show_each_gpu, 0, etnaviv_gpu_debugfs},
+	{"gem", show_unlocked, 0, etnaviv_gem_show},
+	{ "mm", show_unlocked, 0, etnaviv_mm_show },
+	{"mmu", show_each_gpu, 0, etnaviv_mmu_show},
+	{"ring", show_each_gpu, 0, etnaviv_ring_show},
 };
 
 static void etnaviv_debugfs_init(struct drm_minor *minor)
-- 
2.25.1

