Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61C70CB39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjEVUfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjEVUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC4B6;
        Mon, 22 May 2023 13:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3001762BBA;
        Mon, 22 May 2023 20:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E043C4339C;
        Mon, 22 May 2023 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684787695;
        bh=XIX2yDn63uQ9xxgBYNjPu4x/2B0UpeRMuNabTt6UxWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2rAgK7xltyoIWKVyVkj6rwC5zqUbLDvW5Rq9rbpA8rTmzVfu5aNbZ1Ge4E3dW7xd
         wPuDx9IGe7R/m/hwaRUlNIR6ZLSSOJt1DW68fT7ppAeZo00YdTnTNFWpnzYapX64dR
         mApCcZpG+GnWsKaSaIDTYq2+X5u7fNghE2GoFwfC9ihE7Q7iGC+asOT7M57iXsMze/
         DCtwgF6Rb1yYhr7qruSP2JpqhOCh4wH6lxnZEB1PqUEFqw2URi9dmRCQeO8wy75w0I
         gJn82MRQXTiHUFBsMXtqpCwKQ5b/sf8D1y0CMz1MDJofx6Dn6jH2SYWTuTYJ/KnpFM
         QwLIQw3Wxm1nQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 4/8] maccess: clarify kerneldoc comments
Date:   Mon, 22 May 2023 22:33:48 +0200
Message-Id: <20230522203352.738576-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 4f6de12b375c37ba51f9412be7ed6ab44a7f71d8 upstream.

Add proper kerneldoc comments for probe_kernel_read_strict and
probe_kernel_read strncpy_from_unsafe_strict and explain the different
versus the non-strict version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20200521152301.2587579-5-hch@lst.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/maccess.c | 60 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3ca8d97e5010..d263c7b5e4eb 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -31,29 +31,36 @@ probe_write_common(void __user *dst, const void *src, size_t size)
 }
 
 /**
- * probe_kernel_read(): safely attempt to read from a kernel-space location
+ * probe_kernel_read(): safely attempt to read from any location
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from
  * @size: size of the data chunk
  *
- * Safely read from address @src to the buffer at @dst.  If a kernel fault
- * happens, handle that and return -EFAULT.
+ * Same as probe_kernel_read_strict() except that for architectures with
+ * not fully separated user and kernel address spaces this function also works
+ * for user address tanges.
+ *
+ * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
+ * separate kernel and user address spaces, and also a bad idea otherwise.
+ */
+long __weak probe_kernel_read(void *dst, const void *src, size_t size)
+    __attribute__((alias("__probe_kernel_read")));
+
+/**
+ * probe_kernel_read_strict(): safely attempt to read from kernel-space
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from kernel address @src to the buffer at @dst.  If a kernel
+ * fault happens, handle that and return -EFAULT.
  *
  * We ensure that the copy_from_user is executed in atomic context so that
  * do_page_fault() doesn't attempt to take mmap_sem.  This makes
  * probe_kernel_read() suitable for use within regions where the caller
  * already holds mmap_sem, or other locks which nest inside mmap_sem.
- *
- * probe_kernel_read_strict() is the same as probe_kernel_read() except for
- * the case where architectures have non-overlapping user and kernel address
- * ranges: probe_kernel_read_strict() will additionally return -EFAULT for
- * probing memory on a user address range where probe_user_read() is supposed
- * to be used instead.
  */
 
-long __weak probe_kernel_read(void *dst, const void *src, size_t size)
-    __attribute__((alias("__probe_kernel_read")));
-
 long __weak probe_kernel_read_strict(void *dst, const void *src, size_t size)
     __attribute__((alias("__probe_kernel_read")));
 
@@ -167,16 +174,35 @@ EXPORT_SYMBOL_GPL(probe_user_write);
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
  *
- * strncpy_from_unsafe_strict() is the same as strncpy_from_unsafe() except
- * for the case where architectures have non-overlapping user and kernel address
- * ranges: strncpy_from_unsafe_strict() will additionally return -EFAULT for
- * probing memory on a user address range where strncpy_from_unsafe_user() is
- * supposed to be used instead.
+ * Same as strncpy_from_unsafe_strict() except that for architectures with
+ * not fully separated user and kernel address spaces this function also works
+ * for user address tanges.
+ *
+ * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
+ * separate kernel and user address spaces, and also a bad idea otherwise.
  */
 
 long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
     __attribute__((alias("__strncpy_from_unsafe")));
 
+/**
+ * strncpy_from_unsafe_strict: - Copy a NUL terminated string from unsafe
+ *				 address.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @unsafe_addr: Unsafe address.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from unsafe address to kernel buffer.
+ *
+ * On success, returns the length of the string INCLUDING the trailing NUL.
+ *
+ * If access fails, returns -EFAULT (some data may have been copied
+ * and the trailing NUL added).
+ *
+ * If @count is smaller than the length of the string, copies @count-1 bytes,
+ * sets the last byte of @dst buffer to NUL and returns @count.
+ */
 long __weak strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
 				       long count)
     __attribute__((alias("__strncpy_from_unsafe")));
-- 
2.40.1

