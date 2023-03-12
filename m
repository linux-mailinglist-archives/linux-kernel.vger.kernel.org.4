Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7F6B6830
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjCLQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCLQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE82D169;
        Sun, 12 Mar 2023 09:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 860BCB80CA5;
        Sun, 12 Mar 2023 16:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B406BC433EF;
        Sun, 12 Mar 2023 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678637928;
        bh=kxjO+Ajg2e4dJBZ8NRww9WdF51AN2NJ4TsJViXM+NKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hN68ox5t5PEU26u3/vo/cJHkOnGBZ0N5ObbWEtY9AMFdRFhoIwEOmvTCZ2xj93H6d
         DS1E5BqroYC1b8ZGvvWCmFzgqQgB0miY7zkpQKea+hLmLWlrQEjI3ttDsZiLBUrPQo
         tCF3jvxTHTUbmOJkB1FxfIkwQV6rJ6FV0Kx9ZROHnaT4RwR4uh/zwXDyOPyVVDu0fo
         6hC83HQrwGLuYcFg9hcdZxpk6f8l+NWqNVgFTWC/tf3icjma1RLsN0Bh9rnn/hO84V
         icNFm1sbg4pvk9gtTgSl8vf1xW+Cz85+kDJpqtY0qMHl1elgPRre4s0iUIOvU+7PDw
         qbkOnkLD7x9uA==
Date:   Sun, 12 Mar 2023 16:18:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: proximity: sx9500: Reference ACPI and OF ID
 data
Message-ID: <20230312161853.55b5b317@jic23-huawei>
In-Reply-To: <20230312153429.371702-3-krzysztof.kozlowski@linaro.org>
References: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
        <20230312153429.371702-3-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 16:34:29 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Always reference acpi_device_id and of_device_id tables, as they is
> little benefit of conditional compiling and OF table could be used also
> for ACPI matching via PRP0001.  This fixes warning:
>=20
>   drivers/iio/proximity/sx9500.c:1039:34: error: =E2=80=98sx9500_of_match=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
Applied

Thanks,

Jonathan

> Changes since v1:
> 1. Drop of_match_ptr and ACPI_PTR
> ---
>  drivers/iio/proximity/sx9500.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx950=
0.c
> index 8794e75e5bf9..9b2cfcade6a4 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1051,8 +1051,8 @@ MODULE_DEVICE_TABLE(i2c, sx9500_id);
>  static struct i2c_driver sx9500_driver =3D {
>  	.driver =3D {
>  		.name	=3D SX9500_DRIVER_NAME,
> -		.acpi_match_table =3D ACPI_PTR(sx9500_acpi_match),
> -		.of_match_table =3D of_match_ptr(sx9500_of_match),
> +		.acpi_match_table =3D sx9500_acpi_match,
> +		.of_match_table =3D sx9500_of_match,
>  		.pm =3D pm_sleep_ptr(&sx9500_pm_ops),
>  	},
>  	.probe_new	=3D sx9500_probe,

