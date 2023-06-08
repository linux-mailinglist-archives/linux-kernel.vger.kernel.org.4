Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985AC727AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjFHJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjFHJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9AD1FD5;
        Thu,  8 Jun 2023 02:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5225F64B38;
        Thu,  8 Jun 2023 09:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B679DC433AE;
        Thu,  8 Jun 2023 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686215235;
        bh=l/8KvFSOBQsR6ZHV2arMwICZ6p03RvG8WFq8ELQf46U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qxtv0aVaQKZi51iaODGYZ7samno6tayUwaiFH50zeHym1UnWgUzk6JBnvhG4bQyCe
         dyyuF1OgXEBA0XYxvh3zWsIJs/B/4Xb0BJKgJ0qjPH7cl4l4vg3eyclTrPjEiZU/MQ
         qbCyTWurdzN9GXjwgqik/9D/Cz+vzb3tERn4aIsJ3MH5IDj/xyMRutM+gXLQSAvf8N
         8b6nAmGFxD72kmmbjEIXeNCuUj1JEWji+b/VnIXoqwzI7btq/Uo/BnvS2GGc12lPTg
         JhkyuV80yau5wzfWXtGWra25UCVQm5UA1yI/JPsUlBsbzII9CFyke7YxD6sA4yhqkL
         tXx6SxQbBcAXw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so481452e87.2;
        Thu, 08 Jun 2023 02:07:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDwI4ew0iErcJbKMu2oZBAA7uDdSPUIc4djRo4j15icxpULp/kjN
        4tcnSDas4+HSpZBk7hmceznPjalO30kYzqr4pGI=
X-Google-Smtp-Source: ACHHUZ5uIi5oreT9ywSsjd0EtMrF5c1Z6mThS+v2QcCYByRA8rx6zm2ivG6BXSaIq68sVekHTCgaHL6WqjncyAFxM08=
X-Received: by 2002:a2e:8195:0:b0:2af:a696:3691 with SMTP id
 e21-20020a2e8195000000b002afa6963691mr3361814ljg.40.1686215233589; Thu, 08
 Jun 2023 02:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053940.39078-10-bagasdotme@gmail.com> <20230607053940.39078-11-bagasdotme@gmail.com>
 <CAC1cPGxD6xOLksyMHCcreFyEv5Yoo50LY=xM9BmOEP=oECoNww@mail.gmail.com>
 <CAMj1kXGnzphm5Wyz7RfZdWVxPnEihR0NGy5mFs4neQM+7EfEGQ@mail.gmail.com> <2023060850-shakable-dynamite-c4ff@gregkh>
In-Reply-To: <2023060850-shakable-dynamite-c4ff@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 11:07:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4eXrVcXxEpGnjRcg5KDBiEzbA_9XS0mBX_FdMPyHa1w@mail.gmail.com>
Message-ID: <CAMj1kXF4eXrVcXxEpGnjRcg5KDBiEzbA_9XS0mBX_FdMPyHa1w@mail.gmail.com>
Subject: Re: [PATCH 1/8] crypto: Convert dual BSD 3-Clause/GPL 2.0 boilerplate
 to SPDX identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Alexander Kjeldaas <astor@fast.no>,
        Herbert Valerio Riedel <hvr@hvrlab.org>,
        Kyle McMartin <kyle@debian.org>,
        "Adam J . Richter" <adam@yggdrasil.com>,
        Dr Brian Gladman <brg@gladman.me.uk>,
        Stephan Mueller <smueller@chronox.de>
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

On Thu, 8 Jun 2023 at 11:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 08, 2023 at 10:37:33AM +0200, Ard Biesheuvel wrote:
> > On Wed, 7 Jun 2023 at 16:38, Richard Fontana <rfontana@redhat.com> wrot=
e:
> > >
> > > On Wed, Jun 7, 2023 at 1:42=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmai=
l.com> wrote:
> > > >
> > > > Replace license boilerplate for dual BSD-3-Clause/GPL 2.0 (only or
> > > > later) with corresponding SPDX license identifier.
> > >
> > > This is at least the fourth or fifth time (I'm losing track) where yo=
u
> > > have incorrectly assumed a particular non-GPL license text matches a
> > > particular SPDX identifier without (apparently) checking.
> > >
> >
> > What exactly does 'checking' entail here? There is no guidance in
> > Documentation/process/license-rules.rst on how to perform this
> > comparison.
> >
> > Also, checkpatch now complains about missing SPDX identifiers, which
> > is what triggered this effort. Should it stop doing that?
> >
> > > Bagas, I urge that you learn more about the nature of SPDX identifier=
s
> > > before submitting any further patches at least involving replacement
> > > of non-GPL notices with SPDX identifiers. For this unprecedented
> > > license notice replacement initiative to have any legitimacy it must
> > > attempt to apply SPDX identifiers correctly.
> > >
> >
> > Since we're in language pedantic mode: it must do more than attempt,
> > it must apply them correctly, period.
> >
> > Arguably, this is an 'attempt to apply SPDX identifiers correctly' on
> > Bagas's part, which apparently falls short (and I may be guilty of the
> > same for some arch crypto code)
> >
> > So what is the ambition here: do we just leave the ambiguous ones as-is=
?
>
> I recommend yes, leave them as-is until the legal people who actually
> care about having SPDX lines in all of the files take the time to do the
> work to resolve these issues.
>
> Remember, they are the ones asking for it, no need for us to do their
> work for them :)
>

Good point.
