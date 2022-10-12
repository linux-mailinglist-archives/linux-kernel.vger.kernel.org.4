Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B035FC6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJLNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:52:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD8CBFD0;
        Wed, 12 Oct 2022 06:52:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r14so25870102lfm.2;
        Wed, 12 Oct 2022 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Av9jfmBLB3MkNTUY2kvCnqyFqWJkzajPb8rtbOp3slk=;
        b=JupHw3KW7Hva8rWx89prZtXUJ7mo3XjIiuPpUkiSODSgxADVEyxKjkHGJilulfhwW5
         4aiMGzwSK20JMjFOzj/hyA+4KxsW7l0h1IWoJBvCzw8avjwgM0Zzr1b/0fuCwc4S4ahm
         CITh2jOmWevzPnxOfNdcuay37ExTKsFx/3fUqcyVNeScCsehxcVjjXF2RxhCLzfqK96x
         3m05/s+4Ya1WcCRozKVvR2g4FkrRX0EAugEvtOUZi0mTrW5SbK0GoYs4sSZBOmzx2xzP
         9PSVb80vJiVLbzX5vBi2WxbsILyPxQQS5RF9e5mYrxS/PaQTWtt8b5EF8uqrbgWSwAD3
         5+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av9jfmBLB3MkNTUY2kvCnqyFqWJkzajPb8rtbOp3slk=;
        b=30LBVbqIK+Lou74QApFafiym2c6qQKs+p4/Fx/VuFsJDCLRAuWuyebpWl0QbftO4Ol
         S72GwBfNWMTUKagpp6LVvFrPjACBKWGlZwRTrHHXSXfRhL3SPXBvnhhMkZ2NdM2zGEd5
         E1lSWT9iRIV+DvgrKH3ATBAm6IX51KMCKBVFVn42dYNDJQ/tmcbBzxUrd+8uQnOphr/t
         Y9cIafk5bU845Bt8PJ0SF0JoD0nEZmsl4QIjVXupZgy9ICo/Li4+uQ0OBEPMI9PdOBul
         lOVfQo9HAJDsX5HOtej3Wq6EvXqIiE/23wA6Uf0hsGlg3QjhhPTWXFVNPE4aGhirsnQK
         M7eA==
X-Gm-Message-State: ACrzQf2FTJR0utYg+Qxv1vzL6Q0WCdgqZ2QhW1gWUsfURHJ3K2THPm/N
        SvsQnXEuEM0KVVqCU0rnw0sT/qzBCmnntA==
X-Google-Smtp-Source: AMsMyM7r7lSzXbpeAzgyvQgPuxq6dT1fOkt9XpGsgN36zzCdglCAygNSzVB9ZA0zSGlSLpHunCuMZg==
X-Received: by 2002:a05:6512:39cd:b0:4a2:ff7:12ef with SMTP id k13-20020a05651239cd00b004a20ff712efmr11245049lfu.643.1665582736770;
        Wed, 12 Oct 2022 06:52:16 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g14-20020a2eb0ce000000b0026e99b5c5c3sm1831357ljl.41.2022.10.12.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:52:15 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:52:15 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: Fix out of bounds access of array
 mcp3911_osr_table
Message-ID: <Y0bGjwBBt4LZRACd@gmail.com>
References: <20221012134245.5345-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5nSA75CLaUsFpwFr"
Content-Disposition: inline
In-Reply-To: <20221012134245.5345-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5nSA75CLaUsFpwFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Colin,

On Wed, Oct 12, 2022 at 02:42:45PM +0100, Colin Ian King wrote:
> Currently the for-loop is using the size of the array mcp3911_osr_table
> as the upper bounds which is 0..31 which is causing an out of bounds
> access to the array at indexes 8..31. Fix this using the ARRAY_SIZE
> macro to get the size of the array in elements rather than bytes.
>=20
> Fixes: 6d965885f4ea ("iio: adc: mcp3911: add support for oversampling rat=
io")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thank you for the patch!

Dan was a little bit earlier to catch this though
https://lore.kernel.org/all/20221002132053.113f595f@jic23-huawei/

Best regards,
Marcus Folkesson

--5nSA75CLaUsFpwFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmNGxooACgkQiIBOb1ld
UjK6qRAA1rF7nxVVSdzREFmdFoVX0pepJFiU/yFdWzV9YtGYc3DG9UUr1wdJrN1l
DnVKu9knsxdGz9U+p4kBZxcp5ZqnMrqa+wkm2iYErDM4NeS/ZZNl/g+6vQL+i9yw
0U4CWoM9lzt1k1TkyTsv0qvv0mHMPup++c4EyOqOBJhAcew5vFVt6LjLZWwc3zaX
57BevVaDjE1ZFe1rj4d8MrbVdml7Os5E9vbuStqOMGz0SCKrJWSjvz7L5z7YGHrL
r8XouK0DNHGfbXmp4uW9Jj1ZO1fkq2Jh/lwGnSEcUDRTk0cuwsmh84Au4mtBOiWU
jnVqqhi3tCdeXY5Q7F3eiHeqyFO9PVb77DlwxTSw6+GGpI2jXJUuTYmIid/CWfHo
nQ/wb0yzUzWFPhSIGEOZjbqKSYjIF3g4M0H2hxWEpLMceQuhKo3aLxd9PxaUtE8l
X0/bMJNpjQa5Z/vf0fBY+tuEQMG3mkTN4h35sytcZoEQyOcKduGdXuMit0Uzma3m
LxlKZyKKhvNisSmWWe8oEEb+5V2umsgJiJ3c9Y2KQ5txHupUVpDXTD0oneg3Bqsn
vIy6J2AQzcms/4azildTz9r6HCkU3oL6jbEVk4R9PCjgq4Kg8kPyD+Wnp32oteW6
QGHa+RXIAh7adacB9Lh3fImBLCDX5Wzlj77NQFWS4zLdoj8pSX4=
=HgeC
-----END PGP SIGNATURE-----

--5nSA75CLaUsFpwFr--
