Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88349734C12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjFSHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFSHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:06:13 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20518199;
        Mon, 19 Jun 2023 00:06:11 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D1DD31C0AAC; Mon, 19 Jun 2023 09:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1687158369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBKY6rDl+2l5pERVpM4Y1EIIJKI7uRWoOFGHX9VdwhI=;
        b=fdlxs4MsPgvF64lGkjdfTTpiE3iWdAahByhRmjfJdp2vx0MXQm+4dKPXr3U9q9KaMSdiN0
        zLUp6K+8KawXiHlw7Rxy/anLu/jEpIFFXw8Ctps5k1zeDNUZGAU3+hRAvrHbsRWGDCISE8
        HZjyg5AtI7TqckiHNoxaxR4sW6wKO/4=
Date:   Mon, 19 Jun 2023 09:06:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     neil.armstrong@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
Message-ID: <ZI/+YYZ0SYAmtvtR@duo.ucw.cz>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
 <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
 <1a7bdcc1-c737-83c4-24af-eb0028ed45f4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w9pW6tvblwV0iO2W"
Content-Disposition: inline
In-Reply-To: <1a7bdcc1-c737-83c4-24af-eb0028ed45f4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w9pW6tvblwV0iO2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Sure, should I write it down here and/or update the commit message in a=
 new revision ?
>=20
> Yes please add this to the commit msg for the next version.

Actually, putting this into comment in the driver itself might be
good.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--w9pW6tvblwV0iO2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZI/+YQAKCRAw5/Bqldv6
8gthAJoDm1czkivRzCk/nxa3lCri/ps7sgCdFzZyoVdRqGX30p/yqxvDAhkF6iE=
=WGAo
-----END PGP SIGNATURE-----

--w9pW6tvblwV0iO2W--
