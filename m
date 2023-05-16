Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1B704D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjEPMBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEPMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:01:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13E44AA;
        Tue, 16 May 2023 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684238480; x=1715774480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MkgobwPTSWoToec9i45GpRXlMt8+RnGcFPDnD9ytMaA=;
  b=CC1CaOLVx4pfc5YQdEedRq3kX4pw1tvGB2CqChiLaUZLNsCBpSHfz3oD
   rIrVrZEgTvJEEnaRGcuRV45yG+CEaXrjbw+QIyMgyWi2b0gth6G2IeWFf
   dSRrCuvc6hWIGEvIVwqxCsD7ouJ8VetcM3fRb4weUeUcf3l+kGsVpVvyj
   +MTNHJpQnitxtb82b4SUXgbNUjjqqSV1Op0t+HzuvmtTXfCnZz6lWaOuv
   no/V7YfQYjpy5u6oxTxRws6thETWk+lE5ITYD6txKVtc8btTsTV7fsfXe
   K/aM73DiRn0ta36sVaPNm8LrSAlLNFhLLivSxc2PayUeP+J4DDQZ4Q8tS
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="213511896"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 05:01:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 05:01:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 05:01:17 -0700
Date:   Tue, 16 May 2023 13:00:57 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Message-ID: <20230516-modulator-reason-1d3a754c6dd7@wendy>
References: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
 <20230516051836.2511149-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/p49LlXOSFYXPS6l"
Content-Disposition: inline
In-Reply-To: <20230516051836.2511149-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/p49LlXOSFYXPS6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Claudiu,

On Tue, May 16, 2023 at 08:18:33AM +0300, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml. Along with it clock names
> were adapted according to the current available device trees as
> different controller versions accept different clock (some of them
> have 3 clocks as input, some has 2 clocks as inputs and some with 2
> input clocks uses different clock names).
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> new file mode 100644
> index 000000000000..e5f514bc4bf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Power Management Controller (PMC)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  The power management controller optimizes power consumption by controlling all
> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
> +  to many of the peripherals and to the processor.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91sam9g20-pmc
> +          - const: atmel,at91sam9260-pmc
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15-pmc
> +              - atmel,at91sam9g25-pmc
> +              - atmel,at91sam9g35-pmc
> +              - atmel,at91sam9x25-pmc
> +              - atmel,at91sam9x35-pmc
> +          - const: atmel,at91sam9x5-pmc

Yet another combinations question for you...
With this binding the following is not possible:

"atmel,at91sam9x5-pmc", "syscon"

Is that intended?
I notice "atmel,at91sam9260-pmc" is able to appear as:

"atmel,at91sam9260-pmc", "syscon"

So the inconsistency stands out.

> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91rm9200-pmc
> +              - atmel,at91sam9260-pmc
> +              - atmel,at91sam9g45-pmc
> +              - atmel,at91sam9n12-pmc
> +              - atmel,at91sam9rl-pmc
> +              - atmel,sama5d2-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d4-pmc
> +              - microchip,sam9x60-pmc
> +              - microchip,sama7g5-pmc
> +          - const: syscon

Otherwise, this looks grand to me.

Cheers,
Conor.

--/p49LlXOSFYXPS6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGNweAAKCRB4tDGHoIJi
0klMAP0feKg5Rk+Yx1hTTlWBFl+34Zjsn4gGKdFx2Qpcp5s4OwD+IIa9fAnSmOd/
OrjaQNfj+Ol17iJGt9+PsDIjVzpxsQE=
=6H0j
-----END PGP SIGNATURE-----

--/p49LlXOSFYXPS6l--
