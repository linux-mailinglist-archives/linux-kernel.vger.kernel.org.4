Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A523688687
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjBBSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjBBS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:29:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC87BE42
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:58 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-524c76beb5eso1759077b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tw1hsgT63166ej2zhrQQOmMvKwFEkphuz02olq7+08=;
        b=XUzVSAJxWqPbzwVpr2pag5CYXwETYKK0ALTrMWIMIaMu9FjXqHaBxWsq6xe7VlIz30
         yFIDNAFg1bM/ofmE4lU/7FZABxu12+JMdYE3NzAf09Ckl4wguykHS6VSPMPFZr1saL69
         Sl4KrpQGIX4AM9TkxrEbGqTvxEfsnRe0OD4hqMCA/jj8jRZM8ldKBHJvudyJzDH1R/7u
         h+8PFXEa/1NMjUUolvl18NX70IoW2UA1H3yQ0qPMFf+AWxvhU6+ruNAxOey9YOhoWE89
         QoaDG2ZOqizZI1ALnaHRHMb7Fop0Lph4P72Lzd/W6jJ2B+6vqIBmoOWjaoEblZ0BpWuh
         2Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tw1hsgT63166ej2zhrQQOmMvKwFEkphuz02olq7+08=;
        b=xIkhCf2h0WvNH1ArWZZACFNYGoaMFKLpd9QjH+vnos541Nn3IWqTt8ubbJeWRQVPUx
         RPEYu9ucUBs0kBphSOMcROgd/XMSZTyAM77VR9MVySgsOsf5TfkoGGZipHKBVThX/OIK
         wHShUV/gHq7NJHu9aFd6XoQVjJfzy0JD/Igf0gQfGI6yhyD98mYyQc+tAWagFps/1A6G
         nISKxkR3qrw/HKKcnvht4FJl4sb+iIh++Ld5mPK6FoF0JECU+JWuaxk6CGCMBd63u+pk
         nPuAx11szHDRGu5d1BQApSEiJCmj3s3H61RS7z0LVp/iW9etsQuJ1Nj7dleewmz/YKW/
         iLqQ==
X-Gm-Message-State: AO0yUKVyA1c+3NMWhGQbzwVXyFFa98/4REXyEQQYHjPD1NLjMqgyeGGt
        xIRJVQOHWGykiSUfeGCFwxVr1Bn1097whpMfPopAGd2BUEkBqYFF/fbC9WhgcVBGqY1ZbXt2/Xi
        ubB7Rxmau2/lTJ9LYf3BmpdAqRhBvQm8EOLo3HG7Xc2BLFlx4H0w1BiZimnIgT+Hnl09BcN/j
X-Google-Smtp-Source: AK7set+Xz2fBka2jkFS8iVqlOh3mOAFdfXz82uXAipo6phMpUvQSqDYd6OcurBL4o2H0p5DF3P6XI7G5uw0I
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a81:78ca:0:b0:521:db3f:a11f with SMTP id
 t193-20020a8178ca000000b00521db3fa11fmr5ywc.9.1675362522851; Thu, 02 Feb 2023
 10:28:42 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:28:07 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-20-bgardon@google.com>
Subject: [PATCH 19/21] KVM: x86/mmu: Move Shadow MMU part of kvm_mmu_zap_all()
 to shadow_mmu.h
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Shadow MMU part of kvm_mmu_zap_all() into a helper function in
shadow_mmu.h. Also check kvm_memslots_have_rmaps so the Shadow MMU
operation can be skipped entierly if it's not needed. This could present
an opportuinity to move the TDP MMU portion of the function under the
MMU lock in read mode, but since zapping all paging structures should be
a very rare and thus not a perfromance sensitive operation, it's not
necessary.

Suggested-by: David Matlack <dmatlack@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c        | 17 ++---------------
 arch/x86/kvm/mmu/shadow_mmu.c | 19 +++++++++++++++++++
 arch/x86/kvm/mmu/shadow_mmu.h |  2 ++
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8514e998e2127..63b928bded9d1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3011,22 +3011,9 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 
 void kvm_mmu_zap_all(struct kvm *kvm)
 {
-	struct kvm_mmu_page *sp, *node;
-	LIST_HEAD(invalid_list);
-	int ign;
-
 	write_lock(&kvm->mmu_lock);
-restart:
-	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
-		if (WARN_ON(sp->role.invalid))
-			continue;
-		if (__kvm_shadow_mmu_prepare_zap_page(kvm, sp, &invalid_list, &ign))
-			goto restart;
-		if (cond_resched_rwlock_write(&kvm->mmu_lock))
-			goto restart;
-	}
-
-	kvm_shadow_mmu_commit_zap_page(kvm, &invalid_list);
+	if (kvm_memslots_have_rmaps(kvm))
+		kvm_shadow_mmu_zap_all(kvm);
 
 	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_all(kvm);
diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index bb23692d34a73..c6d3da795992e 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -3604,3 +3604,22 @@ bool kvm_shadow_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	return kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
 }
+
+void kvm_shadow_mmu_zap_all(struct kvm *kvm)
+{
+	struct kvm_mmu_page *sp, *node;
+	LIST_HEAD(invalid_list);
+	int ign;
+
+restart:
+	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
+		if (WARN_ON(sp->role.invalid))
+			continue;
+		if (__kvm_shadow_mmu_prepare_zap_page(kvm, sp, &invalid_list, &ign))
+			goto restart;
+		if (cond_resched_rwlock_write(&kvm->mmu_lock))
+			goto restart;
+	}
+
+	kvm_shadow_mmu_commit_zap_page(kvm, &invalid_list);
+}
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index 4d39017873aa6..ab01636373bda 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -101,6 +101,8 @@ bool kvm_shadow_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_shadow_mmu_age_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_shadow_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 
+void kvm_shadow_mmu_zap_all(struct kvm *kvm);
+
 /* Exports from paging_tmpl.h */
 gpa_t paging32_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			  gpa_t vaddr, u64 access,
-- 
2.39.1.519.gcb327c4b5f-goog

