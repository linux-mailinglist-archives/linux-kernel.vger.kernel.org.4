Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE5E64E84B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLPIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLPIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:47:32 -0500
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 00:47:31 PST
Received: from lug-owl.de (lug-owl.de [188.68.32.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9F248CB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:47:31 -0800 (PST)
Received: by lug-owl.de (Postfix, from userid 1001)
        id 81CF142074; Fri, 16 Dec 2022 09:38:56 +0100 (CET)
Date:   Fri, 16 Dec 2022 09:38:56 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221216083856.rla4sfga2akjxno6@lug-owl.de>
References: <176b0f41a8b9e9f1191bf2b8857d121887c4fbe5.1671171965.git.christophe.leroy@csgroup.eu>
 <202212161638.VBZyfyMO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bozrjqcxjqwdy5jy"
Content-Disposition: inline
In-Reply-To: <202212161638.VBZyfyMO-lkp@intel.com>
X-Operating-System: Linux chamaeleon 5.14.0-0.bpo.2-amd64 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear
 warfare test the bombastical terror of flooding the spy listeners explosion
 sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare
 test the bombastical terror of flooding the spy listeners explosion sex
 drugs and rock'n'roll
X-message-flag: Please send plain text messages only. Do not send HTML
 emails. Thank you. 
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bozrjqcxjqwdy5jy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-12-16 16:07:25 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Christophe,
>=20
> I love your patch! Yet something to improve:

[...]

> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    Assembler messages:
> >> Error: invalid switch -mpowerpc
> >> Error: unrecognized option -mpowerpc
>    make[2]: *** [scripts/Makefile.build:250: scripts/mod/empty.o] Error 2
>    make[2]: Target 'scripts/mod/' not remade because of errors.
>    make[1]: *** [Makefile:1271: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:231: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

I see similar failures for many/most (about 4/5 of them) defconfigs.
Needs some more testing, but I also think that's the route to go. :)

  IIRC there was another patch mentioned that needs to be applied as
well, maybe that's already the needed fix along with this one?

MfG, JBG

--=20

--bozrjqcxjqwdy5jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQlDTvPcScNjKREqWEdvV51g5nhuwUCY5wumwAKCRAdvV51g5nh
u+IOAJ9PVf8J5tqMYwYJfBxJ+BaNa+O4kwCfU2rAfoweU+LtpnidNBEdDS+DrDg=
=6o0+
-----END PGP SIGNATURE-----

--bozrjqcxjqwdy5jy--
