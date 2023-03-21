Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF96C3D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCUWJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCUWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:09:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9DE05C;
        Tue, 21 Mar 2023 15:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98F76B81A45;
        Tue, 21 Mar 2023 22:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E3FC433D2;
        Tue, 21 Mar 2023 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679436556;
        bh=jywNbEZP25XOTZg0s8YbV2eIX3RE5vkLLBPIK+u/ySE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrkUUZGKD1eXCrJftt1lQn8XiF7fLosApLIr0bnxzYnVCQzSaA5xwod/LCwwbW8Z/
         HfOnGOfFvlQ4hAIQQGLiXy0kdtfEoHQVz8qMn0AnvhH9YNTdwNe9m58oVCxpJuvoQM
         hUVoCDNzo6aPaf8cYlH7QN8rKKxmVO6EYOUW71f9imbQ3RfChI790fIW5r+LzB8g47
         59uW5gGnYIAJQ4csIoP1a4dF9qKKf036CjK6UU5TQG7RRpVsQ7Q+Id0lxJ3RPxQdc3
         8RiLwzTmqfRvDCbgPKUD1xxBh0KIkKoCvq4RAAbhPM2QgMvWu5rZx+fmQo6i+g5Xrf
         lp5RpbvNlPGwg==
Date:   Tue, 21 Mar 2023 22:09:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 01/10] dt-bindings: serial: snps-dw-apb-uart: Switch
 dma-names order
Message-ID: <5287504e-c0f7-4964-8a61-fd49b7ee9547@spud>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyWiahmxEjVuYmMu"
Content-Disposition: inline
In-Reply-To: <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyWiahmxEjVuYmMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 11:56:15PM +0200, Cristian Ciocaltea wrote:
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwinner
> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
> reverse of what a different board expects:
>=20
>   rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
>=20
> A quick and incomplete check shows the inconsistency is present in many
> other DTS files:

> The initial proposed solution was to allow a flexible dma-names order in
> the binding, due to potential ABI breakage concerns after fixing the DTS
> files. But luckily the Allwinner boards are not really affected, since
> all of them are using a shared DMA channel for rx and tx:

> Switch dma-names order to tx->rx as the first step in fixing the
> inconsistency. The remaining DTS fixes will be handled by separate
> patches.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for doing all of the switch overs too. I should've probably
broadened my searching beyond the allwinner platforms when I initially
added this, so yeah, thanks.

> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 2becdfab4f15..d28cc96fa8e9 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -72,8 +72,8 @@ properties:
> =20
>    dma-names:
>      items:
> -      - const: rx
>        - const: tx
> +      - const: rx
> =20
>    snps,uart-16550-compatible:
>      description: reflects the value of UART_16550_COMPATIBLE configurati=
on
> --=20
> 2.40.0
>=20

--yyWiahmxEjVuYmMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBorBQAKCRB4tDGHoIJi
0vyGAQDrKXra/8V/UIFrQD3UAgVFLRIkAIlnoCWPSGwe9HVDMAEAwe3VgGkUrGcQ
QDMvCe69akSjd+Fl/v/4b8852K/B+AI=
=VkVV
-----END PGP SIGNATURE-----

--yyWiahmxEjVuYmMu--
