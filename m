Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD16F25F1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjD2TMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2TL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173510C1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1345960ACE
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EEFC433EF;
        Sat, 29 Apr 2023 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682795517;
        bh=RvfSv2vXhrQXd/FezE4UM1R+ph+dMkTIsCqUvf6TQ98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFtiN7tyRAJL1OqdrOMeX7uU3dLn0XbUColcbDm2uLnMYAa1bI5mBpQGC1I9fDcti
         MJqCKepChG+Su0LzxvKj3H2+SIZ0cV2YEXNrDoxG+K3XsLoRoBhjLG0UURF0jxPbiT
         1BkvAcqnJ5X7zqdpcRQDWtguJVHB0/vXpGgnbcWKbBOt1bA0mqYjxEDZbf5lp2TFbF
         UD2Wf80q/eWOshi2jcd6KDMK1CbLALFWxpXmEwgdUS9Hv91zoH1c66ZpaJAdrhw6WA
         pR0NEGqsJkNQP2c6zRxsDCz6e2tmIcDmKb/fFeoxMzhoj6d8jQSR10J+6VBr2Rvt/6
         cDoNlrLdKjpFA==
Date:   Sat, 29 Apr 2023 20:11:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in
 errata
Message-ID: <20230429-dandy-gush-6f5da93055bc@spud>
References: <20230429155247.12131-1-rdunlap@infradead.org>
 <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud>
 <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
 <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org>
 <CALs-Hss3b86zAqohK9NYEkzn+pnLeMB37qaj1EA6f6bRkFWwCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qFdXsuwzHEGiYpiV"
Content-Disposition: inline
In-Reply-To: <CALs-Hss3b86zAqohK9NYEkzn+pnLeMB37qaj1EA6f6bRkFWwCg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qFdXsuwzHEGiYpiV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 12:06:19PM -0700, Evan Green wrote:
> On Sat, Apr 29, 2023 at 10:58=E2=80=AFAM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >
> >
> >
> > On 4/29/23 10:48, Evan Green wrote:
> > > On Sat, Apr 29, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > >>
> > >> On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
> > >>> On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@infra=
dead.org> wrote:
> > >>>>
> > >>>> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but =
when
> > >>>> CONFIG_MODULES is not set, __init_or_module becomes __init.
> > >>>> In the latter case, it causes section mismatch warnings:
> > >>>>
> > >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_=
fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .i=
nit.text)
> > >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_=
fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .in=
it.text)
> > >>>>
> > >>>> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vend=
or_features()")
> > >>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > >>>> Cc: Heiko Stuebner <heiko@sntech.de>
> > >>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > >>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > >>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
> > >>>> Cc: linux-riscv@lists.infradead.org
> > >>>> Cc: Conor Dooley <conor@kernel.org>
> > >>>> Cc: Evan Green <evan@rivosinc.com>
> > >>>> ---
> > >>>
> > >>> Thanks, Randy. I'm confused at how I didn't see that when I made the
> > >>> original fix. I feel like repro of these section mismatch errors
> > >>> depend on some other factor I'm not understanding. In any case:
> > >>
> > >> Perhaps you had a cut-down config that did not enable either of the
> > >> relevant ARCH_ options to get those errata compiled?
> > >
> > > It was weird, my original "fix" (the one listed in this Fixes tag) was
> > > needed because while the hwprobe series was clean on Palmer's branch,
> > > it generated a "section mismatch" on linux-next. As noted here, it was
> > > only with !CONFIG_MODULES, so I explicitly remember generating that
> > > config and checking it on linux-next to generate this "fix", and it
> > > came out clean. It's like the robots are getting smarter.
> > > -Evan
> >
> > I observed the problem in 8 out of 20 randconfig builds,
> > using linux-next 20230427.
>=20
> Oh interesting, so not the stock k210_nommu defconfig. That makes me
> feel a little better at least.

Ohh man, that's a pretty bad config to try use (if that's your default)
for build testing stuff. The k210_mmu defconfig doesn't enable anything
other than SOC_CANAAN.
I could reproduce Randy's issue on defconfig w/ CONFIG_MODULES disabled.

--qFdXsuwzHEGiYpiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE1r+QAKCRB4tDGHoIJi
0lMAAP9Yzh1VwUUltw6hlBNuhfRgwEhTKtB7BRE3pAN2cJsS3gEAw/ruaaFT0dyk
VjeOLC2Kb/tzs4sxNU8jzEiNHondEA4=
=XMXc
-----END PGP SIGNATURE-----

--qFdXsuwzHEGiYpiV--
