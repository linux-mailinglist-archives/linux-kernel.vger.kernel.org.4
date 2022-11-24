Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF127637F66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKXTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14C663DC;
        Thu, 24 Nov 2022 11:12:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15DE4621FC;
        Thu, 24 Nov 2022 19:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05400C433D6;
        Thu, 24 Nov 2022 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669317139;
        bh=fm5hOY1yL5EyiRszJuhpXBvb/9VJ/KPDtI6wze+nQP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UDOzl5ePCO7sbcRg6ZQAGDYW/Qlx4j2W5Tz71b4rTPSJHpS7fnxYGTmdFhYvqmGD3
         mmtgd7C8CxX5WbkBOVTHorfOdajrdZiaB7GGWPtpnuBr2GtmIDwqiej1pdtI3rJxaY
         MGV08wfTlylbnFuD8jK4GArnVdpTI80vj0IUUiTPPA+RLKVhnLX8Gh9e86A62xD3VD
         6dU54VPJ0gO2XVLX8PpycESIS7AVgNjlrDgKU2cdm53Ai5FrlImW42S6QWm88TJw9e
         fzrrKcKE4Br1ubJgvTANG07iKQGXiP/Vc7pc3JbrWudlogMb6uZrM0zqXZHFL1mBqR
         Fq8IR2h3taXCw==
Date:   Thu, 24 Nov 2022 19:24:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: fix blank line after declaration
 warning
Message-ID: <20221124192453.13cf0d1c@jic23-huawei>
In-Reply-To: <20221124153049.8851-1-cosmin.tanislav@analog.com>
References: <20221124153049.8851-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 17:30:49 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> Checkpatch wants a blank line after all declarations. Add it now,
> even though the patch has already been submitted.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Fixes: 7b2366008125 ("iio: addac: ad74413r: add spi_device_id table")
Dropped fixes tag as this is just cosmetic.

Applied.
> ---
>  drivers/iio/addac/ad74413r.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 61030053cbea..f32c8c2fb26d 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1315,6 +1315,7 @@ static int ad74413r_probe(struct spi_device *spi)
>  	st->chip_info = device_get_match_data(&spi->dev);
>  	if (!st->chip_info) {
>  		const struct spi_device_id *id = spi_get_device_id(spi);
> +
>  		if (id)
>  			st->chip_info =
>  				(struct ad74413r_chip_info *)id->driver_data;

