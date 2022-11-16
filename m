Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5A62C892
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiKPS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiKPS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:58:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED36B0D;
        Wed, 16 Nov 2022 10:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD67B81E51;
        Wed, 16 Nov 2022 18:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37973C433C1;
        Wed, 16 Nov 2022 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668625112;
        bh=OS58wso0N083t3IgxbnhuBC2cfCnmOPfpkdT9jng7O0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGgr0PcdaXw6N2wNmKxEZbjKkGgvMnDOxBKIsa0qWtoEhsO7gsuo6RHPGN3vlsdTM
         UyA6S+E9aTlgJUMF0e38rCWowPCSUjk3YUEuCL3GTfi1Y6ZkucGrMY3GRdnBu/eOgw
         ZSDXvB8FgdWQqvjZ2Q/YY80xfgXMXl8VcZsLGe2eSJe+FDLhilyS7e5l/ZlggsB3b7
         4UGJtPQH5pglGQF6KHgyjGx8gS7ePQmhvF4tXlEIc/mfZC7NqPRSVwURTkiHJLTWan
         lNx3AhwNfuJ9uRnwudccwOGxsmw7ZPXZr5oVo0L4JmRxBnnEE2N6BRfnLV8EnUHBAA
         or6Wat0bkbG+w==
Date:   Wed, 16 Nov 2022 19:10:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio/adc: add ad7927 compatibility to ad7923 drivers
Message-ID: <20221116191056.59f901da@jic23-huawei>
In-Reply-To: <20221116104453.3207-1-edmund.berenson@emlix.com>
References: <20221116104453.3207-1-edmund.berenson@emlix.com>
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

On Wed, 16 Nov 2022 11:44:52 +0100
Edmund Berenson <edmund.berenson@emlix.com> wrote:

> The ADC ad7927 is compatible with ad7923 driver,
> add explicit compatible and select appropriate
> channel configuration.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
This should match local style for patch formatting (as with the
dt one that has already been commented on).


iio: adc: ad7928: Add ad7927

The ad7927 is software compatible with the existing AD7928
so just add the ID.

S...

Change itself is fine.

> ---
>  drivers/iio/adc/ad7923.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 9d6bf6d0927a..df72e97dc331 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
> + * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7927/AD7928 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
>   * Copyright 2012 CS Systemes d'Information
> @@ -367,6 +367,7 @@ static const struct spi_device_id ad7923_id[] = {
>  	{"ad7924", AD7924},
>  	{"ad7908", AD7908},
>  	{"ad7918", AD7918},
> +	{"ad7927", AD7928},
>  	{"ad7928", AD7928},
>  	{}
>  };
> @@ -379,6 +380,7 @@ static const struct of_device_id ad7923_of_match[] = {
>  	{ .compatible = "adi,ad7924", },
>  	{ .compatible = "adi,ad7908", },
>  	{ .compatible = "adi,ad7918", },
> +	{ .compatible = "adi,ad7927", },
>  	{ .compatible = "adi,ad7928", },
>  	{ },
>  };

