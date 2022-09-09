Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567B5B3910
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiIINen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiIINek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:34:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C3357D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:34:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b2so1112068qkh.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1B9mFN0cxvEq52ylC0j4yhvF/kkQxB2oC++4CzkQxbU=;
        b=LKM4cC3oid/qzGIma2gu52KanSNT+uU2jw5UQzVmsi4evxBnXM9pjKyluyCO4xes25
         oaGX6Htcvm9pxufSOUNmt3u5CPq0ScF17dOyv5Zn5ZpGNq3eMlMDBw9/oNZta1NrFHNf
         IrztlEFWOVpr0y1p05Em25xOWlCADMx3Q7j5RbM/uAb/T8wzyBY1Y4EMJ260+w7ycRnK
         y8fuBUW5v6+N8Dlr+vvL0PIcs7Tc7UBalHOBgKdZzU1cktwSkpW3uB1zR9IptXLcvKjl
         7nxq6v2lDV0YvF/r8iNR0fyY4vnLb8QIY+YkZh8fZvmQ419VYX1l13/kTBZ+qVBqp+A9
         5Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1B9mFN0cxvEq52ylC0j4yhvF/kkQxB2oC++4CzkQxbU=;
        b=0uL0XyVEgv8iSe0vwo7NjbmaAAF2ZEyRkO0WgYcxWE3na4SSaKJTncQkG28HpSfMdF
         YtVJXtkg7SofhW9Dvu7Y9EKzbM/fckhx2z7TEZiInZ4HobSCkBzOad97iNpGBYITYCvm
         0kmio/uMXpYQXOabZ4Au5EJGhv/uD9ypiCwc9PDjUnJyaTdjSLKzUUhdLop5gGn5ivs1
         3zKJl6C/KyhbLRcMwz6lJkZmb3Jg/dyhk+BtYiKx4XnO3P6AtpWlqdZdAF6EGnXdwbbm
         FZLWoEM485lpIjfKa4BRqN+bXiTQ4KUC1Vr8tD9ve0RTiwqhihwwL1RW3ywBekPdkp0F
         yCEg==
X-Gm-Message-State: ACgBeo0hhtPQ2+9sAEZJFbrEXIqwv2q/3AfDUFVcdawwprkiaqOhnTuX
        Nv6Wq/SWXsimkjJ2bNiBYBHnugqS3cxJyFz+ZIL+A5S9oojyIA==
X-Google-Smtp-Source: AA6agR4T18xG754Z+D5DqORCa8ZqC8rW6lRdaZoWxv7Zt6oFW+IqQH5lSbrlpWKdEKZ3m34rI1zWkCOevwBOALsg+Jw=
X-Received: by 2002:a05:620a:29c4:b0:6bc:638d:cf30 with SMTP id
 s4-20020a05620a29c400b006bc638dcf30mr9688037qkp.443.1662730477718; Fri, 09
 Sep 2022 06:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220901141307.2361752-1-georgepee@gmail.com> <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
In-Reply-To: <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
From:   George Pee <georgepee@gmail.com>
Date:   Fri, 9 Sep 2022 08:34:26 -0500
Message-ID: <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the hwcap was part of the diagnosis process-- I added it just
to make sure that the cpu in question supported the optional
extension.
It seems like it could be useful to be able to check for support in
/proc/cpuinfo.

On Fri, Sep 9, 2022 at 7:46 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-09-01 15:13, george pee wrote:
> > Report as fphp to be consistent with arm64
>
> Wasn't the original problem that the VFP support code doesn't understand
> the new FP16 instruction encodings, so in practice they don't actually
> work reliably? Exposing a hwcap to say they're functional doesn't
> inherently make them functional - if there is already another patch
> somewhere for that, it should be made clear that this depends on it.
>
> Robin.
>
> > Signed-off-by: george pee <georgepee@gmail.com>
> > ---
> >   arch/arm/include/uapi/asm/hwcap.h | 1 +
> >   arch/arm/kernel/setup.c           | 1 +
> >   arch/arm/vfp/vfpmodule.c          | 2 ++
> >   3 files changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> > index 990199d8b7c6..f975845ce5d3 100644
> > --- a/arch/arm/include/uapi/asm/hwcap.h
> > +++ b/arch/arm/include/uapi/asm/hwcap.h
> > @@ -28,6 +28,7 @@
> >   #define HWCAP_IDIV  (HWCAP_IDIVA | HWCAP_IDIVT)
> >   #define HWCAP_LPAE  (1 << 20)
> >   #define HWCAP_EVTSTRM       (1 << 21)
> > +#define HWCAP_FPHP   (1 << 22)
> >
> >   /*
> >    * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 1e8a50a97edf..6694ced0552a 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -1249,6 +1249,7 @@ static const char *hwcap_str[] = {
> >       "vfpd32",
> >       "lpae",
> >       "evtstrm",
> > +     "fphp",
> >       NULL
> >   };
> >
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 2cb355c1b5b7..cef8c64ce8bd 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -831,6 +831,8 @@ static int __init vfp_init(void)
> >
> >                       if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
> >                               elf_hwcap |= HWCAP_VFPv4;
> > +                     if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
> > +                             elf_hwcap |= HWCAP_FPHP;
> >               }
> >       /* Extract the architecture version on pre-cpuid scheme */
> >       } else {
