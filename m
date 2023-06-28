Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2271A7416CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjF1Q45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF1Q4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5413D;
        Wed, 28 Jun 2023 09:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C96613CA;
        Wed, 28 Jun 2023 16:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C74C433C8;
        Wed, 28 Jun 2023 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687971412;
        bh=qgf5FOtoDVpdjZsOaE1RhcDabfgWbVLagbas/qMccuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wvf/gUcRm2eG63dyGycFEhQe/F5vVj7bZqE7SW1PoIjqhVHZL1CXinj5z0e6Geqi7
         MaMaIazTZEs7RVaLbWjuM7pHRIL8c+kalRFZyv2/7UZhxWu9GJ9HhnStsUVgeTfEfk
         GT9Ncp8l+Y5GbMNyoyc1Pyapie3xqSeI6UO5D7Y9F/V8qBYrnnFQCiPiNqM12mAQuL
         FTv9Aqt3lOPPfGntOyQzJdw/JYMB4vt+vl2XZgz3434JlqpEV0kccMehqU8bo1vXy/
         uIuhMzh8uJeM86R68/Xaf6KTtBdjCZVWRsTklP6dq4P9bkveLrT5VbWKfrG5vqb/cY
         xcp+iItp4wv7w==
Date:   Wed, 28 Jun 2023 17:56:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next:master 11663/12731] ERROR: modpost:
 "clk_unregister_fixed_rate" [drivers/regulator/raa215300.ko] undefined!
Message-ID: <d9bdf8ba-ccdc-4203-a0ee-0559448fb865@sirena.org.uk>
References: <202306282012.sPQAuAN7-lkp@intel.com>
 <OS0PR01MB5922893DE97EAAD6BAA142558624A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9CvWt+5KXhPjnzp"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922893DE97EAAD6BAA142558624A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9CvWt+5KXhPjnzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 03:47:19PM +0000, Biju Das wrote:
> Hi All,
>=20
> I have come up with two solutions for fixing this issue.
>=20
> Please suggest which solution, I should submit.
>=20
> First solution allows to build the driver for m68k architecture,
> whereas the second solution skips it.

Either is fine for me.

--s9CvWt+5KXhPjnzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScZk4ACgkQJNaLcl1U
h9BQLwf+OpR5EwMwSQHwK+whmfuKLIAYFE94wBFef0ddW26MYs08e2Voc1FxaCz2
MZ6OHxtyjOChKtV4uP7/aVwPtYKWjwLtgn5zJjLIPdh8suf7HueQ8w0aWgGwKUmt
mwUmHHy3icu/riazu/RmtSCmcKqqTQ89xKfpRdkttPrOYm6pptFRejN/JWGg5dKo
tutEzSvhcZVU5NzfCFM6euaOHgpMUHUnnZ4Fv6ZQ3FQAM2eLz5zQmyqI+iws8hQF
BKp+deT/bJ/dxRv27Dx0Kl7w+86OnTJe2dIxuvrjYLjbYO8xmQj666rCleZ04m7u
DFMg+vGCv/gVU9JnKNYRgfzYblICqA==
=vZEN
-----END PGP SIGNATURE-----

--s9CvWt+5KXhPjnzp--
