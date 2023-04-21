Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6076EA958
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjDULiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDULiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:38:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3392CC1D;
        Fri, 21 Apr 2023 04:37:34 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 66D661C0DED; Fri, 21 Apr 2023 13:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1682076995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUsB9flGPWmA2C74bb4reggvNQSxmEsXquICi1rN/WQ=;
        b=VjcyrYD/KZGc65MiGPGlhcff9lr1mQR1YF5oOHZfsYn5oErBQsDt5QlAK6XWNbYt4Sj6vL
        spe5z2X/T867GSsQXSt0zVlTPN2WUvjjaYeON1Ugp0HpxMLvdcFELxPcfPtBxcvICx+0v/
        PRw5GGTl3bTMgkmVcEU0bODd6T7Kq9o=
Date:   Fri, 21 Apr 2023 13:36:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v10 01/14] HP BIOSCFG driver - Documentation
Message-ID: <ZEJ1QhrnmkFqulOu@duo.ucw.cz>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
 <20230419151321.6167-2-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D/BGu9FHlhZNjAo7"
Content-Disposition: inline
In-Reply-To: <20230419151321.6167-2-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D/BGu9FHlhZNjAo7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.=E2=80=99s comme=
rcial
> notebooks.

> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'status' is a read-only file that returns ASCII text in JSO=
N format reporting
> +		the status information.
> +
> +		  "State": "not provisioned | provisioned | provisioning in progress ",
> +		  "Version": " Major. Minor ",
> +		  "Nonce": <16-bit unsigned number display in base 10>,
> +		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
> +		  "EndorsementKeyMod": "<256 bytes in base64>",
> +		  "SigningKeyMod": "<256 bytes in base64>"

I don't think JSON is exactly "one value per file". This needs
different interface.

BR,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--D/BGu9FHlhZNjAo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEJ1QgAKCRAw5/Bqldv6
8qwGAJ0anLrbi2fvXe5gvWMZbtYccTnEywCghZ7wvOcpln3RA9AJ63r1GXz212w=
=96OX
-----END PGP SIGNATURE-----

--D/BGu9FHlhZNjAo7--
