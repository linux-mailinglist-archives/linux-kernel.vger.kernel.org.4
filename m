Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2868D604
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjBGLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:53:44 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860C166C0;
        Tue,  7 Feb 2023 03:53:43 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF76A1C0AC1; Tue,  7 Feb 2023 12:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1675770820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/ISXoRJN7OjSXYI/XQDHcFUt5zq8kzBAjPdDE1ePBE=;
        b=dTyTYkHAhsiD/0G2buTHNzmpOUlsQPm0VYKjZq6PGNoWFMWPmdZRM3n7Zc4CaAYOzdi/XB
        nsDWb5rTlJmM1umgrhUq0sxJWMdbDOxbksDQHrfQgms9YmSozfYq5e9q6VDyoOJF1V+kkX
        6BupfLyA8f4FIE6aj0ph7tGPhC7uJOk=
Date:   Tue, 7 Feb 2023 12:53:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Message-ID: <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1/R09bAlpMH05W/O"
Content-Disposition: inline
In-Reply-To: <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1/R09bAlpMH05W/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> 2. Create 4 separate multi-color LED sysfs devices for each zone:
> >>
> >> /sys/class/leds/hp_omen::kbd_backlight-zone1/
> >> /sys/class/leds/hp_omen::kbd_backlight-zone2/
> >> /sys/class/leds/hp_omen::kbd_backlight-zone3/
> >> /sys/class/leds/hp_omen::kbd_backlight-zone4/

4 separate devices, please. And the naming should be consistent with
the rest, so

:rbg:kbd_backlight-zone1

would be closer to something consistent. Should be documented in

Documentation/leds/well-known-leds.txt

=2E And if you take a look there, you'll notice we already have N900
that has 6 zones with white backlight.

But I'd really like to see plan to go forward. AFAICT there are
keyboards with per-key backlight, and those start to look less like a
set of LEDs and more like a display...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1/R09bAlpMH05W/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+I7xAAKCRAw5/Bqldv6
8lmRAJ9H3ltvW8JDmIbMMIJaYG7arMtCEACgujbuLIFOW2SzpJh7w1dG3LJQS2Y=
=5tqd
-----END PGP SIGNATURE-----

--1/R09bAlpMH05W/O--
