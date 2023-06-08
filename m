Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD79728AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjFHWGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjFHWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:06:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81430D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:06:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25b79a5cf1aso78046a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686261999; x=1688853999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLQAgYf8iBGNcj/RlWRJvdUP+LxzH+dVMP3y494+MG8=;
        b=jiucnEhHBHr3c6BmEzMcwGJYY5q/sfwTNMPWWLYqVidMy1ACgG+F4SMLbQC+sxFx8P
         MgXO/ls1Qh9ojSIi9fREuHQLVDtJVbbXNSGrAHqjqmXunrWoPXQioFgwqITHfRC2RF7S
         krksZEMjv8T4fZD9ohzoli64PNBHIoR7RtjjXhBKm+ILTUHJIsjF6bBVFHudjFQ43RAJ
         QjLnUGQxwAWUeWUK76k33+fR9B50+FAd8nHuH4gYW55RNEa1TK7TgaOcSaYfQfQ/yqEU
         gTerywae+9jvND4TfEQNeVGBNRP4j8FT/9XDIlbTQL9SfcEMzU0DbA+854khObUx4iA2
         DkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261999; x=1688853999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLQAgYf8iBGNcj/RlWRJvdUP+LxzH+dVMP3y494+MG8=;
        b=X8mmyC9ov26xYev9s/JPtg4vBJlGZqgwpVxRuQUcXU3r/RfYpWpNru+rHTSNXU+LU0
         zC9GCUwga42VTu4JmP93WeaUzJgBqyTaZ7ymZl0zMAD2yGCFUkbFWCtVxbfdEGRAXV3i
         pOAFKZ08oKQubCAdd5y4T99mFdNDhzll7rzrzGYCNHc1agz8fM3M2bI4oChpazu2EXNK
         5T+IKa2uTN81YdC3TPcfhxb711JBc51JK5NB+BPt+G419a8PVoQWkuzXHSzmLccmiSFU
         uiEP8/Kzh3JLLcbpGdIvXr3a84MfTOoQxwVD71GECk4ijmTt8dyD2YHv6+oS5bz1ESoo
         wYeg==
X-Gm-Message-State: AC+VfDzDBdIvrYwLDlavSBjxykDPQ9lHNv0KpPHTAEM/SHDMV7XJhx7u
        J/vmaHp5EG2SMR+f7xcm/apmppq9oaL+aRrqWiHm5rSfhnWTWJmSAsH2bZTr4g+kEik6lPLO+jR
        S9o3JfZINN6RBGNi7Z+Q9bGpImw9x9qvUa6kAyGb2ifJoy7q18tYNDSgIJfS0NcWd2msjdQ==
X-Google-Smtp-Source: ACHHUZ4BB7wc/3PLgyJlfh6FiXwuAOEqUsspFVK4qOkYedUMSsY2SeUi7aLElhIVZxfm8OeC1VsqR/loduM=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5cff])
 (user=ctshao job=sendgmr) by 2002:a17:90a:7886:b0:253:4800:438b with SMTP id
 x6-20020a17090a788600b002534800438bmr786194pjk.2.1686261997920; Thu, 08 Jun
 2023 15:06:37 -0700 (PDT)
Date:   Thu,  8 Jun 2023 15:05:41 -0700
In-Reply-To: <20230608220558.39094-1-ctshao@google.com>
Mime-Version: 1.0
References: <20230608220558.39094-1-ctshao@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230608220558.39094-4-ctshao@google.com>
Subject: [PATCH v1 3/3] KVM: arm64: Using rcu_read_lock() for kvm_pgtable_stage2_mkyoung()
From:   Chun-Tse Shao <ctshao@google.com>
To:     linux-kernel@vger.kernel.org, yuzhao@google.com,
        oliver.upton@linux.dev
Cc:     Chun-Tse Shao <ctshao@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access bit is RCU safe and can be set without taking kvm->mmu_lock().
Replacing existing kvm->mmu_lock() with rcu_read_lock() for better
performance.

Original disussion can be found in:
https://lore.kernel.org/kvmarm/CAOUHufZrfnfcbrqSzmHkejR5MA2gmGKZ3LMRhbLHV+1427z=Tw@mail.gmail.com/

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 arch/arm64/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3b9d4d24c361..0f7ea66fb894 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1437,10 +1437,10 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 
 	trace_kvm_access_fault(fault_ipa);
 
-	read_lock(&vcpu->kvm->mmu_lock);
+	rcu_read_lock();
 	mmu = vcpu->arch.hw_mmu;
 	pte = kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
-	read_unlock(&vcpu->kvm->mmu_lock);
+	rcu_read_unlock();
 
 	if (kvm_pte_valid(pte))
 		kvm_set_pfn_accessed(kvm_pte_to_pfn(pte));
-- 
2.41.0.162.gfafddb0af9-goog

