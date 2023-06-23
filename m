Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CC73C408
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFWWZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFWWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:25:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F52693
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3094910b150so1277647f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687559127; x=1690151127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDShF6Qfrh0D9ZEbjzdHO4vNlJH6hZ7KH6f6b8K8APA=;
        b=drspUz+hUGzMT9U5ivf5vWK3qfcNW9c/NVqi/JzyQT+hugXZQsd7ntaPyQuPTMeeh4
         ovDjNAMdSzl/dg5pU5Cg0O1vwPivc9Gu+V/D0yQBUDPUrvuPGyt2sJvpHye2WgXMJ/0s
         obrmq+VEPBLo+u5JNbPPbOHLYKo5d6g57rhqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559127; x=1690151127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDShF6Qfrh0D9ZEbjzdHO4vNlJH6hZ7KH6f6b8K8APA=;
        b=JUFSOhmI1W2JqaXLldreW76LnzODaHGkpu/zU4cUvTXlKcePQmLjH7m+SNjelfg0fZ
         Qolusl7XOxUqRSKSfhj3xfwfxsBt8A9y3DnArCjtpmN5z9Ukh+UA8yFq03KQY9RPtXue
         jUVOUY+1XILUdsq0YgoehN5zVXARuLzV40Zp04+pqrSK5LCG5H+0vbH7iIIHWRHa5u60
         zCafWWosza+k0shXElhrdTc0ekPvsX3EIzkrgsv449Ku+CXtzy4zf6lBtcFwaJkNCOI2
         Pf3iveYJNjTqNLH/blQiqJqnz9KQEdLCYAJUMfqFTqo6X497aRI7uOdhZN7KavuaiPpm
         o2ug==
X-Gm-Message-State: AC+VfDxFZQX7mlmGxGh0D5pzi8VX3dt8903jkwPzTfeJb9yOvSQ1tQ9Y
        EdccWvsKnQ4xURH7PrT4Ak7pyA==
X-Google-Smtp-Source: ACHHUZ7meVCEmPXqJPKja7ki27JkhwCIGc8TspAz4yy4Va7frt40CBBAFpdlXOf1i/+GcsmA+9okQg==
X-Received: by 2002:adf:dfca:0:b0:30e:432b:c54 with SMTP id q10-20020adfdfca000000b0030e432b0c54mr17827827wrn.18.1687559126902;
        Fri, 23 Jun 2023 15:25:26 -0700 (PDT)
Received: from big-boopo.mynetworksettings.com (pool-108-46-233-209.nycmny.fios.verizon.net. [108.46.233.209])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0030c2e3c7fb3sm453223wrp.101.2023.06.23.15.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:25:26 -0700 (PDT)
From:   Jim Shargo <jshargo@chromium.org>
To:     mairacanal@riseup.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jim Shargo <jshargo@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drm/vkms: Back VKMS with DRM memory management instead of static objects
Date:   Fri, 23 Jun 2023 18:23:43 -0400
Message-ID: <20230623222353.97283-2-jshargo@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230623222353.97283-1-jshargo@chromium.org>
References: <20230623222353.97283-1-jshargo@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small refactor to make ConfigFS support easier. Once we
support ConfigFS, there can be multiple devices instantiated by the
driver, and so moving everything into managed memory makes things much
easier.

This should be a no-op refactor.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 130 +++++++++++++++--------------
 drivers/gpu/drm/vkms/vkms_drv.h    |   4 +-
 drivers/gpu/drm/vkms/vkms_output.c |   6 +-
 3 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index e3c9c9571c8d..f07454fff046 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -9,10 +9,12 @@
  * the GPU in DRM API tests.
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -37,8 +39,6 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-static struct vkms_config *default_config;
-
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
@@ -92,13 +92,13 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 static int vkms_config_show(struct seq_file *m, void *data)
 {
-	struct drm_debugfs_entry *entry = m->private;
-	struct drm_device *dev = entry->dev;
-	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct drm_info_node *drm_info = m->private;
+	struct vkms_device *vkms_device =
+		drm_device_to_vkms_device(drm_info->minor->dev);
 
-	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
-	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
-	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+	seq_printf(m, "writeback=%d\n", vkms_device->config.writeback);
+	seq_printf(m, "cursor=%d\n", vkms_device->config.cursor);
+	seq_printf(m, "overlay=%d\n", vkms_device->config.overlay);
 
 	return 0;
 }
@@ -155,114 +155,120 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev, 0);
 }
 
-static int vkms_create(struct vkms_config *config)
+static int vkms_platform_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct platform_device *pdev;
 	struct vkms_device *vkms_device;
+	void *grp;
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto out_unregister;
+	grp = devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+	if (!grp) {
+		return -ENOMEM;
 	}
 
 	vkms_device = devm_drm_dev_alloc(&pdev->dev, &vkms_driver,
 					 struct vkms_device, drm);
 	if (IS_ERR(vkms_device)) {
 		ret = PTR_ERR(vkms_device);
-		goto out_devres;
+		goto out_release_group;
 	}
+
 	vkms_device->platform = pdev;
-	vkms_device->config = config;
-	config->dev = vkms_device;
+	vkms_device->config.cursor = enable_cursor;
+	vkms_device->config.writeback = enable_writeback;
+	vkms_device->config.overlay = enable_overlay;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
-
 	if (ret) {
 		DRM_ERROR("Could not initialize DMA support\n");
-		goto out_devres;
+		goto out_release_group;
 	}
 
 	ret = drm_vblank_init(&vkms_device->drm, 1);
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
-		goto out_devres;
+		goto out_release_group;
 	}
 
 	ret = vkms_modeset_init(vkms_device);
-	if (ret)
-		goto out_devres;
+	if (ret) {
+		DRM_ERROR("Unable to initialize modesetting\n");
+		goto out_release_group;
+	}
 
 	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
 			      ARRAY_SIZE(vkms_config_debugfs_list));
 
 	ret = drm_dev_register(&vkms_device->drm, 0);
-	if (ret)
-		goto out_devres;
+	if (ret) {
+		DRM_ERROR("Unable to register device\n");
+		return ret;
+	}
 
 	drm_fbdev_generic_setup(&vkms_device->drm, 0);
+	platform_set_drvdata(pdev, vkms_device);
+	devres_close_group(&pdev->dev, grp);
 
 	return 0;
 
-out_devres:
-	devres_release_group(&pdev->dev, NULL);
-out_unregister:
-	platform_device_unregister(pdev);
+out_release_group:
+	devres_release_group(&pdev->dev, grp);
 	return ret;
 }
 
-static int __init vkms_init(void)
+static int vkms_platform_remove(struct platform_device *pdev)
 {
-	int ret;
-	struct vkms_config *config;
-
-	config = kmalloc(sizeof(*config), GFP_KERNEL);
-	if (!config)
-		return -ENOMEM;
-
-	default_config = config;
+	struct vkms_device *vkms_device;
 
-	config->cursor = enable_cursor;
-	config->writeback = enable_writeback;
-	config->overlay = enable_overlay;
+	vkms_device = platform_get_drvdata(pdev);
+	if (!vkms_device)
+		return 0;
 
-	ret = vkms_create(config);
-	if (ret)
-		kfree(config);
-
-	return ret;
+	drm_dev_unregister(&vkms_device->drm);
+	drm_atomic_helper_shutdown(&vkms_device->drm);
+	return 0;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+static struct platform_driver vkms_platform_driver = {
+	.probe = vkms_platform_probe,
+	.remove = vkms_platform_remove,
+	.driver.name = DRIVER_NAME,
+};
+
+static int __init vkms_init(void)
 {
+	int ret;
 	struct platform_device *pdev;
 
-	if (!config->dev) {
-		DRM_INFO("vkms_device is NULL.\n");
-		return;
+	ret = platform_driver_register(&vkms_platform_driver);
+	if (ret) {
+		DRM_ERROR("Unable to register platform driver\n");
+		return ret;
 	}
 
-	pdev = config->dev->platform;
-
-	drm_dev_unregister(&config->dev->drm);
-	drm_atomic_helper_shutdown(&config->dev->drm);
-	devres_release_group(&pdev->dev, NULL);
-	platform_device_unregister(pdev);
+	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&vkms_platform_driver);
+		return PTR_ERR(pdev);
+	}
 
-	config->dev = NULL;
+	return 0;
 }
 
 static void __exit vkms_exit(void)
 {
-	if (default_config->dev)
-		vkms_destroy(default_config);
+	struct device *dev;
+
+	while ((dev = platform_find_device_by_driver(
+			NULL, &vkms_platform_driver.driver))) {
+		// platform_find_device_by_driver increments the refcount. Drop 
+		// it so we don't leak memory.
+		put_device(dev);
+		platform_device_unregister(to_platform_device(dev));
+	}
 
-	kfree(default_config);
+	platform_driver_unregister(&vkms_platform_driver);
 }
 
 module_init(vkms_init);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 5f1a0a44a78c..e87c8aea6fb3 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -114,15 +114,13 @@ struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
-	/* only set when instantiated */
-	struct vkms_device *dev;
 };
 
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
 	struct vkms_output output;
-	const struct vkms_config *config;
+	struct vkms_config config;
 };
 
 #define drm_crtc_to_vkms_output(target) \
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 5ce70dd946aa..963a64cf068b 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -62,7 +62,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
-	if (vkmsdev->config->overlay) {
+	if (vkmsdev->config.overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
 			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
 			if (ret)
@@ -70,7 +70,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		}
 	}
 
-	if (vkmsdev->config->cursor) {
+	if (vkmsdev->config.cursor) {
 		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor))
 			return PTR_ERR(cursor);
@@ -103,7 +103,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
-	if (vkmsdev->config->writeback) {
+	if (vkmsdev->config.writeback) {
 		writeback = vkms_enable_writeback_connector(vkmsdev);
 		if (writeback)
 			DRM_ERROR("Failed to init writeback connector\n");
-- 
2.41.0.162.gfafddb0af9-goog

