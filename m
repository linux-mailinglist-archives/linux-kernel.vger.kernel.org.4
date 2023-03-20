Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33F6C19F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjCTPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjCTPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:39:42 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3DB38E95
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:31:18 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5447d217bc6so230521257b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679326275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdjIm567qkBcR6Zk87uH5J+4skizW7Cn2uLqlnBIrks=;
        b=hxMkhDzFS4HWReDlRUh9SLZWjk6bX0nr5ikB2yOlyEAyFdpYWCN/Enb8EirYJu00x9
         pKKwomng7ND7yObX5o6OAwN+Rcng04Zw3Xpg+xWhjq7jsR2Oisd3TfVEVP0T8k5ZyD/m
         om4t9R8q701NHBN14oCxf4D5Ft4WLWGX0yjih7oR1AEy7Be4SUKll+vFUrVewJ7eYEyN
         MezvG8VBIcsvKQl3fIBWxj0VPEylka1XPaP3Ufi6nqSzq+ErcmgzAzt4ILBziUwVfwb1
         8erazUdnjCR1pWHnh2D9b17sJFAy1skVqveQotTFaKFWEVaXzk3cHtp/AWCbQ6e4gmnQ
         /VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdjIm567qkBcR6Zk87uH5J+4skizW7Cn2uLqlnBIrks=;
        b=A9uQPBp8ctY0XpggMzfFhDt/Fwe3oiaxTshBfsiqksGniiEJgtUnaP3lPghJ8xsVcH
         vtng8RAxYuvUpzphffccbhM59I5VhRmhU93JFIBczy/TgLT/bbfOoaEfbZHqZJ2J6uQi
         0iFoqz4d7zaeNIwcrR6kbpug6B42daM4YvokEuIEj7scYnTVrMD7NgStsKtTSY3mex32
         hYZuqGhBm9tUSKubk1BP5WA0VnhH3NvUpO2emTzXRM6sl+UlRgh7Z9IaK4J4vWE/JVSK
         uA+oTpi3zG6vXAG3eXJVNN6/8GQOOvosaaRfyi+wNnHZGzCgKB0BWsA/Wr9IqiMlTI0Y
         zcIg==
X-Gm-Message-State: AO0yUKWqOrrNZnl0zSMWK5A1yrWb30196IC45Iq8tJHeovTqnco5dBG/
        P9KJhlhKLufQavJtMhAW2uedaQ==
X-Google-Smtp-Source: AK7set9CmF/trI8O1BIyJ63UJAKQ5IO8hYkR0e7JraXdD+1qJQVOENDxW3WJFg3ivDhu2Vtvb3e5qw==
X-Received: by 2002:a81:a148:0:b0:541:96c1:495f with SMTP id y69-20020a81a148000000b0054196c1495fmr14818974ywg.18.1679326275188;
        Mon, 20 Mar 2023 08:31:15 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s128-20020a37a986000000b00741a984943fsm7585311qke.40.2023.03.20.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:31:10 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:31:07 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZBh8O5oOL0TB9wzT@fedora>
References: <cover.1679149542.git.william.gray@linaro.org>
 <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
 <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/gEyjofsgQlHKWQq"
Content-Disposition: inline
In-Reply-To: <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/gEyjofsgQlHKWQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 02:28:31PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 18, 2023 at 10:59:51AM -0400, William Breathitt Gray wrote:
> > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > dedicated functions to improve code clarity.
>=20
> ...
>=20
> > +static void quad8_preset_register_set(struct quad8 *const priv, const =
size_t id,
> > +				      const unsigned long preset)
> > +{
> > +	struct channel_reg __iomem *const chan =3D priv->reg->channel + id;
> > +	int i;
> > +
> > +	/* Reset Byte Pointer */
> > +	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
> > +
> > +	/* Set Preset Register */
> > +	for (i =3D 0; i < 3; i++)
> > +		iowrite8(preset >> (8 * i), &chan->data);
> > +}
>=20
> May we add generic __iowrite8_copy() / __ioread8_copy() instead?
>=20
> It seems that even current __ioread32_copy() and __iowrite32_copy() has to
> be amended to support IO.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Sure, I would use __iowrite8_copy() / __ioread8_copy() for these
situations if it were available.

Is something equivalent available for the regmap API? I'm planning to
migrate this driver to the regmap API soon after this patch series is
merged, so the *_copy() calls would need to migrated as well.

William Breathitt Gray

--/gEyjofsgQlHKWQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBh8OwAKCRC1SFbKvhIj
K+NBAP96JxKPh81zqyRL1AQgZuFfPFCsB8KcMETcK9WYBXfPRgEAvjNWudfdxTqs
CKrHqQ/dRgxfGdXMfwGXCSRw+YuofQU=
=/91A
-----END PGP SIGNATURE-----

--/gEyjofsgQlHKWQq--
