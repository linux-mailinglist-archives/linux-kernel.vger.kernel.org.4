Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2151663370
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjAIVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjAIVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:46:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58005F1D;
        Mon,  9 Jan 2023 13:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ED71B81022;
        Mon,  9 Jan 2023 21:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6C5C433EF;
        Mon,  9 Jan 2023 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300815;
        bh=RB2pYujoEeM8ITyKqv1+mdeEBdTMo8SAHoKJZU0gc6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkPR8/FMDayhq87VlmDouJt0uPeYn67iJ1ufQXzow7a2T2Zda1EKmhFoThjhcwSZv
         rikF2Gxw9gaD6w+FAB0TvCfpX0y0hYCfpxgWJy7lA/Zf+GIL0Umc51Q25FAtxeUTju
         w9XmaeSfqU7hV6MkZRf6L4wt73BBit0rr5v3jMVMPCUN3QvzAceoESbhLrkdcLMITY
         5tiMypUl7aTD5TAfQQS1Jdb2p2xzudV5Y53wrVFA89tWOaoeyTRF4KuwShYbGd+9g1
         CSLxZC+ySB6RzEV0+P0YNI+SsztdiprpOwuRpo90FwtqGUcWmcwb8BtO06PwW+zXYD
         JflKeZZi/FcOg==
Date:   Mon, 9 Jan 2023 21:46:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: note that counter access is part
 of the uABI
Message-ID: <Y7yLS1ie8800TW6b@spud>
References: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
 <87359wpy9y.fsf@meer.lwn.net>
 <87y1rooje8.fsf@meer.lwn.net>
 <Y4srdBCmYJFx+ypW@spud>
 <CAOnJCU+DhxcPjgftMspWAzhsms_8sXnGS++vbp1iJDB0XcOxLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Of8Ve/q5NMcybKBF"
Content-Disposition: inline
In-Reply-To: <CAOnJCU+DhxcPjgftMspWAzhsms_8sXnGS++vbp1iJDB0XcOxLQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Of8Ve/q5NMcybKBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 01:36:19PM -0800, Atish Patra wrote:
> On Sat, Dec 3, 2022 at 2:57 AM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Sat, Dec 03, 2022 at 03:45:35AM -0700, Jonathan Corbet wrote:
> > > Jonathan Corbet <corbet@lwn.net> writes:
> > >
> > > > Palmer Dabbelt <palmer@dabbelt.com> writes:
> > > >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > >>
> > > >> I think I merged the last one of these, but if the doc folks pick =
it up
> > > >> that's fine with me.  Otherwise I'll take it when it comes back ar=
ound,
> > > >> so folks have time to take a look.
> > > >
> > > > "Doc folks" applied it, thanks. :)
> > >
> > > Actually, I take that back.  I'd missed this part from the patch:
> > >
> > > > Based on an, as yet, unsent v2 of my other uABI changes. I don't ex=
pect
> > > > it to be applicable, just getting a patch into patchwork while I do=
n't
> > > > forget about this.
> > >
> > > ...but b4 happily picked up a couple of *other* patches from this thr=
ead
> > > and applied them instead; I've now undone that.  Sorry for the noise.
> >
> > Huh, I accidentally put an "in-reply-to" header on this patch. I have
> > been updating some of my submission helper scripts & I must have left
> > the field populated from sending another set by accident:
> > https://lore.kernel.org/linux-riscv/20221129144742.2935581-1-conor.dool=
ey@microchip.com/
> >
>=20
> I don't see the patch upstream. Is this patch merged already ?

No it's not. I was going to resend it actually, but I noticed the thread
yesterday or something. Not sure why you CC'ed half the world on it but
not linux-riscv? Or me if you didn't want me resending it!

> If not, please hold on merging this for now. We had some discussions
> around this in the perf community.
> Here is the thread
> https://lore.kernel.org/lkml/Y7gN32eHJNyWBvVD@FVFF77S0Q05N/T/
>=20
> TLDR; Even though x86 allows unrestricted access through rdpmc (not
> default), it still reads zero unless a privileged root user modifies
> the MSR interface exposed by the kernel.
>=20
> Quoting PeterZ
>=20
> "RDPMC is only useful if you read counters you own on yourself -- IOW
> selfmonitoring, using the interface outlined in uapi/linux/perf_events.h
> near struct perf_event_mmap_page.
>=20
> Any other usage -- you get to keep the pieces."
>=20
> "Anyway, given RISC-V being a very young platform, I would try really
> *really* *REALLY* hard to stomp on these applications and get them to
> change in order to reclaim the PMU usage."
>=20
> We need to decide what's the best approach for RISC-V. The current
> text in uABI will let users assume that
> cycle/instret can be read without any issues which is wrong.
>=20
> There are few options what we can do for RISC-V:
>=20
> 1. We can trap n emulate and report 0 always as suggested by Mark in
> that thread.
> 2. Continue to allow the user to read the counters directly but
> expects the garbage value depending on the other activities
> on the system. Hopefully, folks will fix their application by that time.
>=20
> Once we have the procfs interface, we enforce the behavior by breaking
> the application.
>=20
> In either case, the uABI needs to be updated accordingly.

I don't disagree with what I saw either PeterZ or Mark say. I'm happy
not to resend this, I've got no skin in the game other than not wanting
something like that "documented" only in the driver.

What do you intend doing to instigate the "stomping"?

Thanks,
Conor.


--Of8Ve/q5NMcybKBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7yLSwAKCRB4tDGHoIJi
0nT8AQDrYwKB9zV6+effQvOKu8ROX2RJEKzzr3Hg1ViZ5VcMBAEAor9F8ZBaFQr7
MsupbPHpuGARjonG4i9z+Zu7pVHUcwI=
=GGhW
-----END PGP SIGNATURE-----

--Of8Ve/q5NMcybKBF--
