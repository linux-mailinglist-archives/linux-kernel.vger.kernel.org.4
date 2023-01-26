Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E567D459
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjAZSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjAZSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:38:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B71D68133
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9C3618D3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027AC433EF;
        Thu, 26 Jan 2023 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674758304;
        bh=vSN15U4+3V2iFVQFE4V99mWb1+xvL+gAsefhw3kvQB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyhlXpy+gTPEM0mgxGScKI/INFrgDmQBa5v5iwCoLZu1SddZOOvmzkzdsJfNyy2YF
         2HmRVxrlDC26MQVPwEO2JFcW9S9ev2H8UlbgUr+EDIxsSVhTz+aNFfUYA1Gmvdg6fU
         cE6aMHD3w5SC8P7oQbVg7q02F/32ekGlYEUfoVedSM/80sVRXAsI15KQ6144p9l8gP
         1n3xVho78oSYpkOLnSoSviXviaG7PeeQskkD6KXWync9WlIFFLmqbVb/j/PUMcNov7
         u44a8RotUcqUAMz9cq7Dx+It99xEWwyt6FeNEJ7eIEiVfrVfL2+7sADJQRufiP6RtP
         1AylVxxhxNSSw==
Date:   Thu, 26 Jan 2023 18:38:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] regulator: scmi: Allow for zero voltage domains
Message-ID: <Y9LInDhFoVkWMe7d@sirena.org.uk>
References: <20230126180511.766373-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="09+FMyE3c5KMLHKA"
Content-Disposition: inline
In-Reply-To: <20230126180511.766373-1-cristian.marussi@arm.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--09+FMyE3c5KMLHKA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2023 at 06:05:11PM +0000, Cristian Marussi wrote:
> SCMI Voltage protocol allows the platform to report no voltage domains
> on discovery, while warning the user about such an odd configuration.

This patch removes all diagnostics in this case?

--09+FMyE3c5KMLHKA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPSyJsACgkQJNaLcl1U
h9BfLAf/VnME1mlJ7pDoU0qwhal00UjAby6spW0h1lMeyLOadd/DoI6j03M6VLTl
dgfisO0xOUNr5JZ1d+onWTj1zMl8ib3JVfTGNJKyTIIztbun6IZ7RE1xhlNg+A5J
09RSiWKB1YgBqP/4JQn4NmCbtjpl5oGTnhbjCqWqFbY3+1aZRChVP0AiPxXIWhnS
0SlY27hVvecJ9jaMaUhXR7Gn3Y9usWp9jHKcrB5I4IjoWUQti3bcBbwTCNUPCLE6
1RxdbZaUrABYl1DJk1pDVQdXfyj7fUHWleDKQTDstF+vFt9AfiNwyV4pWYFjJPCy
kKCXDwlgGC8AQxy4N4rGThN1l+jKjQ==
=Sf3V
-----END PGP SIGNATURE-----

--09+FMyE3c5KMLHKA--
