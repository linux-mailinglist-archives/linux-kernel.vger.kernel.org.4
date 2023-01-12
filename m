Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7D667FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALTw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjALTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:52:35 -0500
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC12ACC;
        Thu, 12 Jan 2023 11:48:26 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 52EC54402B7;
        Thu, 12 Jan 2023 21:25:11 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1673551511;
        bh=EvjJ0/igxrI2zj27n/dQ2UDiz3t3gI09pwRm0+l9mrM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=wAqJnFTk0OF4w3n70lHAHOy3kyCNnKIJfH7swrX6w6EdpqTQ5Dy80idfi5+NeZCPi
         6QNS1vUStvzlD4cKZ5k9F44LL2jxHey6PsgQFNqxksBEp8v+CyDG17WULZXqaCM9+v
         W7PEPvHPTpNNq6+CcCKh/8ncVFT3w+axAg00vjEQxFhXzHkQCRzk4sHLLaYTvlZUUe
         pD27fq3XosuMLi0qSupyhoiJvA1jFV/4oiQfvHcICt6qe/7ACbdcN+BhyFdgUviZSM
         4dNUjcNSVeARgesMilY0XhkWPU8Wv0Gdpd6dvzH2RigE3zIIf9+KdAI11pajE7eH+6
         VEBdHPu9R9HRQ==
References: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/2] pinctrl: digicolor: Remove duplicate assignment
 of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 21:28:16 +0200
In-reply-to: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
Message-ID: <87zganpn69.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jan 12 2023, Andy Shevchenko wrote:

> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

> ---
>  drivers/pinctrl/pinctrl-digicolor.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
> index cc3546fc4610..05213261b8a4 100644
> --- a/drivers/pinctrl/pinctrl-digicolor.c
> +++ b/drivers/pinctrl/pinctrl-digicolor.c
> @@ -248,7 +248,6 @@ static int dc_gpiochip_add(struct dc_pinmap *pmap)
>  	chip->set		= dc_gpio_set;
>  	chip->base		= -1;
>  	chip->ngpio		= PINS_COUNT;
> -	chip->of_gpio_n_cells	= 2;
>  
>  	spin_lock_init(&pmap->lock);


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
