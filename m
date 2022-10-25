Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2F60C52B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJYHbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJYHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:31:18 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F027CEE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:31:15 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 56A3C1C0016; Tue, 25 Oct 2022 09:31:13 +0200 (CEST)
Date:   Tue, 25 Oct 2022 09:31:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tty: n_gsm: revert tx_mutex usage
Message-ID: <20221025073112.GA1587@duo.ucw.cz>
References: <3572970f-f40f-5410-651a-a5e019d328d8@ispras.ru>
 <20221008110221.13645-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20221008110221.13645-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As far as switching to tx_mutex turns out to have its own problems,
> we suggest to revert it and to find another solution for the original
> issue described in 902e02ea9385 ("tty: n_gsm: avoid call of sleeping
> functions from atomic context").

We have lived with locking problems for a long time, and we really
don't want data corruption.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1eQwAAKCRAw5/Bqldv6
8nB0AJ9DaAxHYyT3R+w8Mzbayd0rp+dI7wCguS1jTN3LNAweNA0qFGXNw9sldW8=
=q1lp
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
