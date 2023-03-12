Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5246B682C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCLQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF851CAA;
        Sun, 12 Mar 2023 09:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 258CE60F60;
        Sun, 12 Mar 2023 16:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA5C433EF;
        Sun, 12 Mar 2023 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678637886;
        bh=KgAgfsSgV1oBhf5z2JR2P2AqCGcJpGDUhUxXj9OY51k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/tO3FrTXOVywCW3tNBKM3KEuVhu9NSu5SyJMZogD8XoeBMiyyx/VecXFe/xswH7i
         nLVzMMlUEtMhZE80c6eTFYr1KPE5od68h295d3oUT7hkAP8oxjQLlvafjYNfLWRXkV
         A36wx2/1Yv0dI/muy96xwP7SxWU7YK7Uzba3kxP6ZRdkb/B6tuWUuJryGxHvvl9bWB
         HS5NsQKNFsgjfhHc0/EqRR4KYey+HOjYCUvn7XPpwVSZi1YnJouRJENpxBeigZSa9F
         p9d0RupKfm5f/GPwI+rGlSz5R7wTmlJMc/3+6/hSAnG/Od9ZOCo3VcFZiJ+yQa3F/h
         Z172EV6HkfXTA==
Date:   Sun, 12 Mar 2023 16:18:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: max44009: add missing OF device
 matching
Message-ID: <20230312161812.7f997b5b@jic23-huawei>
In-Reply-To: <20230312153429.371702-2-krzysztof.kozlowski@linaro.org>
References: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
        <20230312153429.371702-2-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 16:34:28 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver currently matches only via i2c_device_id, but also has
> of_device_id table:
>=20
>   drivers/iio/light/max44009.c:545:34: error: =E2=80=98max44009_of_match=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>=20
> Changes since v1:
> 1. Drop __maybe_unused/of_match_ptr
> ---
>  drivers/iio/light/max44009.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 3dadace09fe2..176dcad6e8e8 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -527,6 +527,12 @@ static int max44009_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
> =20
> +static const struct of_device_id max44009_of_match[] =3D {
> +	{ .compatible =3D "maxim,max44009" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max44009_of_match);
> +
>  static const struct i2c_device_id max44009_id[] =3D {
>  	{ "max44009", 0 },
>  	{ }
> @@ -536,18 +542,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
>  static struct i2c_driver max44009_driver =3D {
>  	.driver =3D {
>  		.name =3D MAX44009_DRV_NAME,
> +		.of_match_table =3D max44009_of_match,
>  	},
>  	.probe_new =3D max44009_probe,
>  	.id_table =3D max44009_id,
>  };
>  module_i2c_driver(max44009_driver);
> =20
> -static const struct of_device_id max44009_of_match[] =3D {
> -	{ .compatible =3D "maxim,max44009" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, max44009_of_match);
> -
>  MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");

