Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BE719739
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjFAJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjFAJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:39:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D210C6;
        Thu,  1 Jun 2023 02:39:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f7377c86aso82331966b.1;
        Thu, 01 Jun 2023 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685612354; x=1688204354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC5Mt14VowRy48GhWbY/bbPfnc3e4XQZGJKCwvTP6ko=;
        b=fmuq76LBD/BKMfC3X4c2kFRL8sTgZbczaJn52qRjd8YtoPzFDjCEUBSzpNujsGujFy
         XivSodLO+1PFuPikCZ6/WWYhw6Spa1d0HkH7WonfCbAfeUSEcGOAtwrEv5J9hWalGlEx
         VA6zd7rWZKjii/15yOj6sz3UkwI4isdyDBbSB2ZVydBC/frwV0O6gFLz8QXobXAojT5P
         lQFNhZU3tONYzX6mZDcS9g6TsvAd8XoAl39xDPdKNRtpaVp6h6bh9zxWVgrZrtxVpGfU
         fyv361XSbQfjBP9JzSkZeUWLU/hBf5Xt7vJO2PRrYK/PiWICFFWXkOT9nf9bfu6/tAj9
         lb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612354; x=1688204354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC5Mt14VowRy48GhWbY/bbPfnc3e4XQZGJKCwvTP6ko=;
        b=E3TC6O9fDcdWA8bxdPfC3juNIoiAAP7cNpLxU2v/qyowtEYnoa4q9+w3iCSz9Fxg0b
         DR3FWmjhuDzFD7kXdTX6E4u9y7pdXc6L1XBgnsH2TZYc9wvOi+b2eFkwIpw5yM/7c5Po
         kjrxK/4g0OeZR9dSMtzbKEX2CYrZAHOTV4VHlI/ZF6HDgqJNTHE71JLhJxxJJ8QlwpXR
         xicKI5lh9MTmfGbRkWNQ2IwJv/MiyOUxSKHKRaanJmp0i3dIXMjmNAnX3JH80fGbJyuX
         yWT6MJyFDV1x6lMZVBEJnGRuqLUaGzIbeIqyS9MHAzTtSLFx4A1WLuRzOwnxHrhw9BEP
         v86Q==
X-Gm-Message-State: AC+VfDx7L1Oc/SKb1c2wuSTcQQN1xzUUb/waFxnFQr4+kWihsn8dd7SW
        YgYkgA08lMD7apgdultUh1M=
X-Google-Smtp-Source: ACHHUZ6ILEXI3QJmp4nRG4KOpkeYq8Pt7UaWqDtHvvuvoVXfwFQaWKwGPE2d8M3iV0SJByYpeyRvow==
X-Received: by 2002:a17:907:3fa8:b0:973:93d6:189f with SMTP id hr40-20020a1709073fa800b0097393d6189fmr8278145ejc.61.1685612353929;
        Thu, 01 Jun 2023 02:39:13 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402230200b00510d110db58sm6826402eda.80.2023.06.01.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:39:13 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:39:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org,
        jonathanh@nvidia.com, nkristam@nvidia.com,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: xusb: check return value of devm_kzalloc()
Message-ID: <ZHhnP506sBQ3EGGf@orome>
References: <20230531073950.145339-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SzK0EoW6aJTj4hu0"
Content-Disposition: inline
In-Reply-To: <20230531073950.145339-1-claudiu.beznea@microchip.com>
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


--SzK0EoW6aJTj4hu0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 10:39:50AM +0300, Claudiu Beznea wrote:
> devm_kzalloc() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>=20
> Hi,
>=20
> This has been addressed using kmerr.cocci script proposed for update
> at [1].
>=20
> Thank you,
> Claudiu Beznea
>=20
> [1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@m=
icrochip.com/
>=20
>  drivers/phy/tegra/xusb.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--SzK0EoW6aJTj4hu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmR4Zz0ACgkQ3SOs138+
s6GGHBAAtshFSZ3QcyCHwyKBFbTQGF3yAnYM6G6AkNLNP6wp3gPNnFalHh5khzoz
uOWAroLAJrkmk9BLwwonPFbwdirJW7tkJzhc8Ed2wuEqpHoqnri26zXJerzUIVqZ
nRSzIqgLVLZberDqE7wtWORJe/DEvJZm3nVi0Fm9UvpUUDaQERId4dznkMz6RD8K
8Ir7AOy8UubrL3eWUO82suI986h8P7wSSF5bf99TChpzwkamiFV/HtbXUmRez/Ve
JdBpS7UyflCycZc/5toHvRMZiOBnUbeZKqtApRJ6P/ef5Yc0uEd1TcIkq5EPhNw2
ik8PO1g9Uktykvr5nJG13uUj11ESd8avT5yI/+PL7y4g/l5qWFWxtH84chbrZD+5
0NcPWcoZqtP9wMvzi347zU+nD4TVhRPU0F9ATCSYr7LbKrbmrJSpb7FZNTPpkx2b
YLSni3X+d3Q74XxhP9lS+0G1gd3G4upCdD0QwAEVAbvk5iMMVPCknzibariu5mfI
7gMZTBwynWXFV8F1NFiIhvFPU+0+u+lPys+hi6tMoP9Ly4d/unJqQxJ3MAmU4PT8
3xpMQacse1AK2qYuU6HRM8KYRC7rSZw4syOdW5Tf4w//cC89IDWKiu2w3FNQ8KSo
Hs/baYySpA5iUCFBHnMXhyQnr3hIjwdeZPD/cH15VozAKLLdPP0=
=qovl
-----END PGP SIGNATURE-----

--SzK0EoW6aJTj4hu0--
