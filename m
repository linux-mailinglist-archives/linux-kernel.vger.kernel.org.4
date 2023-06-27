Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C573F5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjF0H1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjF0H1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:27:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA2271E;
        Tue, 27 Jun 2023 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687850791; x=1719386791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLczvW7sUK4LxM+v+inLe8on89ihdEZup77Ibi1FUik=;
  b=jOtkh+aTnNKi69dSzxnPTKRiY+WEISACSEXmpGIyKo7PLp5tOOPqdR1f
   GmuRebwRuSYiqRmjsjzEGc0W37Srl1oZ/yzy//hm4TNgg0jXaKTyiIR6t
   iRTPzs45xjyxankTfAwkKo/GOq5enHjxPZvk2gfiPHZPrR1lAaay/ap5I
   8p+cDvMi1eS3ZDgdQhWwx1OCP2P+IOB9yoSt7OaXL8/Z6G9DHoL5ugDui
   8nwvyigDGTlFiIsp+qkNTvcE0RCQKfQQ9FExD+x2VeudJPbTPV7PWSTgs
   6cPRiE7OlyQyBnE08Ny7xB/0IP2loJpy+YA6LGFeE3yRDUBS6Ljm5Ills
   w==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="asc'?scan'208";a="217800925"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2023 00:26:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 27 Jun 2023 00:26:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 27 Jun 2023 00:26:26 -0700
Date:   Tue, 27 Jun 2023 08:25:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add support for T7 based Amlogic AN400
Message-ID: <20230627-pledge-recapture-7b17cc1c3c20@wendy>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-3-xianwei.zhao@amlogic.com>
 <9b49e979-4a24-f628-88c4-fd53f53d46e4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cIrvvHlrPAOZayil"
Content-Disposition: inline
In-Reply-To: <9b49e979-4a24-f628-88c4-fd53f53d46e4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cIrvvHlrPAOZayil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:41:05PM +0200, Krzysztof Kozlowski wrote:
> On 26/06/2023 11:52, Xianwei Zhao wrote:
> > +
> > +		apb4: bus@fe000000 {
> > +			compatible =3D "simple-bus";
> > +			reg =3D <0x0 0xfe000000 0x0 0x480000>;
> > +			#address-cells =3D <2>;
> > +			#size-cells =3D <2>;
> > +			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> > +
> > +			uart_a: serial@78000 {
> > +				compatible =3D "amlogic,meson-s4-uart",
> > +					     "amlogic,meson-ao-uart";
> > +				reg =3D <0x0 0x78000 0x0 0x18>;
> > +				interrupts =3D <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> > +				status =3D "disabled";
>=20
> Please, don't put status in the middle of properties...

The serial entry is also missing the soc specific compatible (and
removal of the always-on uart) that was discussed in Lucas Tanure's
series.

--cIrvvHlrPAOZayil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJqPBgAKCRB4tDGHoIJi
0lUYAQC15qMz0HEe5JtsuiOxiuOPkE7/jHHCIlO8J/hc+XCrCwD/exX4JGWZbAjU
AiyF6DU5r0BztLX/SlsSjJ4IIW54cgs=
=FvQO
-----END PGP SIGNATURE-----

--cIrvvHlrPAOZayil--
