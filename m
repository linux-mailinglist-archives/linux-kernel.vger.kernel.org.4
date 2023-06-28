Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3AD7418D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjF1TUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:20:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:45928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjF1TUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA1461453;
        Wed, 28 Jun 2023 19:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56C4C433C9;
        Wed, 28 Jun 2023 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687980032;
        bh=ZQZVtPeU7dPNfjGKYQ6Traz9rQl2dIA6gWmjA6m8qoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNwdXgUAdozPFhzvee/9wFbEm1LOcTqPM+0kxlq1OXoC4ACco74LdlRpZZdvmn4Aa
         8pARNmwwLJTg+/YUQI9OPZ6xg2xt4hEopHVW21rE7gkCF+zmKmDIFFR3sNddnwga8P
         uovtIqPF8UljmZzo478xqZhrezrLWS/ndPSL2XgYG8gk4qAiNNxHaAoioglGGg7HTE
         L8FAKplr0VVd7jcxJ2H7otD5Hez1qfRM3cO+uNjJEGo6QtNDoFYR7ALyNcWcEDDtuG
         T8/OTb/jl7jherPuJOfe9CeqsGDQoXao7KIAO1A0qDZeWNyeK7inssZBwAKXayuYiz
         Snp2MwMet+L7A==
Date:   Wed, 28 Jun 2023 20:20:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
References: <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t/OdDRDxov9ilkpM"
Content-Disposition: inline
In-Reply-To: <20230628134013.GH10378@google.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t/OdDRDxov9ilkpM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 02:40:13PM +0100, Lee Jones wrote:
> On Tue, 27 Jun 2023, Rob Herring wrote:
> > On Tue, Jun 27, 2023 at 10:33=E2=80=AFAM Lee Jones <lee@kernel.org> wro=
te:

> > IMO, a series with interdependencies, which most cases of a new MFD
> > are, should be applied as a series. That's generally what happens
> > everywhere else. Creating a branch and PR seems like extra work for
> > everyone. The downside to that is any API changes outside of MFD would

> This is what we've been doing for the last decade.  However, I'm getting
> mixed messages from folk.  Mark recently asked for something completely
> different (which I did say would be a bad idea at the time):

> https://lore.kernel.org/all/20230421073938.GO996918@google.com/

> Could we please just pick a strategy and go with it?

The basic ask from me is for things that cause these serieses to make
progress, ideally in ways that minimise the amount of noise that they
generate (given that they're generally pretty routine).  Applying
patches when they're ready at least mitigates the size of the series,
makes it easy to tell that they're OK and doesn't preclude applying more
patches on top of it if that's a thing that people want to do.

> > need some coordination. That coordination would only be needed when a
> > subsystem has some API change and there's a new MFD using that
> > subsystem rather than by default for every new MFD.

> > Another option is just that you take all the binding patches since the
> > MFD binding depends on the others. The drivers can still go via the
> > subsystem. Not totally ideal to have branches of drivers missing
> > bindings, but better than mainline missing bindings.

> My original method of taking everything with Acks was fine IMHO.

As I mentioned before the number of resends of what are frequently very
similar serieses (eg, two PMICs from the same vendor in flight at the
same time) was causing me real issues with tags going AWOL and things
getting lost in the noise.

--t/OdDRDxov9ilkpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSch/cACgkQJNaLcl1U
h9Cquwf/beLq1gjcYtTzTT+W2Y2bDq3eP4a1a1nJj6YBoMNGL+H9aDDh+IEYQcny
tQ93FGnAxxprHje5GpW88ar0WLhMDf/nlCvuv5M5SGXgKtAvTV26FZzQr5NMKgFW
bhdMs4r869lmrqfF8uG7xE6REDJqLKUqTgW7x1i+pVnE2MuFPT5coQbqAJohhR91
ZhEhjPKzdUq1L9gC8MkosngN8XSTQZtVbs060CLHXc12gBqkw0bxgImIMRtP+ld7
bVYPdSDhsTG7cJp/BmJIeNtE70RQczZbXYfqeRgw5wbuZVIWEHilOjV+oe1FJaV0
3EehhtqBFHUFu+aOROFtdNOcsqSnbQ==
=+yB6
-----END PGP SIGNATURE-----

--t/OdDRDxov9ilkpM--
