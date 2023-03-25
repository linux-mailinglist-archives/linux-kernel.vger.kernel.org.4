Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF66C8C14
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCYHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjCYHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:07:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCEB1714A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:07:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kc4so3783615plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxCiDzWJtYvZXYASFFO8pwcp7ZZs/D/6ZbQ/mJbCObY=;
        b=bpjhcmtz81fHpF7LDHdVmp6d+W4Q/kgJIYGcZHbTpTu1CrFxV6d8eyPVLET29+DVym
         zQJg/ELE/zUbeq/X7PRgVzG+P4y8uGoAndDSevKUSfgt3/swzadZKX+Gra7krrm2rfUf
         q/9CzQusV92NLMa+3G6jTC3KZuaVuidJrjqCEDzckU0QrOROC9LG6SWyIKk7V4hlxpci
         NnkiAhL/zmwmTcYXfW9lCi5pkxhokStW5G1c2ucrc69gMFc5KDPpC7vLqn7HWI1lKSFD
         tuRnEXD0cziGDCdLIC1hY4QlvIuuw6bBToweYpVMcWTG0dgf9+2wnbGkgmDkDNjOFOV3
         YV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxCiDzWJtYvZXYASFFO8pwcp7ZZs/D/6ZbQ/mJbCObY=;
        b=lp0flDKEcjzWFEB2z457JhT3HS8fNcasv1DFFH31mYyZy5fjrzoFTCdErz9fkqwb2W
         AisD5qAyJOxoNJkSDkg4yN9OdEWX9h/EFmaNzo5+0JuO+2TG20dTSlF0lxKzf81tOru6
         dqK8tDz0ImXcUnBboo73hImCg8qHcaxBcpkzJEG266WE3geMZgMNRznv6z6iw1ffizdr
         t4v+ALWK9OVALC6H2kcXPWjzWK6bxe6T115EH5XTPNA3BHe6qWLZSXViY80gtETcqi8P
         nhCnBtvU5yMXWDD1lg/dsIAPRtkK7IqGg475JbCrNmJS0Lm7QYN8E9g1MbTKLJqLI+G6
         XI5w==
X-Gm-Message-State: AAQBX9cSJH+PM0dFCwSDUjtrvmYRdtpDKjp3L1G1rDqCWxRJVI9XjpFj
        phOduA/ZhfoNF9gJF0STLDVHU919AviVJMwDfmZ6Zf+2LRq07g==
X-Google-Smtp-Source: AKy350briNpxVFSKYeuamI8CpdgfJj4SgN94KkLbKSu53DazWrEDUPQIdPZ2Gyz8mwTYD7XOJxaOGJo+g3bmqeMKfmc=
X-Received: by 2002:a17:90a:ac16:b0:234:e49:ba9f with SMTP id
 o22-20020a17090aac1600b002340e49ba9fmr1608571pjq.4.1679728044886; Sat, 25 Mar
 2023 00:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeo-3e1emyUvqoQBz-v0CQQQasytb15SyhVVhiPwdheYgN=ow@mail.gmail.com>
 <ZB6O5awTbmcmqFI5@kernel.org> <CAGeo-3cMGSpG413=gA3NtcDyN5oTFLuZfNf8dVdVi3xQmGSWgQ@mail.gmail.com>
 <ZB6XvqqnGa446s5o@kernel.org> <CAGeo-3chRzG_Omr6jXWc6+p4ozMFhk=i-O=WBCHjcBis66Z-sw@mail.gmail.com>
In-Reply-To: <CAGeo-3chRzG_Omr6jXWc6+p4ozMFhk=i-O=WBCHjcBis66Z-sw@mail.gmail.com>
From:   Hongbin Ji <jihongbin999@gmail.com>
Date:   Sat, 25 Mar 2023 15:07:14 +0800
Message-ID: <CAGeo-3fWSP=98a=btSVdzRBYNC1B1P91R7=L4wxNcBjbE7hMQA@mail.gmail.com>
Subject: Re: [PATCH] memblock: Make memblock memblock_dbg info handle
 overflowing range @base + @size
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually @base + @size overflows

On Sat, Mar 25, 2023 at 3:04=E2=80=AFPM Hongbin Ji <jihongbin999@gmail.com>=
 wrote:
>
> Sorry, this is the first time I use email, I checked the top post and
> bottom post just now, I will modify the sending method.
>
> Passing an oversized @size argument is allowed inside membloc_remove().
>
> static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t=
 *size)
> {
>         return *size =3D min(*size, (phys_addr_t)ULLONG_MAX - base);
> }
>
> phys_addr_t end =3D base + memblock_cap_size(base, &size);
>
> and internally checks and handles @size parameter overflow
>
> Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=85=AD 14:42=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Mar 25, 2023 at 02:25:58PM +0800, Hongbin Ji wrote:
> > > It is just to correct the information displayed by the debugging.
> > > The wrong information display is also a problem, but it is not a
> > > problem that affects the function
> >
> > Please don't top post.
> >
> > Wrong debugging info will be the least of the problems if memblock_add(=
) or
> > membloc_remove() are called with wrong parameters.
> >
> > Please work on cleanups based on code inspection outside of mm/
> >
> > > Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=85=AD 14:04=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, Mar 24, 2023 at 04:15:13PM +0800, =E7=BA=AA=E5=AE=8F=E5=AE=
=BE wrote:
> > > > > Allow memblock users to specify range where @base + @size overflo=
ws,
> > > > > This will cause the address range information in the debug output=
 to
> > > > > be displayed incorrectly.
> > > >
> > > > Is there a real problem you are trying to solve?
> > > >
> > > > > For example, calling memblock_remove(1ULL << PHYS_MASK_SHIFT,
> > > > > ULLONG_MAX) in arch/arm64/mm/init.c,
> > > > > would be displayed as:
> > > > > [ 0.000000] memblock_remove: [0x0001000000000000-0x0000ffffffffff=
fe]
> > > > > arm64_memblock_init+0x24/0x270
> > > > > but we expect the output:
> > > > > [ 0.000000] memblock_remove: [0x0001000000000000-0xffffffffffffff=
ff]
> > > > > arm64_memblock_init+0x24/0x270
> > > > >
> > > > > Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> > > > > ---
> > > > >  mm/memblock.c | 14 +++++++-------
> > > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > > index 25fd0626a9e7..567b99e4355d 100644
> > > > > --- a/mm/memblock.c
> > > > > +++ b/mm/memblock.c
> > > > > @@ -700,7 +700,7 @@ static int __init_memblock
> > > > > memblock_add_range(struct memblock_type *type,
> > > > >  int __init_memblock memblock_add_node(phys_addr_t base, phys_add=
r_t size,
> > > > >         int nid, enum memblock_flags flags)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] nid=3D%d flags=3D%x %pS\n", __func_=
_,
> > > > >        &base, &end, nid, flags, (void *)_RET_IP_);
> > > > > @@ -721,7 +721,7 @@ int __init_memblock memblock_add_node(phys_ad=
dr_t
> > > > > base, phys_addr_t size,
> > > > >   */
> > > > >  int __init_memblock memblock_add(phys_addr_t base, phys_addr_t s=
ize)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > > >        &base, &end, (void *)_RET_IP_);
> > > > > @@ -822,7 +822,7 @@ static int __init_memblock
> > > > > memblock_remove_range(struct memblock_type *type,
> > > > >
> > > > >  int __init_memblock memblock_remove(phys_addr_t base, phys_addr_=
t size)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > > >        &base, &end, (void *)_RET_IP_);
> > > > > @@ -854,7 +854,7 @@ void __init_memblock memblock_free(void *ptr,=
 size_t size)
> > > > >   */
> > > > >  int __init_memblock memblock_phys_free(phys_addr_t base, phys_ad=
dr_t size)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > > >        &base, &end, (void *)_RET_IP_);
> > > > > @@ -865,7 +865,7 @@ int __init_memblock memblock_phys_free(phys_a=
ddr_t
> > > > > base, phys_addr_t size)
> > > > >
> > > > >  int __init_memblock memblock_reserve(phys_addr_t base, phys_addr=
_t size)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > > >        &base, &end, (void *)_RET_IP_);
> > > > > @@ -876,7 +876,7 @@ int __init_memblock memblock_reserve(phys_add=
r_t
> > > > > base, phys_addr_t size)
> > > > >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> > > > >  int __init_memblock memblock_physmem_add(phys_addr_t base, phys_=
addr_t size)
> > > > >  {
> > > > > - phys_addr_t end =3D base + size - 1;
> > > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) =
- 1;
> > > > >
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > > >        &base, &end, (void *)_RET_IP_);
> > > > > @@ -1645,7 +1645,7 @@ void __init memblock_free_late(phys_addr_t =
base,
> > > > > phys_addr_t size)
> > > > >  {
> > > > >   phys_addr_t cursor, end;
> > > > >
> > > > > - end =3D base + size - 1;
> > > > > + end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > > > >   memblock_dbg("%s: [%pa-%pa] %pS\n",
> > > > >        __func__, &base, &end, (void *)_RET_IP_);
> > > > >   kmemleak_free_part_phys(base, size);
> > > > > --
> > > > > 2.34.1
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
> >
> > --
> > Sincerely yours,
> > Mike.
