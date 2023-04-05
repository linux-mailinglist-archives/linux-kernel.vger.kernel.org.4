Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC76D8B43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjDEXxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDEXxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:53:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42B30E3;
        Wed,  5 Apr 2023 16:53:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsLzt57Zwz4x1N;
        Thu,  6 Apr 2023 09:53:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680738794;
        bh=m3rTXzOKaKNJeH1s1Hd6Hy3jezK5K9sfPy4sSZlVslw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RrGIoHhxoWlsGqGCzfnZVRfik89zUGKfTErNHfxhfQDD2Xd5l+5V6PMMMsniLqiDO
         rLp793OKCECHbFApgKvDEJsBh3egTlEKJDLMD35R72KemzfWKcVrbY4cS/SLH3McJJ
         3TzSzZ734TPZMJjUiakGBIrJaqEXi4y7JESRc+9xXF0bTRetQuJaogbWMG+9q9/WrG
         1atA4chOMwBj4x0QEMTYiN4vFv+Au3xpa3maURTfUhKWoqsf3yA40YVw01OMIVhmiN
         IE0ka4cy2zFyVPYbWDvt7SGKIgceRWjVyapn1A3wYV+TwbeiZJImMePCU55uI/MkPo
         RkdeAHMzA7R2w==
Date:   Thu, 6 Apr 2023 09:53:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: a couple of breaks
Message-ID: <20230406095312.2a75ad36@canb.auug.org.au>
In-Reply-To: <31ea09c7-7187-4d44-a25a-cd5378cefd69@sirena.org.uk>
References: <20230405165707.189c1a99@canb.auug.org.au>
        <31ea09c7-7187-4d44-a25a-cd5378cefd69@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/91NZE=tinAkvXdy+rcOeB3J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/91NZE=tinAkvXdy+rcOeB3J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, 5 Apr 2023 12:06:55 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 05, 2023 at 04:57:07PM +1000, Stephen Rothwell wrote:
>=20
> > There will be no linux-next releases over the coming Easter long
> > weekend i.e. no release on Friday or Monday. =20
>=20
> > After that, I will be on vacation from April 13 to May 7 inclusive.  So
> > Wednesday April 12 will be the last release I do until May 8.
> > Unfortunately, that means I will miss the whole next merge window. =20
>=20
> I'll try to provide coverage for for the part of this that's in April,
> I won't be able to cover the first week of May unfortunately.

That should be the second week of the merge window, so not a big issue.

>=20
> I'll not cover the coming weekend.

Sounds good - whatever you can reasonably do, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/91NZE=tinAkvXdy+rcOeB3J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuCegACgkQAVBC80lX
0GzDTggAlfzJEbUMVVm7zL9VaXAjfzm0okHWIcrvImhgZ/B65DGXzG+KXmxyAEFk
z+V8eXQ1eoRI3qK7JLZ5L2WhxP70gzu1lTeeAbE3qvatJXgIJX4ff5O0PCB808D6
gs+5dWXevysqehS9kK3sSicHXEKVZI+5h/cbs/0IJhZBqnREjeqvIFKqgOenr1P1
Ep1qjVtZ/IZ0kI2Ppt1mOt7gMir/f6wK4dEsq590au7Glq/hup1on8e6cM8zQ+TS
znTXgPurk099MQyPPbxCOpt62M/bfg8t0pHRFxjyEqxyj5KcTsEBWv2Mm/bfz7+N
xIp5tuysEbYNinm70c1cZACTS7hf5A==
=RcD4
-----END PGP SIGNATURE-----

--Sig_/91NZE=tinAkvXdy+rcOeB3J--
