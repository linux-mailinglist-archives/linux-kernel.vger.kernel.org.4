Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5961DAF8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKEObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiKEObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73093DEAF;
        Sat,  5 Nov 2022 07:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F34060ADB;
        Sat,  5 Nov 2022 14:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F6CC433D6;
        Sat,  5 Nov 2022 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667658681;
        bh=VKza6h5mQJMpE6zmM8QdT4b9Ggv3/0ZoL+CRi6cZoWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqNEApwFwdAq/7RachRRV2MGYbN+3Zy8LfQKAVWGt7eoJfbE1xwBJKr49p1ewfA1o
         0a6nWQEPbxoR2Zsrm2688wl648LzbXcvFYqv6clp4glsrKYb1uZ9I1YFhN9o9D/T5C
         /A45D+1AxWl1hd/gpNi+JK/b1vpSnxnxPUCVGq5ejn1WrwuDvwZ/0QXbf41s93gCXk
         1zX5ByG3xo5ra7AOtMT4CJhAiuS5J3Ppsc7RbVqrWqNzparmuaa9aP2wphclnpE23x
         jgGCfS/IPgdRctDdKQzVuytctY2gUT89BnC41zwwHFE93CCY/LkSDTmoAKUtmNFUtH
         QeHTykXXTfj6Q==
Date:   Sat, 5 Nov 2022 14:31:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: ad4130: Fix spelling mistake
 "diffreential" -> "differential"
Message-ID: <20221105143112.02af0e37@jic23-huawei>
In-Reply-To: <20221104093148.167765-1-colin.i.king@gmail.com>
References: <20221104093148.167765-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Nov 2022 09:31:48 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied
> ---
>  drivers/iio/adc/ad4130.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index 9a4d0043d797..ae1a4dd5c40a 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1480,7 +1480,7 @@ static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
>  
>  	if (pin >= AD4130_MAX_DIFF_INPUTS)
>  		return dev_err_probe(dev, -EINVAL,
> -				     "Invalid diffreential channel %u\n", pin);
> +				     "Invalid differential channel %u\n", pin);
>  
>  	if (pin >= AD4130_MAX_ANALOG_PINS)
>  		return 0;

