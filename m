Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4A6B689F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCLRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F052330B;
        Sun, 12 Mar 2023 10:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FE660F64;
        Sun, 12 Mar 2023 17:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFCFC433D2;
        Sun, 12 Mar 2023 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678640866;
        bh=D+mLpwz4VKHHeNXrNwruBX6RwwU/I9bGtXKO/ptBcO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZYDUfULOZNPPa/uIob9DJM3A0HKjbdA37qLGXlsgB2VC0ID6o3TNiIjdAcmLQBtX
         sgET5c9Sckix6JiuqKkQoBFVYhDUmOlvu7GgUd3f04/5OAUcUvhOOXzP3kFgeON2zU
         J+nfOqVTtRBYEqbtTQmp1GYE/7drLBKzxqR4p7oKGxLgUt3E0ba10UiZIlKPmunGIB
         wMinw8AYbeAlY3Vac5hKZON9e0IMZqqOApEa2My3kxDDqhS/IAeG8zmQyvU4EeoRSn
         AaMgm1m+gTr8bDuBpH3XnMO5itiLKNp2KIDgDwQQPgkBBgcFmo2wQGagbeyaj/1ij0
         +fvrGs5ygbjMQ==
Received: by mercury (Postfix, from userid 1000)
        id 014751060FD4; Sun, 12 Mar 2023 18:07:42 +0100 (CET)
Date:   Sun, 12 Mar 2023 18:07:42 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 02/11] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-3-sre@kernel.org>
 <CACRpkdZofL-cuYcyNAwMAshoQAr3z7-boJoHftVnjt80YQmAOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q46upqfjfsur6qqf"
Content-Disposition: inline
In-Reply-To: <CACRpkdZofL-cuYcyNAwMAshoQAr3z7-boJoHftVnjt80YQmAOQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q46upqfjfsur6qqf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 09:20:09AM +0100, Linus Walleij wrote:
> On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org=
> wrote:
>=20
> > +       /*
> > +        * Set if constant battery information from firmware should be
> > +        * exposed automatically. No driver specific code is required
> > +        * in that case. If the driver also handles a property provided
> > +        * by constant firmware data, the driver's handler is preferred.
> > +        */
> > +       bool expose_battery_info;
>=20
> Playing it safe with opt-in I see! But I would probably invert it and
> add a hide_battery_info for those that don't wanna expose it. It seems
> pretty useful to just expose this in general.

I just did not yet spend the time to understand if there are any
issues. I guess I can do it now and then remove the opt-in part.

> However I have no insight in what happens on laptops etc for this
> so I guess you have your reasons, either way:

ACPI based systems should be fine, since battery info does not
yet support ACPI and thus nothing changes for them.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> > +extern bool power_supply_battery_info_has_prop(struct power_supply_bat=
tery_info *info,
> > +                                              enum power_supply_proper=
ty psp);
> > +extern int power_supply_battery_info_get_prop(struct power_supply_batt=
ery_info *info,
> > +                                             enum power_supply_propert=
y psp,
> > +                                             union power_supply_propva=
l *val);
>=20
> I think the build robots complain because you need to add some stubs
> for the not enabled case.

I don't think so. They are only used from code needing POWER_SUPPLY
being enabled.

One reported error is about the array of battery_info properties not
being used when POWER_SUPPLY is disabled. I will move that array to a
better place.

The other error is about power_supply_get_property(), because I
accidently removed the EXPORT_SYMBOL_GPL(power_supply_get_property).
I did not notice myself, because I compiled a monolithic kernel for
the thermal camera for easy deployment.

Thanks for the review, much appreciated!

-- Sebastian

--q46upqfjfsur6qqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOBtgACgkQ2O7X88g7
+pqBWQ/9FFIeo0ooLJOsidujg3C8gFt9suZlyAeFA1fcubvUY4C7WdXHJDxSy/t9
cfXlwdScebDwapJ2arOY3nJHfHTtwx1Fk3Ubjgt6xPBV6KZQlZXE6O+WsIitlJKt
PrtlT+cdcYITxbrYvZsJGWGDIEACn3ewB9w4WUZiBHYBHWswtrP5KLoSyp1mZQLD
l6VlUB/1awtKqjoh/+AES/67Zvv9BYbYrLdh/HBW+E/mdw0hKYu3jBCvyxOLpWFR
YUuRIdBWmt7I0F0fjarWw5j3Ze/TtS6hieAkXtdIOREqYQABFFMQQc6nZliUOjC3
B2SHJPtJNQ7fNlar5zFbpFFsVWAm7VBcGRDGGoGsMu2pTCnAHjx7p74qS2ny4I4V
+GF/oH2VpLnUfraw3yrZ4B4dia50unYBrBYZTc4gVC2CMGjPDzmS29DpWbcbyYHY
RMnPb6xB3OmfHB7VfY3NubbxBEwkXX8Omb7pjvJHH0PDc2QhvMEpkJoJa92UWbpn
Du2J5dnkwGWWr5aQgjGBuF28L0fj1/AKpXTzONYoTDaavBFKXNNQKpWQicWnCvdy
hxG6piP3iA/kNpOGPGQxiNngSPoOnZp4RI/XwPzs/hoGHuv8aDxPSNiDpIg1Q65V
ZbuPDI2a+bQfp6ZkiXQz19aWlyvveW6x2YxREbQ5/z6s6e78b88=
=kmXQ
-----END PGP SIGNATURE-----

--q46upqfjfsur6qqf--
