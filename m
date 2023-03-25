Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844696C8C09
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCYHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCYHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:04:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE31166D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:04:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z10so2327539pgr.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679727851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEeKKPyP6D5ZOnLC1IFpmfcIAiTAE8/TJkb3XOHx37w=;
        b=QybTFgOtV2aWoTxK9LbPgWA1xmKe1N7LSuqKWt5sTr8hg36FPeFntmXwZ8OaynF8sa
         YHNLaniFrpOZ3qRHMku6GdeXVKZ0spCEVTMeJV5MU/z9St2xZMmrRhynhIC4Van39k3i
         KbK06qm3kIyG6OBsh3vLr9xkoqec022vwCdjNQJdCLK1rVIygSIFV54vBy7GgADCmRgA
         dHC2nUc7de2Bw6s60XVK9v8jjh4383HYw4CmkuN3/u5WQrvhQ0hkiILxLuhgRhZ3wrg+
         nR4fDGQuz3GI7dRziJvsRcV+Bewgwz+ue6AFC2Ptd2aQ/HiB22tbj+25wZDAwp09YRLh
         I5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679727851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEeKKPyP6D5ZOnLC1IFpmfcIAiTAE8/TJkb3XOHx37w=;
        b=NdCAxCTGiKfi0Tk5Oel9SJwDzPRgCpUy/SdlqREEOP1ZWt6I11vRgdbiK++G1N/VVw
         esD7C0UGpgSVcNWpFuhX4j5KXhYaJEhZolzG2U+caaKT5vXgw9CeroHo1zDxPpRm1hr4
         mfAGJBJ1biF9AfVipbzlVmadPAqfUHWFAZCqmMLDYLxr1bPE9kG/ouk/MogfbxFiTQm/
         avKE+XC3Eo8cF4XZRjfHlRqw+YCdn82SmaupmUiJcNN+v5x85xCndSmW4fb8F3lDkGWT
         VIDAqp+ND6RdylwVBXE7L+PQL4USCLZPa8HsI4SCEvG5jAsn17cUjaTw6sD6I7ooDwMO
         IqTg==
X-Gm-Message-State: AAQBX9eHTkr2naFQLTVIcoHoT2fJqIlr+tOqdA+qkYA0fcuxYbC0IJJA
        3pu+B3O/YOU8A1IIvHJYx88ULJrflAzg8BH/n17S5pxmhAhyjA==
X-Google-Smtp-Source: AKy350ZhPSWzq9CxmIFKnSBPBifMyY8FeVfGzlxCkM3U/lUH+vFZmIlLRUu52Gwtdjsh+ZJ+a/WG/jG5HIHZONZmzXU=
X-Received: by 2002:a63:d05:0:b0:503:a26e:b4cf with SMTP id
 c5-20020a630d05000000b00503a26eb4cfmr1299227pgl.8.1679727851484; Sat, 25 Mar
 2023 00:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeo-3e1emyUvqoQBz-v0CQQQasytb15SyhVVhiPwdheYgN=ow@mail.gmail.com>
 <ZB6O5awTbmcmqFI5@kernel.org> <CAGeo-3cMGSpG413=gA3NtcDyN5oTFLuZfNf8dVdVi3xQmGSWgQ@mail.gmail.com>
 <ZB6XvqqnGa446s5o@kernel.org>
In-Reply-To: <ZB6XvqqnGa446s5o@kernel.org>
From:   Hongbin Ji <jihongbin999@gmail.com>
Date:   Sat, 25 Mar 2023 15:04:00 +0800
Message-ID: <CAGeo-3chRzG_Omr6jXWc6+p4ozMFhk=i-O=WBCHjcBis66Z-sw@mail.gmail.com>
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

Sorry, this is the first time I use email, I checked the top post and
bottom post just now, I will modify the sending method.

Passing an oversized @size argument is allowed inside membloc_remove().

static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *=
size)
{
        return *size =3D min(*size, (phys_addr_t)ULLONG_MAX - base);
}

phys_addr_t end =3D base + memblock_cap_size(base, &size);

and internally checks and handles @size parameter overflow

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8825=E6=97=A5=
=E5=91=A8=E5=85=AD 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 25, 2023 at 02:25:58PM +0800, Hongbin Ji wrote:
> > It is just to correct the information displayed by the debugging.
> > The wrong information display is also a problem, but it is not a
> > problem that affects the function
>
> Please don't top post.
>
> Wrong debugging info will be the least of the problems if memblock_add() =
or
> membloc_remove() are called with wrong parameters.
>
> Please work on cleanups based on code inspection outside of mm/
>
> > Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=85=AD 14:04=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Mar 24, 2023 at 04:15:13PM +0800, =E7=BA=AA=E5=AE=8F=E5=AE=BE=
 wrote:
> > > > Allow memblock users to specify range where @base + @size overflows=
,
> > > > This will cause the address range information in the debug output t=
o
> > > > be displayed incorrectly.
> > >
> > > Is there a real problem you are trying to solve?
> > >
> > > > For example, calling memblock_remove(1ULL << PHYS_MASK_SHIFT,
> > > > ULLONG_MAX) in arch/arm64/mm/init.c,
> > > > would be displayed as:
> > > > [ 0.000000] memblock_remove: [0x0001000000000000-0x0000fffffffffffe=
]
> > > > arm64_memblock_init+0x24/0x270
> > > > but we expect the output:
> > > > [ 0.000000] memblock_remove: [0x0001000000000000-0xffffffffffffffff=
]
> > > > arm64_memblock_init+0x24/0x270
> > > >
> > > > Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> > > > ---
> > > >  mm/memblock.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index 25fd0626a9e7..567b99e4355d 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -700,7 +700,7 @@ static int __init_memblock
> > > > memblock_add_range(struct memblock_type *type,
> > > >  int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_=
t size,
> > > >         int nid, enum memblock_flags flags)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] nid=3D%d flags=3D%x %pS\n", __func__,
> > > >        &base, &end, nid, flags, (void *)_RET_IP_);
> > > > @@ -721,7 +721,7 @@ int __init_memblock memblock_add_node(phys_addr=
_t
> > > > base, phys_addr_t size,
> > > >   */
> > > >  int __init_memblock memblock_add(phys_addr_t base, phys_addr_t siz=
e)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > >        &base, &end, (void *)_RET_IP_);
> > > > @@ -822,7 +822,7 @@ static int __init_memblock
> > > > memblock_remove_range(struct memblock_type *type,
> > > >
> > > >  int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t =
size)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > >        &base, &end, (void *)_RET_IP_);
> > > > @@ -854,7 +854,7 @@ void __init_memblock memblock_free(void *ptr, s=
ize_t size)
> > > >   */
> > > >  int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr=
_t size)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > >        &base, &end, (void *)_RET_IP_);
> > > > @@ -865,7 +865,7 @@ int __init_memblock memblock_phys_free(phys_add=
r_t
> > > > base, phys_addr_t size)
> > > >
> > > >  int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t=
 size)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > >        &base, &end, (void *)_RET_IP_);
> > > > @@ -876,7 +876,7 @@ int __init_memblock memblock_reserve(phys_addr_=
t
> > > > base, phys_addr_t size)
> > > >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> > > >  int __init_memblock memblock_physmem_add(phys_addr_t base, phys_ad=
dr_t size)
> > > >  {
> > > > - phys_addr_t end =3D base + size - 1;
> > > > + phys_addr_t end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - =
1;
> > > >
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > > >        &base, &end, (void *)_RET_IP_);
> > > > @@ -1645,7 +1645,7 @@ void __init memblock_free_late(phys_addr_t ba=
se,
> > > > phys_addr_t size)
> > > >  {
> > > >   phys_addr_t cursor, end;
> > > >
> > > > - end =3D base + size - 1;
> > > > + end =3D base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > > >   memblock_dbg("%s: [%pa-%pa] %pS\n",
> > > >        __func__, &base, &end, (void *)_RET_IP_);
> > > >   kmemleak_free_part_phys(base, size);
> > > > --
> > > > 2.34.1
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.
