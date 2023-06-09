Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6F7295A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbjFIJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbjFIJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B24692;
        Fri,  9 Jun 2023 02:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B8661EAF;
        Fri,  9 Jun 2023 09:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E175C4339E;
        Fri,  9 Jun 2023 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303189;
        bh=trIw02rNBpNuNh03ZuX3RvyfOjFoCoUAyx/8izz7MTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEHAQ9BB2obls72irPa4Asg3hWcO+TDzK/6Bat/DyPG683k4tzD67mzmq2MyJUAeq
         4zHWK38xDNn7MvWMslLWv0AjtvMZQ7y5YWMa7j3DttTzw6zKmCAoSnXSGkEh10aCH6
         yt6cLXSMy8SAxhe16YiF8XrpZ6Cu6sd6WR0BKk/hkaRX85HEMJcQaFvSG7bZ2Ct8MX
         TnMytGdNC6Rc1tBFdAP64wkQCR0DW9xQh+wFXQWqQExZ+1+9HK6WjOxasy3PrGDZE2
         yjpzBaodywUz2yXFR5rsEcb79aTm6h1rJAB3CjsdXU7fcR3aP2bolnGNndgGMTIbta
         3HMlrlUVFsmWA==
Date:   Fri, 9 Jun 2023 10:33:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <d0e644f8-462a-4d5e-8086-926b4db7327e@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
 <CACRpkdb=2fogk3bEa4fkPVYQivnvLh1F1TnBj7og43ak+F8gPw@mail.gmail.com>
 <3241150.44csPzL39Z@steina-w>
 <CACRpkda2yQefuUMn6Ot8Ns6nNgfC25i9nwmzwxOy5fUg=A44hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8p4tEmx13yYEDZ7S"
Content-Disposition: inline
In-Reply-To: <CACRpkda2yQefuUMn6Ot8Ns6nNgfC25i9nwmzwxOy5fUg=A44hQ@mail.gmail.com>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8p4tEmx13yYEDZ7S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 10:42:04AM +0200, Linus Walleij wrote:
> On Fri, Jun 9, 2023 at 10:15=E2=80=AFAM Alexander Stein

> > e.g. a sysfs attribute.

> But it needs to be set before userspace is up :/

I'm really not clear that this is actually the case - I've not heard an
articulated use case here.

--8p4tEmx13yYEDZ7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC8c0ACgkQJNaLcl1U
h9BGQgf/YB1hKO5OaW5FGz6/FKPL7YIwLHFL4+hZ3HPtQwiEtKuDApfudQ/9yrC6
4X60YUoR93UUKBOuKFBn23/REhDYGzq6lUp+SW5yJObJs3FbMtu9ZCPAHTjpkh0H
bx9+CX5IzlIBddOKDFCHg1N+6pP5nC2mfdSzff8H3CUvgwuVy09wL3373gf+QXAS
KlPiZPtH8wfHgzALF4xAQpqbzZSgJ+4PRqAF0dA6Wz4C5m3hMrDSmQOpQuX2LK/X
/QHnQ1qC+AY4d/BXXgTALaHRsCFdLKNBPT01Qe3LyVxg2ABWA9E5LpSgyggSpljF
52858nhYb714hTCuBtyiMjcex8NVYw==
=k8Q1
-----END PGP SIGNATURE-----

--8p4tEmx13yYEDZ7S--
