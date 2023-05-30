Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D048E71592A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjE3I4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjE3I4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:56:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13C1AB;
        Tue, 30 May 2023 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685436997; x=1716972997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TwJucBXBGUN+OLdeFJgi+mcuaAx9YZFO5Ndm7y/BYEo=;
  b=U0qHK9LxiwQZbZ9hCXAD89q06AWmqYSgKCXQZu/mgQM9d40vwWFF/MDO
   /k0vfi8ShmiHtKhCS6LjY8FC/LDSTqaPerFdk9ovqxWejsUSvpQi3hYUF
   0fxgx8LufWH02Iei+8qiAc/4Ybce39wl5REtFtCiMipBsQuuJIyONb40U
   3TxKGJW8qvixspGVtN8xOCXuBXzkR+Y78IgPBFjRyb35ItcFPJ6h7y8QA
   Xf1pq3aHxhK2yZ/bvV+GPfyNkROnb/0PlLgqSSeKW0dTj1xdQ9hE6A99A
   JzcqLaS6vUnW5QYzj3nmN8XqQdE/z30XhgNg0Sy5lUnSkvUIC7uZZv93O
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="asc'?scan'208";a="216001309"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 01:56:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 01:56:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 01:56:33 -0700
Date:   Tue, 30 May 2023 09:56:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 02/11] pinctrl: stm32: add stm32mp257 pinctrl support
Message-ID: <20230530-payday-gravity-45a26bd7f2dc@wendy>
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
 <20230529162034.20481-3-alexandre.torgue@foss.st.com>
 <20230529-enrich-clammy-14b498baf09f@spud>
 <879b7689-5663-28b5-9431-2fdd243ffff2@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nUFaAWKbUup9Ifzb"
Content-Disposition: inline
In-Reply-To: <879b7689-5663-28b5-9431-2fdd243ffff2@foss.st.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nUFaAWKbUup9Ifzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 10:38:30AM +0200, Alexandre TORGUE wrote:
> Hi Conor
>=20
> On 5/29/23 20:04, Conor Dooley wrote:
> > On Mon, May 29, 2023 at 06:20:25PM +0200, Alexandre Torgue wrote:
> > > Add stm32mp257 pinctrl support.
> > > diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/=
stm32/pinctrl-stm32.h
> > > index e0c31c4c8bca..5e5de92ddd58 100644
> > > --- a/drivers/pinctrl/stm32/pinctrl-stm32.h
> > > +++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
> > > @@ -24,6 +24,9 @@
> > >   #define STM32MP_PKG_AB		BIT(1)
> > >   #define STM32MP_PKG_AC		BIT(2)
> > >   #define STM32MP_PKG_AD		BIT(3)
> > > +#define STM32MP_PKG_AI		BIT(8)
> > > +#define STM32MP_PKG_AK		BIT(10)
> > > +#define STM32MP_PKG_AL		BIT(11)
> >=20
> > Mainly out of curiosity, why have you go duplicate defines for these?
>=20
> Mainly to fit with available packages for various STM32 MPU. Currently MP1
> SoCs are available with packages AB/AC/AD and MP2 series with AI/AK/AL but
> in the future we could have package AB/AC/AD/AI available for a particular
> SoC and then I need to anticipate this case.

Sorry, what I meant was "why have you got defines for these in this
header, when there is an existing set in
include/dt-bindings/pinctrl/stm32-pinfunc.h?".

Cheers,
Conor.


--nUFaAWKbUup9Ifzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHW6KgAKCRB4tDGHoIJi
0kFZAQDNwlhOAKYKGvOi/CDjWW2Mt/BRKIp/vzjgcMjS9EwGVQD9F29KDtdq+WOs
LS3PsjPYYdNc61FM+WOSgjb+Z3y1bAc=
=gjoB
-----END PGP SIGNATURE-----

--nUFaAWKbUup9Ifzb--
