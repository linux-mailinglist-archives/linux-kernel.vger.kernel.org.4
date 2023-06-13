Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56FF72EB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFMTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbjFMTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9BED;
        Tue, 13 Jun 2023 12:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C2B6399A;
        Tue, 13 Jun 2023 19:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0553FC433F0;
        Tue, 13 Jun 2023 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686683171;
        bh=JVKNrqDZfREE/1K1QquNLqZUTAYZnNkSzqm/PaREPsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+36+jPZTAltXrM/lDBUwXgSMLpX4CeqEC8/CHrmQR9FAwMTmfwBGJJfoe1idMxCk
         eIPVuTFphnleBAd+/rpRQXkvE+QQ2A3NtLmYyiZ/wO8SQsdvQ4V6GL/aWiCGzNyXOS
         9+p/FKK7EinYAza1QjeiBSoLlnH3giRpDEPVCWp9/8fbL/ddUgtq6uOagW4b1dJjSr
         sD7xdMaehaHoxflnunHDnMyqxfyOR31UXU3Yfm6MqzPhkHTo2OSZgGneTXcJIMNyQ0
         eURsSWboWmfqJlOV6ZY6bidlsTU5wH1ze4UCnxlMGmw6qAz5ZpW9fgoGuv0ook8r5V
         0ljaEBGAgCmow==
Date:   Tue, 13 Jun 2023 20:06:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230613-surrender-surcharge-8778867e58c1@spud>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-2-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V86L6w1gIPDva+D3"
Content-Disposition: inline
In-Reply-To: <20230613125852.211636-2-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V86L6w1gIPDva+D3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Xingyu,

Couple nitpick items to be fixed if you resubmit.

On Tue, Jun 13, 2023 at 08:58:46PM +0800, Xingyu Wu wrote:
> +  This PLL are high speed, low jitter frequency synthesizers in JH7110.

nit: These PLLs are

> +  Each PLL clocks work in integer mode or fraction mode by some dividers,
> +  and the configuration registers and dividers are set in several syscon
> +  registers. So pll node should be a child of SYS-SYSCON node.

nit: Each PLL can work in integer or fractional mode, with controlled by
configuration registers in the sys syscon.

> +  The formula for calculating frequency is that,

nit: s/ that//

> +examples:
> +  - |
> +    pll-clock-controller {

nit: s/pll-//

> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt=
-bindings/clock/starfive,jh7110-crg.h
> index 06257bfd9ac1..086a6ddcf380 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -6,6 +6,12 @@
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> =20
> +/* PLL clocks */
> +#define JH7110_CLK_PLL0_OUT			0
> +#define JH7110_CLK_PLL1_OUT			1
> +#define JH7110_CLK_PLL2_OUT			2
> +#define JH7110_PLLCLK_END			3

Please CC me on the patches fixing this for U-Boot :)

Nitpicking aside, which only needs to be fixed if you end up submitting
a new version for other reasons,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--V86L6w1gIPDva+D3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIi+HQAKCRB4tDGHoIJi
0s2YAP9fY80PpW7x8lDibgVYA9PDnGUbJY/AkWQnjg1rf9TwwwEAqBCba6ZRQKlo
zxhNvp+yHUur3Xea7D25AcZmYwEwkwI=
=lL9I
-----END PGP SIGNATURE-----

--V86L6w1gIPDva+D3--
