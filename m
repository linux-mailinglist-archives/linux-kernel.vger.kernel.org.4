Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD17149B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjE2MuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2MuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:50:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A115188;
        Mon, 29 May 2023 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685364573; x=1716900573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sihrqxGXOegLfJu5K0vAKoVsedsMzHotWvqPkMnnUEw=;
  b=uDO2Z0sMLsXYOmn1XkSLjoYsvw17laPvRLlTof4rL2JjtyTbblKp9Mze
   wOWWYqnjJeO+q00HWDAUTBzog5p/71Epn9o85LVr8Hg14kF2mpT4IkqxR
   1k7GUNmH1qRvGRw0TFTLSY5PiYS6iTKkLItJUHWk1otmY219kEIrQp/6n
   JkO/WBIug1mUmzs9GkL4L5TUvdU7uintceEFY0rQDNca3vPBvKJTUIO2L
   feiRoE9r+yH//H8YPF+hyET20SOC2ltDNXNKv39sCxfSc0DzOUq/59//w
   s9p+k5KDkIQfu/B4hZiy6JcGHzN1VV915IiWLrSUIHMG/TuakwYAT15o4
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154432424"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:49:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:49:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:48:58 -0700
Date:   Mon, 29 May 2023 13:48:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: timer: atmel,at91sam9260-pit:
 convert to yaml
Message-ID: <20230529-schematic-abrasion-a06a29481ace@wendy>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-3-claudiu.beznea@microchip.com>
 <20230529-chuck-turbofan-a8aabbdd9341@wendy>
 <f4c04190-c90e-bf5f-f666-c979a7aee8ce@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QnBF0FcDx3VBpqKu"
Content-Disposition: inline
In-Reply-To: <f4c04190-c90e-bf5f-f666-c979a7aee8ce@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QnBF0FcDx3VBpqKu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 12:32:49PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 29.05.2023 15:17, Conor Dooley wrote:
> > On Mon, May 29, 2023 at 09:26:02AM +0300, Claudiu Beznea wrote:
> >> +        interrupts:
> >> +          description:
> >> +            Contain interrupt for the PIT which is the IRQ line share=
d across all
> >> +            System Controller members.
> >=20
> > I think you should drop this & the corresponding section below, since
> > both PIT and PIT64 have a single interrupt.
>=20
> OK. Just wanted to emphasize with this that in case of PIT the interrupt
> may be shared with other IPs.

Hmm. Perhaps for the other patch, keep the description then, and for this
one remove the description from the else branch & add explain what "all
system controller members" actually means here? It probably made sense in
the txt binding, but "system controller" has lost its context here.
Maybe something like:
"Shared interrupt between the PIT and other functions of the system
controller, for example, the watchdog, trumpet and airhorn"?

Cheers,
Conor.

> >> +        clocks:
> >> +          maxItems: 1
> >> +
> >> +    else:
> >> +      properties:
> >> +        interrupts:
> >> +          description:
> >> +            PIT64B peripheral interrupt identifier.
> >> +        clocks:
> >> +          minItems: 2
> >> +        clock-names:
> >> +          items:
> >> +            - const: pclk
> >> +            - const: gclk
> >> +      required:
> >> +        - clock-names
> >=20
>=20

--QnBF0FcDx3VBpqKu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSfIwAKCRB4tDGHoIJi
0jihAP9RPI9uRTfWz1IZRSiam+UQ+nEDIQA6miPvid++71X53gD/WqPNahZzotuJ
FT+ZEVVKizduAnFCebdolxza7JIw6Ac=
=16Ml
-----END PGP SIGNATURE-----

--QnBF0FcDx3VBpqKu--
