Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DA6EB23E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjDUTZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD02D67;
        Fri, 21 Apr 2023 12:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4B461877;
        Fri, 21 Apr 2023 19:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98362C433EF;
        Fri, 21 Apr 2023 19:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682105103;
        bh=W7uWtRhn74gI5DdykMl9Ygbat47KEyixL2s+R7CXf4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1uQO+lQn46h8sPkUIDTeuuuaqYEuXAC5XrVOBAwjT+6B4j8NizF8+Bhcmg/SbXDx
         R35KPmFskBNMwE2hWOlTsNitogRtztEI5E/BMcoea1Ygr0ah4ez9K+IKV/JXLH8xg+
         2hSscDX7Y8/QQfQ0dNAJrbGWNpjH3G26G1l8YL3wv2N927leM1laIByU2Nknx0W5Lh
         9qUiz7pT6ig8062P2j0qb4E+8nVCmlLsP5ZWFcalVG/T7mul1u92MUMzR6U/UeaO7S
         IR77iLd+n3LXOoNWDfycqXuLnHTaBxVfi9wkSaVNIx9yoRUXcGRCx1vUEBj83/9xev
         DJZslEGbLEeSw==
Date:   Fri, 21 Apr 2023 20:24:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konstantin Ryabitsev <konstantin.ryabitsev@linux.dev>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, alexghiti@rivosinc.com,
        aou@eecs.berkeley.edu, linux-kbuild@vger.kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        bjorn@kernel.org, npiggin@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 0/6] Introduce 64b relocatable kernel
Message-ID: <20230421-uneaten-obvious-250d95c86560@spud>
References: <mhng-bb70f74f-2b5b-4880-b7bf-975e67dc554e@palmer-ri-x1c9>
 <ba235aa677a561ceb2dc776414403dc0@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cYLCWmWMPROB1qtr"
Content-Disposition: inline
In-Reply-To: <ba235aa677a561ceb2dc776414403dc0@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYLCWmWMPROB1qtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 07:10:14PM +0000, Konstantin Ryabitsev wrote:
> April 21, 2023 2:59 PM, "Palmer Dabbelt" <palmer@dabbelt.com> wrote:
> >> riscv: Use PUD/P4D/PGD pages for the linear mapping
> >> (https://patchwork.kernel.org/project/linux-riscv/list/?series=3D73360=
3)
> >> base-commit-tag: v6.3-rc1
> >=20
> > The QEMU CI has some way to say "this depends on an un-merged patch set=
 sent as $MESSAGE_ID", not
> > sure if that's a b4-ism but it's a bit less confusing.
>=20
> I think it's patchwork-ism, actually. B4 will eventually learn to be
> able to include dependent series info and automatically retrieve/apply
> them in the proper order on "shazam", but it can't do that yet.

A patchwork-ism or a patchew-ism? Drew Jones was my source for this, but
he had said the thing to do in QEMU-land was put a:
Based-on: $message-id
in your cover letter for each thing that you depend on. I'm not entirely
sure if that meant each series or each patch. I think patchew picks that
up and dumps in it on a patchew github account that the CI might pick up
on. From the QEMU docs:
<quote>
It is also okay to base patches on top of other on-going work that is
not yet part of the git master branch. To aid continuous integration
tools, such as `patchew <http://patchew.org/QEMU/>`__, you should `add a
tag <https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01288.html>`__
line ``Based-on: $MESSAGE_ID`` to your cover letter to make the series
dependency obvious.
<\quote>

FWIW, my vote is for something with a message-id, rather than those
patchwork series links that you can't dump into b4!

--cYLCWmWMPROB1qtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZELjCgAKCRB4tDGHoIJi
0s1yAP9XTAhQrJD/xmNk2JTUsPIU6e0uJxU1rNaDElF8T2ioggD/RuvGZYpDeAT8
rVM1QBn5DNrHVZWw5EILFxMXOgo1hA4=
=0mnA
-----END PGP SIGNATURE-----

--cYLCWmWMPROB1qtr--
