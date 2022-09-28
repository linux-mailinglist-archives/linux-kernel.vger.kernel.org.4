Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0310E5EDC93
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiI1M26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiI1M2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:28:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0691DB0;
        Wed, 28 Sep 2022 05:28:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a26so26817585ejc.4;
        Wed, 28 Sep 2022 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=k95LTZNFDtS0ffvFY2N275h31giGKkkoYxr9XDNiAyc=;
        b=an7jTc2scuDUkFYzai7CZ3gcDF1uATCda1dVKDKAyLtR1WegLnGgsNGL7plDlD0Kj+
         3p2qDDF0n31GljpgOYeYgBQLEcAnxGgF0FlyyG/ukt+bQzy00e/AoN9NqMBx26M1Vxjk
         LEwAXjZlgqq1vEdbKvSUzZBYxgTgLr1TO3Hq8NozA3rpJiyk44g/8V+7CrODmufv4wmp
         0gyXSOQpQSe6OcGUW3lWdMX6fiera2L3qdH0warvnImY3CwOOXW1htZ5JP06OM7wjv71
         833iEcbruuUQx6wYNtGw7Y0pvTKI9Vt443hFBSIVTo9PvCRUwJ4j29bJTRcPd/+m3yI8
         /M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k95LTZNFDtS0ffvFY2N275h31giGKkkoYxr9XDNiAyc=;
        b=5twTeufzj1237YvYcoGiS2bEB0taZj9+f/J6LzWlrX8AsTmvuixZN5tfpNPRWw2hkL
         Isps0VfykRixv8z8UsmPqd4Hihvo5+7IeRbFZ4cS978KHnkcJ3teZUM9QGTNx2wkChGA
         WsSqQYeedFzxm37mLCkDVs12BDuw/wlPiEaohbSmlbscZyA6vPOO1CfWI2vDlwI8Z3QM
         J+z/7VZRinqbNSPjrB9kBoiZIL9gHgm2Rd0ndBU2HOXWuHjSZFI2sxHW5bkiE8wkjzei
         3OIgvinEvWtrYS27vzrVz5gbxL6LNpBiKSArf1APK1E6k0ATf4hkRmghdhdJJMqmDxLt
         Bh3w==
X-Gm-Message-State: ACrzQf0T8BnqDDbcwBwP42+udJoD/QG2T5+0Ynq+ss9aXW/tM2S+FfvD
        LQne1jXa1/sJfZgxQjNoZnw=
X-Google-Smtp-Source: AMsMyM6Zvs/canb36/21+jVObf635cTOnU0H+5kIaF+xN7YuG1giRqGL6Synzzs5HhMlzf6eRELaqg==
X-Received: by 2002:a17:907:75e2:b0:77b:4445:a850 with SMTP id jz2-20020a17090775e200b0077b4445a850mr26726033ejc.587.1664368124412;
        Wed, 28 Sep 2022 05:28:44 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0078015cebd8csm2342168ejg.117.2022.09.28.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:28:43 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:28:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzQ9+Wzhfnila1s3@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3R2fcm2GkPhc+EdA"
Content-Disposition: inline
In-Reply-To: <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
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


--3R2fcm2GkPhc+EdA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> instead of the raw sprintf() & co. This patch replaces such a
> sprintf() call straightforwardly with the new helper.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> v2: added tag (Uwe)
>  drivers/pwm/sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

How exactly is sysfs_emit() safer here? In all of these cases, the
values that sprintf() writes are the only values that are written into
the buffer and we know that none of them exceed PAGE_SIZE. So the
additional checks that sysfs_emit() performs are useless.

Thierry

--3R2fcm2GkPhc+EdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0PfcACgkQ3SOs138+
s6GORA//UHjBaGJ9AAAWN8hus0tfzt64SLQk+/kTOLO/EMT7rG0gLXKjQ32X3ECj
yvn5rWvNF5BfVrswxyzKZOb8p5yIoeJgkEJKPYKv2WtHMT01anCD7pAiH0UuwgSc
QqY6LmPV7tsCKqq6JkRkE8R1l40j7W4a93t3kcNsHl5X9UYELvg6sIHdc1/tQ9Ia
T/KyHqyUN3b9h7tf5GVulqGuyA20Ug7ZhASRSsCGfHx9EHRxm4SVM4pYKH9T4vJK
xGUZ4PZJnpATn7/ErmWY5xjOzv7QI8wh0l7c9cZ//QIRoSPibDOYkvxXbuQSGUaM
azvr7g2p+bhEIVZ6lrYx0RJ9UyGCqUVafW+tPtarn00qwcFeW2UtnlpvQzCCzN3w
mDZ8fjhzPRG08lx0XVBoNFTBObQVwfQXwygcy0xgJDbOT8zQr+MOy8b4AYnVnC8f
PUWkJUbAnwsCmFPpKEigy+oI1yoH29LHZsEH8iL35j8r9anxzqxy/mTf2DXx3TPj
PG8QlW1GqDOasU5thRQut+08ZDtnMk9zSknjT8KaakH9ZCtnim9UIsySqcablgqT
8shSuOexKMyQZf6FiLTzvlNqZt+wgyv69Td8nsoI/1cVxMhToa+zZcjEschDyfHG
ysIf/K6O1zBXlTNJXGVo1GLaaPb55hzjN+nZDxDbYOgsmVuMMzQ=
=UDGs
-----END PGP SIGNATURE-----

--3R2fcm2GkPhc+EdA--
