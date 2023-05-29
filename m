Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759371495A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjE2MVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjE2MVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:21:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4340EA;
        Mon, 29 May 2023 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685362897; x=1716898897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sl777DPq/HAQKybwJRnFzBb4enqhQ3q5YhCuB/mguc=;
  b=VeP5Bm/Y44i1ObTt14nfWP+l6qW4T4VSNBeprefHRErb63qCYepuwT6N
   0SBgfCHz3Z6sGqXwuQGigmkCAIG1/H8n/pHC8ZahH60c3ATMD0VJepcOp
   Z/1cbgyiQQnPwjXlC3O93x1A+fJ9Fgtd119aZE7tM8aK3pWv2/n8D/HIS
   c/Wgd81lEGSIDK/5Y/8nKi2PMcShfBF789XbsTsoBdnUwM5gKtgNYYlRh
   4vKKbssYKhnuflpkKKivRf6UTFXCbvLRXYgLOXDKqFuSB0y670fW8/aNz
   VRcGZ7aVFWn9msQ474CfSi8WMR7LP21xnzPoF2mENOjumAOwpBnnW0s7d
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154424360"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:21:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:21:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:21:32 -0700
Date:   Mon, 29 May 2023 13:21:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: watchdog: atmel,at91rm9200-wdt:
 convert to yaml
Message-ID: <20230529-register-uneaten-5035f7130fca@wendy>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zJaeWXQJTVpJG0U"
Content-Disposition: inline
In-Reply-To: <20230529062604.1498052-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2zJaeWXQJTVpJG0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Mon, May 29, 2023 at 09:26:03AM +0300, Claudiu Beznea wrote:
> Convert Microchip AT91RM9200 system timer watchdog bindings to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91=
rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91=
rm9200-wdt.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.=
yaml
> new file mode 100644
> index 000000000000..592e797df4c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91RM9200 System Timer Watchdog
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.coam>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91rm9200-wdt
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog {
> +        compatible =3D "atmel,at91rm9200-wdt";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-=
wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.t=
xt
> deleted file mode 100644
> index d4d86cf8f9eb..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -Atmel AT91RM9200 System Timer Watchdog
> -
> -Required properties:
> -- compatible: must be "atmel,at91sam9260-wdt".
> -
> -Example:
> -	watchdog@fffffd00 {
> -		compatible =3D "atmel,at91rm9200-wdt";
> -	};
> --=20
> 2.34.1
>=20

--2zJaeWXQJTVpJG0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSYtQAKCRB4tDGHoIJi
0s6/AQC/y0vRbaeXHpMWnxKhswKDHWD3Ln09rcbGQJlEJAbhgwEAxwxBSCSJ+999
Ch45eddzDjENMbmk0otBGgPzl5RENQM=
=GnX9
-----END PGP SIGNATURE-----

--2zJaeWXQJTVpJG0U--
