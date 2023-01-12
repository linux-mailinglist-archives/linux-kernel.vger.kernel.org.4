Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA336666FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjALKbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjALKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:30:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B2186BC;
        Thu, 12 Jan 2023 02:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7591CE1DC2;
        Thu, 12 Jan 2023 10:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CBBC433F1;
        Thu, 12 Jan 2023 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673519242;
        bh=cw35b8Z4PEoMl2FJPoCpQOOon+cF3EAG8E0CmxT+TBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOAh4SMkdo966tScrgeaB409bzuA5MZ/m/wk0uOLK1FStvlzMQM56ZbbaxtMNH1uA
         ytPLPWS6FMC4zM6pgvh2JV3GeRxPmBRV9F1Zf82otgF3BEXMNUDknIngdX0GvJAJvr
         SwOyGGOFPAETUoJgQ5n792YTZ4XBz/Od9lCHPm6bdxadZ8+lAjArmMgx4Q3DBHDlwi
         9McnnSY8U3L0EeJKDvTz+kEXEUWN63FlXVeTzQmPaTbq7EdX9wgVBjfxldpxo2CYIa
         wnhzS1tmztVSmFS1U1zTdu2rMpFb7sJqQsiDrACe5kHlDBkjIrasz15UVyZcV1lsC4
         /Lr6dMzxpY2wA==
Date:   Thu, 12 Jan 2023 10:27:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Message-ID: <Y7/ghAz460VQ/hXt@sirena.org.uk>
References: <20230105160346.29018-1-faiz.abbas@arm.com>
 <20230108163741.GA30997-robh@kernel.org>
 <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfsYPpGuHog5bgZQ"
Content-Disposition: inline
In-Reply-To: <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfsYPpGuHog5bgZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2023 at 01:53:29PM +0530, Mohammad Faiz Abbas Rizvi wrote:
> On 1/8/2023 10:07 PM, Rob Herring wrote:

> > Another node, is it still 'simple card'?

> This behavior already exists in the driver. I am just documenting what already exists.

Right, I think the ship mostly sailed on the naming.  We could add a new
alias but given that we're trying to retire this binding and might
already have existing users who eventually get converted to YAML and
want to validate it seems worth at least documenting what the code has
being accepting.

--mfsYPpGuHog5bgZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO/4IMACgkQJNaLcl1U
h9B4twf/R2QUSUszMxhRq2hWo5eHW/t5+JoKg7r66Pw11tIs4FuKEcdurtNeDbc9
zp1qF23UQzmWLriec53SgttEtEAxO9ylS4WHR7vBCDvFk5KOCgC13aL/JCru1FDK
y5JiWijjertGmWIGnu5iQe74IcHHnTECYTWFMd9wh4U62H41/ITXSA3TJLcyEpRO
FBXhrEZJDiYXsZHbUwReM7aFGJBuR5IzwAPtUcixhOfJ8HBigruq/XQwXKs7KVCO
3/wTCH/uBkY/e4kYCXRBLiTi3zGfrsBNMkhc0x53liQXqP8x6mIOR6fl/QVEXr8J
P7EiQBBUsMXl1RvJfQ6wFd2Y465uTQ==
=gNr0
-----END PGP SIGNATURE-----

--mfsYPpGuHog5bgZQ--
