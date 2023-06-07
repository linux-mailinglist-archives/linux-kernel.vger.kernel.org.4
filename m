Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABB727359
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjFGXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFGXwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD19E;
        Wed,  7 Jun 2023 16:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D4F61040;
        Wed,  7 Jun 2023 23:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BAEC433D2;
        Wed,  7 Jun 2023 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686181950;
        bh=6pgSFYsSsLqInvahVHsx2DhcY3kpo+fzL3XqW2yw6j8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nuRuke7/uPMCJV6aj03GtBWYipIk9M7+oW9yOzrdF7+2jgSt39/Cxr8LJdQHkWmvZ
         Evl73mMzWgH2VXonZIMiy34RpqyjWXfg6Gymry2ujKervcNXiQAxfNtyj+iYWz+/s+
         mbZHMZEMlkxuustlp4DHyN8g+9GQAn5U/FpHel5xaUK9njsLD0vrF+N/8DSx7iR5xa
         kRyMOunz0KztNjuVK5l+oIFJRoGE1bzTw1EW3gDKKWlOzy6w/QSFkl7tTJxe25USpx
         /kZ6dVeIhlItdtzq0i5jC4WZQZ2ECwRUpcfLZFU/2GDyM1JbUqY2RnhFEIFdI15Ayp
         VTH56dyhUV7dw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38e04d1b2b4so43569b6e.3;
        Wed, 07 Jun 2023 16:52:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDyKuVC2+2y9aasumhfDhXmCY+S0fCBL8pVkpAnJxxPlQDh1I5T5
        hU2sEFn52oEGZDIjZ0OQR/0Ote+aBHgsVkhpcFU=
X-Google-Smtp-Source: ACHHUZ49oZDE1kdugK2Y4GVA+zcXnkkevQUVWzQxvY3efR8O0jyI3gzgf7XgmvnqirHK93KhjHG4CuLJOwPw7uY+vgs=
X-Received: by 2002:a05:6808:5ca:b0:39a:ba7e:33bd with SMTP id
 d10-20020a05680805ca00b0039aba7e33bdmr7513928oij.0.1686181949609; Wed, 07 Jun
 2023 16:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
 <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com> <2017a6dba12cc7cd05aec33e8066cb7038a89a31.camel@sipsolutions.net>
In-Reply-To: <2017a6dba12cc7cd05aec33e8066cb7038a89a31.camel@sipsolutions.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Jun 2023 08:51:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROju1ob-5VKEsu_UOfCNoMRE-QU27JE3Ndh-M7pBraSw@mail.gmail.com>
Message-ID: <CAK7LNAROju1ob-5VKEsu_UOfCNoMRE-QU27JE3Ndh-M7pBraSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 6:07=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Tue, 2023-06-06 at 20:15 +0900, Masahiro Yamada wrote:
> > >
> > >  ifneq ($(KBUILD_EXTRA_WARN),)
> > > -  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $<
> > > +  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> > > +        $(if $(KDOC_WALL), -Wall) \
> > > +        $(if $(KDOC_WRETURN), -Wreturn) \
> > > +        $(if $(KDOC_WSHORT_DESC), -Wshort-desc) \
> > > +        $(if $(KDOC_WSHORT_DESC), -Wcontents-before-sections) \
> >
> >
> >
> > Sorry, I misunderstood your intention.
> > (I just thought existing env variables would be moved to Makefile)
> >
> >
> > I do not want to proliferate env variables any more.
>
> Oh, ok, sure.
>
> > If you need per-flag control, maybe we can do like this?
>
> Well honestly, I myself just want to pass -Wall, but not necessarily W=3D=
2
> since that adds more stuff from the C compiler.
>
> > cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> >               $(KDOCFLAGS)
> >
> >
> > Then, users can do
> >
> >   $ make KDOCFLAGS=3D-Wall
> >   $ make KDOCFLAGS=3D-Wreturn
>
> I'd rather call it KDOC_FLAGS if you don't mind to align with
> KDOC_WERROR which we have already, but sure, can do.


I just tried to be consistent with
CPPFLAGS, CFLAGS, AFLAGS, CHECKFLAGS etc.
(CHECKFLAGS is for sparse) because
you apparently mimick compiler flags in kernel-doc.



BTW, kernel-doc is invoked from Documentation/Makefile too.

Do we need to pass the same flags to both of them?



> johannes






--
Best Regards
Masahiro Yamada
