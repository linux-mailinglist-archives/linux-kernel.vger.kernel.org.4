Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2D70E4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbjEWStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjEWStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E591;
        Tue, 23 May 2023 11:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF1F61D46;
        Tue, 23 May 2023 18:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77566C433D2;
        Tue, 23 May 2023 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867749;
        bh=iKyVdrNdupf6FLPN38zfHmfs/Nd6a0SWOFcdapufsBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhGWyFqAUIiIiIEpykYA95zO4MY9L61Oq6pg8Y7hxTBcJJri5cml0pw55QB3duh2i
         dfpVTdmg6UqqQPTkuFyxRdPoZCRsXQDzgPwEdodP4AcZJVnR/m9abkpHwT3sIfppTd
         HRPIvcW7z05HZa+SmBu9zqJRkpphUr0DPiilbxK2JKy25CZgD4LJuDRJ9GSMRJxZts
         tudUfwoWs/DFroseSdgeHbi2/pFC4hKtT9IMjrs16E8L8MFSryUKuKChW9XHe+mP7k
         osPPBjyzC9Zlac4gM0wCs0hfG+wTxc7J0p0VWFer+3rLsRLHKJDKshY1A1wXZOW0qS
         ZNfW9nD4Rs7og==
Date:   Tue, 23 May 2023 19:49:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230523-remission-ageless-0880ed49765d@spud>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
 <20230523061512.195271-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WWGOvCNCU6jCwAEm"
Content-Disposition: inline
In-Reply-To: <20230523061512.195271-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WWGOvCNCU6jCwAEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Tue, May 23, 2023 at 09:15:11AM +0300, Claudiu Beznea wrote:
> Convert Atmel SAMA5D2 shutdown controller to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  63 ----------
>  .../power/reset/atmel,sama5d2-shdwc.yaml      | 114 ++++++++++++++++++
>  2 files changed, 114 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,s=
ama5d2-shdwc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-=
shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-sh=
dwc.yaml
> new file mode 100644
> index 000000000000..613668d6099b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Same comment on the license here. Figure you need a Rob Ack.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SAMA5D2 SHDWC Shutdown Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description: |

Also, you don't need the | if you do not need to preserve formatting.

> +  Atmel SHDWC shutdown controller controls the power supplies VDDIO and =
VDDCORE
> +  and the wake-up detection on debounced input lines.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,sama7g5-shdwc
> +          - const: syscon

^ you should probably mention in the commit message where the syscon
came from, as it doesn't appear in the txt binding AFAICT.

> +      - items:
> +          enum:
> +            - atmel,sama5d2-shdwc
> +            - microchip,sam9x60-shdwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  debounce-delay-us:
> +    description: |
> +      Minimum wake-up inputs debouncer period in microseconds. It is usu=
ally a
> +      board-related property.
> +
> +  atmel,wakeup-rtc-timer:
> +    description: enable real-time clock wake-up
> +    type: boolean
> +
> +patternProperties:
> +  "^input@[0-15]$":
> +    description: |
> +      Wake-up input nodes. These are usually described in the "board" pa=
rt of
> +      the Device Tree. Note also that input 0 is linked to the wake-up p=
in and
> +      is frequently used.
> +    type: object
> +    properties:
> +      reg:
> +        description: contains the wake-up input index
> +        enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ]

Same here with minimum & maximum, no?

Otherwise, this seems fine to me...

Cheers,
Conor.


--WWGOvCNCU6jCwAEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG0KoAAKCRB4tDGHoIJi
0kdhAQCskLgP2mlO/lNxcX/CGR6mGvWUEPUc12bU7z8iCSk3TQEAiudITCr1jawD
4NCyoquvEKgbjWtwsLyE6VyjqrF5Sgc=
=4RFH
-----END PGP SIGNATURE-----

--WWGOvCNCU6jCwAEm--
