Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D805EDEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiI1OWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiI1OW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:22:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F130A9C0D;
        Wed, 28 Sep 2022 07:22:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v4so172118edd.5;
        Wed, 28 Sep 2022 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u9wjJZq8CD5pBr6UtH3ZtDZ879VTn9XWKV0kd+JEUus=;
        b=iofXj1F6FPGbTGmrxH6dlWVAWtfsAS9xmIjuHCQsSos0wZpFieko4foPh/XdqoLefl
         ObrAVmAlLBzm9Qyde2rDaLx1SjZbSnqVjFPiw2roXU51kvJrGD9lUVMP8T9NdeqkebXL
         cfgh1sQoIFm+hh/i4CkPw7qxZnEZQawDJ3GIlQVLJc1+RQA41ZL6e7te6KptpAqcdB4p
         /EJ2PFv2J+FqQaYnLZNkT406GkP3eNdDozI1wtvSggmnsDI9hL2y7cbsskaiFV1N3WAC
         CIiHU6/BjueVTF4SczO9rYXtXX17cma9wl6cYW0VDyQVYBIHFJAnblgfPiE7kW4ORt1e
         bTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u9wjJZq8CD5pBr6UtH3ZtDZ879VTn9XWKV0kd+JEUus=;
        b=yhxrjePy2Xc4ycj9wwD5xB8XAMifmoP+WuBVDqi5aiFz39H1D3jwNGjQR7Cs+VLlXX
         CNwuqs04W1JVrXoxdZnvmNu2ST0EE7R0OgmnWbqYFA4n05AuHA71XrNsjbfNvwji7j5i
         T5Q+nvW+SYCaqitMEWmfj/d+5aeL2eJMzAKgLdKnrRGOE8tVJ1dpMFAZNk04bmuQbcdg
         YFu9gn0QpaxbSgXGwTay8cjxgXUwZR9kCsSq24avqN7mS7WAumtYj/gdXIJi0yjboQxt
         pVfTtdeZwnykE26Izw5RwZs2S38E7dG43UFxmuQ8smIzQkcULjBGG1vowpIoCk/1qyhy
         SzwQ==
X-Gm-Message-State: ACrzQf0Gz7XtayfhnwPmy5TaPHIgHKV924ENDs7zcURhhW8xni9SHR+E
        O9jOn8Spy0o3gwWiSzNNASo=
X-Google-Smtp-Source: AMsMyM7RU95I1QairBTe4wyvRGXj4daJnqV/Hp5fSP2BNlGtXOew99QbPC13N5rLHRtLtLDixFPzWw==
X-Received: by 2002:a05:6402:27ca:b0:451:7b58:1b01 with SMTP id c10-20020a05640227ca00b004517b581b01mr34300686ede.61.1664374940628;
        Wed, 28 Sep 2022 07:22:20 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090695c200b0073cf6ec3276sm2395824ejy.207.2022.09.28.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:22:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:22:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] pwm: lpss: Clean up and convert to a pure library
Message-ID: <YzRYmtcsdW6iSC0L@orome>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FBdDYJFlTkO+Z7cq"
Content-Disposition: inline
In-Reply-To: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FBdDYJFlTkO+Z7cq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 07:24:14PM +0300, Andy Shevchenko wrote:
> First of all, a set of cleanups and code deduplications (for better
> maintenance) to the PWM LPSS driver.
>=20
> Second, we may (re-)use the core part as a library in the future in
> the devices that combine the same PWM IP in their address space. So
> convert the core file to be a pure library which doesn't require any
> special resource handling or alike.
>=20
> Changelog v4:
> - dropped the forward declaration use patch, seems too many questions to =
it
>=20
> Changelog v3:
> - postponed last patch until we have a new user
> - added tags (Uwe, Hans)
> - expanded commit message on why forward declarations are preferred over
>   full header inclusions
>=20
> Changelog v2:
> - replace patch 1 by Uwe's version (Uwe)
> - update NS patch to have a default namespace defined (Uwe)
> - describe all changes done in patch 4 (Uwe)
>=20
>=20
> Andy Shevchenko (6):
>   pwm: lpss: Move exported symbols to PWM_LPSS namespace
>   pwm: lpss: Move resource mapping to the glue drivers
>   pwm: lpss: Use device_get_match_data to get device data
>   pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
>   pwm: lpss: Make use of bits.h macros for all masks
>   pwm: lpss: Add a comment to the bypass field
>=20
> Uwe Kleine-K=C3=B6nig (1):
>   pwm: lpss: Deduplicate board info data structures
>=20
>  drivers/pwm/pwm-lpss-pci.c      | 48 ++++++++-------------------------
>  drivers/pwm/pwm-lpss-platform.c | 40 +++++++--------------------
>  drivers/pwm/pwm-lpss.c          | 46 ++++++++++++++++++++++++++-----
>  drivers/pwm/pwm-lpss.h          | 12 ++++++++-
>  4 files changed, 72 insertions(+), 74 deletions(-)

Series applied, thanks.

Thierry

--FBdDYJFlTkO+Z7cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0WJoACgkQ3SOs138+
s6EJ3Q//cLMA4RgbfX+R58GsagonQvGhb7SDUFrl/kp20S5R4/7pAM29N1PI6VUh
W3QEp9vDdvoE1QH1Ibvn9hYXP9TQ9N17EpQpyt002y053kDERsNafzbuetIUwrff
RHM0OH/wybnTDrGXGxSVVwkJx7jNt4AcQeKIdQxHZa3W3HN1I3g9xc1Sa1wS1q34
42Sit5MKKBROWaodkNsVY+XJyL0cW7W6dhDQ4EnAHnckH3+WQaby4SZA/KaR+E2T
IQfmrxczWtRSk8mXjhzq59Ct/MBpggJU8dsQLTwVcMnDHtIigSRv6CqNxt73jaFm
Sidwx6yJFQ6ANVf1VoGqBQv2ZwnMZl7E0Yxzv9plWy9sLBoA2NUY4czEFu1RTOJE
cs4f8YpiC8TMJ1z/LdOM1cOwKDIIrXZJCnmUYHlr0S+aSdXa1lPtf+MOxAiwuoSe
kmcIEGIn7W/2ZmO0Vn8imS45q6lwceVtFYirSSJzbO9D7hluePWQbCKn2zXKI+1Z
2/trDTaMV1N2roFSReffwHh4RbpJkh/1E4+FDkmRwVlkJiSc4Vz8KmBGtYPu0Zxp
blH0JPpt0pK9bZ38Gypy9AWpRqTcPJlUKBkXUFrFkHYxkzDpIT21h3XsvNoKOu0S
Vm4FP5ZASLWwt8AyWhWQx/jzdsuCf5e9v6RoFTP6OaD9fUqtuho=
=tzQF
-----END PGP SIGNATURE-----

--FBdDYJFlTkO+Z7cq--
