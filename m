Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E976C8BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCYG0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjCYG0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:26:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9115541
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:26:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so3640914pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679725569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovgK8antSVfJGzYjs2xzQkce11kXm5N4wiQsWVLOSTs=;
        b=MsM/Dt0+R+ZIxOgk2zcroYkU4vhohCcafFOzgRKWm/sKKjIAu0flXR+EbXyAKSM6T0
         kWloCxql8bm55xy+EimtrUyZjsDMxNxkJHMptXml4WQNy3QRzqrnuqHYbPppxdoTqPCe
         GTRbjghuF5qVadXAflxI6I+IZXXfL34Dc2xeEOwdVgKaPJ+iGK2w5EcuCQTf2fP0JwCk
         Zi8owNtMVjPcIz7Jheda1S9QceUJ0w1Z0Dy16eWWp74gqujen4glJfL9/9GIy3GF+4RM
         MTExGyC6WaYtdsUGalRvV0j+NL37auHyTc0aUfzYT+B6QLYgjLI1eXTEpYlEwnzei56W
         2PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679725569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovgK8antSVfJGzYjs2xzQkce11kXm5N4wiQsWVLOSTs=;
        b=3N5+kNB792a6p5ZJvdLyYVpslWmQRiJwYyWMxAGqXjvmHzZUf00T3zsDHs8hzYAE8b
         8gTHuYALXFznNUJTrdDdFpumQa5V9jVp2JV7uovBFUpPOKPq7F30ir3jlNnV7VQ3tmNN
         RFJyGaQ4G0L5cRX2E5pzp/uGFVhkSIvY7zQUEphcOQ95X6au+MSFlsEnqQKQnLJ/tRrK
         L5JxAmdmLkWvlEZTe5uVkLiN476iZkt5rU6JwV+4H4THawz44OGddDxeeW3bpfdZmqwS
         M5W2/nM3G8lzT11R7OnMC2BsaFow306ZG2KNK8u5wp3K4fjlOrJM64vSAbbxAI999GmV
         3GTw==
X-Gm-Message-State: AAQBX9dQ1t2NR+hcyUXoyHk5dQxUnACB7fNQLv3C6pEs8ITjigeL9F3d
        2L/wFUhICLZ3K4ZiOGeW44MKWrkykmvLNtY4C/nDJT78SKNqpQ==
X-Google-Smtp-Source: AKy350b3tbL0IlqcDEHW6gO3DFd9UZweAzaT18Rtq5FAO1tsmsDTGaQy876/Y+pHBpP7xdzN2i/oQYV7IneS6rOjt5g=
X-Received: by 2002:a17:903:1c7:b0:1a2:185a:cd6 with SMTP id
 e7-20020a17090301c700b001a2185a0cd6mr1766516plh.4.1679725568975; Fri, 24 Mar
 2023 23:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeo-3e1emyUvqoQBz-v0CQQQasytb15SyhVVhiPwdheYgN=ow@mail.gmail.com>
 <ZB6O5awTbmcmqFI5@kernel.org>
In-Reply-To: <ZB6O5awTbmcmqFI5@kernel.org>
From:   Hongbin Ji <jihongbin999@gmail.com>
Date:   Sat, 25 Mar 2023 14:25:58 +0800
Message-ID: <CAGeo-3cMGSpG413=gA3NtcDyN5oTFLuZfNf8dVdVi3xQmGSWgQ@mail.gmail.com>
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

It is just to correct the information displayed by the debugging.
The wrong information display is also a problem, but it is not a
problem that affects the function

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8825=E6=97=A5=
=E5=91=A8=E5=85=AD 14:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 24, 2023 at 04:15:13PM +0800, =E7=BA=AA=E5=AE=8F=E5=AE=BE wro=
te:
> > Allow memblock users to specify range where @base + @size overflows,
> > This will cause the address range information in the debug output to
> > be displayed incorrectly.
>
> Is there a real problem you are trying to solve?
>
> > For example, calling memblock_remove(1ULL << PHYS_MASK_SHIFT,
> > ULLONG_MAX) in arch/arm64/mm/init.c,
> > would be displayed as:
> > [ 0.000000] memblock_remove: [0x0001000000000000-0x0000fffffffffffe]
> > arm64_memblock_init+0x24/0x270
> > but we expect the output:
> > [ 0.000000] memblock_remove: [0x0001000000000000-0xffffffffffffffff]
> > arm64_memblock_init+0x24/0x270
> >
> > Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> > ---
> >  mm/memblock.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 25fd0626a9e7..567b99e4355d 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -700,7 +700,7 @@ static int __init_memblock
> > memblock_add_range(struct memblock_type *type,
> >  int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t si=
ze,
> >         int nid, enum memblock_flags flags)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] nid=3D%d flags=3D%x %pS\n", __func__,
> >        &base, &end, nid, flags, (void *)_RET_IP_);
> > @@ -721,7 +721,7 @@ int __init_memblock memblock_add_node(phys_addr_t
> > base, phys_addr_t size,
> >   */
> >  int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> >        &base, &end, (void *)_RET_IP_);
> > @@ -822,7 +822,7 @@ static int __init_memblock
> > memblock_remove_range(struct memblock_type *type,
> >
> >  int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size=
)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> >        &base, &end, (void *)_RET_IP_);
> > @@ -854,7 +854,7 @@ void __init_memblock memblock_free(void *ptr, size_=
t size)
> >   */
> >  int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t s=
ize)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> >        &base, &end, (void *)_RET_IP_);
> > @@ -865,7 +865,7 @@ int __init_memblock memblock_phys_free(phys_addr_t
> > base, phys_addr_t size)
> >
> >  int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t siz=
e)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> >        &base, &end, (void *)_RET_IP_);
> > @@ -876,7 +876,7 @@ int __init_memblock memblock_reserve(phys_addr_t
> > base, phys_addr_t size)
> >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >  int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t=
 size)
> >  {
> > - phys_addr_t end =3D base + size - 1;
> > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >
> >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> >        &base, &end, (void *)_RET_IP_);
> > @@ -1645,7 +1645,7 @@ void __init memblock_free_late(phys_addr_t base,
> > phys_addr_t size)
> >  {
> >   phys_addr_t cursor, end;
> >
> > - end =3D base + size - 1;
> > + end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> >   memblock_dbg("%s: [%pa-%pa] %pS\n",
> >        __func__, &base, &end, (void *)_RET_IP_);
> >   kmemleak_free_part_phys(base, size);
> > --
> > 2.34.1
>
> --
> Sincerely yours,
> Mike.
