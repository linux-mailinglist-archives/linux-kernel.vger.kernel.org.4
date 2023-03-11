Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCB6B5B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCKMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:22:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1559116C11;
        Sat, 11 Mar 2023 04:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D84BB8250B;
        Sat, 11 Mar 2023 12:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE4CC433D2;
        Sat, 11 Mar 2023 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678537324;
        bh=mHoVhienBnOUnlaSutDzEvYnbmT2WBB6oOBYve/vQYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H+5ISIOIZxY2XJKWpr3i967RjvpLaNsA3BqPyWMozGkju8eR+EypST3XxmjmkmFHR
         MYKUbDltRMziS8oCEgcJXF6F8IA6JCRCx4IGbUSOrwCRaW7HSZo8kIpE6VBTSDXYSg
         MXWE+gDeaM9Y1Vlw8PAvgPQ5vq78/gUIsM6c0URlZH3RyipHfGyBOY70uNDJImsz1v
         7Chpa+6TBdFxREeW4RuW6Y5vzSc0q+fnhelaimgNwpwNo5o7QnwSPumBsVjZVlmAaC
         NVihljzqqYYwBH0LvEVujB6hnDWYpoh8wFWUkb9mBdQg2TvkEO5zenYsntFTfKdDi5
         /KSD1xlWqlbPQ==
Date:   Sat, 11 Mar 2023 12:22:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe
 unused
Message-ID: <20230311122208.059a81cb@jic23-huawei>
In-Reply-To: <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
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

On Sat, 11 Mar 2023 12:14:55 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused (of_device_id is not used for device matching):

It should be used for device matching I think, so I'd rather see
it assigned for that purpose than hiding the issue.


>=20
>   drivers/iio/dac/ad5755.c:865:34: error: =E2=80=98ad5755_of_match=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/dac/ad5755.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index beadfa938d2d..a6dc8a0bfc29 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -862,7 +862,7 @@ static const struct spi_device_id ad5755_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, ad5755_id);
> =20
> -static const struct of_device_id ad5755_of_match[] =3D {
> +static const struct of_device_id ad5755_of_match[] __maybe_unused =3D {
>  	{ .compatible =3D "adi,ad5755" },
>  	{ .compatible =3D "adi,ad5755-1" },
>  	{ .compatible =3D "adi,ad5757" },

