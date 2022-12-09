Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328966482FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLINvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLINvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:51:46 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61E686B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:51:45 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1447c7aa004so5673700fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uSxCv4WF0QaHKgDSogZbErR2Lw6zQ7VMbcq35VL21s=;
        b=O72D1IKRQjG8i26wTTOnP3gkT0ETa3ClYQiNOxsNMogeoc/uP3ZMpi4uiTpsu24hES
         4X9j4TgiB1wuiE3gNtJ30vLLostu3eKBuOGb66PE1xkabaWokM0J8cOF+v+qBxoEpgo8
         tUVoB3/Qaj6+VgMAP7oI9xl5516MHSvxjx5Kj1AymRFRN8P7Ce9kStmE9T6mlzKEI/6s
         4BzlGtE61cYTVz1i6RoKYSBQAGsfIvyu3t/+aOx421RmQ2ljc1n/IPHIYVPakoz6otO0
         V4oQRhEWxAA90TkbY44ztxpo98I2FY1VRA7xtf3HbXFobw9rRTX8GXlXQX0B/9JXDgf0
         a91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uSxCv4WF0QaHKgDSogZbErR2Lw6zQ7VMbcq35VL21s=;
        b=1ObW0DQao6H2vEZRXCe9yHNvHN4a0O57Z2RLCV1oMj5w87kPImhnLYAJmCZhhGFwWu
         M42ca9UpZBJUhSjVsomf8g3t48GDX5rlngQroeemUbLweR063Cif7+fBlbwewrZU4YBh
         Fw5empnJ/cVxZPDKiJRHZfNgAJSJgyzmpB/QPk+0NpSUgH1fLfk4bxZoIl4aN3m3oXA+
         RBC7noHFxdK5Qrxim5NZLsXdehT0FrQJ78hKH1DP9gXuiasvXTXizxo+Jhlx35PP55C0
         yk17mxM3doRVp+1QkANlbsMpCqJllUrOjEGW4Clasqomyin8u9MV8eiLVHe5ov5GrVO3
         h1kw==
X-Gm-Message-State: ANoB5pmc7mc/kIkRmc6s1PHfM47UUCQlRoAMrbyRAbIxPblPP7SAor/o
        ISPE/MuMvPmOuHJvO3edlMX/mDppfiM9PyMcLag=
X-Google-Smtp-Source: AA0mqf4FkPB/DMRGov6c2W44wjH5B4USukcrgs+vn292N7Bh6s0GsCLQ0ago9NLAJ3WVaDvLTTEUJgbi0Njynv50/GQ=
X-Received: by 2002:a05:6870:f592:b0:144:543:c801 with SMTP id
 eh18-20020a056870f59200b001440543c801mr20734854oab.201.1670593905207; Fri, 09
 Dec 2022 05:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
 <Y5M1UowMyucPOqAl@FVFF77S0Q05N> <CAGkG8RF0QNrC=UQ3uwurYQRS-kajYr3=g1qa6d7x=RC55z7ymg@mail.gmail.com>
 <ed1c32c0-e882-e7f8-3acf-0c0204fb96ae@csgroup.eu>
In-Reply-To: <ed1c32c0-e882-e7f8-3acf-0c0204fb96ae@csgroup.eu>
From:   Xander <xandermoerkerken@gmail.com>
Date:   Fri, 9 Dec 2022 14:51:19 +0100
Message-ID: <CAGkG8RFW2=rLVtUmCOMPoTf2LP9WbQsYFLfJ3Dy17DV99Uza1A@mail.gmail.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 at 14:46, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 09/12/2022 =C3=A0 14:38, Xander a =C3=A9crit :
> >
> > The pgprot parameter got removed because, according to the commit log,
> > for no other apparent reason than it being called with 'PAGE_KERNEL' as
> > an argument in the whole kernel. Therefore it got removed.
> > This removed the ability to allocate virtual memory with executing righ=
ts.
> > My use case comes from ioremap().
> > I think this is useful for others too.
> >
> > I don't see why this pgprot parameter got removed but this is the
> > alternative to reverting it to the older 5.7 function.
>
> Please avoid top-posting, and use only plain text.
>
> I think you don't answer to Mark's question.
>
> You are adding a new function that no driver uses apparently. If you are
> working on some piece of code that needs this new fonction, you can send
> this patch as part of a patch series including that code.
>
> By the way, when you need executable memory, the fonction to use is
> module_alloc(), that's the only function that garanties real executable
> memory on all platforms. For instance, on some powerpc, setting the X
> bit is not enough to get executable memory in vmalloc space.
>
> Christophe
>

Loud and clear, thanks for the feedback.

> >
> > On Fri, 9 Dec 2022 at 14:17, Mark Rutland <mark.rutland@arm.com
> > <mailto:mark.rutland@arm.com>> wrote:
> >
> >     On Fri, Dec 09, 2022 at 02:10:52PM +0100, Xander Moerkerken wrote:
> >      > From: Xander Moerkerken <xander.moerkerken@gmail.com
> >     <mailto:xander.moerkerken@gmail.com>>
> >      >
> >      > Since release 5.8-rc1 the pgprot got removed from __vmalloc
> >      > because the only usage was PAGE_KERNEL as argument.
> >      > However, this removes the ability to input other arguments
> >      > such as 'PAGE_KERNEL_EXEC', which can be used to allocate
> >      > memory in which you can execute. For this reason a new
> >      > function is introduced called '__vmalloc_exec'.
> >      >
> >      > Signed-off-by: Xander Moerkerken <xander.moerkerken@omron.com
> >     <mailto:xander.moerkerken@omron.com>>
> >
> >     What is this going to be used for? There's no user from this patch
> >     alone, as a
> >     module or otherwise.
> >
> >     Mark.
> >
> >      > ---
> >      >  include/linux/vmalloc.h | 1 +
> >      >  mm/vmalloc.c            | 8 ++++++++
> >      >  2 files changed, 9 insertions(+)
> >      >
> >      > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> >      > index 096d48aa3437..10c46513b6b2 100644
> >      > --- a/include/linux/vmalloc.h
> >      > +++ b/include/linux/vmalloc.h
> >      > @@ -147,6 +147,7 @@ extern void *vzalloc_node(unsigned long size=
,
> >     int node) __alloc_size(1);
> >      >  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> >      >  extern void *vmalloc_32_user(unsigned long size) __alloc_size(1=
);
> >      >  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> >     __alloc_size(1);
> >      > +extern void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> >     __alloc_size(1);
> >      >  extern void *__vmalloc_node_range(unsigned long size, unsigned
> >     long align,
> >      >                       unsigned long start, unsigned long end,
> >     gfp_t gfp_mask,
> >      >                       pgprot_t prot, unsigned long vm_flags, int
> >     node,
> >      > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >      > index ccaa461998f3..8fd01ed7082b 100644
> >      > --- a/mm/vmalloc.c
> >      > +++ b/mm/vmalloc.c
> >      > @@ -3294,6 +3294,14 @@ void *__vmalloc(unsigned long size, gfp_t
> >     gfp_mask)
> >      >  }
> >      >  EXPORT_SYMBOL(__vmalloc);
> >      >
> >      > +
> >      > +void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> >      > +{
> >      > +     return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_=
EXEC,
> >      > +                               NUMA_NO_NODE,
> >     __builtin_return_address(0));
> >      > +}
> >      > +EXPORT_SYMBOL(__vmalloc_exec);
> >      > +
> >      >  /**
> >      >   * vmalloc - allocate virtually contiguous memory
> >      >   * @size:    allocation size
> >      > --
> >      > 2.37.2
> >      >
> >
