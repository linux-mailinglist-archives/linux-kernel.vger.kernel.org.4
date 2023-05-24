Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE470F6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEXMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjEXMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:42:47 -0400
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E719D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1684931858;
        bh=CFJjKPMIxMN/cffq3D0k2e9pOGmv8eDy87G58WfCYJ8=;
        h=From:To:Cc:Subject:Date;
        b=AekifiqWPwVL/AzXh5Jln6f3ttgBWfuTC5y7yTkXsz37D7Xa/imWaK8I9QqPvOMJ1
         RVDXmAuZe0DZtaYEjnQGiqfrdTwgw5EWecClzl8U3/0uFUYTgh7JLhkF5s87kpIEJy
         9K/jjseKthkjbbL/Zcd0x3YoR9FY7ZhWGWIVZ+Cc=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 7DE09484; Wed, 24 May 2023 20:31:30 +0800
X-QQ-mid: xmsmtpt1684931490taxo6w62d
Message-ID: <tencent_F53E159DD7925174445D830DA19FACF44B07@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSLD9jovFwzAlkWq1WcscZo42HaCV9f0whEbbxK5w/nA+VvriYgy
         cQpkNB9yn2l/bMyqqDRdcI7phuvgIkxLIedqP1rQ1sAGMqzVLcQMp3ukQyjMwr0cCTy+q0l3XIAJ
         rFPqDoP0T4GSOBqiKVPfL7Y4IfpOS0oJF0S2jWDZRUB8VnjsBtQCmkjXqjngEizG9G+R5U5VOS+4
         0DOQ/C17+2KrwyZQUYHnCBHrQl00lh1XMusxsMj4gj8SDcXRJhcEhh2jxtYuoWoGBfVzE3tDt0aQ
         yMxXUWCP8V9/VGS4pz99x2f9XdNXndR0gBNWATSjn7Qtz5vTfw0WsAnlyFDdBuRgNvfCjho00Imi
         SpgV8WLM/iS4rwk+Dg6VuoEmX6yA73Vckk8e17LSGO5bgAgpDHNVOhTfEPEnXWOZ2zKW4ZGNLmTm
         d14HE9+ujcAkHpE1q0MRSm/1dnbSavHa9CTyRX+meIkt9pXxKkHyXNqwBxPijZWe4A3S9oPeA4wY
         wA6S+I8Rclp8SRHbRwGAK8weyD1XtsPwZypBFhFQL2Y1VTap4RApqnwuCea98yghevrO7TJCc8+w
         XdZN6wkkXWEMsvlzEoHtsNA4zPu8EFbtirOGaTA34iCJ4fGPlaP9aYN0+n1CniLDB/sWPjzUVlDk
         epl/luv/i5iap5vXcSn9CDmoOPDIrHgt5Eds9LlTAUbWshfmyzS+JMi4gdE3j8oNLogz/TRTInnc
         8JRZJsK6381Oy5LkxUCGx42NJbGRJ0LNIAPZTPwRJIYIjCs+DQFNWBruPRIkSZ1rF6VoWa5/S2xq
         4p/zbMahst09HRPPDEqOyUJi7HM9iGqKc22qBCUcsIQ2DSPRNT8BMO1Ryf4AU3dboC3Lo9sq0jVX
         SF4voA7DyeqouFf6/ybR5uzyk0aaS6AxjzpXoE89DukmOLff4I/S+f3Yo2kqCx7CtMwM5uRGXfI+
         OSoWAYdPjJl5MiDNBjpg==
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     rongtao@cestc.cn, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/virtio: Fix arm64 ringtest compilation error
Date:   Wed, 24 May 2023 20:31:24 +0800
X-OQ-MSGID: <20230524123125.14585-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Add cpu_relax() for arm64 instead of directly assert(), and add assert.h
header file. Also, add smp_wmb and smp_mb for arm64.

Compilation error as follows, avoid __always_inline undefined.

    $ make
    cc -Wall -pthread -O2 -ggdb -flto -fwhole-program -c -o ring.o ring.c
    In file included from ring.c:10:
    main.h: In function ‘busy_wait’:
    main.h:99:21: warning: implicit declaration of function ‘assert’
    [-Wimplicit-function-declaration]
    99 | #define cpu_relax() assert(0)
        |                     ^~~~~~
    main.h:107:17: note: in expansion of macro ‘cpu_relax’
    107 |                 cpu_relax();
        |                 ^~~~~~~~~
    main.h:12:1: note: ‘assert’ is defined in header ‘<assert.h>’; did you
    forget to ‘#include <assert.h>’?
    11 | #include <stdbool.h>
    +++ |+#include <assert.h>
    12 |
    main.h: At top level:
    main.h:143:23: error: expected ‘;’ before ‘void’
    143 | static __always_inline
        |                       ^
        |                       ;
    144 | void __read_once_size(const volatile void *p, void *res, int
    size)
        | ~~~~
    main.h:158:23: error: expected ‘;’ before ‘void’
    158 | static __always_inline void __write_once_size(volatile void *p,
    void *res, int size)
        |                       ^~~~~
        |                       ;
    make: *** [<builtin>: ring.o] Error 1

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/virtio/ringtest/main.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index b68920d52750..d18dd317e27f 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -8,6 +8,7 @@
 #ifndef MAIN_H
 #define MAIN_H
 
+#include <assert.h>
 #include <stdbool.h>
 
 extern int param;
@@ -95,6 +96,8 @@ extern unsigned ring_size;
 #define cpu_relax() asm ("rep; nop" ::: "memory")
 #elif defined(__s390x__)
 #define cpu_relax() barrier()
+#elif defined(__aarch64__)
+#define cpu_relax() asm ("yield" ::: "memory")
 #else
 #define cpu_relax() assert(0)
 #endif
@@ -112,6 +115,8 @@ static inline void busy_wait(void)
 
 #if defined(__x86_64__) || defined(__i386__)
 #define smp_mb()     asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#elif defined(__aarch64__)
+#define smp_mb()     asm volatile("dmb ish" ::: "memory")
 #else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
@@ -136,10 +141,16 @@ static inline void busy_wait(void)
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
 #define smp_wmb() barrier()
+#elif defined(__aarch64__)
+#define smp_wmb() asm volatile("dmb ishst" ::: "memory")
 #else
 #define smp_wmb() smp_release()
 #endif
 
+#ifndef __always_inline
+#define __always_inline inline __attribute__((always_inline))
+#endif
+
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
-- 
2.39.1

