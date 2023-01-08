Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD166152A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:46:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7692;
        Sun,  8 Jan 2023 04:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7660B802C5;
        Sun,  8 Jan 2023 12:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B43C433D2;
        Sun,  8 Jan 2023 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673181993;
        bh=z3aS8L/e6jyYFRWSQ4chTGFyGAG153A6jfkZStOXvqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CvL21J+JIvrUebUYwH7XRqCwSKU4ZVIMbb3aJQ1VWxtbQNwM1fJwcHlDv+trmV6oi
         9G2n2zeNl7sB98w5JleZBS2GZkkurxdfQD/Rf6x3kCYGTN1gE5LwgvgsZg/smmaXJO
         CXwo6twEIFHzYMPkLJLXP2MhYrrHL5yJCG4+nP3RfoO5pG2josv8P6DcX6005KFiMd
         0zISHeIuBR5f6Q0qfNnkdRBlRBB18p1jW3CGZTNAE6z8obU0qTVxHjOfH87XkiMwGA
         jqrCzWmDL603wAYHsaKyVRK4yWr2jHIz7fit63ghEEAoNLp5V+14paMvZmkYZyE/LJ
         Kyg334hj4l1KQ==
Date:   Sun, 8 Jan 2023 13:00:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Vorwerk <zabe@avorwerk.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: cdc: Drop redundant if check
Message-ID: <20230108130002.4e0e4f1c@jic23-huawei>
In-Reply-To: <20230105025351.12099-1-zabe@avorwerk.net>
References: <20230105025351.12099-1-zabe@avorwerk.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Thu,  5 Jan 2023 03:53:51 +0100
Alexander Vorwerk <zabe@avorwerk.net> wrote:

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Vorwerk <zabe@avorwerk.net>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/cdc/ad7746.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
> index 6f68651ce1d5..a1db5469f2d1 100644
> --- a/drivers/iio/cdc/ad7746.c
> +++ b/drivers/iio/cdc/ad7746.c
> @@ -285,8 +285,7 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		if (chip->capdac_set != chan->channel)
> -			chip->capdac_set = chan->channel;
> +		chip->capdac_set = chan->channel;
>  		break;
>  	case IIO_VOLTAGE:
>  	case IIO_TEMP:

