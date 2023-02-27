Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741256A361F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0BRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0BRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:17:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FD976C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lBntms4MR6Hm13fIEEtkmC5JJDB9/ZPSCSFm0g7kE4o=; b=yNEtOTfndMqvux2RjDJMdw27lS
        2/yJe999XaC2bVTfobPlQM4COhIe97qQCPSTTBkZv8kwG7fiw4b96UXElmF/pNb4uUm2EZyOsEGba
        3E5HZxVKzb8I/Ws33OQ25NrJAHUGMamUj9oBv/w5Lclhp9reO31xp9Arnw4KFE+r8nqGOmZmQabqc
        96BYVgFDXZxrpbiuLHtnVT4JYVwqGkwDq9KAiNFqEDZt5aWe8/KQMwtK8vInu0rcjHUb84bKvL7Z1
        50c1gGMPeN6bylaDcRWkBHuKam+E6NwlVxllOtS41Ihxn+JLmrTAp/+PzP+ndboANTSFBPCroe1j0
        76iMtHcA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWS8T-0089OP-03; Mon, 27 Feb 2023 01:17:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] instrumented.h: fix all kernel-doc format warnings
Date:   Sun, 26 Feb 2023 17:17:00 -0800
Message-Id: <20230227011700.23947-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 26 kernel-doc notation warnings by converting the function
documentation to kernel-doc format.

Warning example:

instrumented.h:155: warning: Function parameter or member 'to' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'from' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'n' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'left' not described in 'instrument_copy_from_user_after'

Fixes: 36e4d4dd4fc4 ("include/linux: Add instrumented.h infrastructure")
Fixes: 00047c2e6d7c ("instrumented.h: Introduce read-write instrumentation hooks")
Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
Fixes: 888f84a6da4d ("x86: asm: instrument usercopy in get_user() and put_user()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/instrumented.h |   63 +++++++++++++--------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff -- a/include/linux/instrumented.h b/include/linux/instrumented.h
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -15,12 +15,11 @@
 
 /**
  * instrument_read - instrument regular read access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular read access. The instrumentation should be inserted
  * before the actual read happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_read(const volatile void *v, size_t size)
 {
@@ -30,12 +29,11 @@ static __always_inline void instrument_r
 
 /**
  * instrument_write - instrument regular write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_write(const volatile void *v, size_t size)
 {
@@ -45,12 +43,11 @@ static __always_inline void instrument_w
 
 /**
  * instrument_read_write - instrument regular read-write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_read_write(const volatile void *v, size_t size)
 {
@@ -60,12 +57,11 @@ static __always_inline void instrument_r
 
 /**
  * instrument_atomic_read - instrument atomic read access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic read access. The instrumentation should be inserted
  * before the actual read happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
 {
@@ -75,12 +71,11 @@ static __always_inline void instrument_a
 
 /**
  * instrument_atomic_write - instrument atomic write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
 {
@@ -90,12 +85,11 @@ static __always_inline void instrument_a
 
 /**
  * instrument_atomic_read_write - instrument atomic read-write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic read-write access. The instrumentation should be
  * inserted before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
 {
@@ -105,13 +99,12 @@ static __always_inline void instrument_a
 
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
  *
  * Instrument reads from kernel memory, that are due to copy_to_user (and
  * variants). The instrumentation must be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
  */
 static __always_inline void
 instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
@@ -123,13 +116,12 @@ instrument_copy_to_user(void __user *to,
 
 /**
  * instrument_copy_from_user_before - add instrumentation before copy_from_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
  */
 static __always_inline void
 instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
@@ -140,14 +132,13 @@ instrument_copy_from_user_before(const v
 
 /**
  * instrument_copy_from_user_after - add instrumentation after copy_from_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
+ * @left: number of bytes not copied (as returned by copy_from_user)
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted after the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
- * @left number of bytes not copied (as returned by copy_from_user)
  */
 static __always_inline void
 instrument_copy_from_user_after(const void *to, const void __user *from,
@@ -158,12 +149,11 @@ instrument_copy_from_user_after(const vo
 
 /**
  * instrument_get_user() - add instrumentation to get_user()-like macros
+ * @to: destination variable, may not be address-taken
  *
  * get_user() and friends are fragile, so it may depend on the implementation
  * whether the instrumentation happens before or after the data is copied from
  * the userspace.
- *
- * @to destination variable, may not be address-taken
  */
 #define instrument_get_user(to)				\
 ({							\
@@ -175,14 +165,13 @@ instrument_copy_from_user_after(const vo
 
 /**
  * instrument_put_user() - add instrumentation to put_user()-like macros
+ * @from: source address
+ * @ptr: userspace pointer to copy to
+ * @size: number of bytes to copy
  *
  * put_user() and friends are fragile, so it may depend on the implementation
  * whether the instrumentation happens before or after the data is copied from
  * the userspace.
- *
- * @from source address
- * @ptr userspace pointer to copy to
- * @size number of bytes to copy
  */
 #define instrument_put_user(from, ptr, size)			\
 ({								\
