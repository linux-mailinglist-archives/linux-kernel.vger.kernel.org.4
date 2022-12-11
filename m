Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC464946C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLKN0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:26:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18735FCC9;
        Sun, 11 Dec 2022 05:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6E5F60DE4;
        Sun, 11 Dec 2022 13:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEAC433EF;
        Sun, 11 Dec 2022 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765198;
        bh=wMIIzxtmz+YusmMimLm3e2w8T+SRlS4JWqkqezBT9oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ch+A0fppccq/94yAwBbIC9e600YYr3O8E9a4IF5YTZcmiLgd/yu+KrVf1KHAXu1JV
         5/aMR0Gs2k/aXgnqoS3uRyQLx/meQB9Ap2C3ZX7b2ii0oXUX8sB3Cu2tmp2UY5CQwy
         PtMLgZ2lYPpbd67FDmNUjxqIbiq6vgwraigu5ncrT36n27Zit9Ob6F+BCJ16BQpXFF
         WhtnQHkIo1lxU/GJ7a8o6gy/Q9UX5UQSDg6Tjeo7sw7juFTmfB9SSMVa3xjXyGOLCw
         BXz0DZPRc8QphLOZN/UQFRSKeeF5sQXnoRWpLHhjp6SwpALDUsm7eTX5xsYgulOydS
         XUE9j4YusbmXA==
Date:   Sun, 11 Dec 2022 13:39:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: Fix spelling mistake "Errow" ->
 "Error"
Message-ID: <20221211133932.088f7b77@jic23-huawei>
In-Reply-To: <20221209233202.222083-1-colin.i.king@gmail.com>
References: <20221209233202.222083-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Fri,  9 Dec 2022 23:32:02 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied, but will have to wait for next cycle now.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/kmx61.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index e692dfeeda44..53ba020fa5d0 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -649,7 +649,7 @@ static int kmx61_chip_update_thresholds(struct kmx61_data *data)
>  					KMX61_REG_WUF_TIMER,
>  					data->wake_duration);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Errow writing reg_wuf_timer\n");
> +		dev_err(&data->client->dev, "Error writing reg_wuf_timer\n");
>  		return ret;
>  	}
>  

