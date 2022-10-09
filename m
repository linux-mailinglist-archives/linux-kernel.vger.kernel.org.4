Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1885F8B46
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJIMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJIMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07D29C8E;
        Sun,  9 Oct 2022 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C0DB80D19;
        Sun,  9 Oct 2022 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D25C433D6;
        Sun,  9 Oct 2022 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319096;
        bh=K+t4C9xzNH5Di+7Agqf9ZYu2U26rtQPOIR0y+xTSmwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awejgSqd9N58Ra8b4w/uTW75PxwMqFffffJnMxziOprXwYtmDrd9JZW0Rg9kWb2yw
         40PS0wy2V867ThWP8uJJlRpu/n7H7mjBWUQGzJTIjZeefk+5VB2g/yhYvK7fvlBzR4
         Yk1yR7te+LOnMaEf7s+AwFHq7y1LnAvwzOPl3nH8KS2GdhIUt98OrmZApLAWXmdrue
         KQ/ohq5ofv2QG164QkKAVq5BKvEq5yehUnxz0Nuoc+b1SBxRHQlv7dvCogJjb/Ni/k
         EgYuUAxCPkIFfbNwGJUp4ETH+pWJ/2xy3G1bRGEEp5JpizssUehypKEqL69ugkBUpU
         LDo0brHHsJ6xQ==
Date:   Sun, 9 Oct 2022 13:38:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/5] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <20221009133836.4266fbeb@jic23-huawei>
In-Reply-To: <08ccdc318b448eb69c82efc82adcd044536df4af.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <08ccdc318b448eb69c82efc82adcd044536df4af.1665066397.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 6 Oct 2022 17:38:34 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add maintainer entry for ROHM/Kionix KX022A accelerometer senor driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> I can also add myself as a maintainer instead of a reviewer if it better
> suits iio maintainer. I however don't plan setting up my own public
> repository and hope the further patches will be merged via IIO tree.
> 
> So, as Geert once explained to me - In that case the difference between
> me as a maintainer vs. a reviewer would be only really relevant to the
> subsystem (in this case IIO) maintainer. The subsystem maintainer who
> merges patches is allowed to take in changes acked by downstream
> maintainer w/o obligation to do thorough review. (Downstream maintainer is
> to be blamed if things explode :]). If ack is given by a reviewer, then
> the subsystem maintainer has the full responsibility and should always
> do the review. Or - this is how I remember our discussion went - feel
> free to correct me if I am wrong :] In any case - please let me know if
> you'd rather see M: not R: in front of my name for the kx022a.


Entirely up to you.  I tend to take a look at all IIO patches but will
take a less detailed look if there is a tag from someone I've built
up trust with - doesn't matter if they are a maintainer of a particular
driver or not. I only ever look at MAINTAINERS when sending out patches,
never when reviewing except to perhaps moan that someone wasn't cc'd
who should have been!

Jonathan


> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5ca4aefd184..641b4fc2e5e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11356,6 +11356,11 @@ F:	drivers/mfd/khadas-mcu.c
>  F:	include/linux/mfd/khadas-mcu.h
>  F:	drivers/thermal/khadas_mcu_fan.c
>  
> +KIONIX/ROHM KX022A ACCELEROMETER
> +R:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Supported
> +F:	drivers/iio/accel/kionix-kx022a*
> +
>  KMEMLEAK
>  M:	Catalin Marinas <catalin.marinas@arm.com>
>  S:	Maintained

