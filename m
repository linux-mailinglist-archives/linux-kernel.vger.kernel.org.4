Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9036723630
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjFFEW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFFEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8E187;
        Mon,  5 Jun 2023 21:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A82D62BF7;
        Tue,  6 Jun 2023 04:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD6C433D2;
        Tue,  6 Jun 2023 04:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686025343;
        bh=HA8kGF+w0RaR5xoeiuzp/X+oqD7Y1cxhfO27BGJ4a9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CAjiwGz9jRt1wuRCN7l43vjBJFw3MqH9Y8RtzsXuuGgR+eJ0ekefvDM1bkEvP2jvh
         Aj0r1qz46kw8rNpG+xkcd8V3gFTfdCiAtF33TRqScpBFeSDulUQyCEDFqufZyiD6jC
         ybWbHLaIqlSRdJQYqIFgIZu76mJvr9eCyl/FO90kr8rRmrGI0kenSlouGMDOdqRVla
         uWrPEAJzn7hl2pz3DOUeUsbc7ViV5krGZ+v8J+cCStfDBKOMykfLfm5xQ3nn49jn/p
         Ph5qfEY12fob7iT0qC4KGvJJ4f6J5pwiQDRquXsyrdJxtNsL748UsVS1E3k3o//L7Y
         jS+dpCQ+TdOgA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39c4c3da9cbso47004b6e.2;
        Mon, 05 Jun 2023 21:22:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDwAd3embYDtaj5YAvoriROu5PhD+qhD4P3ZMlVVpcaK6ECSvBcm
        zl24u85qXKj0Q2N5wOw/K8JF9pJCS6JsCD3w8rU=
X-Google-Smtp-Source: ACHHUZ4waYFPoMaU/7NZoJeDy2EZuc956Cje2Cz+WyLBOeKIojGIPGR8qMUkFESrIJkv/j+F4/J+UaZqeqEElEwum+c=
X-Received: by 2002:a05:6808:b12:b0:39a:9957:9c26 with SMTP id
 s18-20020a0568080b1200b0039a99579c26mr400127oij.24.1686025343186; Mon, 05 Jun
 2023 21:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
 <CAK7LNAQ87U202fgqkd5T9G82h4F6sNOMW2=vH1HmgAoVA48CMw@mail.gmail.com> <70071209bfa07b38df576c59341b935b9b95ae28.camel@sipsolutions.net>
In-Reply-To: <70071209bfa07b38df576c59341b935b9b95ae28.camel@sipsolutions.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Jun 2023 13:21:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyKdsvD6878RVL+fF0kLm_wcA4XU=5swc3DVY6=TPOTg@mail.gmail.com>
Message-ID: <CAK7LNATyKdsvD6878RVL+fF0kLm_wcA4XU=5swc3DVY6=TPOTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel-doc: don't let V=1 change outcome
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

On Mon, Jun 5, 2023 at 5:19=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Mon, 2023-06-05 at 09:36 +0900, Masahiro Yamada wrote:
>
> > > +if (defined($ENV{'KDOC_WRETURN'})) {
> > > +       $Wreturn =3D "$ENV{'KDOC_WRETURN'}";
> > > +}
> > > +
> > > +if (defined($ENV{'KDOC_WSHORT_DESC'})) {
> > > +       $Wshort_desc =3D "$ENV{'KDOC_WSHORT_DESC'}";
> > > +}
> > > +
> > > +if (defined($ENV{'KDOC_WCONTENTS_BEFORE_SECTION'})) {
> > > +       $Wcontents_before_sections =3D "$ENV{'KDOC_WCONTENTS_BEFORE_S=
ECTION'}";
> > > +}
> > > +
> > > +if (defined($ENV{'KDOC_WALL'})) {
> > > +       $Wreturn =3D "$ENV{'KDOC_WALL'}";
> > > +       $Wshort_desc =3D "$ENV{'KDOC_WALL'}";
> > > +       $Wcontents_before_sections =3D "$ENV{'KDOC_WALL'}";
> > > +}
> >
> >
> >
> > Adding an environment variable to each of them is tedious.
>
> Agree. And adding one for -Wall is especially tedious because you have
> to spell out the list of affected warnings in two places :)
>
> > If you enable -Wall via the command line option,
> > these lines are unneeded?
> >
> > For example,
> >
> > ifneq ($(KBUILD_EXTRA_WARN),)
> >   cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> >          $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) $<
> > endif
> >
>
> Yes, that should be possible.
>
> I feel like maybe we should still have individual settings for the three
> different classes, because you might want to have -Wshort-desc without
> the extra -Wcontents-before-sections (which I thought about removing
> entirely, kernel-doc seems to parse just fine that way, what's the point
> of it?)
>
> But we could even move the env var handling _completely_ to the Makefile
> if you don't mind, and then we don't have to have two places in the
> script that need to be aligned all the time.

Yes, probably that will be a good idea.



--=20
Best Regards
Masahiro Yamada
