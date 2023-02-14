Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F0E69678A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBNPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2A25964;
        Tue, 14 Feb 2023 07:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FC75B81DE8;
        Tue, 14 Feb 2023 15:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D784EC433EF;
        Tue, 14 Feb 2023 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386926;
        bh=b4qXj49NhLH+VmXo0IEZTy5nxQfaEwAeDK2n+P1ywmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjbzqFnN4aFc6EWXGWB6K1KNNMkCWsFg6UQAksXetf8alFsuLg9B2NxdBhl7zCRS/
         +gvKhyWOdAcno5Cpl0xcE0ik4HwMh+sSTf9Id5/xc0nl4cuCfc+T0+MTe0gkimr79M
         2SluDBB4Nin2BdCdt8dGaMygm1gEfnd8YUDfJDu6x7Z4oV5/Wb/fGAIEdFF6swYD+x
         Spir2LsPdDAVfoPJk3d0pdMwBiPifBiWz2QhOYoxYl51OMzMF8UamYED1XxL9O/yIL
         mU+Cwn1ZqY0ybO4xi+6z9jMdKNp3niKQ7TZPePXMogTgv/neYzIdoL01U6tIfu1sdS
         lJZlDUnn4NR3A==
Date:   Tue, 14 Feb 2023 15:02:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Message-ID: <Y+uiaqvdIL4IpRlC@sirena.org.uk>
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
 <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
 <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
 <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
 <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0fp7JQwCfap5FMO"
Content-Disposition: inline
In-Reply-To: <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0fp7JQwCfap5FMO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2023 at 03:26:14PM +0100, Alexander Sverdlin wrote:
> On Tue, 2023-02-14 at 15:11 +0100, Krzysztof Kozlowski wrote:

> > OK, but then I like the example - if datasheet would use name
> > "clk_clk_this_is_clk" would you still find it meaningful?

> > Every clock input in clocks is a clock. There is usually no need to say
> > that a clock is a clock...

> I see you point, but this is legacy code (sound/soc/cirrus/ep93xx-i2s.c)
> which took these names back in platform data times... I also see that
> rather majority of *i2s*.yaml use something "*clk", so maybe it could
> be accepted for legacy code?

Even ignoring the whole legacy thing these are industry standard
names for the clocks - they are pretty much universally named and
referred to with the clk suffix.  I can't see what removing it
would accomplish other than reducing clarity.

--V0fp7JQwCfap5FMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPromkACgkQJNaLcl1U
h9DNdAf+PfDbEGrwAar/U6K2LSnAK3ainnO5AXgzSEuk3ZaWIdkd41jazqjW1RwD
mBX9lNnquoCvsBYlvcfod9Ccs0+GzPbFDgDkxe+EuJ9HqSucvvy4Z+rtvQ1ID14b
7TKCESoXoiIBe6V2hcBYk4bG4979bG72yNChMj59BeudkHCSYpz51D+5YfHxRR/W
BrQVo8Ek09ACp3x8dScwvhKdr3uKWLekbT5rjLRVM1YmuMiHxc1cJwneBnTwNadS
5NNFNJV3nT5ljqIIyOAmPW3REJzV1mc17XfDeFvHk12GnQzQB45j7KIEnns/oNbT
Q8pVKJsSeGBT/7ptDNUajI7hZ6SMbg==
=ZBYi
-----END PGP SIGNATURE-----

--V0fp7JQwCfap5FMO--
