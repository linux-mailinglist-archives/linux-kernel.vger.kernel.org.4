Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E83E654224
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiLVNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:50:08 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C10FCCA;
        Thu, 22 Dec 2022 05:50:07 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 855BE1C09F5; Thu, 22 Dec 2022 14:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671717005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jpj+1VwmvhxhExlLF4QPaPuri9rFDKD5Mcow4RbyqCw=;
        b=T8HWmQL+p+vYjEZSmVO4kO4uq+Yg/VvPcowbM9yWJyybBtdhAkCFf4tpR/wVyamTHKbPG5
        cD8Q99KU2+Pjt8mZ2A967JxY+rHfqCR5VFw1hRj6WkOoy5c3m1MRVYpxAZChO3lZXbvo7X
        Tiq3wrcth/BgxFiBzcA9qsv9v0/kBf4=
Date:   Thu, 22 Dec 2022 14:50:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <Y6RgjV4FT57SaTQw@duo.ucw.cz>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
 <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <4043d693-7739-4709-8551-9f476031db70@denx.de>
 <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
 <e6b166b399314a91bc97db591c8ec5a7@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iHgyHTcg1aeKFfJ0"
Content-Disposition: inline
In-Reply-To: <e6b166b399314a91bc97db591c8ec5a7@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iHgyHTcg1aeKFfJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This part I understand. What is not clear to me is, why is 'label' bei=
ng
> >> un-deprecated.
> >=20
> > It shouldn't be. It seems to be Pavel's ad-hoc decision.
>=20
> Is there a majority agreement that the "label" property remains
> deprecated?


> If so, I would say we can mark the label as deprecated.
>=20
> On the other hand, the new generated standardized sysfs name does not seem
> to provide a full replacement for the "label" property.
> What is still missing?

Having reasonable naming of the LEDs is pre-requisite for deprecating
label property.

And no, kernel community does not operate by "majority agreement"s.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iHgyHTcg1aeKFfJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6RgjQAKCRAw5/Bqldv6
8p4NAJ9zi99fMJIr7fKUDjJAftTizFPRMACfQPcdIq/iB8XDz9BR0bHGvNCos5o=
=XFxf
-----END PGP SIGNATURE-----

--iHgyHTcg1aeKFfJ0--
