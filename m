Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B774105C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjF1LsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:48:24 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:57412 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjF1Lr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:47:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39753612CC;
        Wed, 28 Jun 2023 11:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067DEC433C0;
        Wed, 28 Jun 2023 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687952875;
        bh=Q1FhBIvMRelAU3h4x0qiEZ2oX2C87xJQ3oF5cUFma94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1rhz9yINX4ma+xMgKtFDDwFQsuJcxD4UwoeVhDY7p/GDP1fxbxbKTWhEikuIFnTw
         NQ3KuaXxw1ZlatyzefvArcs0tDxZ4kwyZemqIQ7qn1/OGYksi7vLiAkl2XwUPJEbbO
         p0WkNLeemmMBKlJFKs+uc+qMXS5gVssFo144SVbVqIltOOc9IZT0B6SNOiUkQviWSM
         FT1f+BCe1LEJ3YRGpPcLBu4um+uW7UofRWcIdrS2Xy46AnX3+9MoMl878mk96V5SYB
         c10+jDC2eeh9jpQCa/jUubWS1I7OKA36hXWobtM9u/1U8jOIo2JRwb7Rt3qjthShuE
         MAYxsQ+Qc0PjA==
Date:   Wed, 28 Jun 2023 12:47:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: rt5739: Add DID check and compatible for
 rt5733
Message-ID: <2a8732f4-13fe-476d-9ae7-b970bd82c218@sirena.org.uk>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
 <1687942037-14652-3-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dZp7zQbwpodH2L5a"
Content-Disposition: inline
In-Reply-To: <1687942037-14652-3-git-send-email-cy_huang@richtek.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dZp7zQbwpodH2L5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 04:47:17PM +0800, cy_huang@richtek.com wrote:

> +	if (did == RT5733_CHIPDIE_ID) {
> +		min_uV = RT5733_VOLT_MINUV;
> +		max_uV = RT5733_VOLT_MAXUV;
> +		step_uV = RT5733_VOLT_STPUV;
> +	} else {
> +		min_uV = RT5739_VOLT_MINUV;
> +		max_uV = RT5739_VOLT_MAXUV;
> +		step_uV = RT5739_VOLT_STPUV;
> +	}

It would be better to write these as switch statements so if any more
variants turn up they can be added more easily.

--dZp7zQbwpodH2L5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScHeUACgkQJNaLcl1U
h9CKKgf/eMaIvJ+GA0vHvvKksA4S1NUI7q/j1CaaMTXgwqcv9WCmMdTEZWJHb5GC
sPxe1EOuqiz0RpkDk2NDzgYyUcJGNnY/cdhhYSaejkaaCHToEvz+sSZex642DVRQ
mvwJrxVNlVKFWh7ZQbaqEjpKxy4cSLcaWI4PVq8BFIfS5QzxD04Xq1fqaZu7soSi
Wmvn+XjxALwUEYCtlzDu2m/xncpWC3bcy+3t9lh/44lhwpWTM2keR5NQ7jZj1akB
1X3jGXBOIzfjPPCUxEpgviXVVJik2w9wjUMHNa2FD7ub679cLdACJGL7gH4/CUv3
Xz8F3/FpOBZcDe7otdRBIHTYTMfSPA==
=e51C
-----END PGP SIGNATURE-----

--dZp7zQbwpodH2L5a--
