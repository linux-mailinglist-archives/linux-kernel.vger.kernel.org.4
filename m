Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9318B63154A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKTQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:57:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332C178BD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:57:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w4so6109586qts.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+VIo3bXwJL7SCkFUqftA57rk/MTISGf9OS0PkQ53fU=;
        b=q7rQ4P8FRSe8E4ITCTt7ygFztDEN/f4BX/t+YYivurGMIldAoMBFXKPy7YPxIK1vpD
         kzt5k5geD3mwTOxtpmZOCoNAowgFqf0W6Qz5LVkwcOyd+02PHocQ/3dWOwT6huSlWqMh
         pW4E/8xjXAWgJpf8qlbraXTgM7qLRm6Cqjs2fCNrxz3/VAdYw8LELhdXWzG7bckTv6fc
         nSFwGokZN9pYj9IdFVdRn+vHlaKBESf9VqTkGBwfZME5REB7L5m3So8bc7yDJTQXUlSI
         EUQkfVkUtELmqZahiO1HeDVGjw9v2H35+gcKSTcNV3o26K2DaqO+08TH0mw8u4c5FRGw
         IsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+VIo3bXwJL7SCkFUqftA57rk/MTISGf9OS0PkQ53fU=;
        b=sG+TBi6vm46JIgDcKiClJvacQUMynqyHkHVy4l5KA6m53dw7Wp6w9VI5ufEVOon8As
         bsPP+VFL0wni2xgiznf/5WB6xF7d/vUhg6VGov0N1Qk592qTGEWV3DZxiF+zlGEkPByy
         V+QZ2Eu21I1Ok5aA6Smy6UJja5gu4SGoWyPWgrKN4py29qBf+hQT0Ji22Dp+RLS2iY/E
         euI4+rIgWv7fjTEPC3pO88KY5eZQvu40DPWdn+0TILNmH11IoniiE/cNyq5OCpjFZuSZ
         YyeFp7GQO4xBaXGK4lMezD265aP8NnWKmx3WPdK6xazO20m8v2RN7OM+OMswuxTRY/Bo
         YBSQ==
X-Gm-Message-State: ANoB5pk3LJKOucciIwSWGN6lb6EDuFejJvkN54FqcTU+B6bQKd3snqOO
        8mWUFOWJwdbOgiMrzf5rdA3qEg==
X-Google-Smtp-Source: AA0mqf77g62bEStNLdYbkKLq1/LPs3WrGz4b2DsWAst4+5+zzDaFRf4TgscqOEnJTMYksAesFpWuhg==
X-Received: by 2002:ac8:4545:0:b0:3a5:89c1:a4bf with SMTP id z5-20020ac84545000000b003a589c1a4bfmr14734955qtn.387.1668963477194;
        Sun, 20 Nov 2022 08:57:57 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a245100b006cfc1d827cbsm6766753qkn.9.2022.11.20.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 08:57:56 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:57:54 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3pcktcpTaLYlOa2@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <5123090e11da67e57fb00984445ece2f@walle.cc>
 <Y3ZflHI6CYfaGIbn@sirena.org.uk>
 <bbe25d96e892e8cfd3f0da5d6755be22@walle.cc>
 <Y3dx1rx8mXR7vRX9@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQ+79pNt5B3VS6wu"
Content-Disposition: inline
In-Reply-To: <Y3dx1rx8mXR7vRX9@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQ+79pNt5B3VS6wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 11:51:50AM +0000, Mark Brown wrote:
> On Thu, Nov 17, 2022 at 05:30:29PM +0100, Michael Walle wrote:
> > Am 2022-11-17 17:21, schrieb Mark Brown:
>=20
> > > It's probably useful to provide a query function in the regmap
> > > API for generic regmap users like this.
>=20
> > Now I'm confused. Last time, I've proposed that, there was push
> > back from you:
> > https://lore.kernel.org/linux-gpio/20210430151908.GC5981@sirena.org.uk/
>=20
> > That being said, I'd prefer to have such a query API :)
>=20
> Now we have a generic user which cares about the distinction.

I plan on adding more drivers in future patch sets so I expect this to
actually grow in users. Having a query function in the regmap API would
be useful after all I think.

Michael, if you resubmit your proposal for such a function, please CC me
so I can be kept aware of this as well.

Thanks,

William Breathitt Gray

--hQ+79pNt5B3VS6wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3pckgAKCRC1SFbKvhIj
K3Q6APsEkODNI0xc3PzAKl8kfwwfL58JCdeUAaR/5fwN4YbBBQEA/xy6zJzu22Ik
8QWrFewhKB6MWgSosfK9IYGe4lZUfAc=
=atAX
-----END PGP SIGNATURE-----

--hQ+79pNt5B3VS6wu--
