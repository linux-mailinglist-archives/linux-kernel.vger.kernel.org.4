Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA3639BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiK0RTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0RTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:19:38 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FEAE099
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 09:19:33 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id e18so4604864qvs.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaE+HzmpBZ7f7D1ffTuZdztOBzyIi8jg53me1kyp8aw=;
        b=nUeXtzJdxMKgVNpyiqRBGWKJ0urrJluuMtWn3VUFHZGEwm1xmAB7SjlLBwEC5fdPWe
         MXJ/poaZUMxlZZMRcZA/kc2dusPJWuftsjCVCtnknXfOoa4EMiu+2+cqRTeRshe0Cbh4
         5En0wr2SOt6maNEq6JjdG/P3e/9RswfqkfmFGvVSFmc4VoDNZNNsMRR/loN/skKnWfdh
         JhBIxlZN5jF4EaooAT2hMyKdpDpNgY+Ho4IKib17LwQOTJDojAqTL0wRPvIpjV1VDHFF
         iAQiqE2pXMhczTk62TDR2aMQcDDK+KYxrDkzChzXsjiL+7ADhiKZomAjgwrlAhNDJag2
         HKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaE+HzmpBZ7f7D1ffTuZdztOBzyIi8jg53me1kyp8aw=;
        b=C4x2OtNdpaUZz0M0FyKf3JT/mZxNkE+qQHPhPzhcd/GoBxPgfjFEf1fJX3dslP+bvz
         f4e0yMYyGLl72GF4izj/JykwRHeb1G9u7YArVXeEHVnXzAOWHdFSR4YfwaYcgYNSecPb
         R6aTUNn1XqtOSvrZ471KYKChs93ZPKryvA+vNyp9+3P34nJ6ZeSgaDijh84wC0XKKIQZ
         NFUl9SGKzmdxssg/1xszfpHqHfgrCipgmhE7GJiolbNrKoLERKVQIL2mSlFl5N7B8CXM
         jRqWU6D5o1Tps5ohE1Ixj6yVUF74ysEU4e4Y/YxpMOT89Ec26y/0rDTs4xYV6zZbTQLf
         6NjA==
X-Gm-Message-State: ANoB5plp2jmt82usccv2z0JIBc2NDxrchLjmQB1CqIcnkGpbK3QQePLi
        5XE4y336actAR1n3fuqw6aQmeQ==
X-Google-Smtp-Source: AA0mqf7PTCfRY0ZZxjEk+D3oxT9LQ2sqnyQ8pE21nPC+TnHLrcPNS/qlW7l2UizVfAs6D6fflk/Ttg==
X-Received: by 2002:a05:6214:1027:b0:4c6:9127:b918 with SMTP id k7-20020a056214102700b004c69127b918mr25868890qvr.105.1669569572267;
        Sun, 27 Nov 2022 09:19:32 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cn11-20020a05622a248b00b003972790deb9sm5569417qtb.84.2022.11.27.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 09:19:31 -0800 (PST)
Date:   Tue, 22 Nov 2022 06:34:33 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 6/9] gpio: i8255: Migrate to gpio-regmap API
Message-ID: <Y3yzySLwPlN2MgQz@fedora>
References: <cover.1669100542.git.william.gray@linaro.org>
 <283c5af8825596d55b943b593eab561c912a088f.1669100542.git.william.gray@linaro.org>
 <Y35bgFmiMW3uTm/O@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8TFj+G0T0TRQ8kJ"
Content-Disposition: inline
In-Reply-To: <Y35bgFmiMW3uTm/O@smile.fi.intel.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8TFj+G0T0TRQ8kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 07:42:24PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 02:11:03AM -0500, William Breathitt Gray wrote:
> > +/**
> > + * struct i8255_regmap_config - Configuration for the register map of =
an i8255
> > + * @parent:	parent device
> > + * @map:	regmap for the i8255
> > + * @num_ppi:	number of i8255 Programmable Peripheral Interface
> > + * @names:	(optional) array of names for gpios
> > + * @domain:	(optional) IRQ domain if the controller is interrupt-capab=
le
>=20
> > + * Note: The regmap is expected to have cache enabled and i8255 control
> > + * registers not marked as volatile.
>=20
> Have you considered to catch wrong configurations by BUILD_BUG_ON() /
> static_assert() / another means of validation?

Ideally, I'd like to check for these configurations, but struct regmap
is an opaque type (the definition is in drivers/base/regmap/internal.h).
Do you know if there is some way to query a struct regmap for whether a
particular register has cache enabled or is marked as volatile?

William Breathitt Gray

--a8TFj+G0T0TRQ8kJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3yzyQAKCRC1SFbKvhIj
Ky9KAP42iq/9ni69tKLscqHnxJy12rS4ARDZdLWMji9vF56HjAD/ZoIQOw13blee
jeZ/w1zhsUnqVQJLb40fvdafTMMnBg0=
=vOL1
-----END PGP SIGNATURE-----

--a8TFj+G0T0TRQ8kJ--
