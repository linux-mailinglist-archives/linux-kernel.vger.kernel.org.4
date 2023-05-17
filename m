Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D876706B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjEQObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEQOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2757DA7;
        Wed, 17 May 2023 07:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0DD645BE;
        Wed, 17 May 2023 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DB4C433EF;
        Wed, 17 May 2023 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684333855;
        bh=m6Os9B2ed6cigaZgyvST3zp5sKK8MZYV/M/roj0u/iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RP/qhpzfg0S6E2//ryq4SNYkedqo/IWGritLtCDNhEgQHZtNfcDiCVK4yp7Jqokur
         eZpH0XvtuStZo6aqN+hogrkZ3ILJCcOls7Tl7kcazXTdN/ubmWTgkH9rUIxhuJjz0a
         UBgRVYr3p3w4zT8k+AcySzysNtLfh0Ceap+08PWvRWxYluu8VbpOvpNhKHhNDfUioF
         rrqhnzZsSp2amH1YpoV2Nc23APNXZN5+MCglArTtOdsxNja8I8s1oVOpVnIceiFQHi
         IQUQqLLdXnY2QrLuYg7Pr0y8sIk+L8FCFGHO8OffGQbzXK7BD5WOF8JDk69EcP2T9I
         dLsa58uJTvBGA==
Date:   Wed, 17 May 2023 23:30:52 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Message-ID: <ZGTlHMRl/ifaQmiN@finisterre.sirena.org.uk>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
 <ZF6RMqElYZVMpWRt@surfacebook>
 <20230515101350.GS68926@ediswmail.ad.cirrus.com>
 <CAHp75Vcizrucc-2KFdFNeHNrxCzz4GwX1OzZYyjPH7P9RgnKYQ@mail.gmail.com>
 <20230517101301.GV68926@ediswmail.ad.cirrus.com>
 <CAHp75VchpbiYcd2yaP1WTjX17P0hg3qON5JGAXu08aDVw6Ydkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ov0voJhDONNyMty6"
Content-Disposition: inline
In-Reply-To: <CAHp75VchpbiYcd2yaP1WTjX17P0hg3qON5JGAXu08aDVw6Ydkw@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ov0voJhDONNyMty6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 04:59:50PM +0300, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 1:13=E2=80=AFPM Charles Keepax

> > I am very very far from confident we can guarantee that will be
> > present in the ACPI. The ACPI is typically made for and by the
> > Windows side.

> Why? You may insist firmware vendors / OEMs to use that as a
> requirement to the platforms that would like to use your chip. The
> _DSD() is part of the specification, I don't see how the above can be
> an argument.

> The times when ACPI =3D=3D Windows are quite behind.

Nobody is going to loose a sale over something like that, especially
when it's just not idiomatic.  It's very unlikely to even be worth the
effort of educating customers who don't care what DSD is when there's no
ecosystem push for it, it'd just make you look difficult and weird.

--Ov0voJhDONNyMty6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRk5RsACgkQJNaLcl1U
h9DaIggAgmCuOSFXfbUoH1Su2DcLeh0wIfTqcONVi5GSZAbHyuk9dy5MrNYj7nfa
BcKuolLtwCe4MMP4zB5zLMSydCTOL6J4vPUUcGrQgOl0jUHkF+k/G292o5wyf3B5
346PTZPODQloCnkBdi+vjpx+7XLYki/f4sjbTFZ0i4AeKblgvmROpqBpk7e0oWRa
phVv/QMLjXuxIi+wmCuR8MfiBA3G+V4nhHFpiOQ7tJynbOXwEqwf+Pap/bT1l/pp
q/SLuiz+4SqQLPP/OWZNMDzVLpDfFfHHumuKTS6jztcZ2+EkDjI/NSESl85fkee0
b4R9RbjgMmuLqwnWKrgLotCs+oO0pg==
=aZyT
-----END PGP SIGNATURE-----

--Ov0voJhDONNyMty6--
