Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33B05E57DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIVBNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIVBNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C94CA09
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 94EF55C0151;
        Wed, 21 Sep 2022 21:12:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Sep 2022 21:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809179; x=
        1663895579; bh=qknF5tcmy+B2CeTlFoEm9W1xIUxKlOolFzMt14jmfpk=; b=X
        2bHIeLYGPhTCPgQDwNnhPXIt7MWjcmMCp5OZlT5Mkm1hwHTtIYOmhhbvBieCR2yv
        q3SIY3EojmIMybIMbpb2TbtdtHpVmAqudy1+WlKTAhPVj+ID2hiclyag1lu/20ZH
        7uHC/UM84HyHFhP7ynvU21zoJ6I3LRzuQ4PtCVKEGH06hM93mc9d9Gd9WYZ7CuIe
        WXlQUwqxKDZjl1BG4x2M114vZ2zfvcs1LDkLhzDirl+qFkSEsHybRnJDpDlSxaFD
        waoQM8AM5KSyj4asoHtK4OqmtjaY2pS54OBbBP6Q5x7FM+szqG5zo7YA8wObOG8s
        T3rQEqILXpkiz/nglpygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809179; x=1663895579; bh=q
        knF5tcmy+B2CeTlFoEm9W1xIUxKlOolFzMt14jmfpk=; b=Mk7vLLrcqb21dqzZS
        mmBHP6QqHTSiDjdqwagKJmEE+MDzrCh/m1bOcoJqTg4rm5jSgxOoWwHynF8QRfhY
        05Bw4XyuEEscpaGL26H3lyMmqa3aATo5Q+jEypMQQh2QgYhgWx23C4h2DiR9b5uu
        8jz2JW2gKKuEXz6qVRcOTVzJ6D0cd4584SY7Qwnx+NO4HYVtPOQe90HK9HO++8AU
        ADkUgyFMJg4XozOd1dWNNP1jTlrCWkkKBr4J7e4M/uBG6wkybp4n+y04I85ERQ3l
        onFNvIy7Vh6iUyxKD+MYI7uGfihdCGLDHD9bE11uEevG7TyHELtqNw+rUWM1UxxM
        1Jr4Q==
X-ME-Sender: <xms:mrYrY-V6t4LdY9CT-s4vx8vkBQpcXUxDifnzC-jvtlQn8nu0xyNoWA>
    <xme:mrYrY6ktm6ky3_VtPMFI_DM4rVTeKABPygaq2kFdLG19TKrG36yeRKvII-UvZGoZ5
    nMDjGIzXmOsNBpMNQ>
X-ME-Received: <xmr:mrYrYyafRD9HKvYc4cOi-CkJCJ2NkUlwWy4FN8Kgl2TRqYxxeGoshsNJaHBucVNDq_a9qxnjKdSgFVMrIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:mrYrY1VTH4eYIqK7Kr_nelbSrl02-JWl6B6xPpJA1b02QaauLFuV1g>
    <xmx:mrYrY4md1HF8NWqGj-NmsFKk1wzAL2m4Q1pysVnTrFjoFqCxnKa13Q>
    <xmx:mrYrY6fFQgaFuBObutVB4u0HrF4lEZsM9BR4snwKwuqYPrUJtnl-0w>
    <xmx:m7YrY2mGtgGEIJ0VXRyHL2thll6cY_JpABe5czid2O_5RDc02fXvtw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:57 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/12] fs: proc: use pageblock_nr_pages for reschedule period in read_kcore()
Date:   Wed, 21 Sep 2022 21:12:45 -0400
Message-Id: <20220922011252.2266780-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922011252.2266780-1-zi.yan@sent.com>
References: <20220922011252.2266780-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

MAX_ORDER_NR_PAGES can be increased when it becomes a boot time parameter
in later commits. To make sure read_kcore() reschedule its work in a
constant period, use pageblock_nr_pages instead for reschedule period,
since pageblock_nr_pages is a constant and either the same or half of
MAX_ORDER_NR_PAGES.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Ying Chen <chenying.kernel@bytedance.com>
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index dff921f7ca33..7dc09d211b48 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -491,7 +491,7 @@ read_kcore(struct file *file, char __user *buffer, size=
_t buflen, loff_t *fpos)
 			}
 		}
=20
-		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES =3D=3D 0) {
+		if (page_offline_frozen++ % pageblock_nr_pages =3D=3D 0) {
 			page_offline_thaw();
 			cond_resched();
 			page_offline_freeze();
--=20
2.35.1

