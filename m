Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417F6F7BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjEEEfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEEEe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:34:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF2AD3B;
        Thu,  4 May 2023 21:34:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2502346bea0so343682a91.2;
        Thu, 04 May 2023 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683261295; x=1685853295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JU/pIzA4fBK4yVEhxN1C+3VhmjL6fz5pGKvH4ZVkHH0=;
        b=ZFibOqqDuk+FzGU9aoIZuOctEd45cf4UacwGKl6a/+dWgSkE5Fqb1Zen64YLvem7O4
         iV595gaxO6RbT4cbWrOpAymQvTAICarvAHFw2jL1KUsr+vXdbw4ABeSqO3YZB1Me06WQ
         yKCsKuiuWTh83HBsUaCYg9yCt0nNLC+G6+aL56tYMbXO8BjOe/db8Sjace2gPDBzX1v8
         fTUQsKYuVC+EPEyb8FY19eP1vcO+dP6U1mmB1vwHBiD5ccIr5IJ0/bqzlDFdBuI8/hW/
         xxSCudXs8ObmErgexw2gh1+MvzDgb8Wq9yocmDb7ysYfrcnidhrVd+K5VQHmfQtVTJJ1
         iPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683261295; x=1685853295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU/pIzA4fBK4yVEhxN1C+3VhmjL6fz5pGKvH4ZVkHH0=;
        b=DRuUkJGKtO8YvqNTE67CPgpNKbgsfaJ8rITosUTq1HOmeMBw66Y6fNkyWqTVYhygeV
         j6E4/Qj2OS0lL3kiTlC2irC8TFFDlJUPxwc95z2Ro3eDAeIvL0Z6pbGBVIIve26J3zv4
         lFIFAeh4R4997PQHXaumFcb1Da4MeCLsQYcxhU19uoO6SvuM1cYwm+Gs7rdTRQUkJd/I
         2xlqW0tiw4TAlYc/fRtB1d1XmLmFFqVxPf5s+2saCiEsIw5w58iOeAXqiXUje6C5Sqbs
         QclIBYrW7nUjL6JFQ4X5m7LFNsoILqXU9Tht+geEru0rOiKVxyIoE2MuANVnVpIEZ7VD
         mJHw==
X-Gm-Message-State: AC+VfDzOsoNNCDmJEQZKnG+IfTcMPMzmsUPB+3lfj1v+3TEjMIiZWhkk
        WaBW78noXMhlZoUVT5ktbaDtRnQFTjE=
X-Google-Smtp-Source: ACHHUZ4CeMNsIOJ6HugKvhazaUvRL/XmMONXFKtbOvvBx/o+NiKcWu+NnbOC+GvU1P/U4mUmYuG9lQ==
X-Received: by 2002:a17:90a:a608:b0:233:ee67:8eb3 with SMTP id c8-20020a17090aa60800b00233ee678eb3mr186703pjq.24.1683261295317;
        Thu, 04 May 2023 21:34:55 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id v8-20020a634808000000b004e28be19d1csm597048pga.32.2023.05.04.21.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:34:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F1356106861; Fri,  5 May 2023 11:34:51 +0700 (WIB)
Date:   Fri, 5 May 2023 11:34:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/11] Documentation/hwmon: Revise patch submission
 checklist
Message-ID: <ZFSHa2ThLorH5fwI@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-7-james@equiv.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25CJpLEImxGsf4/m"
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-7-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25CJpLEImxGsf4/m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 12:57:47AM -0700, James Seo wrote:
> -* Only the following I2C addresses shall be probed: 0x18-0x1f, 0x28-0x2f,
> -  0x48-0x4f, 0x58, 0x5c, 0x73 and 0x77. Probing other addresses is stron=
gly
> -  discouraged as it is known to cause trouble with other (non-hwmon) I2C
> -  chips. If your chip lives at an address which can't be probed then the
> -  device will have to be instantiated explicitly (which is always better
> -  anyway.)
> +* Only the following I2C addresses shall be probed: ``0x18``-``0x1f``,
> +  ``0x28``-``0x2f``, ``0x48``-``0x4f``, ``0x58``, ``0x5c``, ``0x73``,
> +  and ``0x77``. Probing other addresses is strongly discouraged, as it is
> +  known to cause trouble with other (non-``hwmon``) I2C chips. If your c=
hip
> +  lives at an address which can't be probed, then the device will have t=
o be
> +  instantiated explicitly (which is always better anyway).

IMO hwmon here refers to the subsystem (not code identifier name), so
inlining here isn't needed.

>  * Make sure there are no race conditions in the probe function. Specific=
ally,
>    completely initialize your chip and your driver first, then register w=
ith
> -  the hwmon subsystem.
> +  the ``hwmon`` subsystem.

Also here.

> =20
> -* Use devm_hwmon_device_register_with_info() or, if your driver needs a =
remove
> -  function, hwmon_device_register_with_info() to register your driver wi=
th the
> -  hwmon subsystem. Try using devm_add_action() instead of a remove funct=
ion if
> -  possible. Do not use any of the deprecated registration functions.
> +* Use
> +  :ref:`devm_hwmon_device_register_with_info() <devm_hwmon_device_regist=
er_with_info>`
> +  or, if your driver needs a remove function,
> +  :ref:`hwmon_device_register_with_info() <hwmon_device_register_with_in=
fo>` to
> +  register your driver with the ``hwmon`` subsystem. Try using devm_add_=
action()
> +  instead of a remove function if possible. Do not use any of the deprec=
ated
> +  registration functions.

And here.

> -* Do not provide support for deprecated sysfs attributes.
> +* Do not provide support for deprecated ``sysfs`` attributes.

Dunno if sysfs (as subsystem name) also needs to be inlined.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--25CJpLEImxGsf4/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFSHawAKCRD2uYlJVVFO
o7XUAQDfbXg0sNIzBhhokOCsjuDlTw0Q1vvP6BPSPrANQc4q1wEAxQFd/Qvkmlwr
iM5HwGpAQ77fNQV02hQ5lQyGndcCoAk=
=GUrd
-----END PGP SIGNATURE-----

--25CJpLEImxGsf4/m--
