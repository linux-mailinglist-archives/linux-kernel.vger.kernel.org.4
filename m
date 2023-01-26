Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5856167C5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjAZIc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjAZIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:32:49 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2746AC92
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1674721957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjJFHQ99v7fimPGIGMu1WpBQB3x5OOboN7EMcJhzvrA=;
        b=Oh5IATyRGJHoiZ5b5t0nTb8EbKGM8MdUMFjRKFrp7lY5AhlSpxpSKE6sKXHD7J/u6x7Sm3
        U1JFf/SxS1SnSW+xWOPhuPP4uEIA8O9E7lua3nXkpwc0O83KZtJeclTW1SoQ3bx1iJiKh4
        jde47Gd8rShdWRE7UgvKZVt0GwbHcw8=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Subject: Re: [PATCH 5/5] HID: sony_remove: manually unregister leds
Date:   Thu, 26 Jan 2023 09:32:34 +0100
Message-ID: <5192178.GXAFRqVoOG@ripper>
In-Reply-To: <20230125-hid-unregister-leds-v1-5-9a5192dcef16@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v1-5-9a5192dcef16@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2259224.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2259224.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5/5] HID: sony_remove: manually unregister leds
Date: Thu, 26 Jan 2023 09:32:34 +0100
Message-ID: <5192178.GXAFRqVoOG@ripper>
MIME-Version: 1.0

On Thursday, 26 January 2023 01:24:57 CET Pietro Borrello wrote:
> Unregister the LED controller before device removal, as
> sony_led_set_brightness() may schedule sc->state_worker
> after the structure has been freed, causing a use-after-free.
> 
> Fixes: 0a286ef27852 ("HID: sony: Add LED support for Sixaxis/Dualshock3 USB")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  drivers/hid/hid-sony.c | 8 ++++++++
>  1 file changed, 8 insertions(+)


Reviewed-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven

--nextPart2259224.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPSOqIACgkQXYcKB8Em
e0YhGxAAm5Z67e9ZJlP2Qs6aAHW87VgdmYj6PIKmYYlzicEVdzf5VITIWyhZN//f
hi6UzNgPvG0X36Evkq1G8Zn9jjNby6i5+4R+RjraWyjAeAkjH1CcpAzIly29KIk1
oFzst4aPPFSg8UEDXsWIr1WY3hrEVqLFByfMJUYCqua04/mNus2Bw+KmMANBOfql
5QHJX/mgVQNJPcFw+3vZGctsXcZM9yOhfZFWvBRwPcsHuAPyIeL029Ee09MrQaW0
3KPpDP/u15s5cwFNecMb/DFe2wvMTgRN3FY5U/pR8vskSeybeqDDoK03mGJr88YI
0R+7G7hiSiwURfK9PybFB/frXd9i+0GNOyjvt9uxAK18IbPeQmKACvp66cFabgtl
5AkXaV9n2AFFWJhhflxpWz/fMmbQwdYlImzRm7mQtdiEFtuO+BrYnpznQwdhzB+1
jxqUmxF4cFsZjxDAEjOqU4CHDoto3Dk19+rxY3MFAS+ykbeUO5gM1HS1p9aPTXvf
dRnakHNIGw701pU+REy+5F7S98L0UDnChJMjZQUmA7fWF/QmHRdwbvAtCvf5Z0Um
IiXYSpJGnoeKTRjYi5D2LqCq+Zu3oXEo8DZj7Zl4gpclHlsNOQlduHIFTqQq2ZOS
N3BEg6iqDmK7hRw+1Xzh4GYpab4k39w6LtaW7NFIqBjV9XEJU+E=
=7yRQ
-----END PGP SIGNATURE-----

--nextPart2259224.tdWV9SEqCh--



