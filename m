Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD59172EFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFMXVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjFMXVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:21:48 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0E12A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:21:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-65252a80823so3614089b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698507; x=1689290507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jaxDs2+WowLgoVNbx6z18nhE8gAIbkvkfZvAkYtRDoo=;
        b=C0iUs/qGutul2GSLBRoHZWIpGZNsIwi45On16iMrJ/Bi/c0MNcKXzC39D358I2ek+u
         k0+34GQJHe4FWyZl93NW3rNwaP/fLF4Wafk1DEeCQ3n7RebneFAJotbfeTRvL1zU73/u
         bOIqZ52SeU8q/N/NHUebI741B29mmFJTdOFC2cpjGya0gTd2/3sfr1QSJlx7rNTOMKPN
         8NqjuOWzhhkzwJhBVzGHnFOiPxmKiI2vR6A4lYfEVttIMTd+8GJNZ9/mvo6RyWF5qb4M
         KdeVbKv5/pHjHlBBtpeYS6CD6rT/VFIsFUzrxV11JZNiJCwST0AFGmQ7e24feY7JVJxR
         BmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698507; x=1689290507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaxDs2+WowLgoVNbx6z18nhE8gAIbkvkfZvAkYtRDoo=;
        b=V9MgPGjSpJURMRnGbhWr1sxQEbGt4igpvLsvF01dtTqQZkf1zcJeS0cbg/wsYHp24q
         okc7ApLr0ZIxHmqvWSOaZMyumCqT3hJis/iQopMeD4JxMBSTwV9llKubVyJtn4U2xBUE
         BjFIKW4CgKF7rHWnfwtX5mdeo/7SXw/t4gz+V6T34FPfDjIlPcheGCQji8OrzSVS2Sij
         Kf8OhPshIEEwOjrtSmctUaXkTAZA1CUcRy+U3yhAcDyM9fhdnyGwGiE0uBGXjSzq8InZ
         ah7CZ02F7L+jOhXYy68j2sc/JxNevvX2ocxn4m8WrP9s+P/klOd4T+/ET2kjuZcneRtV
         uTBQ==
X-Gm-Message-State: AC+VfDwOjLBihyr2ZUDXea5uMFXjkCpcf2lhfIyrmZ5oFXI5eI4ikDGL
        BWzF1tW2DKC74vHp81zRquoRUtQUaYY=
X-Google-Smtp-Source: ACHHUZ6XyfbGsT49oMdIixvGmABWjWPH7uWIctDqjNCSd1E35pCc1dOpFF6URItChEZw9Yk+1+y4jDv8Tvk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a09:b0:65c:b721:dec with SMTP id
 p9-20020a056a000a0900b0065cb7210decmr103020pfh.0.1686698507121; Tue, 13 Jun
 2023 16:21:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:21:38 -0700
In-Reply-To: <20230607004636.1421424-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607004636.1421424-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168667257097.1926329.3773863417862285894.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Update comments about MSR lists exposed to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 17:46:36 -0700, Sean Christopherson wrote:
> Refresh comments about msrs_to_save, emulated_msrs, and msr_based_features
> to remove stale references left behind by commit 2374b7310b66 (KVM:
> x86/pmu: Use separate array for defining "PMU MSRs to save"), and to
> better reflect the current reality, e.g. emulated_msrs is no longer just
> for MSRs that are "kvm-specific".
> 
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Update comments about MSR lists exposed to userspace
      https://github.com/kvm-x86/linux/commit/a30642570855

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
