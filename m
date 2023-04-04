Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB366D5D77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjDDK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjDDK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:28:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181A1731;
        Tue,  4 Apr 2023 03:28:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so128612963edo.2;
        Tue, 04 Apr 2023 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680604131;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFnhjOVDQ3ItCxmop4qZbHatGDWaTPywjSlabLzg9LE=;
        b=cMcc5XGY1xYe2xnDmZxzicNPkAs+dVgKdBYDr5K9dUg0d0aXC3jj5+8Z8xpZ8SF+N7
         bkFYUuUy6ug0qNFeVg84AQ7fYIphC/bZlNkFGbAHvRlyCwhKNP3x9mLUpxQd+tJad9VV
         PqbIZbmpmlYWRj0SydPCJgOLXceOw36xGF23j2TVWYnGBegVL/c55WwWYaHkemZ6M2PD
         R/RgsALUZsOLobzxV20mYQSM2wIENBm1WImLKXLoS3rwSBrmnNk2Zh49P+zRc4aTX8Xh
         xmqgYmD1kF1x5x/zu4fXYqnDpKTUDS7t4w8sXpn4Y+ZjRsVzYd3WjQCV4Qt8Nvtz7eUP
         zQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604131;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFnhjOVDQ3ItCxmop4qZbHatGDWaTPywjSlabLzg9LE=;
        b=USKqJ7foDlZ1agF51xzg6YEMzjFdibthpIhTw07Eqla/oK1MgYr4eAIpdw9HNqLK3G
         eoTHJd/SMkNl7YDtrPs7D0VrrUTpVCqB+BdgwbC1QWPeYzf+aTGUm43seztziFARKK5C
         igHZ23E5KqJ/wzmCA0aV3w8tP4Xx+V4ZhSpWYFt/KR6PV3QCCXQ8gY233MuNzUHYM9Ym
         LwNikRzPNNVEjSKEijTkbn8A4gzjzH1AwWCoNenkgXLVFDiKYEGWyybIFaQEHVGrtsuL
         O+r0XYjIR54Ra/ie36l4V0D7Oxvl1vR0OFDG8rbEcEi6wrwaXPmK1G3Ws6jyyPUDzlK8
         7l9w==
X-Gm-Message-State: AAQBX9e3jOE4aHzhca/CeGWJZ/e6mFmzyRuxpZ0l8P9y1OfZZ7FhcpUd
        Zflt1R28cb0mFK3s05hVR59HK2rKpD8=
X-Google-Smtp-Source: AKy350YTuwR0WdZcRmjxnBolJRplJ7pURoZBpPDv4DaQCLQi6MZav3gLAUxpI2FqWwmGPOf6tN1xIQ==
X-Received: by 2002:a17:906:841a:b0:947:c09f:3a5d with SMTP id n26-20020a170906841a00b00947c09f3a5dmr1582176ejx.75.1680604131452;
        Tue, 04 Apr 2023 03:28:51 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x5-20020a170906b08500b0093dfd62f9dasm5745572ejy.35.2023.04.04.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:28:51 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:28:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Message-ID: <ZCv74dMMucY24L9m@orome>
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
 <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
 <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
 <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j4v+jpU4YnL3mitN"
Content-Disposition: inline
In-Reply-To: <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j4v+jpU4YnL3mitN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 09:24:17PM -0700, Dipen Patel wrote:
> On 3/25/23 4:09 AM, Krzysztof Kozlowski wrote:
> > On 24/03/2023 19:51, Dipen Patel wrote:
> >> On 3/24/23 10:13 AM, Rob Herring wrote:
> >>> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
> >>>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwar=
ds.
> >>>> This is done to help below case.
> >>>>
> >>>> Without this property code would look like:
> >>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
> >>>> 	hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> >>>> 				   tegra_get_gpiochip_from_name);
> >>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-=
aon"))
> >>>> 	hte_dev->c =3D gpiochip_find("tegra234-gpio-aon",
> >>>> 				   tegra_get_gpiochip_from_name);
> >>>> else
> >>>> 	return -ENODEV;
> >>>
> >>> Or you just put the name in match data.
> >>
> >> Not sure I have understood this comment, but "name" the first argument=
 is
> >> already there to supply to callback to match data. Also, this if else =
is
> >> needed to know which "name" to provide.
> >=20
> > The point is that of_device_is_compatible() do not really scale and make
> > code more difficult to read. Your variant-customization should in
> > general entirely come from match/driver data.
>=20
> Perhaps I should not have mentioned driver related details here about how
> this property will help, that detail will go in driver patch. In the next
> patch series I will remove this commit and just focus on what this proper=
ty
> is.

I think the point that Rob and Krzysztof are trying to make that rather
than adding a new property for this, we can add a const char *gpio field
to struct tegra_hte_data and then set that to the compatible string of
the GPIO controller that we need this for.

To be honest, I slightly prefer the explicit phandle reference, but it
also complicates things a bit and looking up by compatible string isn't
all that bad.

Thierry

--j4v+jpU4YnL3mitN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQr+94ACgkQ3SOs138+
s6FuTg//RaYWUCY1EIVK5FtyolJck7DDm1TQXL5ILgE2I9QFBGSGMptLVzAvGKDa
OlqURt08FlaVKMGrdfW6KB4d9eIUt2GI7mFBftFfFa7jB0YDRvrF1HLtUJ80xQmZ
vcLHKiWXfOPBxK8Z1m47MUoWOnhlbbPX2asdk+kF6Zy4c1XvADfKEIckN3LDTv7z
guxioGkdf4/yfbQrIbqxrQ0sxiOU9wQJg9ZqxMObBLtMnMPvylNN9/oP7XsuAMfD
0+hhaM9MSQKa+/XucaqqmiHqCfoP1GoRBl6DvJezrZx4TIoI7FlGJ1QIxuecOI2G
JDelTvifSpzlfC5giaR6GS3cQXvyvKuAG5kQfodHhyV1JdV1wVP4YguEdXFPDRoG
mWrRImkogPPvWvy20wCaqZRor8riz8r8jYTXZBUbL8CnpGeB/7EMG7KU4X7IICTa
yhlqAMN734OzI4EMzp/s+tZCa/QaPaE1nlPHSOBvyp+Pv2xjjzDdbDyN3vzSX1A/
WZTWOooXjbPkvhXcxC2+toMdSGJuvqsEn5emfcnpAw3mNUYuJRF500phzK8sQoVv
G6NetMfFRKcTTzDQznnK3gomRb6EVrKw1cRy3ZOP52s+cSILZXZKLX0aV6l8hppx
rnEDotFl9tti4UbRn+sX2eA7IqB+ftwAQyu1f2dNCPSw0V3m3cY=
=Zelo
-----END PGP SIGNATURE-----

--j4v+jpU4YnL3mitN--
