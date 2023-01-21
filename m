Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEA6769B6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAUVr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:47:56 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747891A480
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:47:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a25so6929109qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IItOU+p55SK2QjQ3YzQRVeif5DdV8TaENAjnN4IuI2s=;
        b=Ox9Tv51sqK/MFsroZpFTPtuz1PEtLzo6HMMf9MTMMDYKZxqMPkKrbsC2+rK3NFMu8l
         rLsc6QbPb99oqg371qE3BP0A1XDzk/VFHO0Ut94/Hd0l10/coXjsPGMkcCJp8Y5Yl0ew
         PHLhgrxiK4cpCLx03dyKeDId1gGXBpVl/CqBCQH/UziFktXZkw1TTfrzoOSzO0xkGMEe
         RWOdbtI18O9RJni4b3VzmFhRkVbz32UPyQkU7bYn66Wl7zs7Y2URhEu1UMi+uGdPi0ph
         P9dB2pAEwBVTrPpz9qtAN6JP5x7yOe4sYGypV8lbsKwvGkbIDSFX+ZQ8RndHSDNHVUK1
         j2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IItOU+p55SK2QjQ3YzQRVeif5DdV8TaENAjnN4IuI2s=;
        b=uvVQ36NKqy81X4belEwnrt/UfOXVWCR5/Xbgi168p0eU+rv6Uz0S0B54BLzxdNnaYl
         3QjuXqVvTSX/D026J4A4QrxcuXiqPlWrxIRUvGAmMqH5Rog8G+7RzvVYvoaY6+Yd+mWN
         SvcsDagLD9IjEVjvxPFIbKtE2ZGaeX/Zf0xeaVIG8cAvyTNmqrrysPwAdC2mdmGOu8oP
         1FXxEw/R5vEhAkSGozSdpnOVj6uKw66M/ajvC3tHEluxxD5nfqw5veIEsf1pps5Ik9yU
         8bhlzGdcdSjitZCvbHtBP5RMOb9VMI8DwDuQarHYkEetF6NDOZ9PKXJ9xGC4A/sw8oxT
         Qyzw==
X-Gm-Message-State: AFqh2kpZxf9C0CIbpSMO0IjQ47IjRqZMjRJ/a97qk6DXN0hYqcjnzA92
        u5nckGJSC7zHOWA24LboiT9qphg89GF6N29ztw==
X-Google-Smtp-Source: AMrXdXs88Z/rTXkf6lrgpVDK2Uy2GUR1VanF69oyot1eTJwLrornNIG2z7fxgHwM/Ty9zWOAsE8HFjE1SGmiDq7rQ5g=
X-Received: by 2002:ac8:70cb:0:b0:3a9:82a1:fb0f with SMTP id
 g11-20020ac870cb000000b003a982a1fb0fmr961787qtp.22.1674337674581; Sat, 21 Jan
 2023 13:47:54 -0800 (PST)
MIME-Version: 1.0
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <5703e698-a92a-2026-e5d4-3c6340578918@intel.com>
In-Reply-To: <5703e698-a92a-2026-e5d4-3c6340578918@intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 21 Jan 2023 16:47:48 -0500
Message-ID: <CAMzpN2iC9_ZfEmQA0469RQqoZ7NsNCCafy3FsZAt6O0gdB9Oig@mail.gmail.com>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:34 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/20/23 20:59, H. Peter Anvin wrote:
> >> If not intentional, it might be something that can still be fixed.
> >> If it is intentional and is going to be with us for a while we have
> >> a few options.  If userspace is _really_ depending on this
> >> behavior, we could just clobber r11 ourselves in the FRED entry
> >> path.  If not, we can remove the assertion in the selftest.
> > We can't clobber it in the FRED entry path, since it is common for
> > all events, but we could do it in the syscall dispatch.
> >
> > However, it doesn't seem to make sense to do so to me. The current
> > behavior is much more of an artifact than desired behavior.
> I guess the SDM statements really are for the kernel's benefit and not
> for userspace.  Userspace _should_ be treating SYSCALL like a CALL and
> r11 like any old register that can be clobbered.  Right now, the kernel
> just happens to clobber it with RFLAGS.
>
> I do the the odds of anyone relying on this behavior are pretty small.
> Let's just zap the check from the selftest, document what we did in the
> FRED docs and changelog and move on.

Keep the selftest check, but also accept preserved RCX/R11.  What
really matters is that the kernel isn't leaking data.

--
Brian Gerst
