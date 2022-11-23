Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1463513C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiKWHo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiKWHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:44:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D995CF72C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:44:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso1235248pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkNCuvzVKZTIBNAMLhyXJqvNV8XoAxmEaDHLKjpaxZk=;
        b=GIZt1ORBmaG7n9RolwWkJ49wmMDAqSAEdkZa8bbfIDHYwD7sXZ5/XEVMkrDHclYtz2
         hhoMoHNj7Y+Mmh577ISuaMfObcYKtff0K5UFEBv1HUMsUl4g8q4atXrN4jWDmw4GrQZk
         m8p8q+ZvAWyb3GLIY1EMqlGI5EvucKfaalL/3RVjz4mcJzzKdqUwKrALJl69n4Rpi9bW
         VY54dSqKoGj6mF9EzI0t6Wo6GK64PWy2CCKzTH8n1VVRJGoNoSq76mKwj4h1ptCcfhjn
         H4ZSYewVbLviJZWghcZqHwaGu8e3L1DJDj8eyHHQtEBRFXvJeFPsg+C23QdYTOGIqK1z
         Fx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkNCuvzVKZTIBNAMLhyXJqvNV8XoAxmEaDHLKjpaxZk=;
        b=wfAev0TpW5Nh3d6nZTQALEIZG4ajF1lNQF93bn/RisQrUB+bLKu9DUd1Kp+MRIeP3Q
         fq/Mjg6w7rYX5gnDmeyuIlG4aa5D7Sw12+/8JvDOwupTsh3uNfz3g3TQa7+HYZDmmv6O
         KOxm1UT951NWgxDyT/4AP+q+UI7nEuFLWsUVWGvPC5C+061pA49IkOugLL54d74mr0o+
         9PHhfmOujm3w0T2Upj2KmpBaRyfPBJ2CCGscBEljuQQZxvys/z8Gj1fWHnH3H5n3Dkwu
         VnEYaoNGI67jgFBvqF/oEi1eW7CKtBFAV3V72SXE0b691DeSDqBjMCsW4bGi32JlRieF
         4xVw==
X-Gm-Message-State: ANoB5pm3zyNjf+9abqz5aK8JQw1h/DsX/kUd3VrYk077ibcJkL8UmUaO
        3kepnvgyGAszmaRnxACd5AQ=
X-Google-Smtp-Source: AA0mqf4ueg2nmqyofxlnFvFtstNwE5iLMoeyWgBN/2X4G08aj/OkYsyL4cJ3tIrLa+4UEKHwNu+I8Q==
X-Received: by 2002:a17:902:b691:b0:17e:3f0f:5ad0 with SMTP id c17-20020a170902b69100b0017e3f0f5ad0mr12056528pls.162.1669189493415;
        Tue, 22 Nov 2022 23:44:53 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902714300b00188f07c9eedsm13290823plm.176.2022.11.22.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:44:52 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] drm/amdgpu: remove redundant NULL check
Date:   Wed, 23 Nov 2022 15:44:37 +0800
Message-Id: <20221123074437.1841014-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

release_firmware() checks whether firmware pointer is NULL.
Remove the redundant NULL check in psp_sw_fini().

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++--------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index effa7df3ddbf..77b966ab5439 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -484,26 +484,22 @@ static int psp_sw_fini(void *handle)
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
-	if (psp->sos_fw) {
-		release_firmware(psp->sos_fw);
-		psp->sos_fw = NULL;
-	}
-	if (psp->asd_fw) {
-		release_firmware(psp->asd_fw);
-		psp->asd_fw = NULL;
-	}
-	if (psp->ta_fw) {
-		release_firmware(psp->ta_fw);
-		psp->ta_fw = NULL;
-	}
-	if (psp->cap_fw) {
-		release_firmware(psp->cap_fw);
-		psp->cap_fw = NULL;
-	}
-	if (psp->toc_fw) {
-		release_firmware(psp->toc_fw);
-		psp->toc_fw = NULL;
-	}
+
+	release_firmware(psp->sos_fw);
+	psp->sos_fw = NULL;
+
+	release_firmware(psp->asd_fw);
+	psp->asd_fw = NULL;
+
+	release_firmware(psp->ta_fw);
+	psp->ta_fw = NULL;
+
+	release_firmware(psp->cap_fw);
+	psp->cap_fw = NULL;
+
+	release_firmware(psp->toc_fw);
+	psp->toc_fw = NULL;
+
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
-- 
2.27.0

