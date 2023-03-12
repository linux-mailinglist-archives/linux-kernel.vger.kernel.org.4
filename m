Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028A26B6833
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCLQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCLQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:22:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C477E3A6;
        Sun, 12 Mar 2023 09:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF1FEB80D0D;
        Sun, 12 Mar 2023 16:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A96AC433D2;
        Sun, 12 Mar 2023 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678638046;
        bh=yb3LFvkQPvsuWr8mjLWiq2v1N0sLSdr/C/2q8szkUuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ObASvZK/bp8yDTZpOqHEBtcuBkIXLyPMnq9c1zeehHttiOUiv6ngbEFjYE65z4c09
         R9ofGe4AA64JQWMztxfGYZHYb5JlnImOMarKjuIyfczrqu+NU/XhoirHSFFbTWRnza
         ndSRY95l/VDlYMSQgPLL3sLP3Pgry1BAYz6ehVj9GDZadfswY/rOuDutDhsEGEK79g
         ayJqdpayZsK3t1M82XIUe7j71GrpUGPnt+nJxprV02w+0j3HudOn5L0rdr8R0bAR7Y
         mdsrR2xYxVrYKTo1FO5O3gZxE3LAyq7k0AV4Jud1wSeVwYY121QCu80HCGNs5y2C5Y
         QmMsRzbR1GbLQ==
Date:   Sun, 12 Mar 2023 16:20:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: dac: ad5755: mark OF related data as maybe
 unused
Message-ID: <20230312162034.040d0edb@jic23-huawei>
In-Reply-To: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
References: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 12 Mar 2023 16:34:27 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused (of_device_id is not used for device matching):
>=20
>   drivers/iio/dac/ad5755.c:865:34: error: =E2=80=98ad5755_of_match=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Changes since v1:
> 1. None.
>=20
> Although Jonathan expressed need of changes here, they are a bit too
> invasive for me thus I am resending it only for completeness.
> I understand therefore that patch might not be accepted.

Hi Krzysztof,

I'll leave it unapplied for now on basis I might get time in near future
to do the more major refactor I'd like to see (and hack some testing togeth=
er
for it).  If that looks unlikely I may pick this up later.

It'll sit in patchwork until then making me feel guilty :)

Thanks,

Jonathan

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

