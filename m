Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0016608AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjAFVPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjAFVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:15:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9B81D56;
        Fri,  6 Jan 2023 13:15:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE487B81E44;
        Fri,  6 Jan 2023 21:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA7C433D2;
        Fri,  6 Jan 2023 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039697;
        bh=7GNxN3gsKz7ckSvjJ4+A1vUxvCZwJtjbQuQzb2hGY60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMtyeXWabLDMPgMF4+nOH1wV6HSKg/fA7FzabkE8Oe06a4xjktRuyD1Ra74LIiuYZ
         13mSR7oewG0MtNjvuXZarHNbBkH9n4JlmbB43YA1Pu/EB6iEKSZfk39JsDevzOaLNu
         ofI8qty68KhWGF3g5cvXP5fwxMeFCCOkQaHmduL+K73eagHXSYmTEI6MigVViiF4mH
         L35QIi+JDp2m/qvJ6NYiPMyi3i8u95svnXDw9sRZveFtRVf/x9xVN4g/XLFHUu3aoF
         AusAKQh7nH7FK8zSGnLbIi47wx7EA/J0bjnqCRqbgpvj2lrwPFr9AmAi3yPBdkl7Jp
         9IZ1OEItjRWcQ==
Date:   Fri, 6 Jan 2023 21:14:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific
 property
Message-ID: <Y7iPS48viBg0QRok@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BxXeJB9XJtZjxHDf"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-4-william.zhang@broadcom.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BxXeJB9XJtZjxHDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 12:07:55PM -0800, William Zhang wrote:

> brcm,no-clk-gate is a Broadcom Broadband HS SPI controller specific
> property for certain SPI device such as Broadcom ISI voice daughtercard
> to work properly. It disables the clock gating feature when the chip
> select is deasserted for any device that wants to keep the clock
> running.

Why would this property be Broadcom specific?  Other devices could in
theory implement this.

> +properties:
> +  brcm,no-clk-gate:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Some SPI device such as Broadcom ISI based voice daughtercard requires SPI
> +      clock running even when chip select is deasserted. By default the
> +      controller turns off or gate the clock when cs is not active to save
> +      power. This flag tells the controller driver to keep the clock running
> +      when chip select is not active.

This seems problematic with any host controlled chip select support...

--BxXeJB9XJtZjxHDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4j0oACgkQJNaLcl1U
h9BIWgf/dihY/phVPCas+x/J3zN4PzuHT1GA+ZnnnM4zDpB7C5rGVTrCRnw0sCv/
1UAmf6yaPRwRTlfd2OYlVpVzEGhRRgrMkYlJoU/bpzOVIOI00lHE+kJJpDonUWtq
hDQHSwPHxuNBeEa2EP6MFco6q/InCrji4nvDE4VLsH1IMjA6gqpplGDPFzRVAKAX
8dbRqhsk452doujt6sRXYhEkBcOJ+SSddDNMC3tgHeXNPFYjaXaqyPWAIgA7h9qU
IMNCL1wIs/sGb8OTCJa4Yuw4hTbrZceKG1hi73ZQaS++6zw6Y/X1pXKhyxIihc9K
IrlWTZZAn+ZRRQ1BNTz0GL7rqaZ+1g==
=eY8r
-----END PGP SIGNATURE-----

--BxXeJB9XJtZjxHDf--
