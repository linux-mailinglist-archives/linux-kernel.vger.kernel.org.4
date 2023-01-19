Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B46746DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjASXDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjASXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:02:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E290A731E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:54:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z11so4804626ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khL1Nx5/0J4PkaYH2tde4UnbrwukvlMmrAWH0vjr2bI=;
        b=Ac2OX+39mFVECn4hmmfAWS6rVP1xBX7Wn30/vwGx8/3ZfjypN7OQgYqrpKb07D8Jlx
         j77BkYexw/gJ1baOWzJ0FtaD5JHwFDfB1FuciuirfpHEBa1UPw7h2lKdabbcKpenEhzc
         9psvBAIsSdBOmYKdPZrBkCZy/eP7Ucr/axblCgKlPqt2qnLpfGXeAnZBe2QtTTIygv+e
         E+LDkFrXqBcIqcFz7xbc+f/ax6knJTfluBa7GV7QkMJTeGEXxRWXNaKcoovlCGBVK99J
         14SdtIXYuok20iBvWMOtCrz+/fTV1A1UCFtWmA2HakOb+K6bWmVAIfHTElFx2k+dOqMI
         Yuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khL1Nx5/0J4PkaYH2tde4UnbrwukvlMmrAWH0vjr2bI=;
        b=SL7VrHIHO1xXDv9KPLUCy0EbyTXusjcLKd6j2bwVUIcGn8y0Ux/B/pKsNGxmOkSID8
         E3VLGezvN8+HO23uwnCOCwejoIGEvPBV9LAavt0gvyfLVGfl10AUuLbHMdnx8voR4TbM
         rkuvtJG6bwQ0pQZjkDbTj3unLZCSYsZgRbjkEBSPfkgFTrMIkrD6T8hkxPKzKJ2p/JCL
         x7qZ0BxdQnR/8wlRoCrzzWBOL6SR2nlZgn6ogBHvNRj1qvQfqJU+RtLnfVCQ88UYm39E
         D4Z31llUXPgHE+pn7vUbi3E2Gve5faD7PvrK9w99j3DR8tu3BCDtGRiOozRamqIrYtZo
         L8kQ==
X-Gm-Message-State: AFqh2kpX7T73jJ2HEJUW9K/mqJGqiriLrpUY4Ds+8pi4EmUM9osckO50
        vcFsSZStexarGvCg32LS5fs=
X-Google-Smtp-Source: AMrXdXsUCyTMzdubcmLV/sZTktU8cjOIaxH0ioMYdQNFrdyqzBYrF/7iQaq0jIBMed1wxB8P61zQzA==
X-Received: by 2002:a05:6402:289b:b0:49e:8410:ff1f with SMTP id eg27-20020a056402289b00b0049e8410ff1fmr1881349edb.28.1674168844603;
        Thu, 19 Jan 2023 14:54:04 -0800 (PST)
Received: from Tanmay.. (ip5f5ad407.dynamic.kabel-deutschland.de. [95.90.212.7])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0077077c62cadsm16916985ejd.31.2023.01.19.14.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:54:04 -0800 (PST)
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH] drm/nouveau: Fix bug in buffer relocs for Nouveau
Date:   Thu, 19 Jan 2023 23:53:51 +0100
Message-Id: <20230119225351.71657-1-007047221b@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_resv_wait_timeout returns greater than zero on success
as opposed to ttm_bo_wait_ctx. As a result of that relocs
will fail and give failure even when it was a success.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index f77e44958037..0e3690459144 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -706,9 +706,8 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 		ret = dma_resv_wait_timeout(nvbo->bo.base.resv,
 					    DMA_RESV_USAGE_BOOKKEEP,
 					    false, 15 * HZ);
-		if (ret == 0)
+		if (ret <= 0) {
 			ret = -EBUSY;
-		if (ret) {
 			NV_PRINTK(err, cli, "reloc wait_idle failed: %ld\n",
 				  ret);
 			break;
-- 
2.34.1

