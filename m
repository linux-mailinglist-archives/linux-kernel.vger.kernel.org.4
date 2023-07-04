Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67B747A23
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGDWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGDWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA210DA;
        Tue,  4 Jul 2023 15:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B705C611E2;
        Tue,  4 Jul 2023 22:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F133FC433C8;
        Tue,  4 Jul 2023 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688509414;
        bh=UgTDdViy1/awgvU32jQWoQqMz3aYBpHqsQN3TpWOtj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UP01IKsINQtFXG8k+1ZU8Q42b9H44Zq5I4YknUGeIpQma1H09OL8rd5PbPT55706F
         uCRNzf6YqhtLV8KHI9GPjp+54oBV2p0lRNmoQZZMsPn4t8lxGGzn37t+MLQLOs0PH8
         TKP7DsLRPrgTwFDL4XljZU5gKUgP9lxZ3Rlm79CjXaQRx2H76CR975OV09BtwxGAq/
         5fUcnqwx/3QUtBZWUmeiTo3lU+bM4pw2d1gu/hRv6PMJMB04T2neZVKGYN/mbhAF25
         gSm/nEyXKUEI0aLDe+X2bNOQG7NpCi/T7YgDA/+lP32elNVOr+htdfkQ/W7Q8VxBlD
         /ADXlHJvEhyaA==
Date:   Tue, 4 Jul 2023 23:23:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH v6 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL
 clock inputs
Message-ID: <20230704-tingling-automaker-22460e884793@spud>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
 <20230704064610.292603-4-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="moQ3gT+gahpFttN/"
Content-Disposition: inline
In-Reply-To: <20230704064610.292603-4-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--moQ3gT+gahpFttN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 02:46:06PM +0800, Xingyu Wu wrote:
> Add PLL clock inputs from PLL clock generator.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

As expected this produces warnings for the existing, in-tree,
devicetrees which go away when the later dts patches are applied.
It'd be good to mention that its intentional if you end up sending
another version of the series.

Otherwise, this looks good to me too.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/clock/starfive,jh7110-syscrg.yaml | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-sysc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.ya=
ml
> index 84373ae31644..5ba0a885aa80 100644
> --- a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> @@ -27,6 +27,9 @@ properties:
>            - description: External I2S RX left/right channel clock
>            - description: External TDM clock
>            - description: External audio master clock
> +          - description: PLL0
> +          - description: PLL1
> +          - description: PLL2
> =20
>        - items:
>            - description: Main Oscillator (24 MHz)
> @@ -38,6 +41,9 @@ properties:
>            - description: External I2S RX left/right channel clock
>            - description: External TDM clock
>            - description: External audio master clock
> +          - description: PLL0
> +          - description: PLL1
> +          - description: PLL2
> =20
>    clock-names:
>      oneOf:
> @@ -52,6 +58,9 @@ properties:
>            - const: i2srx_lrck_ext
>            - const: tdm_ext
>            - const: mclk_ext
> +          - const: pll0_out
> +          - const: pll1_out
> +          - const: pll2_out
> =20
>        - items:
>            - const: osc
> @@ -63,6 +72,9 @@ properties:
>            - const: i2srx_lrck_ext
>            - const: tdm_ext
>            - const: mclk_ext
> +          - const: pll0_out
> +          - const: pll1_out
> +          - const: pll2_out
> =20
>    '#clock-cells':
>      const: 1
> @@ -93,12 +105,14 @@ examples:
>                   <&gmac1_rgmii_rxin>,
>                   <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>                   <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> -                 <&tdm_ext>, <&mclk_ext>;
> +                 <&tdm_ext>, <&mclk_ext>,
> +                 <&pllclk 0>, <&pllclk 1>, <&pllclk 2>;
>          clock-names =3D "osc", "gmac1_rmii_refin",
>                        "gmac1_rgmii_rxin",
>                        "i2stx_bclk_ext", "i2stx_lrck_ext",
>                        "i2srx_bclk_ext", "i2srx_lrck_ext",
> -                      "tdm_ext", "mclk_ext";
> +                      "tdm_ext", "mclk_ext",
> +                      "pll0_out", "pll1_out", "pll2_out";
>          #clock-cells =3D <1>;
>          #reset-cells =3D <1>;
>      };
> --=20
> 2.25.1
>=20

--moQ3gT+gahpFttN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKSb4AAKCRB4tDGHoIJi
0mP6AQDmJ5AWe304kFicAoMhDUQFz3DM3yboaw3sS/h4Hqn5cgEA7YVjLYsd40eM
xMJd2TNxa7X70zPGx7MTA2AeS/5DlgU=
=WZiY
-----END PGP SIGNATURE-----

--moQ3gT+gahpFttN/--
