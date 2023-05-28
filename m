Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48029713A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjE1Oq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Oqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D45FA8;
        Sun, 28 May 2023 07:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B88560D2E;
        Sun, 28 May 2023 14:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB6C433EF;
        Sun, 28 May 2023 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685285214;
        bh=ikS4I6r1Rk9pUtv9Xmje9J7Gdp09e+VlZ3qP+uWyefM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FEeBR4C9b9RRwu5KOyE9CHR8ujekZDfBP2duLXZzlc/Ncuz1ePOfjCMWSwf8yXxUt
         qByBeLp8qAeAxMKFX5g4RgSf8IBWWeeszOFmprI8QwEB76IcYEajLUKtT9qK3bCnXY
         5T8jmR5t76U6Pbl0ve1uUi9nBJldA2Wok4b1vDDebVO/vlqJTnQE2xC8Kb0kXxbaMk
         d6wHolYA6sX6PEBHvuXheaVCHScU+up71LeEaz8AgrBKNmynyyTftbR/CTXErkUK/I
         IoAwjrsf5k9mmECBwxmsAKqLHoZkxC2gdYibcs2loUndc7MubJz9KH4EsxTB/ecrna
         5tDlEOeubUaBg==
Date:   Sun, 28 May 2023 16:03:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] iio: amplifiers: ad8366 Fix whitespace issue
Message-ID: <20230528160313.551794f0@jic23-huawei>
In-Reply-To: <20230528104802.22011-1-franziska.naepelt@gmail.com>
References: <20230528104802.22011-1-franziska.naepelt@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 12:48:02 +0200
Franziska Naepelt <franziska.naepelt@googlemail.com> wrote:

> This removes the following checkpatch issue:
> - ERROR: space prohibited before that ',' (ctx:WxW)
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/ad8366.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index f2c2ea79a07f..8d8c8ea94258 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -281,7 +281,7 @@ static int ad8366_probe(struct spi_device *spi)
>  	indio_dev->info = &ad8366_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = ad8366_write(indio_dev, 0 , 0);
> +	ret = ad8366_write(indio_dev, 0, 0);
>  	if (ret < 0)
>  		goto error_disable_reg;
>  
> 
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511

