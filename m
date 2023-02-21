Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BED69E5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjBUR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjBUR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:27:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4B1DB88;
        Tue, 21 Feb 2023 09:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 318B9B8101F;
        Tue, 21 Feb 2023 17:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E370C433D2;
        Tue, 21 Feb 2023 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000418;
        bh=cU3JZqMV8I3eS5IY8uyBVDPij+HEK0bbMqGZL/n+ibs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBd6XKzZRC4zypG8/Sv9m1DgSz4NXl7JmiIuHWIdOoGLcVmFuqzGWIz8lLvasbrmt
         OmUOGbn9LJUJN4DPV5G3c5OnfUoTQLc9dNe1lJJ1bJepKb5xd66OaYofBoS3C5Rg4G
         OWRJmZ3CnCBdG8XWXsySLYKz3QqeF16N5EXUQpkzJyPtXp6ribvWPcfiDyBUaeV9Ze
         8bqx8Zhjwvbvx1hDMrUGIXo92NL5iuUbhDXRVJqEyNhKnsaTpEjrBe/DxHm3phNFeg
         pV1g/a14ODF7PXArEtZf35UTxyq8MAopmkMH8DvhvsAz/9p4+nAfgAyHcnrwTe1iwW
         5KnBkidNZ01IQ==
Date:   Tue, 21 Feb 2023 17:26:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Message-ID: <Y/T+3H8A7jrX+I9M@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-11-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwaipNMKG/E3gxwR"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-11-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwaipNMKG/E3gxwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:46:36AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.

> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: RTC Oscillator (32.768 kHz)
> +      - description: GMAC0 RMII reference
> +      - description: GMAC0 RGMII RX
> +      - description: STG AXI/AHB
> +      - description: APB Bus
> +      - description: GMAC0 GTX

Ditto here, are some of these clocks, especially gmac0, also optional?

> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: rtc_osc
> +      - const: gmac0_rmii_refin
> +      - const: gmac0_rgmii_rxin
> +      - const: stg_axiahb
> +      - const: apb_bus
> +      - const: gmac0_gtxclk

--uwaipNMKG/E3gxwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/T+3AAKCRB4tDGHoIJi
0lMNAQDqgVssSvoD3wO1kWvaRRB+UiE+OxXFzbBA7J4AeUX9hgEA+XWwcgAbEcF4
SWAUhBnnb6ev3bxrmG4+m7rCyVZ9og4=
=Az7l
-----END PGP SIGNATURE-----

--uwaipNMKG/E3gxwR--
