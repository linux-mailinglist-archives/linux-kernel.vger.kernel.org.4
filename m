Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5A63A9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiK1Ns3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiK1NsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:48:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0FCDD;
        Mon, 28 Nov 2022 05:48:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14037309pjc.3;
        Mon, 28 Nov 2022 05:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihTkpZXSB7kYTKzGjzGKvqW1UYnktApBytoS8uPjPA0=;
        b=qnd+LDke7B8owkSjtNIL8id9FoLHx8S3wMkQ7rvvxqUa/jr94nMprWK2Af9T3tHLBU
         4oaPxj4c0jRK8IiR2UWoL3I6RQB6Q88aWr+9juoDiGdOLjKoEPM1rBM3/vO2NviVqrw3
         t3Up95TPNx0E92dINcvBEg2rN6LWPn4vpB3GER588ok7wm9Q/ufgOx0uHE0g82rTEqlY
         IaAdEJZdwUbgK+1tne2cIF97bk9aenms0I184alpMS2k/uv7pJQZ/QHux7+G67eX2qlA
         LAbkOUhIhdUKIkRCrhSNfdrqLIlcOwG0DmAQXC7rQTuMAuWvFcD/UrUqxKLYrgdMrQXS
         OjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihTkpZXSB7kYTKzGjzGKvqW1UYnktApBytoS8uPjPA0=;
        b=rFzfosPWTlvl119oHK39KZkmN+DQZEJC6doy9yVAg8SVzxeAn89VUX2MNl2zZtD2aL
         xxNZQcXhz9IvR/kJfsicELI7/aQmtXntkH7WLsqZ0M6p1rdWiEoW/HsP/7szs2npe+G5
         SRxWBdXudfmgH6onSs6EtOybg3FQjoPTEpbv07E9EQm0VA9tg4DuTuR/k0f0XggPatVb
         iC7F+9Nk2l36umci/aWHzfRXMVs6/J+Gm+B8Da1a/SXiFIdgyDl3vrORb/1cY7QN8RN3
         WOp3wcTt9gp40+Q8gW9T/84ZEdmS2hfMRiIKoLPyUnYqbMzQletFvBL6lp/YFl22X9sp
         8m0A==
X-Gm-Message-State: ANoB5plv4tXkEMimojytAFkgwaboLfh5mishAtOmwny2YiPzmXzGieZB
        yRXrNdc1AFwP9jKs9sNBkqw=
X-Google-Smtp-Source: AA0mqf6iUn2bgn/WVbIYdWTNLfE7I5OHOZWpqgiWEbpMXSHaa7WaavvP6/VdwV9uaeBv1GXeARnJYA==
X-Received: by 2002:a17:90a:ff84:b0:213:1e05:f992 with SMTP id hf4-20020a17090aff8400b002131e05f992mr33375449pjb.191.1669643301334;
        Mon, 28 Nov 2022 05:48:21 -0800 (PST)
Received: from debian.me (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8861665plg.194.2022.11.28.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:48:20 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E2B2F10016C; Mon, 28 Nov 2022 20:48:15 +0700 (WIB)
Date:   Mon, 28 Nov 2022 20:48:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rafael@kernel.org
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <Y4S8H/hn1EJzw8fL@debian.me>
References: <20221117122904.6759427e@canb.auug.org.au>
 <20221128102212.39f90b0c@canb.auug.org.au>
 <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com>
 <9ac3a182-fc30-0834-8555-a4ec334531ae@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iynkTffpmch+ZImE"
Content-Disposition: inline
In-Reply-To: <9ac3a182-fc30-0834-8555-a4ec334531ae@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iynkTffpmch+ZImE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 02:22:27PM +0100, Daniel Lezcano wrote:
>=20
> Hi,
>=20
> On 28/11/2022 13:51, Rafael J. Wysocki wrote:
> > Sorry about this, but I cannot fix it myself and Daniel is on an
> > extended leave.
> >=20
> > Can you just drop it permanently from linux-next and we'll sort this out
> > when Daniel is back?
>=20
> Yes sorry for that, I'll go back in a couple of days and sort this out
>=20

What about the upcoming merge window? At worst Linus has to figure
out how to solve this complex conflict when pulling either tree...

Linus has already said that there's likely -rc8 of current cycle [1],
so we have about two weeks to try sorting out the conflict and be ready
for PR to him.

Thanks.

[1]: https://lore.kernel.org/lkml/CAHk-=3DwgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16V=
KoqL7Ok9vv7g@mail.gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--iynkTffpmch+ZImE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4S8GQAKCRD2uYlJVVFO
ozF/AP9MjtCMVpS6NQ0HHZdsnhz/6b0F8+hiuk50iHG+x/jGHAD/R6Y/1/8yW9LV
2RIsodNU5iYgAIQGZLqd1hROJrTPmwI=
=Blrz
-----END PGP SIGNATURE-----

--iynkTffpmch+ZImE--
