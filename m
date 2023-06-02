Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0871F7C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjFBBXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjFBBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:23:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC098E45
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:23:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-256563a2097so667135a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668984; x=1688260984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDgd2gotor4ZR8cqfCrVsmiIAEV2vs7BB2zp4kNLJPc=;
        b=pWAmJFh3nGZ3XxQM7dBmf1+v2k6ehvlxXGidXMvm1s19HS+8M0tAvhMEdMZen45J2p
         o89UsftScXkJZ4xodlztX7r7J4Vo9/ZeH4lU1YGROBA6svmK5gjcT2HIHjhR3InifNMc
         FOw2LbaXrMaoCLaUcp56oriTt9toCPCKa+OgV8l90PhxL06KA/36NeNJAr1L1LIB3MOS
         TZ2ecDTpi/lora9QXFE5xtlLgjukbnjBGCqQDm2Qcg9ha2yHnTMRzW6LSvu7QF7KWvOs
         w1tYW4udIMl7d8TIs1CDK+lhshz2+PoOm6YI2heB4Egws2T1Hprc367aAhhkMXwgLmtN
         hDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668984; x=1688260984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDgd2gotor4ZR8cqfCrVsmiIAEV2vs7BB2zp4kNLJPc=;
        b=TxTgKBAcfvweEZQxqHX3b+szskR0Tgl7KvPRt98RdaKED0Oj0dyoZwN/LZji94f9di
         dj8vTxdiDKuFaTWH1qWsulOa+CRjR2sM/xsX3f/pfZ1U/B9VaHGwUfqSsFY2Xi4yTZ5u
         ZThGpJIf3yt1j1LfJRVk3x5QYVHOmqOglEI5uhRTehUmvC/jVuivjPJ7l/08xuFpGTBq
         F+yQJsYb7Ag6q5GFDB52U0CKcWVRT3cm/65QuOAvSaVupAr47Yt3x3fvzHLXiY54Bocr
         jOWrOcFy6pDVQMzbUDvYL1eITceyYoUuftpDZp8WYhqZ3Wf0rS6i9+Wag7oSEFkBTWLf
         Z+xA==
X-Gm-Message-State: AC+VfDxwugTYaps4exWewp7Arvjmp83jXATo+FDPp37msNuW0WRkIpsl
        OQooKvrc9pn4EoWq2d1t5QRSrIAlCzw=
X-Google-Smtp-Source: ACHHUZ7GsMl3I2PpWKbVoXSOY4KCC/lrrEZQrsLdYeTQdiqA5ZzPq8LJKKq1EFalDbkuvSb/Gd9V+tDR+zo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:11cd:b0:255:7a07:9e63 with SMTP id
 gv13-20020a17090b11cd00b002557a079e63mr201828pjb.3.1685668984352; Thu, 01 Jun
 2023 18:23:04 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:22:46 -0700
In-Reply-To: <20230425113932.3148-1-ubizjak@gmail.com>
Mime-Version: 1.0
References: <20230425113932.3148-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168512497255.2748559.4747399178242270011.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Add comment on try_cmpxchg64 usage in tdp_mmu_set_spte_atomic
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 13:39:32 +0200, Uros Bizjak wrote:
> Commit aee98a6838d5 ("KVM: x86/mmu: Use try_cmpxchg64 in
> tdp_mmu_set_spte_atomic") removed the comment that iter->old_spte is
> updated when different logical CPU modifies the page table entry.
> Although this is what try_cmpxchg does implicitly, it won't hurt
> if this fact is explicitly mentioned in a restored comment.
> 
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Add comment on try_cmpxchg64 usage in tdp_mmu_set_spte_atomic
      https://github.com/kvm-x86/linux/commit/12ced095956a

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
