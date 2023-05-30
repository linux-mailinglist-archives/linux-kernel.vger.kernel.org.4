Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A1715AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjE3KDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjE3KCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D5F1;
        Tue, 30 May 2023 03:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 751E962CEC;
        Tue, 30 May 2023 10:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F37C433D2;
        Tue, 30 May 2023 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685440973;
        bh=0+SGUOiDQ5nqxSY0Q4GE42XjVvbo4WQnUN2x3XBiXLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDjDwm0gzNDxPM0YLaa6EZgFsIlXnTNFvV6o0KSu/QojbM+Ky9IRLH4YjxWv1RmZF
         RoD1mt5WV7zzVXWKJ3Lu1FHO7vCrvI8sae8ZfsytrVFAflwJk/Vpmfsv4k2XjiZLsZ
         4pCHIS7B46VZKrG+gbwV9T77tNwzcNFOabKC4rTJZIT/H6rFddYlxWWNO+rKcHMe4u
         z0BDgHfu8aAmKX8VLs8wqozA0A832ne2fWdb4+JlhaxqtgQ7aQ2jp2jv8MfEGsIMuW
         vckff0nz2GXQMs/eBrwymwOlz0ZnpqspZ6wfdYC9wr83dfVGY1P39+t+vv47iMcQJl
         95OlhukAsml8A==
Date:   Tue, 30 May 2023 11:02:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Message-ID: <d417628d-7994-4b07-a670-ec14ad938764@sirena.org.uk>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-2-william.qiu@starfivetech.com>
 <87e9ed95-ea57-44c8-85f8-34264b5c6dde@sirena.org.uk>
 <a09cc0c9-ef4e-120f-e61a-94f628d67e38@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OStcWnmwJi2B52q7"
Content-Disposition: inline
In-Reply-To: <a09cc0c9-ef4e-120f-e61a-94f628d67e38@starfivetech.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OStcWnmwJi2B52q7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 29, 2023 at 02:44:13PM +0800, William Qiu wrote:
> On 2023/5/26 23:33, Mark Brown wrote:
> > On Fri, May 26, 2023 at 02:25:27PM +0800, William Qiu wrote:

> >> +        clock-names:
> >> +          items:
> >> +            - const: qspi-ref
> >> +            - const: qspi-ahb
> >> +            - const: qspi-apb

> 	I'm going to change the names of these three clocks to hclk, pclk,
> and ref_clk, as defined in the data book. What do you think?

That looks fine.  ref, ahb and apb would also be fine, it's just the
qspi- prefix that I was querying.

--OStcWnmwJi2B52q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR1yccACgkQJNaLcl1U
h9DfAgf5Ad6LjZ0DMJ0r5lAycWLFFFtfNyz0mTrawQwG8YBWBhOCeCcdPjjJIiUg
NFKMOUJHcx60wG72KuRjERBeDR3xqA7KdREBspEM004CeKMYPUX4WmG9Wt4VNjtJ
Dcrt2QUrhdx8yvc1nf83wj2bF4xxKtI31Y/6zK2dVrrloTXfne04z3Kv3snetvtc
ZICIfgYQzb3Nzi6Uc0ib6CPNh6lEF+liqsPghw1K1TAC4dGLg9yOIxvxv2MEBKBX
dsGCuq4W1fi1Uzm9hQFm+TqjfdKSqCdtaf4insH1t7KI8ih60bcUuKC2R/NeK8FG
VqH2t0tD1RUh562zh4jZBFepUEaJpg==
=SLrS
-----END PGP SIGNATURE-----

--OStcWnmwJi2B52q7--
