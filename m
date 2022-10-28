Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A6611101
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJ1MST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1MSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:18:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7986B177
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:18:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so8060028lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dY7Y+da7X9K9O4Ac5PtXq8SnkiyCLSRFHFISMn8IhE=;
        b=DU/ltOdllZxhJVdhSGGBTsAkXZC5s2ayfhqb/2pf8/3L9WCb7vmJSPARaIteVgy/C6
         qefskjshrJUgmbJvibi3tHq0ZBku8XhlPA3Rz2pqtcKr/QEXOySEOD0e5hhfX6/nqS7D
         dsFXf7B8regkLIC4WtjeGV3BelF8TQs7tkv20VdQABoAPosbWtzVEYiommR6l7x9ruom
         I+a9bRGWQFtWVRyLquZEZYbaBp374LTir4XJFDPoGs4sRXHMirMUQFTuw28kif3drxGs
         aNRC8BAwblSSghNY2r4gkPVmm7Q0vU6C9ifwEyg8kXzCOoVZrTd9PaDMgNXTlUY3qLOv
         ze7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dY7Y+da7X9K9O4Ac5PtXq8SnkiyCLSRFHFISMn8IhE=;
        b=RbiumrMym9KzbSwmAo8/iD3c7+tC2bxQBsHA9+olTGRUWZholrQB3QcjsnWpy8+5fB
         rCjiIfVIVYC7kH6GRHez+bZ7tKLBd5hQvquR8JRjdxrqsWq/9EA/SfM+ta/vZPMtu/Vg
         nf5E4BKlQg/xjUPbal38UtUNae9ClhQAi+qa3pYoVgtaxWlyOfouZhWmSB9uQURcdYT1
         mrwAZHaOiDWUa7lLD52e0palzWOXskdcdqHcGTyQhDkfFhZ/iUR2eaN9zT9Z4xVQ1HcN
         BHReMA7wSfdxd+0F5ACzjDCNkAnTzdutDxq4KMoE95+sTMoHwA4ecKXnTmsDgy6ozdca
         QiFA==
X-Gm-Message-State: ACrzQf24oKkKAmagANLKJgEatKiRS+5LLek1AEFRSsJp09uCWUgdv/0L
        Gk/8IPq3os0V9nFBiOxi6uxwx1JWUABdfA==
X-Google-Smtp-Source: AMsMyM4c64YK1SqRcBUqVGXKUB+3puqxMCX6YfubK8Z20vazKfoyf++BNBmBQ6mfJ01bOyalCKPcYw==
X-Received: by 2002:a05:6512:2213:b0:4ae:8476:2ce with SMTP id h19-20020a056512221300b004ae847602cemr7356152lfu.0.1666959495019;
        Fri, 28 Oct 2022 05:18:15 -0700 (PDT)
Received: from localhost.localdomain ([95.79.189.126])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b00277041268absm618550ljp.78.2022.10.28.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:18:14 -0700 (PDT)
From:   Oleg Kanatov <okanatov@gmail.com>
X-Google-Original-From: Oleg Kanatov <okanatov@astralinux.ru>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Oleg Kanatov <okanatov@astralinux.ru>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, Oleg Kanatov <okanatov@gmail.com>
Subject: [PATCH] jfs: Fix a typo in function jfs_umount
Date:   Fri, 28 Oct 2022 15:16:39 +0300
Message-Id: <20221028121639.19341-1-okanatov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
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

When closing the block allocation map, an incorrect pointer
was NULL'ed. This commit fixes that.

Signed-off-by: Oleg Kanatov <okanatov@gmail.com>
---
 fs/jfs/jfs_umount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 3e8b13e6aa01..673e132c1c26 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -89,7 +89,7 @@ int jfs_umount(struct super_block *sb)
 	dbUnmount(ipbmap, 0);
 
 	diFreeSpecial(ipbmap);
-	sbi->ipimap = NULL;
+	sbi->ipbmap = NULL;
 
 	/*
 	 * Make sure all metadata makes it to disk before we mark
-- 
2.30.2

