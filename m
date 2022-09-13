Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4655B7B04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIMT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIMT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:29:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E5579EF4;
        Tue, 13 Sep 2022 12:28:48 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD63C6601FF3;
        Tue, 13 Sep 2022 20:28:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663097327;
        bh=Ov9ZX8VHbwHToZzjcmjiNJ0jjSTvXmYhNQje1p3xR4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B15XfPU8GnbNZTWw0ofEzetFD2TYK/dvVkvVuf4RuLMJpUHzPq/xgl6TXqcXjgt0Z
         XTFDGo84L236dwoYZCRiv+vafDk8fgnojykiEOav8siMVIpL3ZUyhmHKVEU3S369PC
         fV+/WR+9JVBJ7aA3hL994exGkNH5NumoWi9vcQD2f2u0DvXjS6R+giO3AFTqYJbu3V
         lssn1YpIxPNNjrZYB2Ibbv0e6G8W9EYd0RiV7B/MGqIwRhmPCBWlBsumRO3nucaEnC
         LJvB2vQrwHK5lgZJlZaSRClarOX8DtCbe1o9VWo93d+i2U94FxF6QraolQnNxupDGZ
         kRHWjffst9Dww==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Ruhl Michael J <michael.j.ruhl@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 05/21] drm/armada: Prepare to dynamic dma-buf locking specification
Date:   Tue, 13 Sep 2022 22:27:41 +0300
Message-Id: <20220913192757.37727-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913192757.37727-1-dmitry.osipenko@collabora.com>
References: <20220913192757.37727-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare Armada driver to the common dynamic dma-buf locking convention
by starting to use the unlocked versions of dma-buf API functions.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/armada/armada_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 5430265ad458..26d10065d534 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -66,8 +66,8 @@ void armada_gem_free_object(struct drm_gem_object *obj)
 	if (dobj->obj.import_attach) {
 		/* We only ever display imported data */
 		if (dobj->sgt)
-			dma_buf_unmap_attachment(dobj->obj.import_attach,
-						 dobj->sgt, DMA_TO_DEVICE);
+			dma_buf_unmap_attachment_unlocked(dobj->obj.import_attach,
+							  dobj->sgt, DMA_TO_DEVICE);
 		drm_prime_gem_destroy(&dobj->obj, NULL);
 	}
 
@@ -539,8 +539,8 @@ int armada_gem_map_import(struct armada_gem_object *dobj)
 {
 	int ret;
 
-	dobj->sgt = dma_buf_map_attachment(dobj->obj.import_attach,
-					   DMA_TO_DEVICE);
+	dobj->sgt = dma_buf_map_attachment_unlocked(dobj->obj.import_attach,
+						    DMA_TO_DEVICE);
 	if (IS_ERR(dobj->sgt)) {
 		ret = PTR_ERR(dobj->sgt);
 		dobj->sgt = NULL;
-- 
2.37.3

