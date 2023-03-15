Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8896A6BB0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjCOMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjCOMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:23:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907196099
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:22:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so27388400edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678882935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjHFnp5bJinWS5RImL+eK7KNDvpSA4xz6wqID74GC5s=;
        b=SXoF7Golk1Y2VkPCoRqfyP1j+FvJTOZeAS52sajIrkZKqf6dqRQrcHzQE5A5H1JP6T
         TRByK/AMbmj5K3azjGrIe5fFNnzVLAdVsGkJ9bfsxuYksCj5LHVVWkvEemVl9lbx528U
         3aV+ECU19PjaIk7dSD6/iQll0K6kyrqJpLI8P9QvdgzY6VhzYJoeKm6S0swj1xCDtKcH
         5bJXrE+I367vtmiMfjBB1/euUnUEu5TEPb83SeLQ2cneCFlKLmjFGcllLt2/2Vx9JiD9
         +LzPJRDny/H2t2yZgoRnLyyVQwKWqemWGmZ3Q86l4C16ajwtEdnD2RH8BHsGGOizDUrd
         +ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjHFnp5bJinWS5RImL+eK7KNDvpSA4xz6wqID74GC5s=;
        b=syyq+CYh3XOMFfi2GLyQbzsZ/NEwmWCJS+mRsJDZFZ/Feqy4xOtMmJ3F4K4gWZSmz9
         +mV7tTtdalIFK8pUrfRQoczoUGAXamDIknPonrE89w5lvttYOkmNyTQy9zNjC1P+IPNP
         mrlXGlOQvNdoaPGkuHaNue3rbVBo3nXjuiucp26wzYwQSkUrP90ZG/BfbgvcY8PRkJ9x
         i8eVc2CwPP1APfomX+c+0ICnSzRsYEDmjDmA5kFF3La06LO9Z6WMo/UcZlcEmHm7j87V
         0jH5R8QqThZWi56azmhRJBP8iuc6cEpdEpGt84YZGozqFYmhhlR7hmzt3VYgMnEJRol/
         /HeQ==
X-Gm-Message-State: AO0yUKXjfwTizZhAkxXg7tUpGr8e/TbXHsNiEBIVNQmL2bHy9Nf/d6Lx
        4ZQg8jlNaHsQD7L9UXcT+3E=
X-Google-Smtp-Source: AK7set9uxUV1N8TEcyw16Tm7CPr7fkDtoIhRtiDV1LxgJNsApzeX2pHMWVbnZOMS4zEEHt+3cYXVVQ==
X-Received: by 2002:a05:6402:10d6:b0:500:2cc6:36da with SMTP id p22-20020a05640210d600b005002cc636damr1235796edu.19.1678882934963;
        Wed, 15 Mar 2023 05:22:14 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id m1-20020a50d7c1000000b004fc856b208asm2383663edj.51.2023.03.15.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:22:14 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 1/2] staging: vme_user: add space around operators
Date:   Wed, 15 Mar 2023 14:21:32 +0200
Message-Id: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
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

CHECK: spaces preferred around that '+' (ctx:VxV)
+		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
 		                                            ^
CHECK: spaces preferred around that '<<' (ctx:VxV)
+	temp_ctl &= ~(3<<4);
 	               ^
CHECK: spaces preferred around that '>>' (ctx:VxV)
+	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
 	                                   ^
CHECK: spaces preferred around that '<<' (ctx:VxV)
+		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
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

