Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77A6FEBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjEKGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjEKGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C64C13;
        Wed, 10 May 2023 23:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71B763F35;
        Thu, 11 May 2023 06:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39502C433D2;
        Thu, 11 May 2023 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683787573;
        bh=IVpbV+z9YGskfzW19j0+bVKEYWgiU3nQ/4t5bI4Ex9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JN4WBZ9UViPjCxYnQfYCefKlJ1XQX1q9CxTPb2vznnv2P2LSHUsvJ9et0CD6Yb6uJ
         pXVEEIvSv8+cG5Xkz2kKMI1pG4chJn9D+WpBcPLSpm9zE1+NJU+RxOrjNnVI3d3+9X
         XBIm0wNq5tY5FpwsAfyg3cb3KoBHzk+VwmEMvh//gP7kJHps8jF0oO/KfHa9uQvFKZ
         t8U3faC4xVOVX+AXCs3jkxudLRLYG2VvHvLtJgEq1SWMbOq41Amr/ywFlfnm8OebEc
         wYa0ym67nUKgcc1p7V7Ikd0QGAy1GXdmJ9x1b32G2QLMT1nZDXes53rEQifvcC4jS3
         k+fVVzWcfsOjw==
Date:   Thu, 11 May 2023 07:46:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20230511074606.0349fc69@sal.lan>
In-Reply-To: <742856c0-ab93-1a6c-4fc8-9451c0908930@leemhuis.info>
References: <ZElaVmxDsOkZj2DK@debian>
        <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
        <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
        <20230510090527.25e26127@sal.lan>
        <742856c0-ab93-1a6c-4fc8-9451c0908930@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Em Wed, 10 May 2023 11:02:57 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 escreveu:

> On 10.05.23 10:05, Mauro Carvalho Chehab wrote:
> > Em Mon, 8 May 2023 09:27:28 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> escreveu: =20
> >> On Mon, May 8, 2023 at 3:55=E2=80=AFAM Linux regression tracking #addi=
ng
> >> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote: =20
> >>>
> >>> Thanks for the report. The fixes (see the mail from Laurent) apparent=
ly
> >>> are still not mainlined (or am I missing something?), so let me add t=
his
> >>> report to the tracking to ensure this is not forgotten:   =20
> >>
> >> Gaah. I was intending to apply the patch directly before rc1, but then
> >> I forgot about this issue.
> >>
> >> Mauro: I'm currently really *really* fed up with the media tree. This
> >> exact same thing happened last merge window, where the media tree
> >> caused pointless build errors, and it took way too long to get the
> >> fixes the proper ways. =20
> > [...]
> >
> > In the specific case of this fixup patch, I didn't identify it as a bui=
ld
> > issue, so it followed the usual workflow. We have a huge number of patc=
hes
> > for media, and it usually takes some time to handle all of them. This o=
ne
> > just followed the normal flow, as it didn't break Jenkins builds nor the
> > subject mentioned anything about build breakage. =20
>=20
> Makes me wonder again if we should start adding
>=20
>  CC: regressions@lists.linux.dev
>=20
> to any patches that fix regressions, that way maintainers and reviewers
> would have something to filter for -- and I would become aware of all
> regression fixes in the work, too.

Having some way that could be parsed by e-mail filters would be
nice.=20

>=20
> Ciao, Thorsten
>=20
> P.S.: BTW, let me tell regzbot that Linus merged the fix for the build
> failure.
>=20
> #regzbot fix: ba0ad6ed89f
>=20
> FWIW, the one for the gcc warnings[1] Laurent mentioned elsewhere in
> this thread is not merged yet afaics.
>=20
> [1] https://lore.kernel.org/all/20230418092007.2902984-1-arnd@kernel.org/

Just sent a pull request.

Btw, I did some changes at linux-media Jenkins instance to help early
track some extra build issues. They're all against
https://git.linuxtv.org/media_stage.git/, which is the tree where we place
media patches that are ready. We move them later, after a couple of days
to https://git.linuxtv.org/media_tree.git/. So, if something bad happens,
we have a chance to fix before setting them into a stone. With such
changes, we now have:

1. https://builder.linuxtv.org/job/patchwork/

   This is a pre-merge test. It tests patch per patch the PRs with patch
   sets ready to be merged, with W=3D1, allyesconfig/almodconfig[1] on x86_=
64.=20
   Builds drivers/media and drivers/staging/media.=20
   This is there already for a long time;

2. https://builder.linuxtv.org/job/media_stage_clang/

   Checks build with clang-12 on x86_64 with W=3D1. Builds drivers/media
   and drivers/staging/media with allyesconfig[1].

   It was building with WERROR disabled, as some core macros were
   producing errors at the time I created it (and for a while).
   It was modified to enable WERROR as well.=20

3. https://builder.linuxtv.org/job/media_stage_gcc-pipeline/=20

   It replaces another job that was just doing builds for x86_64
   with W=3D1. Builds drivers/media and drivers/staging/media with
   different configurations[1]:
      x86_64: allyesconfig, allmodconfig, almodconfig with PM disabled;
      arm32: allyesconfig
      arm64: allyesconfig

4. https://builder.linuxtv.org/job/linux-media/

   Does full builds with different configurations[1]:
      x86_64: allyesconfig, allmodconfig, almodconfig with PM disabled;
      arm32: allyesconfig
      arm64: allyesconfig
      docs: htmldocs and pdfdocs

I hope this will help avoiding future build regressions from our side.
Feel free to suggest a couple of other configs that we might add to
jobs (3) and (4).

I'm still adjusting the pipeline for (4), but currently, it is failing
on an issue that seems unrelated with the media subsystem with gcc 10.2.1:

	  AR      drivers/built-in.a
	  AR      built-in.a
	  AR      vmlinux.a
	  LD      vmlinux.o
	vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x2d8: call to vmread_err=
or_trampoline() leaves .noinstr.text section
	vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xe1: relocation to !ENDBR: =
native_write_cr4+0x40
     =20
Is this a known regression? The media-stage tree is on the top of
Kernel 6.4-rc1.

Regards,
Mauro

-

[1] On all builds, the jobs disable some symbols that should not affect
    media subsystem, to speedup the builds:

   scripts/config -d MODULE_SIG -d KEYS -d IMA -d CONFIG_DEBUG_INFO -d SYST=
EM_TRUSTED_KEYRING -d MODVERSIONS
