Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90026699143
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBPKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:31:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E82460A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:31:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id j184so1142217pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29OzWpxyOz2YKbe7gk+wlUnvCGzWDi9lW+7/pophrnY=;
        b=VuOklK73RybRMNGEpT6+1i1b0r2ft7MGsgRP6Do4TXn0wOAtQ453gLKLV0vCs72wE2
         LIEVFUbzD7N3Axn92WbHDNmCRUx40OTMkWuFJcAH/BzsSEvbWWxbfnklwTRuYC9ZNcfB
         Z3PVBqri9y2hBZYTbSA0tVDV7LeDaAm3T2Sw1K4H8uNUuilPCli5gCtosahCKn+WEn0q
         dlRyWmxqZM/+4IlhLl7Yyt/XbQQIV6y2sfkLaWCIkA+R/NPiZNnnhgomGfM1xBwMvOGB
         eagKWtVDzIDMP8Qvt6LbQtqp0PaosXeiBitO7VnnwVTS7QBgEDv3SBHIw/rwr8Vbh+Rm
         QMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29OzWpxyOz2YKbe7gk+wlUnvCGzWDi9lW+7/pophrnY=;
        b=iTuP3CZglKbP+Uv63ECnIm1a4Y/BoWcCF1Pnd0ePiMZQo0PLDzvRb0hLyorn3Ndk8g
         iKrEHVAQrFLVCMWmBPHMHIZf3R7o0kOy37y2bQhRqY6TBOKuMuCbFzgKlgSA8cxn4ndF
         wSlKxFZeeTkSrCI5YUDJi7zQIEMSPZ4sqfcYbPrYyGer8+3KBWZQ4m9/xGm05YjayVDa
         Aez3EyAB9DDbqulddDxmG6UUphYzD0PCiV7M+sebdSlGHi5kWdyv5XepX8AUNpF92FVi
         6ewHRhgV7GwKeNrITPb6y7hUWGQaSFm5TKiXcD3W0/HjvA3d26pzto0TPJGMHRC3OzAL
         fRWQ==
X-Gm-Message-State: AO0yUKWnvkzCAYe2F8Ry0B4x+zIQjau+IC98y+rCdEGhgsM6zirKlXXG
        xJ1N66phRA7KlHjRoQY/kbCYgTFrhAuHzA==
X-Google-Smtp-Source: AK7set84rxDE0S2Ui4h6nOB6QxOphwCKGJ1gDgb+KixrIcbphyNjJYz+yWMyPkvq3gRdiMhOY4RW7Q==
X-Received: by 2002:a05:6a00:3010:b0:5a8:aa5e:4bc3 with SMTP id ay16-20020a056a00301000b005a8aa5e4bc3mr1724493pfb.1.1676543505864;
        Thu, 16 Feb 2023 02:31:45 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b005893f281d43sm975790pfm.27.2023.02.16.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:31:45 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCHv2] drm/amdgpu: register a vga_switcheroo client for MacBooks with apple-gmux
Date:   Thu, 16 Feb 2023 21:28:57 +1100
Message-Id: <20230216102856.11987-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
vga_switcheroo") made amdgpu only register a vga_switcheroo client for
GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Use apple_gmux_detect() to identify these gpus, and
pci_is_thunderbolt_attached() to ensure eGPUs connected to Dual GPU
Macbooks don't register with vga_switcheroo.

Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
Link: https://lore.kernel.org/amd-gfx/20230210044826.9834-10-orlandoch.dev@gmail.com/
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Use apple_gmux_detect()
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f28a8c02f64..ef8b996f0622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -35,6 +35,7 @@
 #include <linux/devcoredump.h>
 #include <generated/utsrelease.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/apple-gmux.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -3919,12 +3920,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_px(ddev)) {
-		px = true;
+	px = amdgpu_device_supports_px(ddev);
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_register_client(adev->pdev,
 					       &amdgpu_switcheroo_ops, px);
+
+	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
-	}
 
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
@@ -4029,6 +4033,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
+	bool px;
 
 	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
@@ -4048,10 +4053,16 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
+
+	px = amdgpu_device_supports_px(adev_to_drm(adev));
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_unregister_client(adev->pdev);
+
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	}
+
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-- 
2.39.1

