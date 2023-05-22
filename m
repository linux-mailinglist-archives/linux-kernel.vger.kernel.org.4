Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16070C3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEVQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjEVQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:59:16 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233E102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:59:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-623836551f5so28162176d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684774752; x=1687366752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvg1bzTjvO/d9K3oVfrmdmjH+Quxi+XWSLBnFHmrSNo=;
        b=Iobi8TxPNPd07ii6AcbBDoMEVYMNpSHMm6f70MnK3FFRP1TF3RK/nNMQw1qi/IHPqp
         X4iQlVWdhFLmOiuxPCIRqIgiUPN6G+Qf/q4riX4r918oL8xhToyW+TaL2ZoxlhLMBWqm
         4WMNSsfr8JglswirwLULtwWTYZto9gzU1iKfy5aPgnOQoqe6GpI0gFb6dZYsPhCKQ62F
         TQCnH4zukIhbIVZBJIOaOrrySUnXC9LJbp9/nstQ1QHeubSTX+gMCZpTlHKyYV9WXuf9
         eO+cb4NgCKsa6HSmTled3wydzrV7B50wOrJKo9ueDe7h8gRdwxuK7mzTWtIReN5l8PBk
         PWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684774752; x=1687366752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zvg1bzTjvO/d9K3oVfrmdmjH+Quxi+XWSLBnFHmrSNo=;
        b=bTneNyyssC+xS7OKH3d1E6bgVfbEzoFxpB/DJmjM+fGRD8WtN3jUuzZmeIg7cRmkzx
         OadJToW/cVEtK2sPUcPQNFn8e0R6258UpMMUa6Nu5ikcywd9r42RGiTaDRWqCAX8k/ez
         CRZnSRD7r9TSGbu3623od61VNzhrB3mbcs7+lWAqH/jM3nIneOvN3cneOOmKJhvcUTKN
         Y5AnRGNiLsAzxRwNgSofFLq3K2PcHjhc73+l15hw2/x6O3emr4fRbAOZ8/2CRy8ARJTS
         JXaNsoMbJcIyZh/hmyfehq21ykpQjUS25/iUxElE2snyZThEY6rbJreFU/pp36PTDUei
         T+QA==
X-Gm-Message-State: AC+VfDyL7VrL5L45I62VA52chcLZUxTiwo26iDUBt8QXEsRiFvn2asUj
        kYzAE7tWPpWKMA9QHhVm6e1OHlTni115zsLTcuuGdcSOI8WU+rRODGI=
X-Google-Smtp-Source: ACHHUZ77Op0sSUXmoOrooVIGmURs26OvAxqgk9f/luYOhU1KPvhqv0r13WVQbGKr0Fyo/PWZX5kg6LXCrSSVcEET6Go=
X-Received: by 2002:a05:6214:1d0d:b0:61b:79ab:7129 with SMTP id
 e13-20020a0562141d0d00b0061b79ab7129mr22137744qvd.37.1684774752320; Mon, 22
 May 2023 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-11-masahiroy@kernel.org>
 <CAKwvOdmA1q1ojTWq79VK4HJqKfMHA=8VB9q61xJoKyYsegv3tg@mail.gmail.com> <CAK7LNAQ3KO1BY5Nq6uhHQGm_eOVNvk206A-s5pSguTO3ykLUng@mail.gmail.com>
In-Reply-To: <CAK7LNAQ3KO1BY5Nq6uhHQGm_eOVNvk206A-s5pSguTO3ykLUng@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 09:59:01 -0700
Message-ID: <CAKwvOdmrLTfX4sjgs+6n0SEr6GC-z0v4EQTJ7nCyy5LhvPi91Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: multipart/mixed; boundary="000000000000a4019605fc4b30d0"
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

--000000000000a4019605fc4b30d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2023 at 6:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, May 18, 2023 at 6:14=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > find_elf_symbol() and find_elf_symbol2() are not good names.
> > >
> > > Rename them to find_tosym(), find_fromsym(), respectively.
> >
> > The comments maybe could be updated, too. The end of the comment looks
> > wrong for both.
>
>
> What do you mean?
>
> Please tell me which part should be changed, and how.

Attached the comment style changes.  I didn't have precise wording in
mind for the comments; I was suggesting to see if the comments could
be updated to clarify what the functions are doing.

>
>
>
>
>
>
> > Thanks for the patch!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > Changes in v5:
> > >   - Change the names
> > >
> > >  scripts/mod/modpost.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index 3b7b78e69137..0d2c2aff2c03 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -1124,8 +1124,8 @@ static inline int is_valid_name(struct elf_info=
 *elf, Elf_Sym *sym)
> > >   * In other cases the symbol needs to be looked up in the symbol tab=
le
> > >   * based on section and address.
> > >   *  **/
> > > -static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword ad=
dr,
> > > -                               Elf_Sym *relsym)
> > > +static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
> > > +                          Elf_Sym *relsym)
> > >  {
> > >         Elf_Sym *sym;
> > >         Elf_Sym *near =3D NULL;
> > > @@ -1168,8 +1168,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info=
 *elf, Elf64_Sword addr,
> > >   * The ELF format may have a better way to detect what type of symbo=
l
> > >   * it is, but this works for now.
> > >   **/
> > > -static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr=
,
> > > -                                unsigned int secndx)
> > > +static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
> > > +                            unsigned int secndx)
> > >  {
> > >         Elf_Sym *sym;
> > >         Elf_Sym *near =3D NULL;
> > > @@ -1207,10 +1207,10 @@ static void default_mismatch_handler(const ch=
ar *modname, struct elf_info *elf,
> > >         const char *tosym;
> > >         const char *fromsym;
> > >
> > > -       from =3D find_elf_symbol2(elf, r->r_offset, fsecndx);
> > > +       from =3D find_fromsym(elf, r->r_offset, fsecndx);
> > >         fromsym =3D sym_name(elf, from);
> > >
> > > -       to =3D find_elf_symbol(elf, r->r_addend, sym);
> > > +       to =3D find_tosym(elf, r->r_addend, sym);
> > >         tosym =3D sym_name(elf, to);
> > >
> > >         /* check whitelist - we may ignore it */
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers

--000000000000a4019605fc4b30d0
Content-Type: text/plain; charset="US-ASCII"; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lhz3c4un0>
X-Attachment-Id: f_lhz3c4un0

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvbW9kL21vZHBvc3QuYyBiL3NjcmlwdHMvbW9kL21vZHBvc3Qu
YwppbmRleCBkNDUzMWQwOTk4NGQuLjE5MjZlNTAzYjBkNiAxMDA2NDQKLS0tIGEvc2NyaXB0cy9t
b2QvbW9kcG9zdC5jCisrKyBiL3NjcmlwdHMvbW9kL21vZHBvc3QuYwpAQCAtMTEzMSwxMyArMTEz
MSwxMyBAQCBzdGF0aWMgaW5saW5lIGludCBpc192YWxpZF9uYW1lKHN0cnVjdCBlbGZfaW5mbyAq
ZWxmLCBFbGZfU3ltICpzeW0pCiAJcmV0dXJuICFpc19tYXBwaW5nX3N5bWJvbChuYW1lKTsKIH0K
IAotLyoqCisvKgogICogRmluZCBzeW1ib2wgYmFzZWQgb24gcmVsb2NhdGlvbiByZWNvcmQgaW5m
by4KICAqIEluIHNvbWUgY2FzZXMgdGhlIHN5bWJvbCBzdXBwbGllZCBpcyBhIHZhbGlkIHN5bWJv
bCBzbwogICogcmV0dXJuIHJlZnN5bS4gSWYgc3RfbmFtZSAhPSAwIHdlIGFzc3VtZSB0aGlzIGlz
IGEgdmFsaWQgc3ltYm9sLgogICogSW4gb3RoZXIgY2FzZXMgdGhlIHN5bWJvbCBuZWVkcyB0byBi
ZSBsb29rZWQgdXAgaW4gdGhlIHN5bWJvbCB0YWJsZQogICogYmFzZWQgb24gc2VjdGlvbiBhbmQg
YWRkcmVzcy4KLSAqICAqKi8KKyAqLwogc3RhdGljIEVsZl9TeW0gKmZpbmRfZWxmX3N5bWJvbChz
dHJ1Y3QgZWxmX2luZm8gKmVsZiwgRWxmNjRfU3dvcmQgYWRkciwKIAkJCQlFbGZfU3ltICpyZWxz
eW0pCiB7CkBAIC0xMTgxLDcgKzExODEsNyBAQCBzdGF0aWMgRWxmX1N5bSAqZmluZF9lbGZfc3lt
Ym9sKHN0cnVjdCBlbGZfaW5mbyAqZWxmLCBFbGY2NF9Td29yZCBhZGRyLAogICogSWYgd2UgZmlu
ZCB0d28gc3ltYm9scyB3aXRoIGVxdWFsIG9mZnNldCBwcmVmZXIgb25lIHdpdGggYSB2YWxpZCBu
YW1lLgogICogVGhlIEVMRiBmb3JtYXQgbWF5IGhhdmUgYSBiZXR0ZXIgd2F5IHRvIGRldGVjdCB3
aGF0IHR5cGUgb2Ygc3ltYm9sCiAgKiBpdCBpcywgYnV0IHRoaXMgd29ya3MgZm9yIG5vdy4KLSAq
Ki8KKyAqLwogc3RhdGljIEVsZl9TeW0gKmZpbmRfZWxmX3N5bWJvbDIoc3RydWN0IGVsZl9pbmZv
ICplbGYsIEVsZl9BZGRyIGFkZHIsCiAJCQkJIGNvbnN0IGNoYXIgKnNlYykKIHsK
--000000000000a4019605fc4b30d0--
