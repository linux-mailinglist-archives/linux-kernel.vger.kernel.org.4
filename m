Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F8A63E0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiK3T07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiK3T05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:26:57 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980286A12;
        Wed, 30 Nov 2022 11:26:55 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A6E7D1C09DB; Wed, 30 Nov 2022 20:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669836412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJszQtTiyPbeAKNAjPIljuAEWHwGT1w0msQ/GnDzVBs=;
        b=FGKcPWoCjEzXHskO1Fxrb9FnuPUCiLEibcSgcPli6PUht5kvRzPa7FeZZlbRpBhRMegcBb
        obpgIGyos4Vd1/1bkdIsRPnd7SohblHtFVXC7L5URHcg3US041Axj/WRqfP1W14npJFQ1U
        OTxMEAIJvDjCcICcPCR78diQudyvco0=
Date:   Wed, 30 Nov 2022 20:26:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <Y4eufPCzKbfp9k3z@duo.ucw.cz>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
 <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eQM87O+WVwWbNhd3"
Content-Disposition: inline
In-Reply-To: <20221130191905.GA2631320-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eQM87O+WVwWbNhd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-11-30 13:19:05, Rob Herring wrote:
> On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
> > On 11/22/22 13:23, Pavel Machek wrote:
> > > Hi!
> >=20
> > Hi,
> >=20
> > > > Mark the label property as deprecated as it is mentioned
> > > > in the description.
> > >=20
> > > Lets do it the other way around. Functions (etc) don't really provide
> > > good enough description of LED, and label is still needed.
> >=20
> > Can you please provide a clear explanation which property or approach i=
s the
> > correct one for new DTs ?
> >=20
> > So far, the documentation states that "label" is deprecated, and users
> > should replace it with "function" and "color".
>=20
> 'function' is what activity/operation the LED is associated with. It is=
=20
> a fixed set of strings which s/w may use. It is a replacement for=20
> 'linux,default-trigger'.
>=20
> 'label' is what is printed next to the LED for a human to read. 'label'=
=20
> can be anything and the OS shouldn't care what it is.

Unfortunately, no.

We use label as a path in /sys/class/leds. And it looks like integer
"function" is not really adequate for describing what LED does. There
are too many LEDs and not enough integers, and it is common to have
same function ("activity") on multiple devices ("wifi", "mmc", "eth").

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--eQM87O+WVwWbNhd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4eufAAKCRAw5/Bqldv6
8iEKAJ955fdwV606GSRqpigK+uze4DolXQCeJHNIyZz0oT1L+vtwTl8f0gT228w=
=eoCp
-----END PGP SIGNATURE-----

--eQM87O+WVwWbNhd3--
