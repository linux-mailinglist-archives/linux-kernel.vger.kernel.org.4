Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33265436B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLVO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLVO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:56:08 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E901E735;
        Thu, 22 Dec 2022 06:56:04 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 63DF41C09F5; Thu, 22 Dec 2022 15:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671720962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGsweO4fT04ZOHHSUyF4a2DG33BMKp9jkHL7IT3pXvE=;
        b=PjNJgMNphpe/LhbeSipabN44uYFvuXO22OvJn5f5F740gmdEe4ecvaMbHD6plx17LU3iCb
        bGZCQi24MAnW2V5BaOlXCpN7x0cNs15cz16UFcDGqa9dCMWbzxLweRu12uxUSvQyO74+ha
        sRSm9D6Zf4sbcWYwSrIcY4Im70mDvaw=
Date:   Thu, 22 Dec 2022 15:56:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek Vasut <marex@denx.de>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <Y6RwAcXnfY/zjk/b@duo.ucw.cz>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
 <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <4043d693-7739-4709-8551-9f476031db70@denx.de>
 <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
 <e6b166b399314a91bc97db591c8ec5a7@dh-electronics.com>
 <Y6RgjV4FT57SaTQw@duo.ucw.cz>
 <3c555cae-999f-ccd2-d114-00b92abd19ba@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="g1aUR9kw9ctIZUgk"
Content-Disposition: inline
In-Reply-To: <3c555cae-999f-ccd2-d114-00b92abd19ba@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g1aUR9kw9ctIZUgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-12-22 15:01:44, Marek Vasut wrote:
> On 12/22/22 14:50, Pavel Machek wrote:
> > Hi!
> >=20
> > > > > This part I understand. What is not clear to me is, why is 'label=
' being
> > > > > un-deprecated.
> > > >=20
> > > > It shouldn't be. It seems to be Pavel's ad-hoc decision.
> > >=20
> > > Is there a majority agreement that the "label" property remains
> > > deprecated?
> >=20
> >=20
> > > If so, I would say we can mark the label as deprecated.
> > >=20
> > > On the other hand, the new generated standardized sysfs name does not=
 seem
> > > to provide a full replacement for the "label" property.
> > > What is still missing?
> >=20
> > Having reasonable naming of the LEDs is pre-requisite for deprecating
> > label property.
>=20
> As far as I can tell, function and function-enumerator is the reasonable
> naming. Jacek seem to confirm that. I would say, label can be deprecated .
> What is the counter-argument for why it should NOT be deprecated ?

When the label is no longer neccessary for naming leds, it can be
deprecated. AFAICT, that is currently not the case.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--g1aUR9kw9ctIZUgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6RwAQAKCRAw5/Bqldv6
8ipDAJ9UQeaV8wbRmUaK78L8ef8b20shsgCfVQip2dhkf7hu87g/yP0SouLr5yU=
=Vv5l
-----END PGP SIGNATURE-----

--g1aUR9kw9ctIZUgk--
