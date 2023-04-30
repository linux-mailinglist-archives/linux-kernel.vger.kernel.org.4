Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC456F2989
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjD3Qso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3Qsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C585170A;
        Sun, 30 Apr 2023 09:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6CC560BB5;
        Sun, 30 Apr 2023 16:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23940C433D2;
        Sun, 30 Apr 2023 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682873320;
        bh=CdEnRycpTGBamvpmQPy4FWzWBCWU+VEI1Rx4obR2oaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nlA0mh4fVXVBkO4jFy/ES39lJW6RhDhxGZzNpx3Rl8PzKqYOtGhBXNyiUJNFNT+CP
         pZustGXR3R6JjOqO6oKu5TaDGUAcSISdaAVVmBZxutG4paEfESJ9ZclQKgu3PtFts2
         1rA/NoZML2SnKziT45N3DUgRj4RGl6awXqeWgFS/joz2Ht7r2duuwL+Tz/IKxVXnUN
         vgDrphwdZUOJuZt3Jb/d7DNrIcGkFoFGwXGwmLNsNt2T7F/Ba0ovcpnP5ltq8gsk/G
         QgwrRS5SGJkXPxt3EYDLcUlQd9nutoHA23RMTnNGKwJn3jr6xEgqN58mHQq96xsA9U
         2AEyqi2dYYVmg==
Date:   Sun, 30 Apr 2023 18:04:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas: Remove the unneeded include
 <linux/i2c.h>
Message-ID: <20230430180425.3d24ec12@jic23-huawei>
In-Reply-To: <9d23cd04d7f99dc8d813584aae5268b57f92fcd8.1682320298.git.christophe.jaillet@wanadoo.fr>
References: <9d23cd04d7f99dc8d813584aae5268b57f92fcd8.1682320298.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 24 Apr 2023 09:11:51 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> This driver does not use i2c, so there is no point in including
> <linux/i2c.h>
> 
> Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Hard to argue with that logic :)

I guess some long ago cut and paste..

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index c1c439215aeb..42c519504529 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -14,7 +14,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> -#include <linux/i2c.h>
>  #include <linux/pm.h>
>  #include <linux/mfd/palmas.h>
>  #include <linux/completion.h>

