Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7F6E99F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDTQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDTQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3DD2;
        Thu, 20 Apr 2023 09:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 077A1641AF;
        Thu, 20 Apr 2023 16:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AFDC433EF;
        Thu, 20 Apr 2023 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682009549;
        bh=U/Ed3Bf5iQDyeXK4sTAagfDBTCyOzfvKX4J+dgDoT2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpUFunmkElXXI23HUs5s8c9qlu4z0uxsz8ZICJUQLo44UcO0tFwwejDMMwAJAqahg
         f7pm5eVCz8UnNTuTFC0WlSnj6Doxxc1yYzHDf5YZLlnm0lGbZRkx1Jz9yGTqRJtWIW
         pwdy1IfEQ1exI/Su4rCgVt8Kqm99RBDprvbHkmU9l25M1WMRXCRzyrA2PQcJbtOQye
         7YQIOkw2znTEK6iKnrgj871XC/dI645BXONXY6VO3daDLJR9gf3Mvtsd4AvWoIaLM3
         P/inYFJI5lRDwa5of98v5gBG3ovdbMQTrFr2hT36HygI8XHhDRZyb0xjqVBZyF/xQr
         jo0mWM/he4XSg==
Date:   Thu, 20 Apr 2023 17:52:21 +0100
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
Message-ID: <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="enmX+yyvaFeCf0/m"
Content-Disposition: inline
In-Reply-To: <20230420103438.GI9904@google.com>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enmX+yyvaFeCf0/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 11:34:38AM +0100, Lee Jones wrote:

> Once the regulator driver has been reviewed, I can take the set.

> Please apply this if you have to resubmit:

> For my own reference (apply this as-is to your sign-off block):

> Acked-for-MFD-by: Lee Jones <lee@kernel.org>

For situations like this where there's a depends on to the MFD it'd be
great if you could just apply the MFD rather than waiting, the
individual drivers can either get applied on top or just go via the
subsystem and have everything sort itself out in the merge window.  It'd
help things move along faster and be less confusing.

These serieses tend to get so many resends that I'm often just not
looking at them, previously I'd have just applied the function driver
when it's ready but with the complaints when the core ends up missing
the merge window but function drivers are going in I stopped.  In the=20
past I've ended up missing things because either there's multiple
serieses for similarly named devices out at once or (less often) some
change results in a repeat review being needed so it's easier to just
wait for things to settle down.

--enmX+yyvaFeCf0/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBbcQACgkQJNaLcl1U
h9AEGwf/cZ5jz601ThWLKn8DrgHpVkT4V1DcOQlZnAAuvef8R6TLj17mP5voXh4d
6H1KXgNljwwO755+9o8YBPLWo0MKybFlD/L+vElU5SU9Z4nhBirPvFhMOP+7VY2n
IEn0TnMW7+ELbwuhlp2uYw38CX8AztWvR6tWCKko6uyMm/nCBfFpON+rlEkZ63+4
abvINbrTEggEly0giW4MnlmNMuF9d5yqZMq2A9+3K2RFRVwa3KOCOcIkyPStqxqD
JimllAVHjijGGkgk1Xe4zwma4omY389whj17TAANkgFdEIAL4hL1+PQG/XwjBeth
E+4lngNuk7ooRmgKkS7hHzTwfNFaPA==
=RCMr
-----END PGP SIGNATURE-----

--enmX+yyvaFeCf0/m--
