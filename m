Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B25F5D98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJFARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJFARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:17:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826673922;
        Wed,  5 Oct 2022 17:17:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MjX7r16d0z4x1R;
        Thu,  6 Oct 2022 11:17:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665015450;
        bh=/FXxgeNqypV39KZ75lnqr6O6dEY9shiUVMoU67UEf3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FaZ/Gp5iEA2LNs2r8rP9RspB7i2Ts/++TFDqd2aVVOqOachSRUI7AphpPJsQ0HqbP
         I53uK6p19EN/2L455Sg++DDPZIwKtFuAEkKJqYqx9yQA4ab8CrC6C6/nWOlZ9YuYrV
         v4xR9bmHm4fpClZ5kaUjKsByMPXs86j/xc1dYOTQt5sTj9Ob8nPPCjtmgJyZdjxh1y
         kfBEMbnp10ESVXUMi47dCZQ00f81OhCixcvPJgrt+eUu5KHRZPfbP7kaqz3mfLWaIH
         HvcSQUwwR+2pVcU+klnVjYc/zaDu0FKD/ryiEYFkAMJwksfBfmZ3ee9Iem++nGDhza
         dlil5hSalK45Q==
Date:   Thu, 6 Oct 2022 11:17:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Olof Johansson" <olof@lixom.net>,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20221006111725.01ed0eac@canb.auug.org.au>
In-Reply-To: <f8416a63-3460-4b43-8532-2d5eacea4457@app.fastmail.com>
References: <20220725095913.31e859ec@canb.auug.org.au>
        <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
        <20220815105419.4df1005b@canb.auug.org.au>
        <20220831091654.45d5ed41@canb.auug.org.au>
        <20221005114841.4540d325@canb.auug.org.au>
        <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
        <CACPK8Xecn8ZREAqcLcuZHjA=NhaanRMKu4W39okAkBFX4aaOnw@mail.gmail.com>
        <f8416a63-3460-4b43-8532-2d5eacea4457@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jJaJovNuPEl9t6vd97RGOaU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jJaJovNuPEl9t6vd97RGOaU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 05 Oct 2022 09:21:21 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
> Agreed. Alternatively, we could just remove the pcie@ nodes from
> bcm5301x as a hotfix, as they are clearly not usable in the
> current form, and none of the three versions (5.19, Rafa=C5=82's
> patch missing ranges, and Florian's patch with incorrect ranges)
> actually conform to the binding.
>=20
> I'll tentatively apply the revert for now so I can send the pull
> request tonight. If someone comes up with a better fix, I can
> use that instead.

I applied the revert to the merge of the arm-soc tree today and *all*
the warnings are gone.

--=20
Cheers,
Stephen Rothwell

--Sig_/jJaJovNuPEl9t6vd97RGOaU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM+HpUACgkQAVBC80lX
0Gwqhgf+L95a7+fs9qPa4OK9tGLvl5PHQdKKDOfH6P/SSQw8ohprXeAc0ReuIbEL
0inLRel+nX+jYEZ0rm7dipPruh9DwYhj/3Uur0y1FYsEvkm2rcuyqydWHzAW8OsE
nuD+m2JlyOgNA1EB9nK5jZZ4IlqoVREgxzMTK9d1Xv4md8xkEwJ/U0CEuNO0Xg64
ePR7dJ55KnzppmKLRjETlcChlZu3FR78zd2ck0EN+Wgo460z+1u0seDBaFSwfsAK
KYB3SA/jwA6dCghJmxEsVvdaq+D4aLEmXRqNmdM7EO24rX/0cX/AxujoztX++BeM
T+meDt7EXoW6T0bApNMUuQaIl/fHVQ==
=RUX0
-----END PGP SIGNATURE-----

--Sig_/jJaJovNuPEl9t6vd97RGOaU--
