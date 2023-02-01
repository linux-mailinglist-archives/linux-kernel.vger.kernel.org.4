Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96725686989
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBAPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjBAPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74B6DB05;
        Wed,  1 Feb 2023 07:02:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D19AB821A1;
        Wed,  1 Feb 2023 15:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B2C433D2;
        Wed,  1 Feb 2023 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675263660;
        bh=YmsUF8dYyS1t9iHkHZl4QyzCYaAaEk1KI4sRfdsRaIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWU/uBx64dGc2xdxP94hbFndKoMOooiLvGJW9syKl5VW9CNhcBGfe7leZ3+USFgBz
         END1RF7ldrpYmDuxzDaiVcl6IPJ5pG9QQ53bx1raIxWCcQDSxdCpDsa6rssURWBx4e
         bmLZbMGPyovn5XkJpVagXH4LHEqA26B+k55d0yAn5S9Bdbc3rMwlI5PXi9yqc3QPWt
         1PlU3MdR5rEhCNKRaOyca1wGW2JCQ/cV0KO634+pEjX3Bqgb89r47NsWW97LSRSIpp
         GZGUqfY++Cvcb1L2sVUcukcpP72lKIVYac2xVj//PRSeeF3lXLJk+e2Pvl8LawP++J
         cIUrK0SftDKPA==
Date:   Wed, 1 Feb 2023 15:00:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kiseok Jo <kiseok.jo@irondevice.com>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Message-ID: <Y9p+p6wt8WugDBuH@sirena.org.uk>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qLcimmkhW1yYyJm9"
Content-Disposition: inline
In-Reply-To: <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qLcimmkhW1yYyJm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 03:43:12PM +0100, Krzysztof Kozlowski wrote:

> I tried. I started writing patch to fix few things in this binding and
> then noticed that it is entirely empty and documents nothing.

I really don't see an empty binding as a major problem in and of itself,
we can always add properties later.  Again, I can't tell what the
problems you're seeing are.

> The trouble is that soon you will send it to Linus and then it becomes
> the ABI even though no one ever approved or reviewed the actual ABI.

So send a patch to delete the property parsing code then, like I say
removing the entire driver is very much an overraction.  The properties
are all optional in the code.

--qLcimmkhW1yYyJm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPafqYACgkQJNaLcl1U
h9B4SQf/V/sdNWAHAktgLl/T/dtFKrx37Qe9wxNlsIs5nCLDx+P4A075LhmLQC7/
CBRhMIjVPmWoXMvMz+QcrL1YZw4Yuqt+pMg0vOxkKuQQplPLK+sj1Os36jT+NLAR
VXmvhhsy/ohXtnTdD7tx+YycrlQBw25Wd/iMBKzBRHoqjBFCYSyJqKcYtqxw2jqQ
wAoxYuNJi3NIZYHlOd4qVLJTp8zGmW023L+MomhTFTimbr94npCTbz49CjVZ8B5v
a9YHAKi3jsDWpIz45hLso5GQZvrvbvRbst3u92dAN2CXSQpb3mW75EDm+rn21TuF
ANteV+q5cPoO2CT9zGdGYBhFYe5pLw==
=mFhz
-----END PGP SIGNATURE-----

--qLcimmkhW1yYyJm9--
