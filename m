Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C85B87BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiINMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiINMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:11 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103E491E4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:00:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3452214cec6so177059397b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QsMCaVH5gf5julRO/w6xJ6Us9sb9A4zSO2PGVhrKaaY=;
        b=ZyREX7134NFnv+/oAG5wLXi2j0idORn9gJdu6JDDCBfneoua05daTo2P3avmR6l7ey
         gbWCq2WJvLmAKls41j2WhXjyjkYOHK4bwlqHzvSfC9rNw3pFSIZQpmkAcihga5bksbZK
         swhZgrGIa49svXTkq2mMiI/b52UPtCi3BWrchSDizUca2HgNJgtFV0tDg29fOTVF1ZWT
         hkAL1UQ16wYPRN5oMiUqQC5MEFI8kObWiWwSPeGQ0TatohpIsjgQcpLLiGyebETjKOzy
         qjibWmn7+mPgJ6HHhN8rQqHoHmgF2A+9sw99NtijP8m4Etk/tS8Lhu7MMzLC6Dzmp8Uu
         k+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QsMCaVH5gf5julRO/w6xJ6Us9sb9A4zSO2PGVhrKaaY=;
        b=6Uxpy0Anvt5NS9smvdY77BWV2verRmW6EtfYo0bkO/FrfsDhp9DBv0qTC5J0+eWiQE
         0vlbEBNskj7Xy5Hpc87McHbIliNRmDEA+r53p/ZsnQV5nnPgqKJ7UaTqv9Y1BSWPOrkQ
         2tGoisAAyGBXSG6/4fEAE8Lisy+9Y6gokhDeqPC+THx8OKym7LAGlRL8xCgyey/RdPDs
         WqtqOL4uD8t9STtTyMRhQYKX3XmZyN/MuxH5bPvSdG57FpS7cX3OGtKZiPaLMhvCB92D
         vnbmtuXnP+8KjV6MCrJQSEKpXAiZVGjZ/xx28/XGhT2sjaS/aWm/5k+bb7+bN14qhqU2
         g3Bg==
X-Gm-Message-State: ACgBeo3BCzK/0VZxJYexOLFZMojoaH//nY6gGqoMKCtyUO//gp8UL6oY
        xqCbATX+2+G19mK3PFztBZXxTLBM2IGqpXr9s8gr0Q==
X-Google-Smtp-Source: AA6agR7hrRw99xEORXM7EbpxVm65aZiVieHnXxD+jFhchF2PDeLw4PWBq9V0wVP1vvGrdLGtNeHc16IMsT6Ly6nSZXY=
X-Received: by 2002:a81:7cd7:0:b0:345:221c:5671 with SMTP id
 x206-20020a817cd7000000b00345221c5671mr29558481ywc.297.1663156808987; Wed, 14
 Sep 2022 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com> <CAA03e5FLwODdqCpk4BGdxZBrOxQR7rfmrmQg6v5ckzEKuYUx2w@mail.gmail.com>
In-Reply-To: <CAA03e5FLwODdqCpk4BGdxZBrOxQR7rfmrmQg6v5ckzEKuYUx2w@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 14 Sep 2022 12:59:58 +0100
Message-ID: <CAA03e5EFk7VjkaT8+xXMaDQcEDTJRzLEuQxxNX=OOyAQG5eCng@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Peter Gonda <pgonda@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>
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

On Wed, Sep 14, 2022 at 12:59 PM Marc Orr <marcorr@google.com> wrote:
>
> On Wed, Sep 14, 2022 at 12:13 PM Peter Gonda <pgonda@google.com> wrote:
> >
> > On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
> > >
> > > Previously, when compiled with clang, native_apic_mem_read gets inlined
> > > into __xapic_wait_icr_idle and optimized to a testl instruction. When
> > > run in a VM with SEV-ES enabled, it attempts to emulate this
> > > instruction, but the emulator does not support it. Instead, use inline
> > > assembly to force native_apic_mem_read to use the mov instruction which
> > > is supported by the emulator.
> >
> > This seems to be an issue with the SEV-ES in guest #VC handler's
> > "emulator" right?
> >
> > If that's the case I think this should be fixed in the #VC handler
> > instead of fixing the code that is failing to be emulated. What if
> > there are other places where a testl is used and our tests have not
> > caught them.
>
> That was my initial reaction too. But we spoke w/ Tom offline (before
> sending this) and my understanding was that we really should be using
> MOV for MMIO. I've cc'd Tom so he can speak to this directly though.

Actually cc'ing Tom :-).
