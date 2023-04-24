Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F26E5007
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDQSRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:17:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B131BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:17:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v8-20020a17090a520800b0023fe33f8825so7120927pjh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681755455; x=1684347455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b67qKCuPJhxdGCIYBD88XUwMlst2sP8pTPxRVgDYQ/s=;
        b=OJqxgE3hhWr2QapyCbmlCqDzBA6YCED4cdsim4DZuKVtq6MYxjsMw7K+baBmM9Qcx3
         LOfhoKzpK9ck0B8hFXbbJieu0f8qfFCJb3orge7d/6DZA1spOAeycySGLy0kxptB6AhS
         lOhwzqRpx9aaOQfN6sYsvyDJ3of/pExuwB/f8Cjq4Eyk2yJKeuKzJmQkY0loFaORwVos
         V4SxOmeey9QY9qx2/VVungNEtjLJHGOLjxnmDBvdF/lDOBuU+o7c3qJnnsMph6xo8GaF
         XKxuG3dpRjb9ABAVcxcP+21fft5m8yBioUGVYy6xG1enYacIiRev4TiVi6zieF5xjHUs
         967Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681755455; x=1684347455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b67qKCuPJhxdGCIYBD88XUwMlst2sP8pTPxRVgDYQ/s=;
        b=f60NZ9ZcW4RkGtKwqpoZsAmgvjE5woDLIeXnsC66q0CJTNllHUJiu32bU3oHSBr1Nt
         HV8RSuO5YBg4/se+9UnvOX5k5Lc5B1b6Tk+Hu601shKB6L20Cz2hMv+QWTkwamaOIYlA
         rWj15J+9DhW1DQ5Z9DJ7Nd4yLLIqKoNfjU53DtVZ51NHNKEMf5lXZ3ZV3HgT3Svh6XXn
         763CwvvaHxBDbb5AcuvuE3IvVNANTuiND1rG+gTlceEEvBCvFhlQg+/4DOkjnv4xfa2a
         cs7rVYq7N2EqtgF06Pl+56IYCw2soHJFSIi1WV0Gqch4CF4EgbuOUX0FixD1nzX0VTrp
         vjQg==
X-Gm-Message-State: AAQBX9eY+sLRr9I8sg3jv91eBKYtf+FOfDfdmenfKLkYrflr+kpLOn9L
        0fnsENBKNsdEQb0nXAZn/Z58ET4SWCY=
X-Google-Smtp-Source: AKy350Yb3F0OYG+jZ+kTLa25mOn8hutHBg6sHYCyUSq3zyXVNjophoK5Q78qs3WjhRoO5n9a9vGwFuVuyDc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2944:b0:247:2c8e:9911 with SMTP id
 x4-20020a17090a294400b002472c8e9911mr3831104pjf.5.1681755454734; Mon, 17 Apr
 2023 11:17:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:17:33 -0700
In-Reply-To: <diqzv8huxwl0.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <ZD12htq6dWg0tg2e@google.com> <diqzv8huxwl0.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZD2NPRQaLiSiY11s@google.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     david@redhat.com, chao.p.peng@linux.intel.com, pbonzini@redhat.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        mail@maciej.szmigiero.name, vbabka@suse.cz, vannapurve@google.com,
        yu.c.zhang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com, rppt@kernel.org,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Mon, Apr 17, 2023, David Hildenbrand wrote:
> > > On 17.04.23 17:40, Sean Christopherson wrote:
> > > > I want to start referring to the code/patches by its
> > > syscall/implementation name
> > > > instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to
> > > the broader effort
> > > > and not just the non-KVM code, and (c) will likely be confusing
> > > for future reviewers
> > > > since there's nothing in the code that mentions "UPM" in any way.
> > > >
> > > > But typing out restrictedmem is quite tedious, and git grep shows
> > > that "rmem" is

Your mail client appears to be wrapping too aggressively and mangling quotes.  I'm
guessing gmail is to blame?

> > > > already used to refer to "reserved memory".
> > > >
> > > > Renaming the syscall to "guardedmem"...
> 
> > > restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask
> > > me ...
> 
> > I'm definitely open to other suggestions, but I suspect it's going to be
> > difficult
> > to be more precise than something like "guarded".
> 
> > E.g. we discussed "unmappable" at one point, but the memory can still be
> > mapped,
> > just not via mmap().  And it's not just about mappings, e.g. read() and
> > its many
> > variants are all disallowed too, despite the kernel direct map still
> > being live
> > (modulo SNP requirements).
> 
> I'm for renaming the concept because restrictedmem is quite a
> mouthful. :)
> 
> How about "concealedmem" or "obscuredmem" to highlight the idea of this
> memory being hidden/unreadable/unmappable from userspace?

I'm hesitant to use something like "concealed" becuase it's too close to secretmem,
e.g. might be miscontrued as concealing the memory from anything _but_ the process
that creates the file.

Obscured has similar problems, and obscure often suggests that something is unclear,
as opposed to outright unreachable.

The other aspect of hidden/concealed/etc is that the memory isn't necessarily
concealed from the user.  Long term, I hope to get to the point where even "normal"
VMs use restricted/guarded/??? memory, e.g. to guard (heh) against _unintentional_
access from userspace.  In that use case, the memory isn't truly concealed, espeically
if the user is both the "admin" and the consumer.

Though by that argument, "guarded" is also a poor choice.  And now I'm remembering
how we ended up with "restricted"...

> Guarded is better than restricted but doesn't really highlight how/in
> what way it is being guarded.

Ya, though in practice I think it's infeasible for us to get a name that is both
precise and succinct.
