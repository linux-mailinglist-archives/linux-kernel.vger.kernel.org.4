Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB96BF537
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCQWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCQWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:34:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A113CE14;
        Fri, 17 Mar 2023 15:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28C89CE2179;
        Fri, 17 Mar 2023 22:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4322FC433D2;
        Fri, 17 Mar 2023 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679092463;
        bh=Le9I2nwKv2qxWdoK/EihPpLIEeWl2PAjv+kdU++Fl6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CM6C2G2uF9sAn0m58+XxDfhCd9Oav81M6b/34uamWl3+q6+jdqlvqv2QY3O844kMf
         ZrNjo48ZV4SLwMnfWtznqRqgS41tMf9XFl+tJoaFs4LZS9xqRIYRQPMYNjLk4qJ/F5
         HYEEy3CV/0PoBKU30JZnbLbSdv8NQqGEj5d0aT4DTMiF/IATOF47iY+86PmGMSGV/A
         jI1ZBOcxba1T2xeZ1Mvc9/QBUWoVV1xIjMD99AZ3WSxDVz99QWmLn6QRMyPtATTlJ0
         ZoW2G8z3yWkJZCGrIrphzgqeWkUZpnJsCNpvWzOrS/eqJ0FS0H5yN777oAHB7gvu1W
         3Wdwxf2GtU8AQ==
Received: by mercury (Postfix, from userid 1000)
        id 8DAF010620FB; Fri, 17 Mar 2023 23:34:20 +0100 (CET)
Date:   Fri, 17 Mar 2023 23:34:20 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 02/12] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <20230317223420.n27xxoxgj54hllme@mercury.elektranox.org>
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-3-sre@kernel.org>
 <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
 <20230316004121.rwieru4aj7d6mwgb@mercury.elektranox.org>
 <de0848f7-7f33-b170-54b7-f0fbf4e5d7d6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bm5gvqe4rlmcjssl"
Content-Disposition: inline
In-Reply-To: <de0848f7-7f33-b170-54b7-f0fbf4e5d7d6@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bm5gvqe4rlmcjssl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2023 at 09:10:03AM +0200, Matti Vaittinen wrote:
> > For chargers the situation is different (they usually want the
> > data before registration), but they should not expose the
> > battery data anyways.
>=20
> I probably should go back studying how the power-supply class
> works before continuing this discussion :)
>=20
> So, is it so that when a single IC contains both the charger logic
> and battery monitoring - then the driver is expected to create two
> power_supply devices. One for the battery and the other for the
> charger? I assume both of these pover_supply devices will then
> find the same battery_info - which means that one of the devices
> (probably the charger) should not auto-expose properties(?)

Yes.

> Well, as I said I should go study things better before continuing
> - but as I have limited time for studying this now I'll just ask
> if there is a danger we auto-expose battery details from existing
> drivers via two devices? And as I did no study I will just accept
> what ever answer you give and trust you to know this better ^_^;

Nothing will explode. But charger devices are supposed to provide
charger information and the data from simple-battery is about the
battery, so it should be exposed through a battery typed device.

Exposing e.g. POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN for a charger
makes no sense. Why would the charger have a design capacity?

> [...]
> > [05/12] power: supply: generic-adc-battery: drop jitter delay support
>=20
> I didn't feel technically capable of reviewing the above delay
> patch as I don't know what kind of delays are typically needed -
> or if they need to be configurable - or what is the purpose of
> this delay (some stabilization period after charging?)
>=20
> So, it's not that your patch had something I didn't agree with - I
> was just not feeling I understand the consequences of the changes.
> Purely from coding perspective it looked good to me :)

=46rom what I can tell the original author had to debounce the GPIO.

-- Sebastian

--bm5gvqe4rlmcjssl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQU6ucACgkQ2O7X88g7
+pqknxAAlJi7VQYoNHVt+wEjzCipiTv88KVhTRpQtXL2ydIseMy0Ana+EjZOguYz
+lLjotno0p1IGrUrOU8xS6G4S+AEaus4tFnkHUgiQ2yns7FCz29gFMsxuPuhD9lw
660hcjOBWhCHttCsP72k+JqIVZhfRX2iV5KOLb4cLDWoObGfHxdCLqQdzUO/tviY
gt+bmBVndCZCepBmcHkgor1WGg9wuJdcrvOq2XT/L1W0HT8Xmm7pMqX5QW4QucEi
vV+e7wO+otBnyxT8sFcG16yHxHpLQx3waPYIMv75Hp19LOl5EqDfmBwB3tiH+RRP
Uce+O9taal7RIHptMbEf1Bqf5xq8JHsMmUh6sSYI1kvCNJN9sYd64HK6I5PnUM0G
lkCJ07cwp4iD9CyyzMyOf24EiKX4EgyMpfsEdvT4Bi874dg6piKxYrvoT1ksxGtK
Pzn/Ke/nBgZqpPlHXtZOYXjAfrcANDEj5ERuEV4FApYhGqKna+dggofSfggyvi4X
n1Vn8YbxJ24y0hZLla+p/NlxlObFtoUQJnp4BQc6ae8MJONmBTBQjws3/i8S7v7A
LV7+bR517gYFPsVhpXIsFS4+nqXPjbf6cwEGin/zQVzR499JMwAiIrc9cOadQxd+
XtQjtQWqd226oXeEWbNGj+6xvBq6+xYv1gSD3vXA/ibeOZMczoA=
=HQqR
-----END PGP SIGNATURE-----

--bm5gvqe4rlmcjssl--
