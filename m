Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C5F748DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjGETZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjGETZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51804C03;
        Wed,  5 Jul 2023 12:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1460C616CC;
        Wed,  5 Jul 2023 19:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3813CC433C7;
        Wed,  5 Jul 2023 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688584990;
        bh=XkVpsUMAas5eIwMCK29P6mupS9x7AHoqzqeWqww4zek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNl7MYi731YwNgsgM/VwIqWPCoZUNk0bnt3+OStb36lZZCm+6qhcnoPIgV5j+ziht
         hVr94DU8Jay65as+NyTdkTyby1mDqoTxh1IjK1SHgJSbHhCGbwi5pNEGv8sMiOByOh
         GKDQZHyNXX+mpxM2tpRqOn4YfMtGFVhZ4qrLn9OBxraO1IZwBGCiSBuzuJTbnkYGXI
         lqnMqho2MgW3jb/iSaYQTBHqlsR2P1tvYKXreKn4uenMO9QoTIT6MRg3nkvq+27Jds
         24ZU6wAVtUcid427JvedRqKRIxbIuzDoaI7Nvy33/HD/uvStyPDZaQfCx/8pW2Rzwx
         +IGEg0bKCFjDw==
Date:   Wed, 5 Jul 2023 20:23:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] ARM: dts: omap4: embt2ws: Add audio support
Message-ID: <9014a59b-5972-484e-ac70-c013e049b140@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pcNKJC6KNSizl/+7"
Content-Disposition: inline
In-Reply-To: <20230705190324.355282-4-andreas@kemnade.info>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pcNKJC6KNSizl/+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 09:03:24PM +0200, Andreas Kemnade wrote:

> +	sound {
> +		compatible = "simple-audio-card";

For new usage audio-graph-card2 is preferred, it's a superset of the
functionality and much more flexible.

> +		simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3x>;
> +			system-clock-frequency = <24000000>;
> +		};
> +	};

Are you *sure* the BCLK always comes out at this rate?

--pcNKJC6KNSizl/+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlwxcACgkQJNaLcl1U
h9AxHQf/dak+OKZYRo/pero4Ava2YorLLQDCh8ADYq1T+GPQnaWaBTdq0golyC18
AlqjHoluidxXdpB3UWSe9x0dlvNCpGCuVXnlWOTXDEG8DSK3S0PPbbNEEslMQh8c
SBLHqRGCn2PQkurZiWVJYHRmkM79+HlVSC58kHit3ErbDsesSCrdyPSAl8UspAo7
/jtUhvbU7+NmPj9DQ7JDwdJrQouIel015F1YmjLPHBzlMecQ0kernj55wb0l0K/N
ytyuHhQyyadBVaGh0x9EoctC3/Nbk1ETR45Xlg9eIlSGwUTnyDzF/PhmlT9CVj6s
ZrL++EXT411pHGrqVeBIgUE9Ht9fpg==
=QPu1
-----END PGP SIGNATURE-----

--pcNKJC6KNSizl/+7--
