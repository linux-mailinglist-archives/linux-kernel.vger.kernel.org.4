Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7A740211
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjF0RWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF0RW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:22:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3791722;
        Tue, 27 Jun 2023 10:22:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9A9DA320094F;
        Tue, 27 Jun 2023 13:22:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Jun 2023 13:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687886545; x=1687972945; bh=UGy1h7/yBoCL+NGQDbYT9sVoQM4JXCJ8XYZ
        vW+aIHhY=; b=FN5HL4LiZK8BnmJSMpE/4/zQ5W/C8nfSKvARuC3qSq5gs0uzq2Z
        oKV9lxM4Qc2b1v+0NeVUYTnghdAEqs4CVyQGuB1jdf+0VZaCdduxQhZ4Gx6gVyvX
        nrZMzI5jwpenVLXlL7rUiKFvAE3hOZ3RRdGvt6ncXLcovTcTjHSKRz2LKL9P2/7T
        7Xr8a9WA5fCeh3SZXwtC9NJUZTWdosp13qA+USMGIQrEuPVUfnxhqD7kPzIBSFKT
        Pwuo/LrPxNLs84OiTDhQRE/oeqC/EmebfB9/3fiLV+gT/fdk6wb49Q2+Xz1z4EmL
        kXE5p+sowB/15dDvqJOSWAkqoAfhZt8xwzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687886545; x=1687972945; bh=UGy1h7/yBoCL+
        NGQDbYT9sVoQM4JXCJ8XYZvW+aIHhY=; b=RshzrOgydTM6POsx2gvl8qpFBzQY+
        hfLxI4ngsrp2Yak8y0oehjzX17FaEp0rjXapJyK7rBuKeZTOM9SwLz4gxv4iLT+R
        KCusRoBW2iXI72N3ec7O9LHmTFBMMfe44SwyRdhE604wBjlB/IsCq6hXXRGke+Lz
        120dVvdIXTG5kE2F/+B3HFIgC6MWg7B1ziCvfaH/Uz/wawVnGI0MDyS3xqKSFdkR
        fZz3tKU2JVa6GRV9jN82ECheBGOUOW8XhcmNh2SWTIH2A098spvle6YVeTQRS/sP
        S2pQng0onjmgm2fdJic5bxsVEgTWttdIhw0z5sZ3NQIG6SAxXIOP9K8Eg==
X-ME-Sender: <xms:0BqbZNWPtl-wKXZaPjE4XUHeZ242oq4VUzPEvCYHEeEuy1aQiZKaRg>
    <xme:0BqbZNm3Rlwc-z13_al9lae6Fy8Or6tHvdaSRPPdqTwNXmE2Rt_AJ8OoR7IsMVdM8
    qSQnu2ERAeBzc8>
X-ME-Received: <xmr:0BqbZJaVtXTex6eRhKx5jBdthxmtvhutulvaS0YjQaVRKiS7lsqGbVxkW9ak-PFUpucBlgD051m48jPwTd8_2nGZVvTul2bapyoaUUDnlQE-QMd5Uw0g6PYvC_0Zv-ef>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcuofgr
    rhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegkedvkefgffegkefhieejtdffkeeh
    hfelheefjeeutefgleeggfdtveeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggs
    rdgtohhm
X-ME-Proxy: <xmx:0BqbZAXh4BTNSx8-fzHghPNpT61SOp_hrw5whh7nPGZdJhBVbpj0-w>
    <xmx:0BqbZHkRyvBow9XrbrvMgjrw9gwhv3vlfQ-als92-4W1XPyJ4mquaQ>
    <xmx:0BqbZNfCLpxQBVHWFO7_4bmnfkSA_4OWbQrb97BtCqMcCjBd9giElw>
    <xmx:0RqbZFaUa3I26k-x-M1RNsSxFhR3V2fTY9PF-hnkzAxNKm226puxrQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 13:22:24 -0400 (EDT)
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
Subject: [PATCH v3] xen: speed up grant-table reclaim
Date:   Tue, 27 Jun 2023 13:22:14 -0400
Message-ID: <20230627172216.1359-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

This is Cc: stable because (when combined with appropriate userspace
changes) it fixes a severe performance and stability problem for Qubes
OS users.

Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/xen/grant-table.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

Changes since v2:
- use atomic_inc_return(x) and atomic_dec_return(x) instead of
  atomic_add_return(1, x) and atomic_sub_return(1, x) respectively.
- move module_param macro closer to the definition of
  free_per_iteration.
- add blank line between declarations and statements.

Changes since v1:
- drop setting default via Kconfig

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index e1ec725c2819d4d5dede063eb00d86a6d52944c0..f13c3b76ad1eb7110e2a2981e9fa4e504174e431 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -498,14 +498,21 @@ static LIST_HEAD(deferred_list);
 static void gnttab_handle_deferred(struct timer_list *);
 static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
 
+static atomic64_t deferred_count;
+static atomic64_t leaked_count;
+static unsigned int free_per_iteration = 10;
+module_param(free_per_iteration, uint, 0600);
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
@@ -515,10 +522,14 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 		list_del(&entry->list);
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		if (_gnttab_end_foreign_access_ref(entry->ref)) {
+			uint64_t ret = atomic64_dec_return(&deferred_count);
+
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
@@ -530,21 +541,22 @@ static void gnttab_handle_deferred(struct timer_list *unused)
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
@@ -567,10 +579,16 @@ static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 			add_timer(&deferred_timer);
 		}
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
-		what = KERN_DEBUG "deferring";
+		deferred = atomic64_inc_return(&deferred_count);
+		leaked = atomic64_read(&leaked_count);
+		pr_debug("deferring g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			 ref, page ? page_to_pfn(page) : -1, deferred, leaked);
+	} else {
+		deferred = atomic64_read(&deferred_count);
+		leaked = atomic64_inc_return(&leaked_count);
+		pr_warn("leaking g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			ref, page ? page_to_pfn(page) : -1, deferred, leaked);
 	}
-	printk("%s g.e. %#x (pfn %#lx)\n",
-	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
 int gnttab_try_end_foreign_access(grant_ref_t ref)
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
