Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597F702872
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbjEOJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjEOJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337861708;
        Mon, 15 May 2023 02:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C572161474;
        Mon, 15 May 2023 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB94AC433D2;
        Mon, 15 May 2023 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684142732;
        bh=I/JHQf4eIEsXKezsZsMd1fV+aRLmrENZDEW/GBeFnBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IkcvM/nf4fogAbzM9g7VY/ONJN+bLvbZW8FynVvvFGqsI2oH7QiTGAHjnb5eil/qh
         dobgamg0SCITkPm7wwLMoRmDqJQSOdcHdPgBjbrzotay8LF23muG+3uwHPve5beoP6
         00pd35Y0AvLPKt/AP5P0FQVMYkiWN4mDQyDvhSiZV5YboHWJmNIR08ABvYK1OMsOHY
         ZfYm1Ukq7iU6DRsmjg+gNVyj10kPpfQDoJlhdKLzL+zYFoCPPqRL7g5983Ym4k5HLh
         g6a1tOm5UVQiafQAf3g58jh1NZSnXiFF/N8Z+Ycu9OqMjpCvqN5DQJeFZLlVjVCbtS
         8jhSybGaVDI/Q==
Date:   Mon, 15 May 2023 10:25:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Message-ID: <20230515102525.65150633@sal.lan>
In-Reply-To: <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
        <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
        <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
        <20230510090527.25e26127@sal.lan>
        <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
        <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 15 May 2023 09:46:41 +0200
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

> Hi Krzysztof,
>=20
> On Sun, May 14, 2023 at 1:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> > On 10/05/2023 10:05, Mauro Carvalho Chehab wrote: =20
> > > And another CI job testing bisect breakages as I receive pull request=
s,
> > > applying patch per patch and using both allyesconfig and allmodconfig,
> > > also on x86_64 arch with W=3D1:
> > >
> > >       https://builder.linuxtv.org/job/patchwork/
> > >
> > > The rule is to not merge stuff on media tree if any of those jobs
> > > fail. I also fast-forward merging patches whose subject states that
> > > the build has failed.
> > >
> > > In order to help with that, on normal situation, I usually take one w=
eek
> > > to merge stuff from media_stage into media_tree, doing rebases at
> > > media_stage if needed to avoid git bisect build breakages at media_tr=
ee
> > > (which is from where I send my update PRs to you).
> > >
> > > Unfortunately, currently we don't have resources to do multiple randc=
onfig =20
> >
> > Is you media staging tree included in LKP (kernel test robot)? You would
> > get huge build coverage after every push to your staging repo. =20

No idea, as I don't know where LKP settings are stored, nor what frequency
it is doing builds from git://linuxtv.org/media_stage.git, if any. Do you k=
now
where we can check such configuration?

In the end, patches there will end going to linux-next, so at least some
sort of coverage is there, but I'm not sure if LKP will always reply to
linux-media if the patch causing build regressions is there.

While being helpful, one problem with LKP is that it is hard to filter out=
=20
reports per git tree. The only way to check if the report is applicable to
media trees seems to be looking inside the e-mail's body.

> As (multiple[*[) fixes for the build issues were submitted before the
> opening of the merge window, there must have been some build coverage,
> with even some people acting upon it...
>=20
> [*] General note, not limited to media: please apply build fixes and
>     regression fixes ASAP, to avoid multiple people running into the
>     same issues, and spending time on bisecting, investigating,
>     fixing, ...
>     Thanks a lot!

Fully agreed. That's why we opted to have a CI instance focused on media:
we should be able to program it to give feedback with the kernel build
parameters we use (Like W=3D1) and set it up in a way that it we can
customize to our needs (like testing for the architectures where media
drivers are known to be used in practice), and setting up an e-mail subject
that can be easily be filtered by our e-mail filters.

Regards,
Mauro
