Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A006B5BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCKMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:36:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAD136D23;
        Sat, 11 Mar 2023 04:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF5DC60BA1;
        Sat, 11 Mar 2023 12:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BA9C433D2;
        Sat, 11 Mar 2023 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678538201;
        bh=BIBTybdKqwJEt/RSZb7asrosSP61EvkNuvxZC5nACGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNMaEaZxclm0/bjw6FVY/hL6lW7mOr7hQiQoLv5jKE5fma0ltMZwSnIwMSUYH56MF
         w5q/hWH3LwZaisgP94bzZYTytUFI2rDYoz5jklPTWxTtrLxGuV4sKuwrlehIbWJhzc
         Tw9CtF6lkjrhS5pbgMhKA/lwn9zbdX9isamHiHw285RftrcWwJxw66W/TmZX2UvsrQ
         Mrnl9SCqY88lGIZ9ZqYCCe8nwjjq5mBMS/UQzYIn3Jt0b0EUvT606YCaW02Dx2fhE6
         ZYVK1ubclK81VJzRi6ZHHRahswQRdJx4/9CFo3oOXxF4saL8ckrY+nYOd+VIcGMLR2
         CPGkvyOMG2c1Q==
Date:   Sat, 11 Mar 2023 12:36:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: cio-dac: Fix typo in comment listing
 supported devices
Message-ID: <20230311123645.208b7bc1@jic23-huawei>
In-Reply-To: <20230311002434.8761-1-william.gray@linaro.org>
References: <20230311002434.8761-1-william.gray@linaro.org>
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

On Fri, 10 Mar 2023 19:24:34 -0500
William Breathitt Gray <william.gray@linaro.org> wrote:

> This driver supports the CIO-DAC08 device and not "CIO-DAC06".
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/cio-dac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> index 791dd999cf29..bb67d3340c9f 100644
> --- a/drivers/iio/dac/cio-dac.c
> +++ b/drivers/iio/dac/cio-dac.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2016 William Breathitt Gray
>   *
>   * This driver supports the following Measurement Computing devices: CIO-DAC16,
> - * CIO-DAC06, and PC104-DAC06.
> + * CIO-DAC08, and PC104-DAC06.
>   */
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

