Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E389D727B15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjFHJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjFHJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:20:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF718F;
        Thu,  8 Jun 2023 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686216025; x=1717752025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ImvKob1XLuKksnBkKdSIUMhiZFOJa0LRyXm3owOpFFY=;
  b=wSerHhqUUwjM2WcctY2xGwEUuasUaqJf95a+HKK7r8y4TpObR+lVuqMs
   auFPKlYHj4gaf+YDTFKVu/axF2hoZDRerFjMuLVBZ2hAPlEOO2lUbIh2g
   BtK6GLme3CBJduKIIzLF2T32us/4U+HXLjyG+DJb9y5ruzu/NkvGDOHcf
   RbPNfsHCwK/ZSznmirYTsJm4NJbfe5pQFhQ0fOTeGJOW7hkrUcNynw5Ve
   i05UYidO8ZX6zU6spc/0ILzgqT3Fmcj2Lnp8NXBYurUsYI3jg8lbljNF5
   Uvu9LteoHzzqR5Z164W2nizvXBz25i1s99wOtigWsx7g/SMV9f/bUODV9
   g==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="asc'?scan'208";a="216828071"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2023 02:20:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 8 Jun 2023 02:20:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 8 Jun 2023 02:20:22 -0700
Date:   Thu, 8 Jun 2023 10:19:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Message-ID: <20230608-steadying-idealism-1f8a97db1491@wendy>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtCTEnlvLCD5pXov"
Content-Disposition: inline
In-Reply-To: <20230608085544.16211-2-quic_tnimkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vtCTEnlvLCD5pXov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tushar,

On Thu, Jun 08, 2023 at 02:25:42PM +0530, Tushar Nimkar wrote:
> This change adds idle-state-disabled property using which certain or all
> idle-states can be kept disabled during boot-up. Once boot-up is completed
> same can be enabled using below command.
>=20
> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>=20
> Cc: devicetree@vger.kernel.org

Firstly, you should CC the dt-bindings maintainers like
get_maintainer.pl would tell you.
Secondly, there are two 1/2 patches in this series.

> Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Doc=
umentation/devicetree/bindings/cpu/idle-states.yaml
> index b8cc826c9501..f999bc666bbd 100644
> --- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> @@ -358,6 +358,13 @@ patternProperties:
>            systems entry-latency-us + exit-latency-us will exceed
>            wakeup-latency-us by this duration.
> =20
> +      idle-state-disabled:
> +        description: |
> +          If present the idle state stays disabled.

> It can be enabled back from
> +          shell using below command.
> +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable

Thirdly, this is operating system specific behaviour, tied to Linux, and
has no place in a binding.

Cheers,
Conor.

> +        type: boolean
> +
>        idle-state-name:
>          $ref: /schemas/types.yaml#/definitions/string
>          description:
> @@ -548,6 +555,7 @@ examples:
>              CPU_SLEEP_0_0: cpu-sleep-0-0 {
>                  compatible =3D "arm,idle-state";
>                  local-timer-stop;
> +                idle-state-disabled;
>                  arm,psci-suspend-param =3D <0x0010000>;
>                  entry-latency-us =3D <250>;
>                  exit-latency-us =3D <500>;
> --=20
> 2.17.1
>=20

--vtCTEnlvLCD5pXov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIGdPgAKCRB4tDGHoIJi
0jYeAQD2vq8CAZyZPfQBYO0XGcZgS5CZfIokwYmVJvMluNX5FgD/VKSusjjBHh15
cAJDaI7n/Zxpka9ImfjHO1sN2deJHgs=
=tiyx
-----END PGP SIGNATURE-----

--vtCTEnlvLCD5pXov--
