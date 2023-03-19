Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4616C02C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCSPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCSPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:22:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590822006;
        Sun, 19 Mar 2023 08:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1D51B80BE8;
        Sun, 19 Mar 2023 15:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B885C433EF;
        Sun, 19 Mar 2023 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679239347;
        bh=hTRqeLTVCKIVZQ35MSCsugL9JXMjOSPwKA3wkXaV3a0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ekl5fwVG3X73dGj3DAN1avWo0IVXZJ9Ru4Ck5e7Cdmnm+ioAPdDvaLueRjxZGukoH
         9GvrFqh/opXrN3ID3CoLh4teTMdFtHM3OpnPDUuFPUU3SQDE4bHsElzai2V74KSINg
         +qZb0xKrxsA1ZdD0hcSeM5YaFLN+v/ePx3Nb+E66ot6lsDg7HddY0D0u0rt0KYNJo1
         yTZqO1+yX4IW5t3Pm1tslXArOCjNDt/5DcqooGBKfOEHEPW8kbA0+WRDAMGbWyg2Q0
         +S4ZSKMzrx0pD/5asRM7mrAuIiHF+a40TBHcBASfLRzIBF8LBb6vBIjly0L9G4XLAQ
         UPKMn5lqBz8kg==
Date:   Sun, 19 Mar 2023 15:37:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: stx104: Replace bitops.h header inclusion
 with bits.h
Message-ID: <20230319153721.55f1e723@jic23-huawei>
In-Reply-To: <20230318185503.341914-1-william.gray@linaro.org>
References: <20230318185503.341914-1-william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 14:55:03 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> The <linux/bitops.h> header is included in the stx104 driver so that we
> can use the BIT() macro. This macro is actually defined in the
> <linux/bits.h> header, so replace the <linux/bitops.h> header inclusion
> with <linux/bits.h>.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/addac/stx104.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
> index 48a91a95e597..e45b70aa5bb7 100644
> --- a/drivers/iio/addac/stx104.c
> +++ b/drivers/iio/addac/stx104.c
> @@ -3,7 +3,7 @@
>   * IIO driver for the Apex Embedded Systems STX104
>   * Copyright (C) 2016 William Breathitt Gray
>   */
> -#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/gpio/driver.h>
> 
> base-commit: 87a1ff66a0e57d9022665d24793f31fc54de182d

