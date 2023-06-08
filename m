Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99AA728486
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFHQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjFHQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:02:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18D2D69;
        Thu,  8 Jun 2023 09:02:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso939602e87.2;
        Thu, 08 Jun 2023 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686240143; x=1688832143;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wC0K+zv5AaMummE4d3P8YjDZk92NoISkCSAunXVGk4=;
        b=sSmdcvdTIKcbbWpE2/GUSdX3TbsaPEe0R9RRWqwIy/hanhX+Z/mQuGCPScaej4+i6k
         kc/PMWRMTxJfMt1zprPQRUtcZOs6GrE3GSQ88x1+vheuTIB69V90L2Y/JkOQr8Fqm9z/
         PvJdRqUVKwZ2uHAC8U2yFndha8vwswH8BzqDUxc5s0K28tKdwpsJpgIQzMcIZffPY+N1
         B4TLEOFacaVwe2BKuQW12TKRkTEWpPDyEWFqKg4tYXe/dttLuTTH5UPTMNwmLykvDZtI
         oSItoC9R/icV1J0gMkil+CfqiaxMn9Qu+jeoeicvFcLV82jSuD1u67aRl/UfsZzzs2AB
         yOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240143; x=1688832143;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wC0K+zv5AaMummE4d3P8YjDZk92NoISkCSAunXVGk4=;
        b=jlHSgbyrRM5O8AoLAv5Pp+GCTNL9FE5vKbrAZdWV/1W/4gTAX1BK1IoY0p55J9oVB3
         MagRvgIeKKPPT4Jn85T9yZ9Jl2QzRK1fpo7A5/zGA3+17g074yyl3gEOttswnADF2rw+
         Bo6mdfgNzlgWkSIrzDW6I6NueQNySMdh+md6BjWoWn7iVfy06alRGXrVYFU3UeP8467O
         H1ZIN5HSIFOepFtAOTn3hwCAu4Qe4LVQJ0XioZ3mML7UhTCSEgT8yY4n1B90FDE+O4pT
         IFMlbWBfbOcTftCuljiCXSDM4Hjg8jaKHGEsj1Pu1LiY0DzhZg9UHfgxfjLfX+yM7dUU
         8QTQ==
X-Gm-Message-State: AC+VfDyJhxM6f0h232ECSVUIykGVEurhSm8c3cQO9U5X1XGvSoqZ5/5d
        Sv00nYLT4UwJrbLFILf5pRk=
X-Google-Smtp-Source: ACHHUZ5w3YwBhbIgXFXo2/U07gaxhtG8s+1zMFwADmxGA6MszF00HIz+sGxVpjrgliIAOGYzkGHgLg==
X-Received: by 2002:ac2:5445:0:b0:4f1:26f5:77fb with SMTP id d5-20020ac25445000000b004f126f577fbmr2777125lfn.28.1686240142422;
        Thu, 08 Jun 2023 09:02:22 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7cf0c000000b00514b8d5eb29sm698757edy.43.2023.06.08.09.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:02:21 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:02:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, smangipudi@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH v2] gpio: tegra186: Check PMC driver status before any
 request
Message-ID: <ZIH7jH09-Y7BIFPH@orome>
References: <496889ff-dd61-51af-c716-b9b9e2300be7@nvidia.com>
 <20230607113104.11761-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jrqh871mn6iBEVvD"
Content-Disposition: inline
In-Reply-To: <20230607113104.11761-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jrqh871mn6iBEVvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 05:01:04PM +0530, Prathamesh Shete wrote:
> When the PMC device is disabled, probing of the Tegra186 GPIO driver
> fails because the IRQ domain that is registered by the PMC driver is
> not found. The PMC IRQ domain is only used for wake-up and does not
> impact GPIO functionality in general. Therefore, if the PMC device is
> disabled, skip looking up the PMC IRQ domain to allow the GPIO driver
> to be probed.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Jrqh871mn6iBEVvD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSB+4sACgkQ3SOs138+
s6HCdg//Qt5jiYtxE2B83Jj7uqx28hS+mfupMUfd7f7S0LWBG0WYLliSEg//PI6e
s2EhsZckyZMpm323A05W3eO7DEA3iWHLa20Zw/fRSj6I4dRLoXWS4KEMQDkKEOeg
0s0klJoxSx5bCfy5TiEgwqpk1uh3cIjItVoDj4inAF4cR38UDJwJlx9OgUmUaeBb
n5xVj0JbWlyLJCw91wWnyPgWFYsVseG3n1isThfvUTRyG33TdezA7zlrsDh9CKi2
Uas0BbA+HHbrgukdYVHXH+HUhXSmQOc+YK+HHTQMB/zbKx8mCAql4La1elK5PD1C
DDJ5ys8mNdpE3HjvjEqxNNqWP+RTaPiiAelPa7qiw1bNHy8klaBCxLlqVLUB5d/h
73tzNuNinWo4TzJ20gov93MbWOuK/7/7KuZUEIBrXMrLFD7G60D5aX/AhAfBe0sK
GK+o7/k5EbXM/2UxWICOCkCQL0rp3Bxz68FtamaipMlQeeHffOQggQFlDxYKnTTT
yQhdwJEFpGWhkrL3ArdyGkjnlESDAbznKd86LwEWQddRRmw8YLMeQ1rjiMKbrIJ+
bTRe2imL6LEdjq57ZqV7DMabvnj86AIwpMvw8KLXbx7dSe8GZv4w9ny9IQmt/xVB
smfy39RIQDNJXk7tf2rinqHPpq8DDk2hJpvsuYTmsEKBBaO/fhs=
=LNUG
-----END PGP SIGNATURE-----

--Jrqh871mn6iBEVvD--
