Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184BB6BB55A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjCON5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjCON5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:57:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9683B3E7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:57:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd5so42026883edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJDmE8nLtNAwqzKNS3st8xzMZ28J8twt+9hFH7I9HWg=;
        b=qHaYVdwuHPj8qpV9Xal5hHjRjnbdzUQlXAra9/kKJ+L/8O9NWj5DAU7ZHrE/hI1tGv
         BAa+bqgVRr3987ebUhUYHFxwI6emihyFM/RhLaJCrkHaULqlRwnIC/x+UOmBGAP4mjwc
         vzYCcU06QAbB2l5NHzKMM8+8+5mG4KCLUTxQvAvBPZHtmRFbDqYmXY1fG4msgfqK/YA6
         BUiHBCOiGbu9UYhFxcvgjjsSuSS/JuW2cDWqMRhVya//uh00YwDBF9NYfqTRdCKreeBU
         jaNcUEx2YfEHptqDvgCFrw6aic4XgERCa+uvuJ3kOUyAh9w3H6UvNSxlyDn9ySsbz9bN
         dXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJDmE8nLtNAwqzKNS3st8xzMZ28J8twt+9hFH7I9HWg=;
        b=EIccVtQP0nyeH4nNLUf2QUdzszcsTp8Fj/NxrbmJyM4P9ZbxfSy1y3g4zodLvJObA+
         KR+Q185Vayl+7Mt2mYrm2dYZgRRJsrYvoe2QeFWyfcb7G5V41JixshHvkLein6y9Rt24
         E5hHBpmsoFcJaFg7pfAFjzS8pqXZsOi4NuxnD77KDJU/M+xkKEemEipBhYdSRl2fK90o
         Afja1wwEVTMWMi5ubI924EtrYkhcjoRuS3YEHTSxV7VT7AmsiWqIR5iXBoZYL6edTX6W
         D6nNhmnz2VDQSNSbdSIGn2/ajGDsl12AEKSPIKmJdyWiw0SsQNCYgVumjAhw6zJRtiCd
         EjXA==
X-Gm-Message-State: AO0yUKUj1Kj1Gg7pZRYlLCGdSC3yDxO97NXkUkXhgWmkwBPeSU/RXxuU
        P6g4Ua3Is9ea3SibhfM99p0=
X-Google-Smtp-Source: AK7set/pGW6K2Z8PjEPnatxCW7d6XUOxH4b4CCCzt6vSXSnp6bNCmW0nCHC4KdpOLQHk+462ckcFcg==
X-Received: by 2002:a17:906:f8cb:b0:885:d02f:d4ad with SMTP id lh11-20020a170906f8cb00b00885d02fd4admr5863877ejb.43.1678888641386;
        Wed, 15 Mar 2023 06:57:21 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id jz14-20020a17090775ee00b00926f89e2213sm2529441ejc.190.2023.03.15.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:57:20 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v3 1/2] staging: vme_user: add space around operators
Date:   Wed, 15 Mar 2023 15:57:08 +0200
Message-Id: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
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
---
change in v2:
        edit commit message
---
change in v3:
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

