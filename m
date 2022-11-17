Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F362E6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiKQVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiKQVZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:18 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D792DEC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:23:20 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v123so3445995ybv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WkqynFnuTl+SBnf8vAzWE9ynW3+h/Y4/Q34MzfRHcPc=;
        b=XcGF4xkzh24/cOTLB7WLZEBztN+OCwfswrdgEOAyH3o3QLjQbxkfEyH9o6xNF9BsRK
         9x4aQ+1HEgJsRN/V4s0WVTj59/sznY5RKQ254hPsFHzZnqkC5uSIuiFpu3XaslREx5xC
         P8NyDAs/d/rBmQrhuwVc/JrZo2D21hAbhmF/6zUxC7MbyPTI1bJzIrQ7D07JFTtiQ4Um
         476qa2MATVla+W4z06fWU6nud4VsmPVx/sQicQ8RqDPMg8hZAWr85jrrY+fZX/GQbNmF
         vmWjmgHtn4296hBgxIusZKveQBin0uDHIIWJezBuCX7EU89J3FrQsbKkEK8metMUqSw6
         9ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkqynFnuTl+SBnf8vAzWE9ynW3+h/Y4/Q34MzfRHcPc=;
        b=CVa2tTHCAvBXCrde/V87jVxISQRKVC5/POH0IEfSEQZL8yxABbWqhcQ3Ef5CjD/ikO
         XqrsqPPwVQboSTIxo3mSDXAHJL3ctFjJ+P+NmX6tUSFweuTml2QCazwnF4LMjWXDINnu
         kOmPtjTTVHcbMWFQX3JOzVV3YmB+aFC4eKEnjsoSeuGieG0+1WAIaFMuS6xffQl9p5io
         A0Qd4ME5ivXIdVF8o80p4G2/KD8ni3iRxcuBrlYUNaiJVRWfWgUDPJNqUKbK2fPL1kGM
         H8spbKdLj5MFwHqyhicsMDa81AUAJupyBXCVFGUtFWN9bBmJzcm08ao/8UwgwwaXHQxs
         GWBw==
X-Gm-Message-State: ANoB5pmn/ptgj7l/1PZ2u3FcF1aPNxVXknG7h2p2quuTpmglfQ8s6D5B
        rO0cJV1RyrHXg0hI74RkwbxUwZN+X2ciwTPfZTihXA==
X-Google-Smtp-Source: AA0mqf4JVGtSyb4NJ+SoBWhjXtO1KWOMSMsFG22erYTaz0MdcyM3hNCHGpDDoIAeUO7E0+Rm25aoKwhiNOBTAh8rvEM=
X-Received: by 2002:a25:744f:0:b0:6e6:8d2d:4b42 with SMTP id
 p76-20020a25744f000000b006e68d2d4b42mr3924310ybc.435.1668720198916; Thu, 17
 Nov 2022 13:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com> <YyH/tOqrl8pZmoub@google.com>
 <CAMkAt6p2Y=6sBB1JiZ2FovYXme9QBFWFu+EtnNyuQ3Db3ZhBSg@mail.gmail.com>
 <CAMBK9=YB=8EQymDUda300qPFAL1=7dzC61c0pshrWEC5ibrUfQ@mail.gmail.com>
 <B7175642-351D-44A0-B7AD-E69C6B64FC18@zytor.com> <81950d38-4d5a-6902-bc2e-327d2800eb58@amd.com>
In-Reply-To: <81950d38-4d5a-6902-bc2e-327d2800eb58@amd.com>
From:   Marc Orr <marcorr@google.com>
Date:   Thu, 17 Nov 2022 13:23:08 -0800
Message-ID: <CAA03e5Gb0BDn-e7Th8JPQqrX-EmFW3kGeiKfuFvwEzKe6xRadg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Adam Dunlap <acdunlap@google.com>,
        Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 6:29 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/3/22 18:11, H. Peter Anvin wrote:
> > On October 3, 2022 4:01:01 PM PDT, Adam Dunlap <acdunlap@google.com> wrote:
> >> Thanks for all the responses. Is the consensus that we should use the
> >> readl function here or instead use inline assembly directly as in the patch
> >> I originally sent out:
> >>
> >> asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
> >>
> >> ? The readl function has this exact same code, I'm just not sure
> >> which version fits better stylistically.
> >
> > Is mov with an arbitrary addressing mode still acceptable for whatever is causing this problem?
>
> The acceptable forms of MOV are covered by insn_decode_mmio() in
> arch/x86/lib/insn-eval.c.

Is this blocked on an item? There seems to be consensus that this
patch fixes a bug and is taking the right high-level approach (i.e.,
change the guest code to avoid triggering a sequence that isn't
supported under CVM exception-based emulation). Without something like
this, we weren't able to build the kernel w/ CLANG when it is
configured to run under SEV-ES.

We sent out two versions of the patch. One that does the mov directly
[1] and a second that calls readl [2]. Is one of these two patches
acceptable? Or do we need to follow up on something?

[1] https://lore.kernel.org/lkml/0D6A1E49-F21B-42AA-BBBF-13BFC308BB1E@zytor.com/T/
[2] https://lore.kernel.org/all/20220812183501.3555820-1-acdunlap@google.com/

Thanks,
Marc
