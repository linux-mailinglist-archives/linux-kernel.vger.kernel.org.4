Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704616B1676
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCHXYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCHXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:24:41 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84862DA1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:24:40 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x137-20020a62868f000000b0060017d68643so180588pfd.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678317880;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31I/66ZbofU/Nk2qVtIf1lMcjjuaecDM5cG516tV2lE=;
        b=sai5S0skSzcUtZzyiz2IlpPTGo14T0H3FbpxEJEj1V6Q28YhcwpvJP+LeOcK+ikL1z
         lW8yEw0futR4uJ+/CUYbDg6tbB6EfDCzXd+NYqR12wu6ajrhCDaKGdHtlASy/v5bwB0V
         xW+9kVH+YyeRBQQp/IRTQ6PRZVQj257t/N2Y3elGixX81b/S1Casafg7iD5kUN51fO8S
         MqAJf9s9M11CHr2s4yycMB0Xyqof/KAB2ogLh3A376qy8jlgv+IJvacim2mKgQuYK86Y
         ENCULmkf7yfAWqXxGeNMBO7ktePaqEbiyPmZ9Bvq1nPoIPqNQXaCcz4esSyoB5usHRxB
         k1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317880;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31I/66ZbofU/Nk2qVtIf1lMcjjuaecDM5cG516tV2lE=;
        b=mf23ESc/D8uoEu1I8ihzwnhaIUZMME9JipbcMWU38j014N6IESwU33bxv8td8QaNfH
         pfK3/RJrw8ibCNFrtlOMZxVuwXtYh81Hh/YdIVFSSPtAEaocXSQsXMTlMQ1JRBbP2RXT
         hk2AAk7SF/MSg/JDIOQdVpjOWTkjeCkg2gN6ynh/aoVdgFSPdMG/du+BUjAQx7Y7Cy14
         lMK0+VtGuMF08c/iRu6JVXKEJ2O+HQXSQR0WVBiHFogk4rbKo5WUVRo5O3xSQXr0rFUJ
         40cNCIqZvn7P8T71+asvoxn934JRQ0kklet9DI1MmATc4oBjG+NbFv0d1mObX6QFJGZl
         uKrA==
X-Gm-Message-State: AO0yUKXUgMlQ/W57c64GlhpkueCDc9vqobKE34wdzDvI8RDK+su12Atv
        WhikQUHUzuHhwJoRJF4+LjO8o/g2gvM=
X-Google-Smtp-Source: AK7set91cIekvGyz37KGXJyidj3ek+gAcesMSlg1uywzEOVkU4MmvuhZ7paM+eJKHRVGbO6jHqoxuMUfMdU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8f17:0:b0:507:4d05:15ef with SMTP id
 n23-20020a638f17000000b005074d0515efmr3985603pgd.11.1678317880007; Wed, 08
 Mar 2023 15:24:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Mar 2023 15:24:37 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230308232437.500031-1-seanjc@google.com>
Subject: [PATCH] KVM: PPC: Mark three local functions "static"
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Tag a few functions that are local and don't have a previous prototype as
"static".

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303031630.ntvIuYqo-lkp@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

This was prompted by a new W=1 build warning for a commit that went in
through the KVM tree, but said commit has made its way to Linus, so it
shouldn't matter who grabs this.

 arch/powerpc/kvm/booke.c  | 5 +++--
 arch/powerpc/kvm/e500mc.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 01adffb24667..ce37d282be6d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -623,7 +623,7 @@ static void arm_next_watchdog(struct kvm_vcpu *vcpu)
 	spin_unlock_irqrestore(&vcpu->arch.wdt_lock, flags);
 }
 
-void kvmppc_watchdog_func(struct timer_list *t)
+static void kvmppc_watchdog_func(struct timer_list *t)
 {
 	struct kvm_vcpu *vcpu = from_timer(vcpu, t, arch.wdt_timer);
 	u32 tsr, new_tsr;
@@ -1946,7 +1946,8 @@ static int kvmppc_booke_add_watchpoint(struct debug_reg *dbg_reg, uint64_t addr,
 	dbg_reg->dbcr0 |= DBCR0_IDM;
 	return 0;
 }
-void kvm_guest_protect_msr(struct kvm_vcpu *vcpu, ulong prot_bitmap, bool set)
+static void kvm_guest_protect_msr(struct kvm_vcpu *vcpu, ulong prot_bitmap,
+				  bool set)
 {
 	/* XXX: Add similar MSR protection for BookE-PR */
 #ifdef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index a309138927ff..d58df71ace58 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -168,7 +168,7 @@ static void kvmppc_core_vcpu_put_e500mc(struct kvm_vcpu *vcpu)
 	kvmppc_booke_vcpu_put(vcpu);
 }
 
-int kvmppc_e500mc_check_processor_compat(void)
+static int kvmppc_e500mc_check_processor_compat(void)
 {
 	int r;
 

base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
-- 
2.40.0.rc1.284.g88254d51c5-goog

