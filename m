Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3A637F68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiKXTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:13:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E37FC00;
        Thu, 24 Nov 2022 11:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 124A9620DD;
        Thu, 24 Nov 2022 19:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7131C433C1;
        Thu, 24 Nov 2022 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669317198;
        bh=7KpnDMUalSgWItP+VAa3m8OXxzBAWFMqff0RWDZTOmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLJy9iOSIrhvTe0cTLIq5+fa/nwBk1do8oHdXtkkOfEfEmjgWNfPS/lTSEJJiXFVm
         yKZA5WW1KVTQeOOrNeAXW48ebU9kmvNWi1KkcWqWwZwPXIbvC2sY6QEA9NR/OfFZkZ
         ennZtrnRfTTLFsVs7YG8RwUR8sJ0Z2rfejdcQYuEcKIw41iIdKqIF3CIpQnDB07Ecl
         /4AeQxW3RtVUkJyKFmT+UVaqpUHkOgycqj9bGuS/Ibr7OS0jv+LN7lYBy2U17flbdB
         uCMoyF8o53yAiKZHBF4mriD9PMjcyIjzpxPTfPC/JjpLi5LPks0JtpN2W0al1K59bA
         KONn/CRJUE04w==
Date:   Thu, 24 Nov 2022 19:25:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: addac: ad74115: remove unused
 ad74115_dac_slew_rate_hz_tbl
Message-ID: <20221124192552.144e8348@jic23-huawei>
In-Reply-To: <20221124152559.7895-1-cosmin.tanislav@analog.com>
References: <20221124152559.7895-1-cosmin.tanislav@analog.com>
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

On Thu, 24 Nov 2022 17:25:59 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> This table was supposed to be used for handling the DAC rate, but it
> ended up being unused. Remove it.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 48ea75598db2 ("iio: addac: add AD74115 driver")
Dropped fixes tag as it's not going to do anything bad other than warning
without this and to put it likely fixes tags against recent patches have
been causing me a world of pain this week.

Applied on basis its safe enough even without time soaking in next.

Jonathan

> ---
>  drivers/iio/addac/ad74115.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index 383b92e7b682..e6bc5eb3788d 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -317,10 +317,6 @@ static const unsigned int ad74115_dac_rate_step_tbl[][3] = {
>  	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_240KHZ },
>  };
>  
> -static const unsigned int ad74115_dac_slew_rate_hz_tbl[] = {
> -	4000, 64000, 150000, 240000
> -};
> -
>  static const unsigned int ad74115_rtd_excitation_current_ua_tbl[] = {
>  	250, 500, 750, 1000
>  };

