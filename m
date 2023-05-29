Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E4714B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjE2N5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjE2N5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:57:15 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00D54193;
        Mon, 29 May 2023 06:56:46 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id ADD1410861D;
        Mon, 29 May 2023 15:55:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n4Z--l1KX59Q; Mon, 29 May 2023 15:54:50 +0200 (CEST)
Received: from localhost (ns3093303.ip-145-239-244.eu [145.239.244.120])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 39FE610861C;
        Mon, 29 May 2023 15:54:50 +0200 (CEST)
Date:   Mon, 29 May 2023 15:54:36 +0200
From:   simon.guinot@sequanux.org
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     xingtong_wu@163.com, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHSunJyh2AU1eb0H@localhost>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydUJH2p/CGhrI1Ua"
Content-Disposition: inline
In-Reply-To: <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydUJH2p/CGhrI1Ua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org> wrote:
>=20
> > It would be nice if a pin number found in the device datasheet could
> > still be converted into a Linux GPIO number by adding the base of the
> > first bank.
>=20
> We actively discourage this kind of mapping because of reasons stated
> in drivers/gpio/TODO: we want dynamic number allocation to be the
> norm.

Hi Linus,

Sure but it would be nice to have a dynamic base applied to a controller
(and not to each chip of this controller), and to respect the interval
between the chips (as stated in the controllers datasheets).

This way the assignation would be dynamic and the pin numbers found in
controller datasheet would be meaningful as well.

Simon

--ydUJH2p/CGhrI1Ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmR0rpkACgkQzyg/RDPm
szrjBBAAtzabocRJDXcpxtRjNgPwWSADLDqJKTqz7LeMyON4qw0A7PuE7KQ9dqsH
rB/+HbJ90TIJWDKl8dcoVoNJnIy3j7XtnE4XzG7/AqZH+Yik1c0ZV7XWlIYZldN/
LLphcGqcxZUPy9aR8CNflEd83EcJ5rCROnjDPLxEToAydk6ApD/erjQ00pc9emun
fgavVZktLcIMeHeKZmW8nEUHrJXI3KtTUTZV4mzECCB1PurlcWdaPARksOqQaiBv
LoIcFahBmXwUN3Lq8Hk5LewLaLGnSKR2R1jU/ga7Xrw+NFN8mk4UIvLJ8ejzIpTE
jkieRlLvDFZvEIWpzA9X32XsMoMxqNxkam/Zm9bghPTpSVJXoyTHFHt/jMWGdDZR
BPguRFB8MMLqk4LjMF5Jyhh27Ty1VuSEtXWQWMJL/o/FIECmG/ORyyhDS5g4jJEc
0j43KmwQUcn7MKb9UKNClI9Qu91MUj4w/TYFinGjyAwZ98ovoDDpaL0bmrLM2/Wx
AZZq8AluJN/3aQmRsClP3Xwbnh33SBfA8jy77KV3PNqB7lpMdcuacCFKczk9K/aS
7You6CjspVRosB/BmFmAuNypfW8A4QOKEP4SRsqPOwqXzBknTCX83kXjMYm/ptdn
bees/wwDn1yNYpzRethm3E2Mq84ec7hpD+gCII7auUDUrqYECJI=
=ukCq
-----END PGP SIGNATURE-----

--ydUJH2p/CGhrI1Ua--
