Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD871F37A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFAUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A251A1;
        Thu,  1 Jun 2023 13:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828FB646C7;
        Thu,  1 Jun 2023 20:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51289C43443;
        Thu,  1 Jun 2023 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685650420;
        bh=DCSJXIhqlYYsF0jNkPfKzV5MfwJ9SAulhFSDDwt8Qu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVty/LniZ4Eoxr0CcFWpQoP2bAkQ1mhsCOQqj4ha1ew5zBwoHHjDYmCdN/Ak2d/dJ
         cjMdf+VqC2k8mlHM97czldDGclv4vyblevvuCSZdMiF5oBc0G0ehqJArE/0N6gl6Hb
         H7EeaAkIY1SDGnH5Qh8VLw8i3mj2MRMIGw41D2HAuIciKuMBHWBKcvYi+ctUaO7Mpx
         d3fsqN8NZ0H+z4Ruz7X9YhWYVS4qKEX5/SqVNxi4lSO+Cgb3/XpdwvKZ+KHGctcOqV
         l4+uHUlRWAHFh2fLi7C7p2XCoAh1kyI2Birw2cGQu/wwzivUTcIpJwAg9rSVgnSzxN
         8tFGadTrIX/DA==
Date:   Thu, 1 Jun 2023 21:13:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Message-ID: <20230601-starry-nurture-5aecf1f332ac@spud>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <20230529-impurity-dismount-bca5c9100c9b@spud>
 <44015844858c42a79e0e7f9207d01496@realtek.com>
 <202305310146.34V1kevI7026106@rtits1.realtek.com.tw>
 <96a7905208c148debe3791636034a038@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oafWaJor0Kq+VBSZ"
Content-Disposition: inline
In-Reply-To: <96a7905208c148debe3791636034a038@realtek.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oafWaJor0Kq+VBSZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 02:24:28AM +0000, Stanley Chang[=E6=98=8C=E8=82=B2=
=E5=BE=B7] wrote:
> Hi Conor,
>=20
> > > > You have device-specific compatibles, which is great, but you also =
allow
> > > > only those two generic ones. I had a _brief_ look at the driver, an=
d it
> > > > seems like there is no decision making done based on the compatible=
s,
> > > > only on the properties. Is that correct?
> > > > If it is, I would understand having "realtek,usb3phy" as a fallback
> > > > compatible for "realtek,rtd1619-usb3phy", but I do not get the curr=
ent
> > > > setup.
> > >
> > > This driver is compatible with all Realtek RTD SoCs without specifyin=
g different settings.
> > > So use "realtek,usb3phy" as fallback compatible for all SoCs.
> > > This is the compatible name we use.
> > > Other compatible names simply indicate that the driver supports the S=
oCs.
> >=20
> > Then you should write the binding such that having fallback compatibles
> > is permitted. Try plugging
> > compatible =3D "realtek,rtd1295-usb2phy", "realtek,rtd-usb2phy", "realt=
ek,usb2phy";
> > into your example below and see what happens.
> >=20
> > > The name "usbNphy" and "rtd-usbNphy" seem to be more generic for all =
RTD SoCs,
> > > but they are not device-specific compatible.
> > > Do you have a better suggestion?
> >=20
> > Write the binding so that having fallback compatibles in the DT actually
> > works, don't add the SoC-specific ones merely as indicators that those
> > SoCs are supported and don't permit "realtek,usbNphy" or
> > "realtek,rtd-usbNphy" in isolation ;)
> >
>=20
> As far as I understand what you mean.
> I should follow other docs to define compatible.
> Reference:
>   Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
>   drivers/phy/mediatek/phy-mtk-xsphy.c
>=20
> For example:
>=20
>   compatible:
>     items:
>       - enum:
>           - realtek,rtd1295-usb2phy
>           - realtek,rtd1395-usb2phy
>           - realtek,rtd1619-usb2phy
>           - realtek,rtd1319-usb2phy
>           - realtek,rtd1619b-usb2phy
>           - realtek,rtd1312c-usb2phy
>           - realtek,rtd1319d-usb2phy
>           - realtek,rtd1315e-usb2phy
>       - const: realtek,usb2phy
>=20
> examples:
>   -
>     dwc3_u3drd_usb2phy: dwc3_u3drd_usb2phy@98013e14 {
>         compatible =3D "realtek,rtd1319-usb2phy", "realtek,usb2phy";
>  =20
> And use only "Realtek, usb2phy" in the driver.
> static const struct of_device_id usbphy_rtk_dt_match[] =3D {
>         { .compatible =3D "realtek,usb2phy", },
>         {},
> };

Yes, this would be a vast improvement, thanks.

--oafWaJor0Kq+VBSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHj77QAKCRB4tDGHoIJi
0rr9AQCJvO7utcVmJn6jLUWkmuB24q/OS1WxIkdUIU9nFqMwCAEAjyvUtBKHzjkE
0gbFxWfaaRIrhWYzxPppdQHgaYpl2QU=
=mWjQ
-----END PGP SIGNATURE-----

--oafWaJor0Kq+VBSZ--
