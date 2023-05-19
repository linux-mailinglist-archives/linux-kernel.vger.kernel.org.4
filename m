Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99A709C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjESQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D38F;
        Fri, 19 May 2023 09:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3B765937;
        Fri, 19 May 2023 16:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D044C433EF;
        Fri, 19 May 2023 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684513777;
        bh=cO6StIidaESxZ9kWWRmaxDEVVAfI+i5D8OvevReKs60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkTa8JVNDPha/XjnnDrGFHxlpapc5C6U7TQZFgETv+eZA6nN6nfdqiSpQT/psKEEz
         tRW9pwSW148Zgx/L1Kc9+6rsBL3ztrT6wY+RC4ASnGfn/BwatLhVBYd0QrmBXtgkQd
         nkgrFGN6mtqzhhfwGV8zVNQxa11LhxtfjfvGA3c5yl1BeP8mBIvPMT7mYAiYjvZOhq
         m+3TRv2PBfBz6UhYrARsLysxqj4wsW6SAH5SdAEDSIdj0CUpWtAd/ppOM0b/VVjzxw
         YtUWFL4X8RgoE6CLUX8Z1vTjyI0PVwWaRZSmjD5WoZtnzv7so11eKPZtov/QZNyEtY
         AGsFJHtC+HKMw==
Date:   Fri, 19 May 2023 17:29:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     conor+dt@kernel.org, support.opensource@diasemi.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Message-ID: <20230519-tables-stoppage-51c998e0421c@spud>
References: <20230519092321.26915-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17iPMXSczGXY/rl6"
Content-Disposition: inline
In-Reply-To: <20230519092321.26915-1-David.Rau.opensource@dm.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17iPMXSczGXY/rl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey David,

I think some wires got crossed here - what I meant was send 2 patches in
a series, where one did the conversion and the other added the new
property.

On Fri, May 19, 2023 at 09:23:21AM +0000, David Rau wrote:
> Convert Dialog DA7219 bindings to DT schema format.
>=20
> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>

> +  interrupt-names:
> +    oneOf:
> +      - items:
> +          - const: wakeup
> +      - items:
> +          - const: irq
> +    description:
> +      Name associated with interrupt line.
> +      Should be "wakeup" if interrupt is to be used to wake system,
> +      otherwise "irq" should be used.

Hmm, that is not quite what I meant. I was thinking that you could
add itemised descriptions for what the individual behaviours are.
But on reflection, how about:
  interrupt-names:
    description:
      Should be "wakeup" if interrupt is to be used to wake the system,
      otherwise "irq" should be used.
    enum:
      - wakeup
      - irq

> +
> +  wakeup-source:
> +    type: boolean
> +    description:
> +      Flag to indicate this device can wake system (suspend/resume).
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 2
> +    maxItems: 2

I was thinking
clock-output-names:
  - items:
      - const: WCLK
      - const: BCLK
(assuming I didn't misunderstand the text binding!)

> +    description:
> +      Name given for DAI word clock and bit clock outputs.
> +
> +  clocks:

    maxItems: 1

> +    description:
> +      phandle and clock specifier for codec MCLK.
> +
> +  clock-names:
> +    const: mclk

> +      dlg,jack-det-rate:
> +        enum: ["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]

The "s here are not needed btw, the other enums in the tree described
like this (that use strings) avoid the "s.

Thanks & apologies for the confusion,
Conor.

> +        description:
> +          Jack type detection latency (3/4 pole).
> +        $ref: /schemas/types.yaml#/definitions/string

--17iPMXSczGXY/rl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGej7QAKCRB4tDGHoIJi
0qhMAP0UQUBLP3rRh9+fsSVNXLEsKmJvateo000gx8LaIls4xQD/bRjAsk0YVjbg
j4Q26gB4g/gUmLVzrEmo3x2pCdAIzQs=
=tJz2
-----END PGP SIGNATURE-----

--17iPMXSczGXY/rl6--
