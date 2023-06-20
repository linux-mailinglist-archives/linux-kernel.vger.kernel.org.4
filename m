Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE69737657
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFTVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFTVAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:00:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60C10C2;
        Tue, 20 Jun 2023 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YcvY7QOtHwan3q4NreVnuR76TIbxVuHusS3f68VDMV0=; b=GM2uklojChzXnKbemQWZ/HGMrr
        i07Yix95B3kAmwkG/XpxFd/MYy75xqDmI6Q2t/eZIC7+rYfo6nUt6+Nl7NSGeJswO1cqh7jE1QW6j
        oE5Tmvdrf4j9Fo/DpJjNMH8mxbCmZnWpawEgtMvn/BccvWtT5qzbx8VQevYwK2pB3tetcL5/AZxEi
        shDBA/7X18ioj3c7TgCo/gmJUUow8VWJ5dhM2vMtoAvyD3ukHzX7W8FtEzB9/LaJ2NCo8xVlo6EQL
        XD8X4nSE4Ac5+3UJGKj+1yCOGmYlDqQZFOyJmXkiGE3fzIlElBYmXrzy639Lc4JLE3a0sBgZjbWWi
        pkDzO60A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBiSs-00CLfB-2p;
        Tue, 20 Jun 2023 21:00:38 +0000
Message-ID: <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
Date:   Tue, 20 Jun 2023 14:00:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu entries
 disappearance
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
References: <20230620170159.556788-1-william.gray@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230620170159.556788-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/23 10:01, William Breathitt Gray wrote:
> The current placement of the I8254 Kconfig entry results in the
> disappearance of the "Counter support" submenu items in menuconfig. Move
> the I8254 above the menuconfig COUNTER entry to restore the intended
> submenu behavior.
> 
> Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 interface library module")
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com/
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

but why is I8254 here at all? Users cannot enable it
and nothing selects it.  Is it a WIP?

Thanks.

> ---
>  drivers/counter/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index a61a4b9b8ec6..86536c2cc531 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -3,13 +3,6 @@
>  # Counter devices
>  #
>  
> -menuconfig COUNTER
> -	tristate "Counter support"
> -	help
> -	  This enables counter device support through the Generic Counter
> -	  interface. You only need to enable this, if you also want to enable
> -	  one or more of the counter device drivers below.
> -
>  config I8254
>  	tristate
>  	select COUNTER
> @@ -25,6 +18,13 @@ config I8254
>  
>  	  If built as a module its name will be i8254.
>  
> +menuconfig COUNTER
> +	tristate "Counter support"
> +	help
> +	  This enables counter device support through the Generic Counter
> +	  interface. You only need to enable this, if you also want to enable
> +	  one or more of the counter device drivers below.
> +
>  if COUNTER
>  
>  config 104_QUAD_8
> 
> base-commit: d428487471ba6640ee8bcdabaf830aec08b85400

-- 
~Randy
