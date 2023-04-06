Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F326D9477
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjDFKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjDFKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:51:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC74C05;
        Thu,  6 Apr 2023 03:51:33 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1638566031C0;
        Thu,  6 Apr 2023 11:51:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680778292;
        bh=x3aRxla+DsZNmlA36XqdRv0nclCoMSIM66m0rWdCOno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bl6uvRbRN9rcLi0VaAIkIHx9E+RvBNULGoeukOhgfwG4FLRmoshhPEGXJehxT0mxb
         u2672Aw61Cc/Lyv59X/PhSMgd5N1nmlFpegoVRnUCacQQSCFiMlK/siFXt8HVRC9EU
         6/PLHJjhjaVxg8WrzrAsjWFWX0G3fQbYCTcI1giPMTynA5r/rkLCKyfVFdX8/3h6GK
         KFYEz8Fkk+FRQHzpW2gJXUx4M3KjQFSvaBxjdQo/90juFFNscFnhYAR7p6D0X4pgO7
         JLX75iK4Ix6YH6+fhMO39MqPQPH0GNBoPRHlFdAsPHdjxTDTvv1NIO/a2LGoS8yxlj
         G8+eWSe2aOKhA==
Received: by mercury (Postfix, from userid 1000)
        id 89011106273A; Thu,  6 Apr 2023 12:51:29 +0200 (CEST)
Date:   Thu, 6 Apr 2023 12:51:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Message-ID: <20230406105129.nuv3jcmwl7ugql3q@mercury.elektranox.org>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <20230404145350.45388-2-sebastian.reichel@collabora.com>
 <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gkot42bc7hmuouit"
Content-Disposition: inline
In-Reply-To: <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gkot42bc7hmuouit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Apr 06, 2023 at 09:45:11AM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2023 16:53, Sebastian Reichel wrote:
> > Add compatible for RK3588 OHCI. As far as I know it's fully
> > compatible with generic-ohci.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/usb/generic-ohci.yaml  | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/=
Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > index a9ba7257b884..d84732a100ba 100644
> > --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > @@ -44,6 +44,7 @@ properties:
> >                - hpe,gxp-ohci
> >                - ibm,476gtr-ohci
> >                - ingenic,jz4740-ohci
> > +              - rockchip,rk3588-ohci
> >                - snps,hsdk-v1.0-ohci
> >            - const: generic-ohci
> >        - enum:
> > @@ -68,8 +69,6 @@ properties:
> >      maxItems: 2
> > =20
> >    clocks:
> > -    minItems: 1
> > -    maxItems: 3
>=20
> The constraints here should stay.

dtbs_check complained about the 4 RK3588 clock entries if this
stays. That's why I moved them to the condition down below into
the else branch.

-- Sebastian

--gkot42bc7hmuouit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQupCsACgkQ2O7X88g7
+prC3xAAh3TAmObHfSQgOxu06NxPtt+duhRILfQCjMBuvM+PEgF5VacsK6ki3wi9
/1wNZ/bDxPi8t41BJfdOJF6CQ69By5PkwmgpJwJRQpmSU3UKhh46ITHQYdXPQDGV
FhOhvBDiQmGYsQT4J46qPssYTgcfNv2SQecZj4CFVQ+fUqjASD9jsI5kj9czvg4k
O4v6kNT3PoPZ0k7KlD9QOAD0XO1wfwgwgnPuXEOMYoOhm5et+ITKYlo2argQw5gO
vXlamu6+AjA/BWbqVFKrcqxtnAjhdY3uXGJebCmJx5rNSbIRAcuYKo0m7pqiDHyq
Sds7ovnnfV7TnMsds+g6I/f0NlfKVO5IiRwWCrBvfOpE12nYLvqIT0zyqhxUXcbf
u/P8Lj1NPvZ5N0XLwCo4NRZBRlUFJ3x/99eRwsf0+x9SuRNsSQWrWohOPMDAfCki
G5Lj0A2826oG5uM92IjJ3CYfStLIO59o4Y2gM1/RTgnSE1w2wLW+Lf9WXxKkdqiZ
POhqOdPj3m7b76/F45xA1wVCksAGFXSNM63IPZLyTek4tIGHkAvIaoYgpYTpw48Y
c4/HM5SHSiZlhlqlon4wKRjQ4klrfJjA8tDkBjgPWeeaHujp+fnONWuRX6FbCkEH
HWF1DxCe38g3RJZa5Njy0N4/qnF9hJ0wW0G7msUDWdRdB2PjTks=
=OhJQ
-----END PGP SIGNATURE-----

--gkot42bc7hmuouit--
