Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900DA63BDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiK2KPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiK2KO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:14:56 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72D1FFA1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:14:55 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16834373pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poSmrhdJ4U00W1z+gbHBDA9DySuHPZHfxMPRbSyJiW0=;
        b=GlyUwPws0GVRHJkmCDGEoALIe3k+cKrflmkIjBsgkExmKjPW+R4JzfFmbT2OVBzSdY
         9Ca3TSMUVR97rp36JYkYFCAliF7dFss+LGQKGQ0AxcPOZ5/eAErlXwey9mN8JJ+ujRba
         6wy7dWjTgQeBEO06CO4o8PWUjqJSQ7Gvu815Jl8ZhYqtWmVdoVveydFIrWhJW88he395
         PY8lyzE6o1JTFhhInzahnHCDeDHou2+dLZ4NZBEahOXexBupCjUSkhmSVLpKFaiMKAHk
         NN1bODZs00FYqzCCpbEKQDeDFrWhcYw8cIXnsuhgncrERmSEwHfBkhuOuU4Do2NvSfbr
         8Slg==
X-Gm-Message-State: ANoB5pmhfUF2UUUdvzctfWY1jPGn1Hj6zxsKgiH5mN8cdIVA2Bjkbca0
        nmFoUGF7X3Aw2QdJS51r6YAhPRpXeS84RnkLY9o=
X-Google-Smtp-Source: AA0mqf5lRr2qpXUVgAGsQ+zxp35mp24tyMktK8I3RmHQqWmIlKgHZm2rYtj+60KiAIGe3PRoJaOXbQJKb+k4ke7lwlw=
X-Received: by 2002:a17:903:452:b0:189:6574:7ac2 with SMTP id
 iw18-20020a170903045200b0018965747ac2mr22249796plb.65.1669716894564; Tue, 29
 Nov 2022 02:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
 <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr> <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
 <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
 <20221128124513.76392c3d@gandalf.local.home> <b98429d8-6d18-cf0b-6ca0-d9d6472d21f9@redhat.com>
 <Y4T4msSXCNnfPCMG@google.com> <20221128141056.29ccafd6@gandalf.local.home>
In-Reply-To: <20221128141056.29ccafd6@gandalf.local.home>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 29 Nov 2022 19:14:43 +0900
Message-ID: <CAMZ6Rq+fb0AkmeBQwQY32d=_ihAPsN1NR5scerBJ2m5hqn7mLQ@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from asm-offsets.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kirill.shutemov@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 29 Nov. 2022 at 04:10, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 28 Nov 2022 18:06:18 +0000
> Sean Christopherson <seanjc@google.com> wrote:
>
> > > > IIRC, the reason for adding that was because that logic was screwing up
> > > > asm-offsets.c. I'm not sure it screws up kvm-asm-offsets.c though.
> > > >
> > > > This is one of those cases I wish I commented that code better :-/
> > >
> > > I don't think KVM includes linux/ftrace.h or asm/ftrace.h at all.
> >
> > >From include/linux/kvm_host.h
> >
> >   #include <linux/ftrace.h>
> >
> > Even if that didn't exist, saying that XYZ never includes a header is a dangerous
> > business, it's all too easy to indirectly include headers in the kernel, now or
> > in the future.

ACK. This is why I relied on the compiler's -Wunused-macros to assert
that COMPILE_OFFSETS can be removed from asm-offsets.c but not from
kvm-asm-offsets.c.
I also asserted that it is
https://git.kernel.org/torvalds/linux/c/debc5a1ec0d1 which removed the
dependency.

> But going back to the original intent of COMPILE_OFFSETS. I believe it was
> because some code that did not work with the auto generation of compiler
> offsets and was a way to hide them.
>
> I do not know if it is still an issue or not today.

This I do not know. I only have the confidence to remove
COMPILE_OFFSETS from asm-offsets.c. Nothing more.
