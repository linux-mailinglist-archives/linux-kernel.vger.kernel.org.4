Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95865BDD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjACKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjACKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0599F49
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CBF1B80E63
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA7CC433EF;
        Tue,  3 Jan 2023 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741134;
        bh=HSkVcDE93TTwdgQxX+NA/uwZL5WLjZtqGQP1f8SU5p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agDOiY9giFZqyqoG3aX1QNO2DsCG6ek4ASaFfVcZKSsPpBPaioUkl+2uUMGUC15L/
         4IHlfN8H0PS2uvrpzIBZfK6QApOSQPNvGVPxXUE7TbvTW2PzcRmBmK6+NsUGBzePXI
         htwc/2oRapfGIZv0ZSnT//3WVwCLjEj+FwbgARQsYhWYVexmank2TaBYKThcBQ0m2a
         goB5v27HnyHmT6/rleh344S3IwvZnJ4FtwAu05i+iZk/zWRUN3ucJKj++LeG66qhtY
         jsegLAStQZI4KzVYDdp8HjiXxy6JOC7hgEJ5nDfy0HqTEJK3ILq6N0nLognr1QC5WS
         bBNETEftCZ+3A==
Date:   Tue, 3 Jan 2023 10:18:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, uwu@icenowy.me
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] riscv: errata: prefix T-Head mnemonics with
 th.
Message-ID: <Y7QBCeqh96rKmZvf@spud>
References: <20230103062610.69704-1-uwu@icenowy.me>
 <20230103062610.69704-2-uwu@icenowy.me>
 <5641668.DvuYhMxLoT@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hAPl3w13QUb7Di8T"
Content-Disposition: inline
In-Reply-To: <5641668.DvuYhMxLoT@diego>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hAPl3w13QUb7Di8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> T-Head now maintains some specification for their extended instructions
> at [1], in which all instructions are prefixed "th.".
>=20
> Follow this practice in the kernel comments.
>=20
> [1] https://github.com/T-head-Semi/thead-extension-spec
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Hey Icenowy,
This (yet again) appears to not have made it to the list.
It's not on patchwork, nor lore:
https://lore.kernel.org/linux-riscv/2668919.mvXUDI8C0e@diego/T/#t
https://lore.kernel.org/all/2668919.mvXUDI8C0e@diego/T/#t

Since you CCed lkml & not just linux-riscv, but it is not showing idk
what's wrong..
Your reply to me the other day came through:
https://lore.kernel.org/all/dda144a8397a175f3ce092485f08896c9a66d232.camel@=
icenowy.me/

Thanks,
Conor.


--hAPl3w13QUb7Di8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7QBCQAKCRB4tDGHoIJi
0tAGAPsFQ8k9MUuX4iWMfvfLGnFocl2dh5/008Fu0QoDJl3+aAD9G/mDs4wbC+hu
PcisOihXXbQQPYBicsUO15UAgnF7Tgo=
=Q0QQ
-----END PGP SIGNATURE-----

--hAPl3w13QUb7Di8T--
