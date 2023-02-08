Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0968ECAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjBHKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBHKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64115568
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1851821pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFDa6RzFjbYJQKnaADEQ469/RoyljuIaxBNPhmYoeo0=;
        b=j8s42LpmW6Y2jpUh2/r/k420Dqx2Nj/DoQrajguzkxbPLNszzOy+J7zKfE+kAyeMMp
         PLJoSocqe/R/SI98XlpLBbbaF1A/1XGVCWnuP5e/k9jTNDxscp/ksIl0H8BwQl5Nxk1A
         g6qid9M60K8mNPYoqZmiFc9uAZFCJnxqksJM8rOCeKERTLgB8qvDO0U5F/llDF1lKew9
         MfDXFn7hcA1gdLNJz/plwyySU98VmpDC67pv4tEVkpa/war5rLiK77ydKPeYt2I+HyWq
         m71Ubk3u1uPECcqero5CwYuR72LNVM8mFHuIwOVnz2ENLwCHkUa5Ao3sTQLk9XJwa+sn
         zL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFDa6RzFjbYJQKnaADEQ469/RoyljuIaxBNPhmYoeo0=;
        b=Gxp/++B+lcMFyZ40Ono+3BVjmAxAatsdxvMURuoaoIIhZ4O8nDHKwCLcxJU1nic8Hd
         Mq3AXdlUQeSjTS+u0dB8ia4Y55EzZe/qS7Toe/fT5vCi7iGKOJdvGKIg3YV3Sh832JxN
         RvY41qt+v8ayHhqly6ZemTnJYs2meIywe+4eZXuXNWwT6pbPrZzGMkkvtf6UenItJuuQ
         UfSfwySxIs4k5ljG4GbbY3gSXHghbotMd3C4gJpGsUSzNc8CTE7TTyplXHgS8H+c+tfl
         zI7UNOdqtyhWwQb5gGi2VsGarX0p4IT+Bj0GWdMZwGCNWb3YJPiut2e/V1ENEyDO4NPE
         tYaA==
X-Gm-Message-State: AO0yUKUldgNU8huCJ+tit+1w0xVuWqEspP5if7xMTdBN1XArDVCJ6Ttr
        NA94reTj1D0bcjx//1D+vWs=
X-Google-Smtp-Source: AK7set9/EE2raGMoytste5SzOwD31oKFjlIJABzy3vfltf46sSpJUgS0bi1S35nFZu7qy7+P+NcL4Q==
X-Received: by 2002:a17:902:e844:b0:196:8dce:82eb with SMTP id t4-20020a170902e84400b001968dce82ebmr7551286plg.66.1675851490266;
        Wed, 08 Feb 2023 02:18:10 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:09 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] tools/nolibc: Include linux/fcntl.h and remove duplicate code
Date:   Wed,  8 Feb 2023 18:17:50 +0800
Message-Id: <cf503323a85a90dcc8040a1b07a6448b97cf6b5c.1675851111.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675851111.git.chenfeiyang@loongson.cn>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
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

From: Feiyang Chen <chenfeiyang@loongson.cn>

Include linux/fcntl.h for O_* and AT_*. asm/fcntl.h is included
by linux/fcntl.h, so it can be safely removed.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/sys.h   | 2 +-
 tools/include/nolibc/types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b5f8cd35c03b..c4818a9c8823 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -11,7 +11,6 @@
 #include "std.h"
 
 /* system includes */
-#include <asm/fcntl.h>   // for O_*
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
@@ -20,6 +19,7 @@
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
+#include <linux/fcntl.h> // for O_* and AT_*
 
 #include "arch.h"
 #include "errno.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..a3651c514e2f 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -60,11 +60,6 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
-/* Special FD used by all the *at functions */
-#ifndef AT_FDCWD
-#define AT_FDCWD       (-100)
-#endif
-
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.39.0

