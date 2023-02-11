Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949C693265
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBKQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:23:47 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F75B91;
        Sat, 11 Feb 2023 08:23:47 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 282431C0DFD; Sat, 11 Feb 2023 17:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676132626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r92fy9MW3nH3RxLudTkvfuM0yDdhsZSc0e0m5YaXE9g=;
        b=Knle6Z65jbUJSnUYVyyuI/HmaLqtYaxtxck6kd3nP7sWcffjoc67KzY1ymfHjs5Eb8Wkcf
        CggLgOe0hu/wPlJXoJbJgs/dbwqm9kivpY46yhkav9f8VqQ2cpT6AqUQgSGZL7OoLJ6B2O
        wa5FVCOcOQvqyLz4VWdtjj2EaNmNwPE=
Date:   Sat, 11 Feb 2023 17:23:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 notification LED
Message-ID: <Y+fBEWMWOoNiKKO7@duo.ucw.cz>
References: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
 <20230122-msm8974-bacon-features-v2-5-06bb83c20a58@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kPesULmYibtARmJP"
Content-Disposition: inline
In-Reply-To: <20230122-msm8974-bacon-features-v2-5-06bb83c20a58@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kPesULmYibtARmJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2023-02-06 21:40:18, Luca Weiss wrote:
> Add the node describing the sn3193 that's used to provide notification
> LED.
>=20
> Unfortunately the driver currently supports neither multicolor API nor
> using the properties function & color, so we use label instead.

Let's not do that. It will be hard to fix it later without changing
ABI.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--kPesULmYibtARmJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+fBEQAKCRAw5/Bqldv6
8uBZAKCeeNh7D75ok+13fywiOaW+E+nSjwCfQJbiSrQfTlSZeEJbHf1dNCHj/H0=
=UAFw
-----END PGP SIGNATURE-----

--kPesULmYibtARmJP--
