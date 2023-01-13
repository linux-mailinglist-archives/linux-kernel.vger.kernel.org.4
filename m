Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5955669819
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjAMNME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjAMNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:11:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5492636315
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:59:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bj3so19160165pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=;
        b=VV85mTEQK8exgFDT+XzgtYq+QugP5JE+PB6JlYPa9LAViXHvUXXi9pkeXQoygkxM8q
         ydImAB4McSvmNf5y7RSPUkFL6vu6OEqJly0/OM6h/y1QV3QGmQbWriasYxiBl1GBiuOX
         8JX/IvhF+uw/tySM1pT4zK1+LaZvUPWUDH5VMY0gptUBESE4PbpKKaKqRkefhrkZspBk
         9YaI9FD/z+HVhhWMxqUReQSzJJtaYTfijWbe+xXuu2ssDbOQNsAofz9G1s20TuFvh6h9
         cuXBrZoWARdcTprcOWTzuwfdu4g6NnsYjhokDzuEPOoEa5506v4qYW7oA/levKXOTDyG
         r93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=;
        b=OVGLDpHT9sDScrupGnF29k4xLArSw1YKz8eNKqqAPgFXOlIr73tKV5L95YjBiMCTfM
         Rr3V6pg30jMnCmYOVjcB2xNU8Sx8kDy8ydILZNQElPM7jZYB1QX22sQB1RyVN6zu1+25
         GMfbKK5yTYIzdnSZHsa/9DiRWGVyb1uZRBAPQmLP8VKe4M6aeRByZMzin025yxL7mUkV
         b+gHCL+PS0nG3HHFP345JZuuPbVE/8x6ytypSPg1B2QUEPLHydwXGz2zkdkljxDWqtKM
         eO572Apt2pmh1AME1YOiD0T/OzSksmcl39Z3ZyMluctnavns8yGV7UByscSzba8Rd+qX
         zoGQ==
X-Gm-Message-State: AFqh2koamNGtTZuOV6dq6h0YNd/wJYCxuGcNLarV6auOQZaIe606Jc3A
        hhLVH9GEoYaFkUQYt2QqB6wUFgSNRVo=
X-Google-Smtp-Source: AMrXdXvgn07KG5wMlDNEbDZr8oWO9g6pnJe6P4oA+ehqvt3qrwt1UvniqAt25BeVV0jBblXuVkbrEg==
X-Received: by 2002:a17:902:c948:b0:188:a6ea:279f with SMTP id i8-20020a170902c94800b00188a6ea279fmr109457559pla.12.1673614759801;
        Fri, 13 Jan 2023 04:59:19 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001944bf0b57asm5453820plr.204.2023.01.13.04.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 04:59:19 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, xiongping1@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH 1/2] f2fs: fix wrong calculation of block age
Date:   Fri, 13 Jan 2023 20:58:58 +0800
Message-Id: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we wrongly calculate the new block age to
old * LAST_AGE_WEIGHT / 100.

Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
                + old * LAST_AGE_WEIGHT / 100.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 342af24b2f8c..93a1ab186517 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -874,11 +874,7 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 static unsigned long long __calculate_block_age(unsigned long long new,
 						unsigned long long old)
 {
-	unsigned long long diff;
-
-	diff = (new >= old) ? new - (new - old) : new + (old - new);
-
-	return div_u64(diff * LAST_AGE_WEIGHT, 100);
+	return new - new / 100 * LAST_AGE_WEIGHT + old / 100 * LAST_AGE_WEIGHT;
 }
 
 /* This returns a new age and allocated blocks in ei */
-- 
2.36.1

