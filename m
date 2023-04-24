Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B86ED1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjDXPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8F4C2E;
        Mon, 24 Apr 2023 08:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5E2D61E42;
        Mon, 24 Apr 2023 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33B8C433D2;
        Mon, 24 Apr 2023 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682351686;
        bh=wJkYfjrjra0oygKVxhm3cneeeeb81vFNJgDbqDD4x/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKVPFNaiobdBlPggFdCm4fMaA70Bwfx5gFduFin18Oc7ek30AwXrnOgiur+RWxOLq
         hH7m8fsB+ytX802FIYddCfco3PncnPbP2YVvtwBZMx5YInKV8NfmDoT+99bt+uW5Cb
         5DDHqW01tZDSRX003TaIw9wSJiOob0wWdUmq5TdzKz39gfWgrX86fI3qXIG0VnPVc/
         joR1T7gEIkATxSn0sB9rRKnyBv5gcw87UQJ+fQMwCY7jEGASR/99YXxtTWcMINhFQy
         ELzcRLdqxnCrJLCvzsK39NxTk0eaF81FpYpmRn5gWMOzi3Ejmf3T7GDcu3UIPgKKbd
         DdnlsdgCD2bmQ==
Date:   Mon, 24 Apr 2023 16:54:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/43] dt-bindings: spi: Add DT bindings ep93xx spi
Message-ID: <8f02b54d-00c5-4328-9e14-ef77097eaabe@sirena.org.uk>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-17-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqO6L1/B8uJqiHh5"
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-17-nikita.shubin@maquefel.me>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqO6L1/B8uJqiHh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2023 at 03:34:32PM +0300, Nikita Shubin wrote:

> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

This needs to be someone who actually knows about and works on the
device.

> +  use_dma:
> +    type: boolean
> +    items:
> +      - description: Flag indicating that the SPI should use dma

There don't seem to be any DMA properties here, and why would this not
just be done by making them optional rather than having a separate
specific property?

--qqO6L1/B8uJqiHh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGpj8ACgkQJNaLcl1U
h9AJmgf+KXQLmqdIYxw937OjV3lA3I+LWg+c5T7eV9/GTC08qMz1dWlkvIAy3C9l
Zf3T7Y8WCHTQIJcAHz/DablFp9op7PMnBk3YMxEH32qr4+JcDyGB4uhloIsj2puf
qc7xycstyS+GhCGHoo9y1FCElIF3xi2XqE//Yg22s4rKnkxabo+ddWDXdT9QlT1D
+CPsKO6yR/b3l6q4N6R6C/I8aXKLwa+muRwek7lETtgvXwPdD4CCe31rT7eCp+GA
KlZWNJ5Kc61LRt+ngTYI92IwwuAXyqWlm5Q9NmMW2PDBmpybWNZmIftxQoJ+gNwf
JS8iUhhQSOSW8DmsoK+oa+RZiorSZg==
=+SnN
-----END PGP SIGNATURE-----

--qqO6L1/B8uJqiHh5--
