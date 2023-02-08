Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381568EE05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBHLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjBHLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:35:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989C3B0ED;
        Wed,  8 Feb 2023 03:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E7D615F5;
        Wed,  8 Feb 2023 11:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46498C433EF;
        Wed,  8 Feb 2023 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675856141;
        bh=AUKE6M5tMZuXDYA8IUjucWQolhmviuw2K6E1aGJS+5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFEGyQnI/ki1HjHQ5rj5yWlFqkyV3rxAZ1YZHYWsr7hIxiUdF4kXT0JCX7hyDXA4d
         40nk9fJeyAoehXLh4GRdbjXvf1i6X7wfe4CUIH2AhGHxgJZh0LArOLEIdDqdhw1aU9
         uAWbzeB5/NCYBasygh5zk4KGlKG81WC3Ux2pE7qSIKTODjSkiBxT+doOm3MC4pRMfk
         DONTiocCp2uJ5V9D98tSiO5tXwr+8T470wIxlHmJM/RPQGJHRaBU8EOI9nBEdJVZUJ
         5+g2uUHcRRQxVdcJEsY285sCBTLMhNWD+9UAMHWrZetEcDTdMwIoi8iCsaY4lYt+fc
         Gmcef5nCWHCmA==
Date:   Wed, 8 Feb 2023 11:35:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] ASoC: dt-bindings: meson: covert axg audio to
 schema
Message-ID: <Y+OJB7OPABnPfeq7@sirena.org.uk>
References: <20230208093520.52843-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q8hUcRno+jxdc1xU"
Content-Disposition: inline
In-Reply-To: <20230208093520.52843-1-jbrunet@baylibre.com>
X-Cookie: Walk softly and carry a megawatt laser.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q8hUcRno+jxdc1xU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 10:35:18AM +0100, Jerome Brunet wrote:
> Continue conversion of AXG audio dt-binding documentation to schema

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--q8hUcRno+jxdc1xU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPjiQcACgkQJNaLcl1U
h9BmoAf9EcajJ7S7A4aYay3TP8axqaTlV6e/par8YbD+TMjVAIn3rVhLP/tfYPzT
LUmutr/WdLwRIHyN4+1kB1sanVXRDq8EUHGgoJTsA+Z1RajZFS2ot8xWNLeoZO8b
EGBDTF7+8axEQCw1KG1JQMHoL4lErqeWzOJxwUQfbcmXjndfdUHAnQlS4i91USVA
qW/GQ3F93rXeyQPC/BCjvBBeYwmrf9X6s/flz4YEE24hFYi+qzeqy7cKtZsWEczy
qdU9I7SsK24zW5za4lgHw1QJcmSANztHgvoqte5on59EUhP08u5N2fuSi2Ek+m/T
iwn11JkoQnMg9u0sAq7uTjtq2EgYMg==
=T+/7
-----END PGP SIGNATURE-----

--q8hUcRno+jxdc1xU--
