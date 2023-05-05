Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F36F847D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjEEOF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjEEOF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:05:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC6270D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:05:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so13015635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683295521; x=1685887521;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzqCiS98IPcP1NO5D+IvEvMY4nJyl5P4wSObXpEuRpY=;
        b=bpKZtv/aAeervyGxt6hJ5jf921aCdGeuIvYwOlAd5vCAslhLMj/MEyeq4nHFL+hwf9
         ED3nywlxa2GqmtJzVdCCYkYFfTQbyYjyxi/X9ZTfV1I4Mo+9EfMKpZLpOs7mHh8zzymm
         Q2Ice9GsQhX4EXznSnL/NXKYywcPAn3hdgyRRyZO+VqbL4EZlAfjb7h0ssg/btxrvc2A
         Mnv54OYE3rQvoO7aMyIpUPQYpcXADGL5DM4hprWSse9L/pne+jutyCr0VaSw2wbf6k0B
         Ru+lG+TUTLDw7dQGZq+Mb6/IqYfmAnxjGLZzrBOlGedyIYwT/gJML71z2a0BzOWmTAB2
         ytdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295521; x=1685887521;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzqCiS98IPcP1NO5D+IvEvMY4nJyl5P4wSObXpEuRpY=;
        b=BeeTwIAjPEc9QxKKxUXLh3J+WFofxxfOOJKGEBrkHvnMzAyMJbL8MeCsmZb+0gmlsS
         vLUcQT96GH5N6BLtPtEkr6QgjQMpaeK2vzHrdLtSZahyL8e1mrB7MGuo/ujLwVYHY38N
         1F9yydkAxKSktXbK0pG1ZGsOSUOpt8PrFrDVsQjExsi/iBZ/p+z476XalPpFGmTGRQWt
         KQ0qzCxm8KNXNus4SHgRDK3A6pK4++agd8wqOZicVJlq7TXazlIEgT8MFwT7k885YsXR
         LbcysdwA6E6R7mK3ImAq8Nqg0twDcBvPlZOVBOAiZ9eBrH6asjdOZHHL4gszObtO2tiK
         K5zw==
X-Gm-Message-State: AC+VfDz0Q+cO6ytVBOsdIusV47RtrlnHK9y7v/B6Y0jZvW4KZMuyEB4s
        5kVSd/805F7Y77LTI7M8CH0=
X-Google-Smtp-Source: ACHHUZ7gbOnhc9STpFgcE/bQM1D6CfRmVBGNlFt05nMCk6igeMsP4gD6F5LqP/inTAFAJLNeLb2hpw==
X-Received: by 2002:a17:902:f391:b0:1a1:dd2a:fe6c with SMTP id f17-20020a170902f39100b001a1dd2afe6cmr1275756ple.53.1683295521501;
        Fri, 05 May 2023 07:05:21 -0700 (PDT)
Received: from ubuntu22-virtual-machine.localdomain ([211.218.36.103])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902740500b001ab09f5ca61sm1822217pll.55.2023.05.05.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 07:05:21 -0700 (PDT)
Date:   Fri, 5 May 2023 23:05:16 +0900
From:   Wonguk Lee <wonguk.lee1023@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] fs: jfs: (trivial) Fix typo in dbInitTree function
Message-ID: <ZFUNHFUr/IhyvTn9@ubuntu22-virtual-machine.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to fix the jfs UBSAN problem reported in syzkaller,
(https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2)

I found the typo in the comment of dbInitTree function and fix it.

Signed-off-by: Wonguk Lee <wonguk.lee1023@gmail.com>
---
Changes in v2:
  - Add the patch description and change the name in the Signed-off-by

 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..d8a03d3026cc 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3851,7 +3851,7 @@ static int dbInitTree(struct dmaptree * dtp)
 	l2max = le32_to_cpu(dtp->l2nleafs) + dtp->budmin;
 
 	/*
-	 * configure the leaf levevl into binary buddy system
+	 * configure the leaf level into binary buddy system
 	 *
 	 * Try to combine buddies starting with a buddy size of 1
 	 * (i.e. two leaves). At a buddy size of 1 two buddy leaves
-- 
2.34.1

