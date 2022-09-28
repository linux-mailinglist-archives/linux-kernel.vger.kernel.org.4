Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FE5EE893
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiI1Vra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiI1Vr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:47:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA602B636;
        Wed, 28 Sep 2022 14:47:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so1702804wms.4;
        Wed, 28 Sep 2022 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Y8BhmZH5AcD5sR0X65fMe7O7Q8DdK6Jv1JPYl8VWFjc=;
        b=aFgpKSSMgo3BcTcIbuO1zVk6bjzrs432caB8kYplv5HZeO7e/hfLgujSDZYlmgjnEX
         R84AGDVWlib/vLG64I7H3KtFOQzABh7H3iNXl+XvuF0QvlmrPe7L0/nYpOlAlYrMwnai
         7jTVU49PE3fZ7jdk3vgLFc1BeaOAPcWT8DT/cf0qJ/VR+yURysrXCmdYL6Pg9Nc1qNJ8
         zAtdzZUueZTyMia3bOKcC+8cqPzPryYb5zACq1Tz+0gSXjJOxVsPo8fSrS+4KVc2MLSK
         4SL9Lda8/bQdVE0zkvmoEzslvLVn9fyGXkUfDpLB7fi1uwt9oX+OLEM/Cf1NdBmTkXCF
         LaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Y8BhmZH5AcD5sR0X65fMe7O7Q8DdK6Jv1JPYl8VWFjc=;
        b=b69VDFatrpfS6/AdZ3/AbW1v0k9aBat11XA0oU6aiRdHKiS5jIp7hTcSqgO5mmDoZP
         uxNrjaKwdd0sGCNFNu06RPgXkIJXltuY2tiFs/WjK6ips/uSjAK2sSVpAJVSLsqtymJs
         r5Z6+514fg9mckpPToguIrygncBXlqIPmLD+wPuXUFIzagEG873XZ8l8lAfJ+hKyhIcZ
         /D7/fMXWDLgJ9WJMEop0TW6dgmlleNBZNIeG40aHJkvT47wZqYl9T/pACQTYkZRKNWYE
         Z6PlnVTBYFckDFDttafYpjHoEQaE51JG0490b83mjggyFZJzS8n2LGSqm7gfomrhqk2L
         Toww==
X-Gm-Message-State: ACrzQf1bzDRIRbwjspsvB02wajWXXT+zd3SzsM1hoFFtV/ZnebedTzQX
        kjaZBXq7G6y1BZiVxuHSo/M=
X-Google-Smtp-Source: AMsMyM7G4H2NtzDKbo7S+PKWD54yHhOPk2DvlxWMTKeD9KUECeVw+ku6w7fmHsgjCTICsVqppObneQ==
X-Received: by 2002:a05:600c:42d4:b0:3b3:3de1:7564 with SMTP id j20-20020a05600c42d400b003b33de17564mr45388wme.152.1664401646296;
        Wed, 28 Sep 2022 14:47:26 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00228a6ce17b4sm5103333wrr.37.2022.09.28.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:47:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] freevxfs: Fix spelling mistake "ivalid" -> "invalid"
Date:   Wed, 28 Sep 2022 22:47:25 +0100
Message-Id: <20220928214725.65284-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a kernel message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/freevxfs/vxfs_olt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 23f35187c289..48027a421fa3 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -63,7 +63,7 @@ vxfs_read_olt(struct super_block *sbp, u_long bsize)
 
 	op = (struct vxfs_olt *)bp->b_data;
 	if (fs32_to_cpu(infp, op->olt_magic) != VXFS_OLT_MAGIC) {
-		printk(KERN_NOTICE "vxfs: ivalid olt magic number\n");
+		printk(KERN_NOTICE "vxfs: invalid olt magic number\n");
 		goto fail;
 	}
 
-- 
2.37.1

