Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4055F0996
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiI3LKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiI3LJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:09:38 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3310F723;
        Fri, 30 Sep 2022 03:46:08 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C980A1C0017; Fri, 30 Sep 2022 12:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1664534712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il/taYMbbtNSWzJc33Fe3cBexV3ZZEZqg1p66cD8ChU=;
        b=FHTEw7RWH2Nae3OIJKyPu8WZh6jWRiv8uluiqXkCXJvjFSapWTUza9isNkPjbes8QF7HW7
        u8rmqM2fRKPsAPEK41j9WkY8KMlEaRvbCTQaHPnypI7nu0x+YfudcKA36yhhwPFXysJ/m4
        gfTxl6gzxt4qGO80KriV6TWCx4+Zjhk=
Date:   Fri, 30 Sep 2022 12:45:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH] ARM: dts: lan966x: add led configuration
Message-ID: <20220930104512.GA18584@duo.ucw.cz>
References: <20220831194430.53108-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20220831194430.53108-1-horatiu.vultur@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add led configuration for pcb8291 and pcb8309. Both pcbs have 4 leds which
> are connected to the sgpio controller.

> +		led-s0-blue {
> +			label =3D "s0:blue";
> +			label =3D "s0:green";
> +			label =3D "s1:blue";
> +			label =3D "s1:green";

Can we get more usefule led labels, please?

								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzbIuAAKCRAw5/Bqldv6
8h5tAJ0YF9dZus2BdqDx6YQECrgcHqfSzwCfatVPW74eeCmJM45fQHUv2FFXDks=
=OyfC
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
