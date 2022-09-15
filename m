Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AB5B95F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIOIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIOIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:10:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A93844A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h3so12823620lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aFwGASWRgsXAK8lC70BFOrXWvfMpVU18irE6y0Vbjm0=;
        b=EaqZPRAqvxtjjSm+WqGQU7jqVOgLOZ6k0oDpgW7OzIw+rFDqUG8MyePQY8klPaAvj6
         bj5Y1L7mi7tovVudJBxS3i6OofgIT4O0oRmE2bJsdg4fdpIEW7UEzh7GDZxcI0QnVyxP
         i3Vt/8q6JcMuC2kzpJoKxT2WcNF7cBFBCt8033pwAaZE+9y3eO2OEuSuP/PnFf1kOjfJ
         BruNDX6MRIPub2TL4+7U/Oemce9B2+GG7YwL+DL5x2S9EoVMRHd+GUhuWKSMqTKOXf/g
         /Kq96flzN5SFfVHCgAZEGWSCDzCSzrYk/rmIBeeR1CZJlnlfzBRM2NUaUWt1+Y7WR2CG
         tkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aFwGASWRgsXAK8lC70BFOrXWvfMpVU18irE6y0Vbjm0=;
        b=DNyIIioq2Ky/rl1gC9jx3BBgHkJFmHr5eaaynSo2rCA7bTwAPySI0eZgW93eSbkRjp
         YAESyEXfDOhsWkwaxBL0afS3Tv+Y1w0PoTrG3/1/pPn6gsp0FiR9nOB/Zx76NGwgZlqU
         GgVyNKgqFklGqeX6NKra+g9hiWxT3hIDDnetS33odQFSmoQ71kXW8b8D99iKlgXTpff5
         QGrDRzVJkbhgyFIFAvr002Td9V3EQI3ZJptr8TH7XpV5oLu1UEbq2M2hFFPijB9LCNRZ
         gOmEzKoLf1ROihUQRqFpyPsnic7xTO4v6S0YrAahsLNL0jiZBT8LqT8zac5rp7Kd54IO
         O6xA==
X-Gm-Message-State: ACgBeo2y1OL5cnLfJzD8TG1KYXW85Ox+Na5np0R8ONMiGsSniMN6C8rH
        3ofmRyUDr2pv307aBRfTTJejMMlEtN0mswA44xUAsw==
X-Google-Smtp-Source: AA6agR7mddkCs1EgVqJOPDXZ2sGd0ezdTapiYlPiA1HWGZvmT8wgdVFgHMLeYx3jCnJM/ZOFK6RQ2fYtWSNCDeg7ehs=
X-Received: by 2002:a05:651c:1787:b0:261:c1ff:4407 with SMTP id
 bn7-20020a05651c178700b00261c1ff4407mr11764546ljb.257.1663229396349; Thu, 15
 Sep 2022 01:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com> <YyH/tOqrl8pZmoub@google.com>
In-Reply-To: <YyH/tOqrl8pZmoub@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 15 Sep 2022 09:09:45 +0100
Message-ID: <CAMkAt6p2Y=6sBB1JiZ2FovYXme9QBFWFu+EtnNyuQ3Db3ZhBSg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 5:22 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Sep 14, 2022, Dave Hansen wrote:
> > On 9/14/22 04:13, Peter Gonda wrote:
> > > On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
> > >> Previously, when compiled with clang, native_apic_mem_read gets inlined
> > >> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> > >> run in a VM with SEV-ES enabled, it attempts to emulate this
> > >> instruction, but the emulator does not support it. Instead, use inline
> > >> assembly to force native_apic_mem_read to use the mov instruction which
> > >> is supported by the emulator.
> > > This seems to be an issue with the SEV-ES in guest #VC handler's
> > > "emulator" right?
> >
> > No.
> >
> > It's not just an SEV-ES thing.  It's a problem for TDX and _probably_ a
> > problem for normal virtualization where it's a host-side issue.  Kirill
> > wrote a lot of great background information in here:
> >
> > > https://lore.kernel.org/all/164946765464.4207.3715751176055921036.tip-bot2@tip-bot2/
> >
> > So, the question is not "should we extend the MMIO instruction decoders
> > to handle one more instruction?".  It is "should we extend the MMIO
> > decoders to handle *ALL* memory read instructions?"
> >
> > That's an even more emphatic "NO".
>
> +1, keep the guest-side decoding as simple as possible.
>
> > readl() seems to be the right thing to do.  Also, Dear TDX, SEV and virt
> > folks: please look for more of these.  They're going to bite you sooner
> > or later.  You should have caught this one before now.

Thanks for the context here Dave. Fixing the offending MMIO
instruction here makes sense.
