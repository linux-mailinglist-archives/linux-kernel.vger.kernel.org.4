Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842372AC9D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjFJPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFJPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:32:42 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B81FDE;
        Sat, 10 Jun 2023 08:32:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B5165C0094;
        Sat, 10 Jun 2023 11:32:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 10 Jun 2023 11:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686411157; x=1686497557; bh=E9OTs5ny+Fb91amwPPB8ZaWp4/OQurkf5gc
        QxoQX9vA=; b=Da37icMjqR6GYRdNqfWZlRPFGrktUIW9LyZteNhfFX3EOQc+4mk
        KK+r8BE3vRJl8mwyKBRXeat1qCe74eOw0CrXwAVPPooW97XcM7LzjnRmbKXPz7ep
        caK1O+k0ojvQVNKYbbkBw/AjDsxfHVT+of3enFYUSJyfPZ5IX1Nqj4KmQmNW9iTX
        A8wt6GSErWG7L8hKVltbEzPw2jPkZOam+LBjnNsp/JNV4Ro6yfiWKdZHPkqrTV+E
        6PLKBWO9RjmZGvZ0OEmPgdWD+gvHDA1ftL5/Poq+AWYkZhA3aVdLXLAELnUhkdQv
        QYGiW+CsL8BcjcfcJWUHcyLubLkJb94ClvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686411157; x=1686497557; bh=E9OTs5ny+Fb91
        amwPPB8ZaWp4/OQurkf5gcQxoQX9vA=; b=EJG+MDFWDJ3y3FT3gQOh3PdijNfdt
        +b1+8DLjbkNTU6RfdA6qWd+ivIwzlq06ncHRAVzWd3hcrwM0vk1wBjiZXAE8heGX
        4ZOynEgpGT305IIUc8yMPxfIuc8HUgdhVai6baqqHlQ3+nCYmdzOfDb4DfjlTpgH
        duNhOaGarpvUzVvMlbCaHArurU0gT8I/L6hnw0Z4ystLjefz2LnT4QkR9LhyKzhr
        odInYrQYsA9VK2pNFZFAMoQCnf20CflHRNV1vrbmccjGfHH2xRjwLrln507KS4WT
        VBinPGxCqIiul+YA3RDCtiQYg22wkPRmfQV2LzSEp8/gc9xXR2cuzL15A==
X-ME-Sender: <xms:lZeEZLwOaHg7mdJTo6Ew312wiVM0urD1NhRsSn4_G0_NAk2UgAdK-w>
    <xme:lZeEZDRK0aYwwxPqzlpr1ADv2amvaNXETXpOYNhP1R0rmih5sC67Nuxg7c-aN4XzI
    gXVONWubq3R_fw>
X-ME-Received: <xmr:lZeEZFWoF4cMDbvKmQmhANWmb5gnuNblpx7LfEqn_eETt3UfUhIcwvJ2_hsGjs41awIks7Opjco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:lZeEZFh2ju-d1E65mVb5_fu0bA_iwdrGcCd7OO7OsN6F0ARqzOGL1A>
    <xmx:lZeEZNA3X6PXyHOzNm0DQVF6_T4ype3b_3_DVhmsNCOW80cF_vw_BQ>
    <xmx:lZeEZOI_VnABGB12eGANNHbpA9ajCxeQTnJCTILGaR0bmo6LWUPllQ>
    <xmx:lZeEZP2aJjsuC7XuPrgsGc5TPKaioQ6E4ECsybYYOGL1SjrR4hTBmg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 11:32:36 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] xen: speed up grant-table reclaim
Date:   Sat, 10 Jun 2023 11:32:32 -0400
Message-Id: <20230610153232.1859-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a grant entry is still in use by the remote domain, Linux must put
it on a deferred list.  Normally, this list is very short, because
the PV network and block protocols expect the backend to unmap the grant
first.  However, Qubes OS's GUI protocol is subject to the constraints
of the X Window System, and as such winds up with the frontend unmapping
the window first.  As a result, the list can grow very large, resulting
in a massive memory leak and eventual VM freeze.

To partially solve this problem, make the number of entries that the VM
will attempt to free at each iteration tunable.  The default is still
10, but it can be overridden at compile-time (via Kconfig), boot-time
(via a kernel command-line option), or runtime (via sysfs).

Fixes: 569ca5b3f94c ("xen/gnttab: add deferred freeing logic")
Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/xen/Kconfig       | 12 ++++++++++++
 drivers/xen/grant-table.c | 40 ++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d5d7c402b65112b8592ba10bd3fd1732c26b771e..8f96e1359eb102d6420775b66e7805004a4ce9fe 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -65,6 +65,18 @@ config XEN_MEMORY_HOTPLUG_LIMIT
 	  This value is used to allocate enough space in internal
 	  tables needed for physical memory administration.
 
+config XEN_GRANTS_RECLAIM_PER_ITERATION
+	int "Default number of grant entries to reclaim per iteration"
+	default 10
+	range 10 4294967295
+	help
+	  This sets the default value for the grant_table.free_per_iteration
+	  kernel command line option, which sets the number of grants that
+	  Linux will try to reclaim at once.  The default is 10, but
+	  workloads that make heavy use of gntalloc will likely want to
+	  increase this.  The current value can be accessed and/or modified
+	  via /sys/module/grant_table/parameters/free_per_iteration.
+
 config XEN_SCRUB_PAGES_DEFAULT
 	bool "Scrub pages before returning them to system by default"
 	depends on XEN_BALLOON
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index e1ec725c2819d4d5dede063eb00d86a6d52944c0..fa666aa6abc3e786dddc94f895641505ec0b23d8 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -498,14 +498,20 @@ static LIST_HEAD(deferred_list);
 static void gnttab_handle_deferred(struct timer_list *);
 static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
 
+static atomic64_t deferred_count;
+static atomic64_t leaked_count;
+static unsigned int free_per_iteration = CONFIG_XEN_GRANTS_RECLAIM_PER_ITERATION;
+
 static void gnttab_handle_deferred(struct timer_list *unused)
 {
-	unsigned int nr = 10;
+	unsigned int nr = READ_ONCE(free_per_iteration);
+	const bool ignore_limit = nr == 0;
 	struct deferred_entry *first = NULL;
 	unsigned long flags;
+	size_t freed = 0;
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
-	while (nr--) {
+	while ((ignore_limit || nr--) && !list_empty(&deferred_list)) {
 		struct deferred_entry *entry
 			= list_first_entry(&deferred_list,
 					   struct deferred_entry, list);
@@ -515,10 +521,13 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 		list_del(&entry->list);
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		if (_gnttab_end_foreign_access_ref(entry->ref)) {
+			uint64_t ret = atomic64_sub_return(1, &deferred_count);
 			put_free_entry(entry->ref);
-			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
-				 entry->ref, page_to_pfn(entry->page));
+			pr_debug("freeing g.e. %#x (pfn %#lx), %llu remaining\n",
+				 entry->ref, page_to_pfn(entry->page),
+				 (unsigned long long)ret);
 			put_page(entry->page);
+			freed++;
 			kfree(entry);
 			entry = NULL;
 		} else {
@@ -530,21 +539,22 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 		spin_lock_irqsave(&gnttab_list_lock, flags);
 		if (entry)
 			list_add_tail(&entry->list, &deferred_list);
-		else if (list_empty(&deferred_list))
-			break;
 	}
-	if (!list_empty(&deferred_list) && !timer_pending(&deferred_timer)) {
+	if (list_empty(&deferred_list))
+		WARN_ON(atomic64_read(&deferred_count));
+	else if (!timer_pending(&deferred_timer)) {
 		deferred_timer.expires = jiffies + HZ;
 		add_timer(&deferred_timer);
 	}
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+	pr_debug("Freed %zu references", freed);
 }
 
 static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 {
 	struct deferred_entry *entry;
 	gfp_t gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
-	const char *what = KERN_WARNING "leaking";
+	uint64_t leaked, deferred;
 
 	entry = kmalloc(sizeof(*entry), gfp);
 	if (!page) {
@@ -567,12 +577,20 @@ static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 			add_timer(&deferred_timer);
 		}
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
-		what = KERN_DEBUG "deferring";
+		deferred = atomic64_add_return(1, &deferred_count);
+		leaked = atomic64_read(&leaked_count);
+		pr_debug("deferring g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			 ref, page ? page_to_pfn(page) : -1, deferred, leaked);
+	} else {
+		deferred = atomic64_read(&deferred_count);
+		leaked = atomic64_add_return(1, &leaked_count);
+		pr_warn("leaking g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			ref, page ? page_to_pfn(page) : -1, deferred, leaked);
 	}
-	printk("%s g.e. %#x (pfn %#lx)\n",
-	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
+module_param(free_per_iteration, uint, 0600);
+
 int gnttab_try_end_foreign_access(grant_ref_t ref)
 {
 	int ret = _gnttab_end_foreign_access_ref(ref);
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
