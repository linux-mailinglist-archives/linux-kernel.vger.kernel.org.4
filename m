Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978E26369F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiKWTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiKWTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:35:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202664563
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:35:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s68-20020a257747000000b006f0a255dcaaso1230308ybc.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jLDp8vw7aMAjJeFpfKO4YBrTiEXBAR482/YtAEl8kLM=;
        b=StbBjyKlYV+4Fmi48HCaiw3/kUn+TaFFIfxysSI2GTDPFB4sGjwArYVCQo4RB9c5TX
         7fs1A+RanhrUPWfJYtvyGHz1PosxUfw5Bx6zKDtbdIooKvA4GatIoDKYGmAdREAts4is
         Ai+ArGpnq8dNBk5B3PKZJoXLMXHu9rO8mt+b0c9dGeXqUwiJEzg1l8mdwr/nPbLottoe
         +1tn1HtMzl/3eyxWwr4KK4A31t9E1O97eOi+FnVrqQIKXiahGZkWdk70j/WrGx1NpEOQ
         v/WC0RC37QYEW69ewihq+gQ+3swcSlaKxOmdT91SarBzzAHFtUsJ5CMrLBmvNZtASpkK
         OIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLDp8vw7aMAjJeFpfKO4YBrTiEXBAR482/YtAEl8kLM=;
        b=ildHXfI4JI2NEVD1O5p4dRWl+0GK33F3PD83TS1+cbPd6vnTpR/NL23WBhGXiKt8RD
         YI+o5xhi4bp56xtFMIba4sn15dz0YmQCtD2VPJbzRyFhi/WD0pY70OgwP67xmVf7fVPd
         D8CKyeosHL5TrlKETYHfzIc+kagJ7POU2kJiXKBOswSl2iwGTm8a8i42vCxJW6dieT3Y
         1GHlKtOm5hwIoPd52ClM0H0BGArhL8AuljQfhz9+CHSJbjKrj18RfokMHvfsLdsGqz7s
         Xh13Vlh8s+hmJwKPVPTnxtPOuahwF6IZXHT8SftE6a3TV0m9IY4zjLN2gToFFRzd/v7m
         LffQ==
X-Gm-Message-State: ANoB5pnVb1a/5dssdBL01gHe7jmqArIQLbOhF1l6ktBQed/v3+1oFtv2
        Na6uipMO63eJ0qIEUEB+iAJhtuCpSZo1kWs=
X-Google-Smtp-Source: AA0mqf64/dZv6PYFgAQdc0HNOMo02CenM0lc/zGSzC7KJc/CKlNcE6pHRhd1zosA1sq0HjB/UDmS16gNfYq+Cl0=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:8249:0:b0:6dd:b521:a8f2 with SMTP id
 d9-20020a258249000000b006ddb521a8f2mr8883552ybn.380.1669232128681; Wed, 23
 Nov 2022 11:35:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 19:35:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123193519.3948105-1-tjmercier@google.com>
Subject: [PATCH] dma-buf: A collection of typo and documentation fixes
From:   "T.J. Mercier" <tjmercier@google.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been collecting these typo fixes for a while and it feels like
time to send them in.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c | 14 +++++++-------
 include/linux/dma-buf.h   |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index dd0f83ee505b..614ccd208af4 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1141,7 +1141,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment, DMA_BUF);
  *
  * @dmabuf:	[in]	buffer which is moving
  *
- * Informs all attachmenst that they need to destroy and recreated all their
+ * Informs all attachments that they need to destroy and recreate all their
  * mappings.
  */
 void dma_buf_move_notify(struct dma_buf *dmabuf)
@@ -1159,11 +1159,11 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
 /**
  * DOC: cpu access
  *
- * There are mutliple reasons for supporting CPU access to a dma buffer object:
+ * There are multiple reasons for supporting CPU access to a dma buffer object:
  *
  * - Fallback operations in the kernel, for example when a device is connected
  *   over USB and the kernel needs to shuffle the data around first before
- *   sending it away. Cache coherency is handled by braketing any transactions
+ *   sending it away. Cache coherency is handled by bracketing any transactions
  *   with calls to dma_buf_begin_cpu_access() and dma_buf_end_cpu_access()
  *   access.
  *
@@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
  *   replace ION buffers mmap support was needed.
  *
  *   There is no special interfaces, userspace simply calls mmap on the dma-buf
- *   fd. But like for CPU access there's a need to braket the actual access,
+ *   fd. But like for CPU access there's a need to bracket the actual access,
  *   which is handled by the ioctl (DMA_BUF_IOCTL_SYNC). Note that
  *   DMA_BUF_IOCTL_SYNC can fail with -EAGAIN or -EINTR, in which case it must
  *   be restarted.
@@ -1264,10 +1264,10 @@ static int __dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
  * preparations. Coherency is only guaranteed in the specified range for the
  * specified access direction.
  * @dmabuf:	[in]	buffer to prepare cpu access for.
- * @direction:	[in]	length of range for cpu access.
+ * @direction:	[in]	direction of access.
  *
  * After the cpu access is complete the caller should call
- * dma_buf_end_cpu_access(). Only when cpu access is braketed by both calls is
+ * dma_buf_end_cpu_access(). Only when cpu access is bracketed by both calls is
  * it guaranteed to be coherent with other DMA access.
  *
  * This function will also wait for any DMA transactions tracked through
@@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_begin_cpu_access, DMA_BUF);
  * actions. Coherency is only guaranteed in the specified range for the
  * specified access direction.
  * @dmabuf:	[in]	buffer to complete cpu access for.
- * @direction:	[in]	length of range for cpu access.
+ * @direction:	[in]	direction of access.
  *
  * This terminates CPU access started with dma_buf_begin_cpu_access().
  *
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 71731796c8c3..1d61a4f6db35 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -330,7 +330,7 @@ struct dma_buf {
 	 * @lock:
 	 *
 	 * Used internally to serialize list manipulation, attach/detach and
-	 * vmap/unmap. Note that in many cases this is superseeded by
+	 * vmap/unmap. Note that in many cases this is superseded by
 	 * dma_resv_lock() on @resv.
 	 */
 	struct mutex lock;
@@ -365,7 +365,7 @@ struct dma_buf {
 	 */
 	const char *name;
 
-	/** @name_lock: Spinlock to protect name acces for read access. */
+	/** @name_lock: Spinlock to protect name access for read access. */
 	spinlock_t name_lock;
 
 	/**
@@ -402,7 +402,7 @@ struct dma_buf {
 	 *   anything the userspace API considers write access.
 	 *
 	 * - Drivers may just always add a write fence, since that only
-	 *   causes unecessarily synchronization, but no correctness issues.
+	 *   causes unnecessary synchronization, but no correctness issues.
 	 *
 	 * - Some drivers only expose a synchronous userspace API with no
 	 *   pipelining across drivers. These do not set any fences for their
-- 
2.38.1.584.g0f3c55d4c2-goog

