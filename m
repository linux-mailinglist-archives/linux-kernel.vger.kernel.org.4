Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBB6F7AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEEBUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEBUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:20:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727412494
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 18:20:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaea43def7so8049565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683249646; x=1685841646;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0soDqfw6362dujeUcWQ5P8Z55oslCidLxBQzR0OR5g=;
        b=TLSSFHC4/+nutVQAyNGbslhe+OJicKevchFGzKKnPrPaEfAyWKbRoCWUQpa5EQ66ne
         bqNZSrNW2gAehb2mQ2S7SPgZlmUHfFWi/2BJJ/FpooJkI5W0P9B7ie1Jmb5EiR1adFP9
         fmBJ2wX8WqQbEcjpvHUC9vHWhUxq5rTS71ElPpG0MDX1UPbbvA12TIzhQJ22nCHXCfiM
         yd+HiOoZmBJlrQrU7u5YY6LcOuOuvXBONvCvnrNM75nyEmdZH/tNrH6sw784WL+7RGl6
         +DOlWwqnD6CH9YI7z21986z3IEgzAtaAeZUBJK+Gzmdib4kx69yX/IlXYDuJEZHyKQAq
         q6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683249646; x=1685841646;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0soDqfw6362dujeUcWQ5P8Z55oslCidLxBQzR0OR5g=;
        b=NFoo7nFn79JjSzlQHbemB5eCvqUhZvOJA2pDAlM+6mAOVkwFfP3qkJWHF1qbAKbz94
         yc7KURrxnKgwBVGlDwvlcOd1YWLVVmiPmuAx9g9KpeZBO+U1BQ56g6RJnCJL6V97IZul
         WTZnd+Ov8L1hz2pvI0/AvfNNb/jlQoGjiabRGV/V1OgiO7pePTEU0948Hzi/HVRTgUn9
         7zS9ouYw1/VqygNUEcLVo57A5wSLInDl8qFQS3dEXB7MFxKfwcoB8LcbANzME/VsoYnf
         xlAZbdtuZqCmP9kMpr7wj8ScsBrbYtl/ULDC0RpcdjxTkT7yMfwTwDMnSWA3ieFNAy8g
         vC+Q==
X-Gm-Message-State: AC+VfDxiW0jiS8wzXAMA19rwXFFbsyLizeMITvjAbL4HAuSMaY9mmrwH
        7uIBuZoCWQnbxdi3ZEXc+i65hJSMoFCagA==
X-Google-Smtp-Source: ACHHUZ54hVNW8sc377s1AqcIhpKRNyKHeEd7ZYAA/6ulwj5hPj250Z/L+wAXPAyP+D0TL6KYMpGZwA==
X-Received: by 2002:a17:902:8c90:b0:1a9:3fab:3ebe with SMTP id t16-20020a1709028c9000b001a93fab3ebemr4578727plo.10.1683249645579;
        Thu, 04 May 2023 18:20:45 -0700 (PDT)
Received: from ubuntu22-virtual-machine.localdomain ([211.218.36.103])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b00199193e5ea1sm241636plg.61.2023.05.04.18.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 18:20:45 -0700 (PDT)
Date:   Fri, 5 May 2023 10:20:41 +0900
From:   "wonguk.lee" <wonguk.lee1023@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] fs: jfs: (trivial) Fix typo in dbInitTree function
Message-ID: <ZFRZ6UwxnrxLf6ZX@ubuntu22-virtual-machine.localdomain>
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

Signed-off-by: wonguk.lee <wonguk.lee1023@gmail.com>
---
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

