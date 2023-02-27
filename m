Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317E6A3C28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjB0IRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0IRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:17:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D61B337
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:17:10 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id r5so5759493qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7xaHTTjjwPzcROeiG6rMkbFuYzhGubT8ddT/2NI1II=;
        b=jrFhqOO/Q7AL0OwbKB0kyzg9htz8UY7+m3HXQ6tGkqK1jIntlMSScnfX4DR28XHlMi
         v5HLkZD46RcG6E4ZIMQ61ksYHPpNGljTObwzcA4fHWEnpexqnXvEqrnZQxphVms4lhBc
         ysOEmGFy5XvptLB89hF1uWe4rgyq5y6WA4eHbs71R24nD6YP6aIMpo3WEvmSmymuStO1
         Qet9yxTjo6T9XSMfb05UsIXw3h3vzJ9reXyDq8ICVgPZJK47g1lMtggh8hNbbBpiVNG3
         o8c0vihZUe51E2M5wZUeJrMpWw99QkG+/2feq0VWeW/U8mi6E4vDGmOt4sDiDv2E8Tbz
         JJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7xaHTTjjwPzcROeiG6rMkbFuYzhGubT8ddT/2NI1II=;
        b=YhArZ51i/gYq3X4ZsAF6POHtOT9l6KUCe7uGtc/baYovVKgIiGWJUL7IDfZWNcpeEf
         scpy0ktTaVDMPBP/1QtNvInsBippCW8pN1h9XwdkfgDiBJskers6BL0eO6s/VIrjtNA5
         iy6w/tkSuHGHMWwwfZ/vM9oitBDdgqd+4ikCNhrmV7ogkgjGkbNFPzucCSq5e/G6j8AD
         YH0G3WTtCtvQDCAxlYjPPm5rCY1jJZOLvJfLFYKc1NLkAaDG1r0gW8VARigYRNzYTn74
         p+vkU3rkpQjiXPEQptBxuHtz5aKKjS4KVi0yGGRvMXApvAEFExcbOeiGK666p7s3jrAJ
         cXrA==
X-Gm-Message-State: AO0yUKU8LFDAC2WCY3M4ETbWtZHXvqJ+rPfK9pgl5grqBEu71MU/IIF9
        SAiJLovw/E4H8AV4RrRSHf+NPhSRR3ZSOw==
X-Google-Smtp-Source: AK7set8LoBbOD6ZI28Zmw94NaEhIRWVBbo7qG03ZYN1OeZi/+GsZ+e6Kl904eQgKDmz1M9LZwgiTzg==
X-Received: by 2002:a05:622a:1002:b0:3bf:c7f4:24b with SMTP id d2-20020a05622a100200b003bfc7f4024bmr10372066qte.42.1677485829173;
        Mon, 27 Feb 2023 00:17:09 -0800 (PST)
Received: from localhost.localdomain ([154.16.192.130])
        by smtp.gmail.com with ESMTPSA id x2-20020ac86b42000000b003b635a5d56csm4265387qts.30.2023.02.27.00.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 00:17:08 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, unixbhaskar@gmail.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     hch@lst.de, acme@redhat.com, jpoimboe@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org
Subject: [PATCH] tools: scripts: Remove SH architecture build entry
Date:   Mon, 27 Feb 2023 13:42:53 +0530
Message-Id: <20230227081253.15909-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.39.2
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

As per Christoph's effort to remove the defunct architecture,which you can
see it here :

https://lore.kernel.org/all/20230113062339.1909087-4-hch@lst.de/

I have remove the sh related build option.

cc: hch@lst.de
cc: acme@redhat.com
cc: jpoimboe@redhat.com
cc: namhyung@kernel.org
cc: jolsa@kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/scripts/Makefile.arch | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index 0c6c7f456887..43bc1c4bf301 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -4,7 +4,7 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
                                   -e /arm64/!s/arm.*/arm/ -e s/sa110/arm/ \
                                   -e s/s390x/s390/ -e s/parisc64/parisc/ \
                                   -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+                                   -e s/aarch64.*/arm64/ \
                                   -e s/riscv.*/riscv/)

 ifndef ARCH
@@ -29,11 +29,6 @@ ifeq ($(ARCH),sparc64)
        SRCARCH := sparc
 endif

-# Additional ARCH settings for sh
-ifeq ($(ARCH),sh64)
-       SRCARCH := sh
-endif
-
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
--
2.39.2

