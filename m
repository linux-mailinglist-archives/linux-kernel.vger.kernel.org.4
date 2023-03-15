Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947C6BB4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjCONpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjCONoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:44:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823B99BCB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:43:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so46296286edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoJ32fY2U6onu2XeTo5DX618tP1s6+s3YRLKr7wGres=;
        b=J8dt7NZabR68uwiqryISbGu/PmcQUqJcNVHirreVXGHQUT9Ii8iVdq9OKF9FbJjwBl
         RRyeo4gsBUnR9xhbGineny22Zr9mnGQrpgS4Lj9KLYuA2J0jy506Jo2i/LEnOQxEvhKG
         yPoh9OTapSyKgkm/dWNRO01CFAJZ0Q23PSTiPeO2ruqzEDvwrPGua3VhOOZJF3W2JVaV
         Z/QZwlbFltztyL2t0yoNVn59euJ/JFQDBw3ZWwuOaByG9z7A1kRDEUjSw14Z6286drFE
         trbfgagLphAAb0dAmj6qj7MTMytVtGyltigOJHk6jIhb8oZMJyPU566wDVKrNHt8xl2I
         KsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoJ32fY2U6onu2XeTo5DX618tP1s6+s3YRLKr7wGres=;
        b=UxZGVTYefVbjVCIdIyiPwlDzTZ42T8hIM6uHYEbU5bY2+hduLBpVBZxd44X8ou4R9C
         dU5yXIN3HHf2IZlslEiRxGod3Qd81it01qXsBGYEGzVYUclLIIsZ9tXyjfPpiISaEFK3
         I9brgHwY7p1J/awH+B9szNLI0IKrLg3H93M0qtXQhyZYXIwSewfMNBJiZB260NnZU2TL
         vosv5n4TnE5Xjhdmy9tsVvRtEWjqzI0Q8lZIWqUQwblF5UjFavoNDme53KTPCprqlS17
         jnaoa1H5ard1SaaaWDo5lBt+Ny+7wQQy09Esybj0Yj33mM8DX61sD3JDRcJRuf266sCX
         0aQQ==
X-Gm-Message-State: AO0yUKW8+N2ujuAqvcDNosJ7d+P1R58st+wMioDKbgJOhVvqnJhZOzuU
        tV99lg/Nk3GYoRLOFhwowtwdmXY5aPM=
X-Google-Smtp-Source: AK7set9/6OO+1HqP1LXwHDjU1sOWrZZQXj88e8j9SHocwupKAN7znEQ7DkAzhaTwJwsXpTwyVCnCdQ==
X-Received: by 2002:a17:907:6e23:b0:92e:eecf:b742 with SMTP id sd35-20020a1709076e2300b0092eeecfb742mr2982706ejc.2.1678887824610;
        Wed, 15 Mar 2023 06:43:44 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709066d4c00b00914001c91fcsm2546201ejt.86.2023.03.15.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:43:44 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v2 1/2] staging: vme_user: add space around operators
Date:   Wed, 15 Mar 2023 15:43:28 +0200
Message-Id: <4bdfd864b573c164df30ec738afc93b06ce0d573.1678887330.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

add a space before and after the operator, for readability.

Reported By checkpatch script:

" CHECK: spaces preferred around that '+', '<<' and '>>' ".

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
----
changes in v2:
        edit commit message
---
 drivers/staging/vme_user/vme_tsi148.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 482049cfc664..bfa604043355 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -737,7 +737,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
 		return 0;
 
 	if (!image->bus_resource.name) {
-		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
+		image->bus_resource.name = kmalloc(VMENAMSIZ + 3, GFP_ATOMIC);
 		if (!image->bus_resource.name) {
 			retval = -ENOMEM;
 			goto err_name;
@@ -983,7 +983,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 		goto err_aspace;
 	}
 
-	temp_ctl &= ~(3<<4);
+	temp_ctl &= ~(3 << 4);
 	if (cycle & VME_SUPER)
 		temp_ctl |= TSI148_LCSR_OTAT_SUP;
 	if (cycle & VME_PROG)
@@ -2187,14 +2187,14 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 
 	/* Ensure that the CR/CSR is configured at the correct offset */
 	cbar = ioread32be(bridge->base + TSI148_CBAR);
-	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
+	cbar = (cbar & TSI148_CRCSR_CBAR_M) >> 3;
 
 	vstat = tsi148_slot_get(tsi148_bridge);
 
 	if (cbar != vstat) {
 		cbar = vstat;
 		dev_info(tsi148_bridge->parent, "Setting CR/CSR offset\n");
-		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);
+		iowrite32be(cbar << 3, bridge->base + TSI148_CBAR);
 	}
 	dev_info(tsi148_bridge->parent, "CR/CSR Offset: %d\n", cbar);
 
-- 
2.34.1

