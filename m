Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BB74F3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGKPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGKPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:45:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0E10FC;
        Tue, 11 Jul 2023 08:45:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so60380075e9.0;
        Tue, 11 Jul 2023 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689090343; x=1691682343;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEnZrLvHdlB3PZ8L85NuzxKsb9GUXwvaPc+7AvopSIs=;
        b=Ve35qujJ7tMg8SnA6xPQuYXHUiMu7GE3AMJYZK7HK5zf1Logu8Qu6+8webPkguM5CJ
         zU6QQXqlSkCuZm75x3tMegGpfByijBndA5Y0YvKrratm6judUwMv4rcGSwxfcdNZS8hw
         5Bhkvz/BD1yV02DttN2YFw9re4IgL74cfTTEpxWwYj4ewfStF+BwxdAYc0CltmNZW7NZ
         YpA4/EmUuYpz01gcEoIUJXN8A9ixew6NFEtTBR08NMSSfei5g5vBEb7pVWZpidiC/HOY
         u8Hntxen/sTpDMLqhbt3lQC1jt5+LuLrTtt90+7ETSwRmqiSBLt9E2OVM8cEuE5Ics8w
         xhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090343; x=1691682343;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEnZrLvHdlB3PZ8L85NuzxKsb9GUXwvaPc+7AvopSIs=;
        b=gZqp2fIGihN/qK6yi4kBqAJux7/THbhJ3Xqn0vj2v0wiL9m54N6AqVustP4O2q2twz
         dz1y4NEM3XS5EdAGViCqZa0thlvfeBCVCbzzPSMS5R9VOEzKIIP3rPaYM/Iz6xWtCvmO
         JVb/N92lfvq9FoMghoosuD+IZitWr5mVm2SWr8Ff45b/FYs50rFHfjxKVuiFFTLbKU0h
         4siI10Un5IYywhRH1hbijZitpkpxWGcoVXCpPZlbqJUCCtt675YjnirXWFW2QJICJ8cC
         UmwC22ZWfZ14AD2zQyftvnQk1MuM+o8+rL5CTncwwMOT31F2AOBwY0NvFn4K1q44LuLv
         D5QQ==
X-Gm-Message-State: ABy/qLZI0i+3kAO8JBHEpL3rUXjGNrKS0ZbhpjMbgR3M+TOFG08FTz8k
        k8pvGUlae1uo3Ui9GyLgCgw=
X-Google-Smtp-Source: APBJJlHXhHtlNJoX08En4eWf1XbIwtd8s5TeV7etCD1pudCcBw050V+aHMjErPbL6Odb/Ug0wgAW+Q==
X-Received: by 2002:a1c:7914:0:b0:3f9:b1e7:8a4b with SMTP id l20-20020a1c7914000000b003f9b1e78a4bmr14521606wme.21.1689090342506;
        Tue, 11 Jul 2023 08:45:42 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b00301a351a8d6sm2576702wrm.84.2023.07.11.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:45:42 -0700 (PDT)
Date:   Tue, 11 Jul 2023 17:45:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Message-ID: <ZK15JNtBFU_7l30o@orome>
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
 <ZKwdHUWzXujfVk0R@orome>
 <d3f07a74-3fce-2310-a1fc-239aa1a25024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B8pxxDeV9zU7sDZJ"
Content-Disposition: inline
In-Reply-To: <d3f07a74-3fce-2310-a1fc-239aa1a25024@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B8pxxDeV9zU7sDZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:30:54AM +0800, Guiting Shen wrote:
> On Mon, Jul 10, 2023 at 23:00:45PM GMT+8, Thierry Reding wrote:
> > On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
> >> The driver would never call clk_eanble() if the pwm channel already
> >> enable in bootloader which lead to dump the warning message of "the pwm
> >> clk already disabled" when poweroff the pwm channel.
> >>
> >> Add atmel_pwm_enanle_clk_if_on() in probe function to enable clk if the
> >> pwm channel already enabled in bootloader.
> >=20
> > You've got multiple spelling errors in the commit message. Also, PWM is
> > an abbreviation and so should be all uppercase (except for the subject
> > prefix). I also prefer spelling out terms like "clock" in the commit
> > message. This is text that is supposed to be readable. It's not code.
>=20
> Got it, Thank you. How about this commit message:
>=20
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the pwm
> clock already disabled" when turn off the PWM channel.
>=20
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clk if the
> PWM channel was already enabled in bootloader.

s/clk/clock/ but otherwise looks good.

Thierry

--B8pxxDeV9zU7sDZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSteSQACgkQ3SOs138+
s6Ewmw/+Jw6LqxW+nhesVM4WtgxXisrH0NZjNWnHnpN5oBoqgBSAVwdXgCPJKu4S
L5GBmquR2ovzDLFCrn7Rkmis9FGeTu+kwFtcQY3ni47JCb6sg+oNM2qHmjC3O/Ad
PpQMLLGaTsrCeSKYOiW1kSQXfB/O121aFdpDSuV2T/CZZWLeeFuCpPS6exjv7pCq
GesJT7F1ZyeCH6kLrNN+5aciCSa+uOiSmvfjcZPsKbQcwiVxILIGIKCz1m2bKghE
/7aA55I/l0G3DOkKk1JbY75tRVcyJDvldB39FMtY/vluqRxA2g/rWJ2EdGd9+IUr
obHvnvsKUKD1MvNhgNe3qBmZg8HUrimB/YLBvth4yhEDbr4jgTwiPK/++Yx8lXdK
CMbWdafBPsUingZ+N2oPfmYpm0zj91b7YR/dx43nqyQF4dfUi2NMw+eHZ/60jkst
dv7hEbNFTd4OTcKkHjHWVC4fSrrT59YjoDt286WkFV04cKmwq7TK6Vev1m4o0Pfb
zaMVQbja7A5Z+qQsPgIi8bFh0gzm0a7cZ1WsiDi7mSXkH3XoMcWyWrqlM6D7Z9BR
kpiMJ4nH2ZGNIMiU3R0OZdr8GZ+SS0suhefHnosHsGVmxDUXoHqei6PfI3AsYERd
QVsDLgy9kUM4ig4NAiZ7gHVB71Eb3DfnCi0A16fvfv/5w7h5kTY=
=frzs
-----END PGP SIGNATURE-----

--B8pxxDeV9zU7sDZJ--
