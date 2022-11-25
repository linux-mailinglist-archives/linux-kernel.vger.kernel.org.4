Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3F638822
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKYLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiKYLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:01:49 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC14A5A5;
        Fri, 25 Nov 2022 03:01:47 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E9F251C09FE; Fri, 25 Nov 2022 12:01:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669374104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXyqDQQ59BVTr+7aAy1Rwv26TeRNfyoVwKWF9sq8TvQ=;
        b=LfVQeZ+Vqc3GiXbUjfGtEg3jUKc72YGGE/57LCZtwvdesX4F72nbLabbLJGAF5L884nDRP
        TLz2TT/iaGKg8n6YUhtgbfqjn3oVU8Myzd1W9i1B9JQ5cMLLhWq6NNYFFks3s318lQ3RqX
        TbpRQElT8qRfoLw3jMlX8WExsScxXD0=
Date:   Fri, 25 Nov 2022 12:01:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] leds: MAINTAINERS: include dt-bindings headers
Message-ID: <Y4CgmOqhF12UtG+Q@duo.ucw.cz>
References: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
 <93f128ce-5229-5163-841a-66d3cd54130a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yBUrESvZpahUzmxj"
Content-Disposition: inline
In-Reply-To: <93f128ce-5229-5163-841a-66d3cd54130a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yBUrESvZpahUzmxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-11-25 11:52:59, Krzysztof Kozlowski wrote:
> On 30/08/2022 10:36, Krzysztof Kozlowski wrote:
> > Include the Devicetree binding headers in LED SUBSYSTEM entry.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
> Anyone is going to pick it up?

That's for me, I guess.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--yBUrESvZpahUzmxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4CgmAAKCRAw5/Bqldv6
8vNpAKCo1MRJ/StIB+ns+ZRbFLKs9DPBfgCgv9BwGlOdxYs5dgodtEQF0FdOKP8=
=I5nw
-----END PGP SIGNATURE-----

--yBUrESvZpahUzmxj--
