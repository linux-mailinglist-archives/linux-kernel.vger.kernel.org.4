Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE36A1BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBXMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBXMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:11:19 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF7679B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:10:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PNT5C41XWz9y4T8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 20:01:35 +0800 (CST)
Received: from petrtesarik.huaweicloud.com (unknown [10.48.147.101])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGMIqfhjh0tJAQ--.32630S2;
        Fri, 24 Feb 2023 13:09:52 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     roberto.sassu@huawei.com, petr@tesarici.cz
Subject: [PATCH] drm/prime: Fix documentation of drm_gem_prime_fd_to_handle()
Date:   Fri, 24 Feb 2023 13:09:31 +0100
Message-Id: <20230224120931.1024-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHXGMIqfhjh0tJAQ--.32630S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW8Xry3AF4rKrWxtF48Crg_yoW8Gry8pF
        W3GFyUtrWvqr42g3WfA3ZrZas3ua17ZFWxWFW3Awsxuw1YyFyDuFW3K390y3yUJry7JFyF
        qFyqqFyjyryUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0E
        Y4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUn5ku7UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The DRM device passed to drm_gem_prime_fd_to_handle() is where the
dma-buf is being imported, not the device where it was exported.

Also fix a trivial typo in drm_gem_prime_import_dev().

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 drivers/gpu/drm/drm_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index f924b8b4ab6b..149cd4ff6a3b 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -285,7 +285,7 @@ EXPORT_SYMBOL(drm_gem_dmabuf_release);
 
 /**
  * drm_gem_prime_fd_to_handle - PRIME import function for GEM drivers
- * @dev: dev to export the buffer from
+ * @dev: drm_device to import into
  * @file_priv: drm file-private structure
  * @prime_fd: fd id of the dma-buf which should be imported
  * @handle: pointer to storage for the handle of the imported buffer object
@@ -925,7 +925,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 		obj = dma_buf->priv;
 		if (obj->dev == dev) {
 			/*
-			 * Importing dmabuf exported from out own gem increases
+			 * Importing dmabuf exported from our own gem increases
 			 * refcount on gem itself instead of f_count of dmabuf.
 			 */
 			drm_gem_object_get(obj);
-- 
2.25.1

