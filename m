Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F726C2A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCUGL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCUGL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6521954;
        Mon, 20 Mar 2023 23:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA84618BB;
        Tue, 21 Mar 2023 06:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B9C433EF;
        Tue, 21 Mar 2023 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679379085;
        bh=e4KeP0Jj7jEFEhtwLwBd8yfk3eg3gh5xp+hcXYcRwSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoUwQhhZKlSolub/ogaCXgnXRBYiwRRznkjZeFV+CMShgY434FPdOLIJL30DEZGS9
         h9FMmZDHa/l/vyxc4u+VSzWDfORy3nZCwEJ8e7T+Cr8b0o6HNMHRfpHLWbm5pC8PSG
         a+IsN7Qvt8ugJc+B7PAWGDw/v/Bx19omvTsKXLf4=
Date:   Tue, 21 Mar 2023 07:11:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: remove camel case
Message-ID: <ZBlKijo6zLsE8jUx@kroah.com>
References: <ZBiPlhkqHUegMRAb@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiPlhkqHUegMRAb@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:53:42PM +0500, Khadija Kamran wrote:
> Several variables and functions were named Camel Case. This resulted in
> checks pointed by checkpatch.pl
> 
> Avoid camel case by changing names.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 64 ++++++++++++++---------------

This has nothing to do with "greybus" :(

>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 79467f056a05..49702beeac30 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -672,7 +672,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
>  		adt7316_store_da_high_resolution,
>  		0);
> 
> -static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> +static ssize_t adt7316_show_AIN_internal_vref(struct device *dev,

"Vref" is correct, please keep it as is.

thanks,

greg k-h
