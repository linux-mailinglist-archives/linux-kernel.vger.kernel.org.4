Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC96E4E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDQQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:40:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7F6E8E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:40:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54feaa94819so68933827b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681749639; x=1684341639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PobCa3arsJG8fXaXnn3PVfRcCfm9R9LgpKNeTxPDrhk=;
        b=66Hlx2HGGdue05sAAFGmQdUh42QnQ4aO1LdebGweI8poz/SM3LB7V7Qi8Ad369CQ4g
         +GQif2hH32d8wB5a0dvcpB5JmnQq9QcsYw0RcOO41DpuHQVCSFZuqnSa7v4K2KeOXMEm
         o9wkzA1szQPPlX4OCmrajVt3z4IL85pQ7BeyX2b554DssXixwjN/czZmOKqQM4h0a7zR
         AcMguzYXg4qIY+r11k/Wy6BwozRAS+05171+FECc4IMlHt2eCLNPchKJVZ4B8vbPat8h
         eHfN7+zTZ//8Ui1nh5L3PPi1GxVNa/PIpdIktXlqUgAis1PEdhbe3jyeGNLr2AflbqKU
         yJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681749639; x=1684341639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PobCa3arsJG8fXaXnn3PVfRcCfm9R9LgpKNeTxPDrhk=;
        b=Yd9aSz1XtNRoZxI3B4itbHTxe7f6m0kGBwLeKAKkJiSS28VmkKAYU/YsTkPuMnLx8P
         7B60qLhBIq4PLLNLqHNGKG2IOu70oFsi8Rsbg7Uu1vXXOejB9EjdqB+wtnNHqF7FaGvL
         wUkazmQNIczDu012ZmtH87ofCWDr9Qv4GPpQz35c2I25Rx/CviCT4Y0Upy4VWSelUsGF
         IWomqtxmKfMPN+sz1Pe8CogJ4rYWwzht3QHvoRu4lla3h7ImP30dF+86RxSSzcKWUzow
         +U0NNHHgMCJtlmHM1bgM+CNl/PYRCHtsBEGdCNh0Gu6GhAO0VErKLH5g5XmtnbSdN61O
         wllg==
X-Gm-Message-State: AAQBX9fJWtmYfMr4hl7W1/E8vA9GF/ysOddBAJuem65KJ/pqw/MWLLzD
        pJzkTQGuaKgupnW34iozjbH+k5CGv/Y=
X-Google-Smtp-Source: AKy350aYxV6RtTDr/qKihqV/tUtySt3S5JV8Q41pF4i6EiZVUJ1qvMd5qxj27kyztEzxqjYv+B94rCeviqY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af22:0:b0:534:d71f:14e6 with SMTP id
 n34-20020a81af22000000b00534d71f14e6mr9264079ywh.9.1681749639451; Mon, 17 Apr
 2023 09:40:39 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:40:38 -0700
In-Reply-To: <658018f9-581c-7786-795a-85227c712be0@redhat.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <ZD1oevE8iHsi66T2@google.com> <658018f9-581c-7786-795a-85227c712be0@redhat.com>
Message-ID: <ZD12htq6dWg0tg2e@google.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023, David Hildenbrand wrote:
> On 17.04.23 17:40, Sean Christopherson wrote:
> > I want to start referring to the code/patches by its syscall/implementation name
> > instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
> > and not just the non-KVM code, and (c) will likely be confusing for future reviewers
> > since there's nothing in the code that mentions "UPM" in any way.
> > 
> > But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
> > already used to refer to "reserved memory".
> > 
> > Renaming the syscall to "guardedmem"...
> 
> restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask me ...

I'm definitely open to other suggestions, but I suspect it's going to be difficult
to be more precise than something like "guarded".

E.g. we discussed "unmappable" at one point, but the memory can still be mapped,
just not via mmap().  And it's not just about mappings, e.g. read() and its many
variants are all disallowed too, despite the kernel direct map still being live
(modulo SNP requirements).
