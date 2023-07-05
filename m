Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E77484B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGENPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGENPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:15:18 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8651700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:15:16 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b3f722fdafso101128fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688562916; x=1691154916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7IBSzLx2BKQyuc64R/8yQcG7ZKpuKKGPwzKfgcwMHo=;
        b=BjvTQt6gUPtAP24bf00pU1LGgVYwqpEAxiKvjIYiwJ6PrgRTpeuZ8Zev/ox7+UE4aD
         9xWlzPvke/RO+YCv4gVkvKmn93On0UiqWbKHoR+PcKsthmYDpYXhZ1qUi/EGhVlPpieC
         QRCwX6n+qvt2Q2lz0BNo/bhWfaTDeM5bH5j88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688562916; x=1691154916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7IBSzLx2BKQyuc64R/8yQcG7ZKpuKKGPwzKfgcwMHo=;
        b=aGayeF7fcT9P0r7NEzT9htw3pzS36UPkzbzd6+3G/Rzu93H5+6zHShns6xVSZ9gKcs
         3ByPvhVcbmlfbu7XbYU2L/faWQGe0nTUQ232XvSUUyhq3lAp703DYMp/ru81/HIGnfxh
         Rl6Cc92qgu+N7OLNoOC1aHvoDR+FobY+NVxctdPUdWJBQ7ZHIL6YIh3VBT3p0zwWWI9K
         vzxNrNy4purbWg9qummbwGO/I+hSpW8geOehvJEsMaJxkB3YvZjG4ZDhyBwP4Vtj8AGL
         9XC18KMCIxIjkF8NFpw7uNeXXyIuiN/DkK3Pp1IG6ykxX4XpX8gpoFuFTfESeE2+qVRW
         FATg==
X-Gm-Message-State: ABy/qLYL7AR0imLgxsgPs7FI6o/x8WwH0T7NjcyptcRacRqsGdD2lXGD
        lDyL0HVUo2vXJ39lX9eQmJCa9Q==
X-Google-Smtp-Source: APBJJlG4tmoTS0lNCzco8q9F+nRhtIAneWOJesJon34d7q4QCr+dxu8jsn2GgLuNskiL7ZK5pRIxxw==
X-Received: by 2002:a05:6870:9a1d:b0:1b3:f166:72da with SMTP id fo29-20020a0568709a1d00b001b3f16672damr1084553oab.41.1688562916022;
        Wed, 05 Jul 2023 06:15:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6094:6c14:daf8:eb68])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a74c100b00263dab4841dsm1409676pjl.30.2023.07.05.06.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:15:15 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] MAINTAINERS: adjust printk/vsprintf entries
Date:   Wed,  5 Jul 2023 22:14:34 +0900
Message-ID: <20230705131511.2806776-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M should be earned.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15ce1f07d9f7..42b3b05f8473 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17037,9 +17037,9 @@ F:	kernel/sched/psi.c
 
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
-M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
+R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	include/linux/printk.h
@@ -22796,9 +22796,9 @@ F:	drivers/net/vrf.c
 VSPRINTF
 M:	Petr Mladek <pmladek@suse.com>
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
+R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
-- 
2.41.0.255.g8b1d071c50-goog

