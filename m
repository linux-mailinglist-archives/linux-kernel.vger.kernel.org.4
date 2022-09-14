Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345E65B87B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiINL75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiINL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:59:40 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FB38AE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:59:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-349c4310cf7so11198327b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Af0ZsDPyJgdTr/TUks7HMX0MOkiwdsdfC6dDsp+AdmY=;
        b=caMfRnhMjAAcuWfqKzIREz06Y0ofv0vsUz0iAAkXwc/p27apoikQfCiZ//EqFBLCyX
         6/LjkFijqkgoWK0xoBNs2ebOVJztDz+TGO8xbTtwJSWPdAhYNh8IhhcQOEyJlIoGv6bv
         gb+uelQjQxKhROytfgCELdZFNmdk0RrV8Z13ONPYwLUuss1DpC7h21uqinTMHDRYnpIN
         0m6Zix9kEZ8EttadiD/vvQj5iN4rzEAvZZuSNgK13bGVSk/BL/jH6CRn0Oii86AF1i8R
         4d1bnqe3a9aD2QvDPPAgXSY/7QU5qG9mDzDjs6FLncaCfebKU0FIgGbC8C5Uw4uaOSVI
         Zt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Af0ZsDPyJgdTr/TUks7HMX0MOkiwdsdfC6dDsp+AdmY=;
        b=bTECqlT90AYfypY387vMobzH8e9TyRA5nvbXW1lNFR7wkdC3n/zUQM7wFavF3jhQcW
         U8ttwiDyivyoaHYW4O6hmgaE1K9MjHYSil7iTu/xJwj3fIJl/jQwJzZDqeTyzsEbVk3U
         d7fo5kvGWlFo8y4yif2z2La4Seb8gJnPolel7On1VAwYX7xAkwOTKJwPKP7BRVyDbvpr
         Ijq/+XTkAURc54X8NDWQI6R8s/cNt5FJXj2RwFsKx1AWnA7yzhfx4e8fGTfv27VHROPe
         JdUXCEGD2XCN0l+7qtVCz3UqNSaZBvn8/nqXQjdbJnRiSRErxpaZ3Cg0E6V6l/P47dpc
         Dgbw==
X-Gm-Message-State: ACgBeo3ZKZoJB7be6ksnl6T2HN0q+Yfs847f0e/TbOmDxUArQeSRgdWo
        LslRTJoHzk24dAZa9fBQCi8HpHubFJTONfdUTgDI/A==
X-Google-Smtp-Source: AA6agR7589auuQ/9iWjrUoQfLowfBPv7DFT0AZ2qXsKOLI1SemwwlWcZle4JKS6G0QRfZWzT/gD5XHG1TvCh4hzVF2s=
X-Received: by 2002:a0d:de05:0:b0:345:4827:5029 with SMTP id
 h5-20020a0dde05000000b0034548275029mr29700203ywe.385.1663156770383; Wed, 14
 Sep 2022 04:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
In-Reply-To: <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 14 Sep 2022 12:59:19 +0100
Message-ID: <CAA03e5FLwODdqCpk4BGdxZBrOxQR7rfmrmQg6v5ckzEKuYUx2w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Peter Gonda <pgonda@google.com>
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

On Wed, Sep 14, 2022 at 12:13 PM Peter Gonda <pgonda@google.com> wrote:
>
> On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
> >
> > Previously, when compiled with clang, native_apic_mem_read gets inlined
> > into __xapic_wait_icr_idle and optimized to a testl instruction. When
> > run in a VM with SEV-ES enabled, it attempts to emulate this
> > instruction, but the emulator does not support it. Instead, use inline
> > assembly to force native_apic_mem_read to use the mov instruction which
> > is supported by the emulator.
>
> This seems to be an issue with the SEV-ES in guest #VC handler's
> "emulator" right?
>
> If that's the case I think this should be fixed in the #VC handler
> instead of fixing the code that is failing to be emulated. What if
> there are other places where a testl is used and our tests have not
> caught them.

That was my initial reaction too. But we spoke w/ Tom offline (before
sending this) and my understanding was that we really should be using
MOV for MMIO. I've cc'd Tom so he can speak to this directly though.
