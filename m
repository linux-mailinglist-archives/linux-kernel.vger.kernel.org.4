Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436A6C7151
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCWTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCWTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:49:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851FF940;
        Thu, 23 Mar 2023 12:49:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2119C1C0E45; Thu, 23 Mar 2023 20:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679600966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NF6JGwEiBb3A1966uTV2ceil1MVZpjYOBG+VDfrrDGk=;
        b=phZY1YA9DWHh+GMOFjap/L1p6/j6tG3kJeQJ5Dwdz+2vjdEXGygpKx1ZPj4socFkd5Zpjk
        XyDJGcoMRKoNip1eWXNbtpbRn7Ao1v8Y73xvP/52MXYLqaV7dGUL9NrckA3FrCnnZS30PM
        jHea30xt6OsLLiTgGWaK6vmMBrWJtVc=
Date:   Thu, 23 Mar 2023 20:49:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_c_skakit@quicinc.com
Subject: Re: [PATCH 2/3] leds: rgb: leds-qcom-lpg: Add support for high
 resolution PWM
Message-ID: <ZBytRdLCTm/D34Ua@duo.ucw.cz>
References: <20230316192134.26436-1-quic_amelende@quicinc.com>
 <20230316192134.26436-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ys+4h6ZS/zW1fps0"
Content-Disposition: inline
In-Reply-To: <20230316192134.26436-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ys+4h6ZS/zW1fps0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2023-03-16 12:21:33, Anjelique Melendez wrote:
> Certain PMICs like PMK8550 have a high resolution PWM module which can
> support from 8-bit to 15-bit PWM. Add support for it.
>=20
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Provided build problems are fixed:

Acked-by: Pavel Machek <pavel@ucw.cz>

							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ys+4h6ZS/zW1fps0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBytRQAKCRAw5/Bqldv6
8h/5AKC+0XiH3kRszN1Vtw6OzkIz3PMeYACdHjPxPeRAKnxjsC2upepDtSe3KLA=
=GpGg
-----END PGP SIGNATURE-----

--ys+4h6ZS/zW1fps0--
