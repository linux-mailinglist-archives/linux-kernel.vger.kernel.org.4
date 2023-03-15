Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2936D6BBA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjCORA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjCORAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:00:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C301B559E4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so48707186edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678899616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bThpFt7ecM4XEK4+UmZ8s/Q2y4cVJVw4hg9eF1s+C9s=;
        b=JBt2scHOn9ML2pxuv1XbAQehxjXtsRkovyFsCeOit6Kph11Ghs94PTl1nFLhb7YdsH
         9EEBpkWk77ZzsZ5c64ldnKBjzwWM+Px7XcEjqaPQISs2bn7cfLxX1ImsJOI5SpZYffrN
         /LDTw6xPF4zSTRZi5iebpz071dHuvdbNSc7p4Rh+bQ/1HL9KsCMnfws+OVMS2ZBSplTG
         s3pljQoGPPUL3ZJ6Hfepp6cFlLCTlbuVEEGdDggt2A/uO8vczSBWdyVZmQtzZCt49/Si
         VtvOBfG4d3YUi8AE/2y6K/ptOqMD1xZSZTlXjZDpXojwHK74JN7FUiDdv7bDEq/YO+yQ
         2zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bThpFt7ecM4XEK4+UmZ8s/Q2y4cVJVw4hg9eF1s+C9s=;
        b=FYaTWM5pjw0/dLG44UpPPePApwKJ66cUTHxy9eUnCkABehEre4yGwkN5j82ANRtPcY
         XtyZ3H+Ya7X2nyqknJgfQbI/PDxdYLNxBDHwr4q5/qfaOerinIXrtDve7CJLrXDwQpPQ
         7QaexUWDVqxLRXDsCSPDmyBy7vma1h4VyYgAAerLIi38JqlYfv9e2w/mX3Z4UPzsEBtc
         EkaFsk+tRjlxy58NUXSTCMwBC7qPazEZmZRrySiIszQYhNQKt4MpUJyE15igKqoiH6Te
         06MXm4zyOZpuNX/Udwkn+tN2xEPcEa4h8NcG4My1a2gUiQ8+UiwhrgFQbCulW+W9adX7
         Inyg==
X-Gm-Message-State: AO0yUKVGN2f+5GiMFPUQKXdD7oEfTT3/cdvfm5k/vcI9kLT6tn0oJn/d
        r/vfBbZpsLvbpsQrFl/xKeQ=
X-Google-Smtp-Source: AK7set8KqxGChd+10+eNCk53L7LRkWLuMM95PrJIZ6Ng1lUa3Y/dw2cuDJZwFw8olvwi+hoVb2G9EQ==
X-Received: by 2002:a17:906:e248:b0:925:51e2:e91e with SMTP id gq8-20020a170906e24800b0092551e2e91emr7146796ejb.71.1678899615845;
        Wed, 15 Mar 2023 10:00:15 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709060f9600b008eabe71429bsm2771895ejj.63.2023.03.15.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:00:15 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v4 1/2] staging: vme_user: add space around operators
Date:   Wed, 15 Mar 2023 19:00:06 +0200
Message-Id: <57006c151d4d95550b987143a6650f8b3594ddea.1678899549.git.eng.mennamahmoud.mm@gmail.com>
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

Add a space before and after the operator, for readability.

Reported by checkpatch script:

" CHECK: spaces preferred around that '+', '<<' and '>>' ".

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
        edit commit message

change in v3:
        edit commit message

change in v4:
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

