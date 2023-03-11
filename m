Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083C6B5FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCKTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCKTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:05:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2F6422D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:05:15 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r5so9375610qtp.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678561515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbfswi8F0tvm4TB1oEfjIUGvqcw32tOuUkfi+zA3fKw=;
        b=isog/hOcdR0ifh9gwT9ytZpi/1TJ1sGvjtWA9jWbewn5sb1LhFPYqwjJanA1Ruy9/r
         rtD1Ojyzd+2xcZw9IZ1a26aAkJ8Y3RdOuxJM1nDSMgl6VEVYhNrh7u8ojRu2+TOywzrv
         8uiqP4Bbr3AUhO5xncn1Ba39xuUG82QSlpR/Yq1SM+gZQkrfWqaKsn67x8VhWJ5xwDHJ
         aKD/3wFnYvMERio00Tq28Op3kwiOwtzNveqHeQNzPf/A+6wjAZcogh9Tm9xtw8FqNe5Q
         yNb2lWpyGYz4sW6ZO+d6jPm3EsAcjBIYFpd6qD/A32k0oUaMKc8MVxz2/tjdfsZTm9jG
         Ueqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678561515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbfswi8F0tvm4TB1oEfjIUGvqcw32tOuUkfi+zA3fKw=;
        b=gHib5AwQSbABH8lEO0Gu057fuH1s6uoI2Ev+mwRNOClFF7m5TqPqWNLmzebVLU8oY7
         HHqTTKxx0J1FiAFR42anWxClDSQsQiE0RoI9V0btJdjUlsus1aialcWhCwIHL/+2ny1P
         8SnaW4HIKVdDYxFkYKXnf9TgWoEgxdHTUrIg9tgGDTnjBv6x/IXm+ZHBb2IFx+Zszq/w
         CbxGC1WehuU7hD1/j80J5JZRjDmeD6u0UCEddwX14UlYnk+MlsZK4oZZUkrtKKqGDH3r
         0Z5PXKt8h4r2vdGj9WmdNAXA9yLz0J56VsaUQOgSPiqbrHTTjL5P3G0oJFpG7mNkJJgu
         J4tg==
X-Gm-Message-State: AO0yUKWqIRuc8zLr1yYiZCXtLzAxR0JYEvHoxGjDKi8KCdhEuqSOQVcN
        OuHLuPuh1JmQS4nwJs/XeXSNdLzwQq5en7BUiBc=
X-Google-Smtp-Source: AK7set8yXHbkrDKo9BiVAsqxPSADoxC9ajohxwr6pGdGG8Vk74ehqQzfvnlYxcWaedXAo35janM3nQ==
X-Received: by 2002:a05:622a:83:b0:3bf:da69:6107 with SMTP id o3-20020a05622a008300b003bfda696107mr48730811qtw.67.1678561514875;
        Sat, 11 Mar 2023 11:05:14 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b0073bacce6ad7sm2184377qkm.82.2023.03.11.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 11:05:14 -0800 (PST)
Date:   Sat, 11 Mar 2023 14:05:12 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: dac: cio-dac: Migrate to the regmap API
Message-ID: <ZAzQ6LyfllSjN16j@fedora>
References: <20230311140218.74920-1-william.gray@linaro.org>
 <20230311185719.7af38a8a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdSAI13kS9LQ1z0A"
Content-Disposition: inline
In-Reply-To: <20230311185719.7af38a8a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gdSAI13kS9LQ1z0A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 06:57:19PM +0000, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 09:02:18 -0500
> William Breathitt Gray <william.gray@linaro.org> wrote:
> > diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> > index 791dd999cf29..759833a6bd29 100644
> > --- a/drivers/iio/dac/cio-dac.c
> > +++ b/drivers/iio/dac/cio-dac.c
> > @@ -6,16 +6,15 @@
> >   * This driver supports the following Measurement Computing devices: C=
IO-DAC16,
> >   * CIO-DAC06, and PC104-DAC06.
> >   */
> > -#include <linux/bitops.h>
> > +#include <linux/bits.h>
>=20
> I'm not immediately spotting why this change is part of the regmap
> conversion.
>=20
> It may well make sense, but if unrelated, should probably be in a differe=
nt patch.

No you're right, this is an unrelated cleanup that I should probably
have pulled out to its own dedicated patch. If there is a need for a v3,
I'll split this off and submit it separately.

William Breathitt Gray

--gdSAI13kS9LQ1z0A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAzQ6AAKCRC1SFbKvhIj
KxfEAQC3HNpmFWAkWMGkhGrkKmzcQxNcUC1NNFwA3SJHUyAqDgEAlgvrzVmYbfQY
dx/LDVo9zCyk6h39l2Ys4VwxSnM5Fg4=
=OXGt
-----END PGP SIGNATURE-----

--gdSAI13kS9LQ1z0A--
