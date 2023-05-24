Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644E710122
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjEXWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEXWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C790;
        Wed, 24 May 2023 15:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FCC637C6;
        Wed, 24 May 2023 22:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F20C433D2;
        Wed, 24 May 2023 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684968585;
        bh=GVSpmgDJgKvtnAYJ89QgN844pnETkbbglcC/+ts5s7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYc36qtVDq8cKr5n/fDlSZeY8kAuJ4wIpgJ1hDdKF3Rm44LlF0AKfrYuUVdJRqUyv
         +7ByDmoIwoJh5WhieEAM6odTnCMOGmFmDR/ifYr8voksEKgq3LjEMCg2t+XXg93H13
         TIrY2+59udREprIfv+C62vJlIOblMaxQqsA3DEePbbkqY5MI63MkWgG0GPXsxw6i8c
         NIyiq99BeA/5fsOi9qxAyu0ciR/TGH8CdOilkxdGsIcWZi3rAVf2iT1yvorOw/wSme
         j3e2owtgwiDUy4dcIVnVeg7OqEFFkzhj9LvJR7Rn4O6kud6KoaMolaioyCE3+ZtiV0
         yhMyqo3Iu5wUQ==
Date:   Wed, 24 May 2023 23:49:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Message-ID: <20230524-scalping-number-63ec10c1f7bf@spud>
References: <mhng-e172207d-d67d-46ab-ab95-85f0a854ace2@palmer-ri-x1c9a>
 <65124759-26de-4111-bc54-545a00620d75@app.fastmail.com>
 <8af1acf1-64a5-5868-9702-0929fe279761@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vifRCZgSv5ueTTCK"
Content-Disposition: inline
In-Reply-To: <8af1acf1-64a5-5868-9702-0929fe279761@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vifRCZgSv5ueTTCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 03:41:15PM -0700, Randy Dunlap wrote:
> On 5/23/23 23:23, Arnd Bergmann wrote:
> > On Wed, May 24, 2023, at 03:29, Palmer Dabbelt wrote:
> >> On Tue, 23 May 2023 17:22:20 PDT (-0700), rdunlap@infradead.org wrote:
> >>> On 5/23/23 06:07, Alexandre Ghiti wrote:
> >>>> On 23/05/2023 04:28, Randy Dunlap wrote:
> >>>>> On 5/19/23 03:42, Alexandre Ghiti wrote:
> >>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux=
-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section=
 .text LMA [00000000000f09d4,00000000033562ab]
> >>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux=
-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps=
 section .data LMA [000000000041a000,00000000075bffd7]
> >>>>>>>
> >>>>>>> I'll check this one too which seems to be related to kernel/pi in=
troduction.
> >>>>>>
> >>>>>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to h=
ave limited size, hence the overlap, so no fix for this one. Is there a way=
 to exclude this config from randconfig?
> >>>>> Does this mean exclude XIP_KERNEL or something else from randconfig=
s?
> >>>>
> >>>>
> >>>> I meant excluding XIP_KERNEL from randconfigs: it has very strict co=
nstraints regarding what can/can't be enabled then it needs human intervent=
ion to make sure the error above does not happen. So I would not bother tes=
ting this in randconfigs if possible.
> >>>
> >>> I can exclude it from my randconfig builds, but I don't know of a way=
 to exclude it from randconfig builds in general (i.e., for everyone).
> >>
> >> Arnd had suggested a trick related to menus that would result in=20
> >> randconfig never enabling some config.  It'd suggested for=20
> >> CONFIG_NONPORTABLE, but we didn't use it because it'd reduce randconfi=
g=20
> >> coverage.
> >>
> >> Maybe we should add a CONFIG_VERYSPECIAL of some sort and hide things=
=20
> >> like XIP behind it (maybe M-mode too)?
> >=20
> > I usually add 'depends on !COMPILE_TEST', that excludes it from most
> > build bots.
>=20
> XIP_KERNEL already has "depends on !COMPILE_TEST", since April of 2021.

Half of me wants to say just remove XIP_KERNEL entirely. Or make it
depend on BROKEN, since noone seems to actually test it and I don't
think we even know if it works right now?

--vifRCZgSv5ueTTCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG6UhQAKCRB4tDGHoIJi
0gQCAQDJF5AaPKZcpLOA853nW9fm061vxB5oKFNYpcO+ZBM5ogEA0VCjHShKVo6P
t1yS9OcbEhAlJC3/btQ7ILZI557nWA4=
=wzlZ
-----END PGP SIGNATURE-----

--vifRCZgSv5ueTTCK--
