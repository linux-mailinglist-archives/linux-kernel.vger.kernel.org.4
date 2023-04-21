Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AF6EABBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjDUNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjDUNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCCE6B;
        Fri, 21 Apr 2023 06:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875D060EB3;
        Fri, 21 Apr 2023 13:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B0FC433D2;
        Fri, 21 Apr 2023 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682084014;
        bh=3Qm//CBVeUe9SBOSAX18g++Nk/w3euOpimYciN7RDGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UO8A3bAe91kpm5Dh6H2Nnke+sw0QjxXwJUPxTGWVeP7iFKBzdU59DYBnl8VJEK6Ld
         aceSBJ9yoZ2yqHNxpD3lHa8PzThHiU4MLFoblRBLD2MOypc9pkuRJrBHqP69c0mbL8
         gxwRc9JmDlBOvtYM991zXgSJOVZTCinCazh2iKcW3M2h5rNpO0kxU6qCDYpHLyJQtK
         dOnBvi4R9LS2DKL2gane6a5ToSSOjDyia+/NUFYgTjUGlvTw9oPfy+xi1mzkh7Dil3
         UslbToe+wuBV0jEyTC00OK+zb5nnFZ0PBRg9Qt2GrJzmeroKO/OPbcm4DTWGT4INx4
         ChC1pAEwtMh3w==
Date:   Fri, 21 Apr 2023 14:33:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/lvOMfkBujeu9yC"
Content-Disposition: inline
In-Reply-To: <20230421073938.GO996918@google.com>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/lvOMfkBujeu9yC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:

> I'll try anything once!

> Fair warning, I think this is going to massively complicate things.=20

> Either we're going to be left with a situation where child-driver
> maintainers are scrabbling around looking for previous versions for the
> MFD pull-request or contributors being forced to wait a full cycle for
> their dependencies to arrive in the maintainer's base.

If people are resending after the MFD has gone in they really ought to
be including the pull request in the cover letter, with some combination
of either referencing the mail or just saying "this depends on the
signed tag at url+tag", the same way they would for any other dependency.

I can't see how you applying stuff when you can slow things down TBH,
the MFD bits will be applied faster and either people can pull in a
shared tag or you can apply more commits on top of the existing core
driver.

> I'm not sure why simply providing your Ack when you're happy with the
> driver and forgetting about the set until the pull-request arrives, like
> we've been doing for nearly a decade now, isn't working for you anymore
> but I'm mostly sure this method will be a regression.

Like I said I've not been doing that, I've mostly been just applying the
driver when it's ready.  This might not have been so visible to you
since it means that the regulator driver doesn't appear in the series by
the time the MFD settles down.  The whole "Acked-for-MFD" has always
been a bit confusing TBH, it's not a normal ack ("go ahead and apply
this, I'm fine with it") so it was never clear what the intention was.

Before I started just applying the drivers there used to be constant
problems with things like tags going missing (which some of the time is
the submitter just not carrying them but can also be the result of some
churn causing them to be deliberately dropped due to changes) or
forgetting the series as you suggest and then not looking at some other
very similarly named series that was also getting lots of versions after
thinking it was one that had been reviewed already.  It was all very
frustrating.  Not doing the tags until the dependencies have settled
down means that if it's in my inbox it at least consistently needs some
kind of attention and that the submitter didn't drop tags or anything so
I know why there's no tag on it even though the version number is high,
though it's not ideal either.

--w/lvOMfkBujeu9yC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRCkKYACgkQJNaLcl1U
h9Dpfwf8Dh2GPrH7cGwBbc/TaazUhpmNsJOqTl3322vTv5HohfkjwHZJFvoN0EWH
r9n3YTcTQY9dv2BFSUNMmv5SBZqzWgJrRopbrKtK43ieuq18tqvLowpyTwFWXb/2
obkdKaySl0cW2JLEm2XX6S0ZmA+hfL7DF+tAy3iTfu2VyWBGw2hpNRFyIqD5BJrV
LqIWRwn54+SBYuqeTr9Oxk4VpPtlGkuJs4ZF2l1c3Nho9AkQNNzzAVnwGy9a6tv1
STJv4eYTnHZGPleSdET9Ne9jHd54863nUUoNunqROn4OR5Qy/dmw+hMTAC7+V0vz
ofmDSxmMt/kmGlQJe2ZBaMhO7pxSaA==
=dsIM
-----END PGP SIGNATURE-----

--w/lvOMfkBujeu9yC--
