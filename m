Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90965C6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbjACTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbjACTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:10:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E113F1D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB3D961499
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEFC433D2;
        Tue,  3 Jan 2023 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672773037;
        bh=etxDQ0Uv7EXayM8Xh0GJOsPu0SY3JxhWPjiRbQ4Bd04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQJlDysa31xrUr8R1W1e/UBgISCRKeQTCwDCfB1kXiELl8IxrdXdC8AknOtuvc6vR
         nWJQPkAXoFm1vBH+UeCUYpic82t9lvlUtH97cIzhDg7Bt/zPz9XS9xqePgTRVLmTHL
         YaYF8xWYosg4ln796nVC5be/SI5QbgI0mWu/B5cnsnPTlxiBffXTsZU5CVsmHcNBNC
         Aizf8vC58dACwXInqpnXu9JU7UGVrSqKJpL5tuXRcuEMtMHeCGbYyTawiZGAeYFtOH
         6v+xAw4Dc8Xrfrizxzd+6ULtxqMiSFkACkrTSGaHj7LWnvR464ECYBbvfAROdB1fop
         O8mrq/cgBIgig==
Date:   Tue, 3 Jan 2023 19:10:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, uwu@icenowy.me
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] riscv: errata: prefix T-Head mnemonics with
 th.
Message-ID: <Y7R9qB6fNTwCvqek@spud>
References: <20230103062610.69704-1-uwu@icenowy.me>
 <20230103062610.69704-2-uwu@icenowy.me>
 <5641668.DvuYhMxLoT@diego>
 <Y7QBCeqh96rKmZvf@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LVa78PCruCP8gqTJ"
Content-Disposition: inline
In-Reply-To: <Y7QBCeqh96rKmZvf@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LVa78PCruCP8gqTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 10:18:49AM +0000, Conor Dooley wrote:
> > T-Head now maintains some specification for their extended instructions
> > at [1], in which all instructions are prefixed "th.".
> >=20
> > Follow this practice in the kernel comments.
> >=20
> > [1] https://github.com/T-head-Semi/thead-extension-spec
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>=20
> Hey Icenowy,
> This (yet again) appears to not have made it to the list.
> It's not on patchwork, nor lore:
> https://lore.kernel.org/linux-riscv/2668919.mvXUDI8C0e@diego/T/#t
> https://lore.kernel.org/all/2668919.mvXUDI8C0e@diego/T/#t
>=20
> Since you CCed lkml & not just linux-riscv, but it is not showing idk
> what's wrong..
> Your reply to me the other day came through:
> https://lore.kernel.org/all/dda144a8397a175f3ce092485f08896c9a66d232.came=
l@icenowy.me/

This (and the previous iteration) finally came through to the list.
I guess the pusher-of-buttons for "suspicious" mail or w/e is back to
work after Christmas. It's in patchwork now:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D708586

Thanks,
Conor.


--LVa78PCruCP8gqTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7R9qAAKCRB4tDGHoIJi
0rogAP9LW4bvmXOCZvT0p+1r1xnkdcr6g+wA3yApv4c0EO2mBgD7BrHC7EPJUL4q
5msTX6EyE+Rs4XPyefrmRjn7cdkmeQk=
=zoqn
-----END PGP SIGNATURE-----

--LVa78PCruCP8gqTJ--
