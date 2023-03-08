Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3146B0779
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCHMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCHMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:54:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A869BE12;
        Wed,  8 Mar 2023 04:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61DBD61790;
        Wed,  8 Mar 2023 12:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C403DC4339E;
        Wed,  8 Mar 2023 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678280079;
        bh=HqivjhTLcI9Zd9MO0OlzSyZha29bdurLv8W0YTXg1fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsFxZFTY/aVRyNg0z4JPNurU4J9t0IXWsQJsgjwq1nmlMmIzDKCvbpugVljV6O6+h
         reQRTVH/qViUmaENQdv5/f/VaBGR9quZ4vTfhzmKHABxpTlrCF6ufuZ7w5vQjiwo+o
         XBVRcH19RCca+cFCpfWG2J2mTfaMuP1CZ/sW2qlX2MhUVqxnp1oZaLD+Ekkw+xonKc
         TMkq4rWciNYdSsW6zDqKuGiXM6X7a0LTbzmEUCigze30aKkT4XLbpwASpLZZT5eC44
         aKw49NHXVLJmgdk1pCKxeEWXNU06HNB9bCsG9A/dJC/rPcxuVJGZHTohV6b+b4j1Ds
         o94X8lLqbhZ1A==
Date:   Wed, 8 Mar 2023 12:54:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
Message-ID: <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lx90xIVXyxO5I7OI"
Content-Disposition: inline
In-Reply-To: <20230308094024.14115-2-clamor95@gmail.com>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lx90xIVXyxO5I7OI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2023 at 11:40:23AM +0200, Svyatoslav Ryhel wrote:
> Add supply property.

> +  vdd-supply: true
> +
>  required:
>    - compatible
>    - reg

Unless the device can work without power the supply should be required.

--Lx90xIVXyxO5I7OI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIhYkACgkQJNaLcl1U
h9DxuQgAhd9/3KHUfsZXob8PZ/h6D1Yvs9GG3wCJ2iFn5NVkVsm+++sK7UI7VjQb
zWdpl/G//+4BA4VxxRtMsLoWba2ALW1dewxlvohBA/GkaxU/ZKDG77TmkB+pDv0x
4KoSpS0fJxfRObVPc+XC/alDkq527HBJC1Lo/cQm5ExXr3zOOPUc8X/j8u+CCcoX
pzCCiKt50kNltwKC0eQW8hyDfeLOWaOPWi79SuOhbY8pMei5M+2AcfpEFi3ZO8h5
4Jhmaa/9pX2rSHLCBhZatolqbvwHt9lMHjh4F0tLNiBzOYu+EPOOiKgTPQiiR5WV
cO9kV6PjD//OnG3ALzh8ryrGLdK68w==
=hdxv
-----END PGP SIGNATURE-----

--Lx90xIVXyxO5I7OI--
