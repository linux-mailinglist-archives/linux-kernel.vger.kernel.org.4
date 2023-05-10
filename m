Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF856FD8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjEJIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEJIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A281BC0;
        Wed, 10 May 2023 01:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A344A63B91;
        Wed, 10 May 2023 08:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297C9C433D2;
        Wed, 10 May 2023 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683705933;
        bh=zAtZ70naQXiiJhGVd2X1W6n4PKQ2vnqsXMKHc0aV1PA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GKKyKA42JDR90NrVwF45MXcGgM8C6GYVbd/ltDYA/rLLcBwYNSCbdLqKOuL4Qv314
         Yo6DDlidCG0a1SPvpzZsBcUehYoRPa3WieWEvZThD6u0fCFrwCfQS+fMuIecCE/uGv
         SfVwCx2PN2BEPQKl+WtrEp/EK8e+nXKHI/FoypIUxXVgMW6rTi1H3bLdZPwbsnDjMF
         h0N+iroiEEfh405dmPAS7IwJ+fXvlV7efHo6FqGBkOnM15XKW/uDjBGxt+cOX+FVft
         7aPEamaz4tLDKZqOKCD6AK0Wd5vPbpuTa3AtTwS5ehEcaUXbnZhujH7246TqNeIyzx
         PD+sQsUMMsjmg==
Date:   Wed, 10 May 2023 09:05:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
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
Message-ID: <20230510090527.25e26127@sal.lan>
In-Reply-To: <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
        <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
        <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Mon, 8 May 2023 09:27:28 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Mon, May 8, 2023 at 3:55=E2=80=AFAM Linux regression tracking #adding
> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Thanks for the report. The fixes (see the mail from Laurent) apparently
> > are still not mainlined (or am I missing something?), so let me add this
> > report to the tracking to ensure this is not forgotten: =20
>=20
> Gaah. I was intending to apply the patch directly before rc1, but then
> I forgot about this issue.
>=20
> Mauro: I'm currently really *really* fed up with the media tree. This
> exact same thing happened last merge window, where the media tree
> caused pointless build errors, and it took way too long to get the
> fixes the proper ways.
>=20
> If something doesn't even build, it should damn well be fixed ASAP.
>=20
> Last release it was imx290.c and PM support being disabled, and I had
> to apply the fix manually because it continued to not come in the
> proper way.
>=20
> See commit 7b50567bdcad ("media: i2c: imx290: fix conditional function
> defintions").
>=20
> But also see commit b928db940448 ("media: i2c: imx290: fix conditional
> function definitions"), which you *did* commit, but note this on that
> commit:
>=20
>     AuthorDate: Tue Feb 7 17:13
>     CommitDate: Sat Mar 18 08:44
>=20
> so it took you a MONTH AND A HALF to react to a build failure.
>=20
> And see this:
>=20
>     git name-rev b928db940448
>     b928db940448 tags/v6.4-rc1~161^2~458
>=20
> ie that build fix that you finally committed came in *AFTER* the 6.3
> release, even though the bug it fixes was introduced in the 6.3 merge
> window:
>=20
>     git name-rev 02852c01f654
>     02852c01f654 tags/v6.3-rc1~72^2~2^2~193
>=20
> and now we're in the *EXACT*SAME* situation, with me applying a build
> fix directly, because you couldn't get it fixed in a timely manner.

Sorry for the mess. I'll work to improve the process to avoid this
to happen again.

FYI, in order to reduce build issues, we have a Jenkins instance
doing builds with gcc and CLANG at the media stage tree, before we even mer=
ge
them at the main media development tree. They run with allyesconfig for
x86_64 arch, with W=3D1:

	https://builder.linuxtv.org/job/media_stage_clang/
	https://builder.linuxtv.org/job/media_stage_gcc/

And another CI job testing bisect breakages as I receive pull requests,
applying patch per patch and using both allyesconfig and allmodconfig,
also on x86_64 arch with W=3D1:

	https://builder.linuxtv.org/job/patchwork/

The rule is to not merge stuff on media tree if any of those jobs
fail. I also fast-forward merging patches whose subject states that
the build has failed.

In order to help with that, on normal situation, I usually take one week
to merge stuff from media_stage into media_tree, doing rebases at
media_stage if needed to avoid git bisect build breakages at media_tree
(which is from where I send my update PRs to you).

Unfortunately, currently we don't have resources to do multiple randconfig
on Jenkins, as the build machines on the server are very slow. Yet, I'll
add CONFIG_PM disabled to the test set, as it seems to be a recurrent source
of troubles those days. I'll also try to identify a couple of other=20
randconfigs that would help to catch earlier problems like that.
If some other problematic Kconfig variables comes to your mind, please
feel free to suggest them for us to add to the CI automation.

-

In the specific case of this fixup patch, I didn't identify it as a build
issue, so it followed the usual workflow. We have a huge number of patches
for media, and it usually takes some time to handle all of them. This one
just followed the normal flow, as it didn't break Jenkins builds nor the
subject mentioned anything about build breakage.

Regards,
Mauro
