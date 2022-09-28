Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065C5EDEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiI1O0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiI1O0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:26:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A6AB043;
        Wed, 28 Sep 2022 07:26:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so4623792eja.6;
        Wed, 28 Sep 2022 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ST2BK2mX1JCCQ9EFwAE5AZgxqJqWOKXszXNYYKrCeOo=;
        b=fOAtzd8r5UBHXZOTqNd+oJWdgIr3GR0dH4rYbxhJCt+n1wC1qN0wOOdeghk/B0ZOKY
         Ds3f/WSrShkTNGz8rSkG2WP3GbQuHtfVZ4LSSnSDLNS14Cd36vzDjJlaIUD6Mjc7Oejy
         P9E/LNtKNMlAS7xxyJXArBWsEk+wDmaxjwWwe3v4rexKnYNvNp1nYHCMM7XnvIxgvCIm
         TY2+L1domuiGpddzNb/Z4uPq0XT4eJs93PADRHjvhyzSpevT7CDdycDU/EhKMJ603N1f
         kzXn/Zv9L093xAMdPROKPjZAj5xcZIXuk63xm+lTwIyGxgYbK21AiEnmapr99sX9P7cS
         FzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ST2BK2mX1JCCQ9EFwAE5AZgxqJqWOKXszXNYYKrCeOo=;
        b=7rrpMcxbg7wCQ5yEzN41RSydm+nh/ajZoSgqnsU4ET2rhQFAk9vO1ZzwIYzS0cPZRU
         QVe1lU/yVLK690QfYdceBXxfap+WyAPhlTZRLrlsARz1Y6FEU4y/PLCwju7thQcWf3SF
         czhnHeC996EIBR0UW0MChlkdX6NnoUjgVbxQ59F+qoYBv240a2UUIDx/jTysFG/jZktE
         aRX7ZF0bui2Yg1gofkLeEVpPWswA0DsKpmct0rDIgrTaLQw6IHu99Qg/FgZE6sWO3x0N
         iXcDElHQdLQa4CgZYP+R9AlzEXaTL+jK5Xfxi9WoHDrGu/Ad7NqbWVIYK7u0CY0pDucO
         4ZXQ==
X-Gm-Message-State: ACrzQf3fOvwikbZB6jFf2eGkeSk33JxiaXb66uBq6MfyoNfnmPpUDSlp
        FYKtSecJGMHnBh2iyvfAayY=
X-Google-Smtp-Source: AMsMyM6XNfrZvpFbSGtzSmzUFzKSUmxyNXOHyplBro9a2JQ0GLSefzDlPE8FHnRnQki92+NorjgG8g==
X-Received: by 2002:a17:907:608f:b0:787:a1ae:1d3b with SMTP id ht15-20020a170907608f00b00787a1ae1d3bmr1146140ejc.431.1664375210394;
        Wed, 28 Sep 2022 07:26:50 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g17-20020a50ee11000000b00452e7ae2214sm369354eds.42.2022.09.28.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:26:49 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:26:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: Replace custom implementation of
 device_match_fwnode()
Message-ID: <YzRZp4e48XK6jAZD@orome>
References: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vdy9eD3fV+qPIudS"
Content-Disposition: inline
In-Reply-To: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
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


--vdy9eD3fV+qPIudS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 08:22:58PM +0300, Andy Shevchenko wrote:
> Replace custom implementation of the device_match_fwnode().
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I really don't see the point in having an exported symbol for this. It's
a simple comparison and the result is even longer than the original. The
*only* reason why this helper exists seems to be because it is getting
used in *_find_device() callbacks.

Honestly, I don't see a reason why this should be applied. And frankly,
why bother making all these changes. It's a waste of time, in my
opinion.

Thierry

--vdy9eD3fV+qPIudS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0WacACgkQ3SOs138+
s6GZPQ/9GNWC4zWN1qTFdvUJKUGytJRXd3aIpbRWPPgKs0JUnsO3vLmw1Z+Apaos
iDtgZdRUXn15+bO+/T47KsrVDy1+PC8ejhx1GEe8Ao268N5vDuXpMyotsZFBRHaU
POysXXfzZ0ATASmMCjXt2hWW7x2n4uxsobc6Y+EwtboZcS8UOaaQAaEA4MoFdCpl
FIO9LNq5NW4mRM6dV/7roK56igsBNTVr4KLQ4WGkP4DAOyMPOebUSxgYNWADMHgn
Te5jcNRw4t55P8YMqhSVjSm/xu2N/cqAWu9DGRo7t25ts2cY0o6blOGbj0kizW1+
1R5/g3Vz6XclBWPcGr+ILP2S1dQF4drpEuEer+EDv00T7B11HBsmz7Vz13GvU/Od
pX6hnvTFRdnRghSGqB4H340rougcPjQanqPkgv+MMJjW0DdVOX/HKcB179C/h/Vj
izQe77r3/GNcJRHUhi6/y3toTFHUthqfYuBBojETmvpLKaNkQQe5rUklu4RUncQL
kxjY9P1J7XJNSKkoOyleInHcbCgOtGzTYgYR3LLgYhl32rXHjwt38c5b7HK6Hl/f
K35l3uB1qTa1E4rWTu9LECNAYq+1UstNgBhd4wgztQRpK6Spbynafkxgk9aG14Pw
Vadh7dn/UfzAvURKhub6qQWjx3JSEsCQlprnMCy3FzR6eIvNi/I=
=aH0a
-----END PGP SIGNATURE-----

--vdy9eD3fV+qPIudS--
