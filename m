Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472A731E96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjFORA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjFOQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E2F1FE5;
        Thu, 15 Jun 2023 09:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDF361C5A;
        Thu, 15 Jun 2023 16:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5662C433C8;
        Thu, 15 Jun 2023 16:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686848386;
        bh=BQEcv2N2wM4uuDgzSLAz7LxAjKlRZwXq5X5243Yt/P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvMMLJW2eW14NI8sCbXtP1++JrozS9ho2m6lNq25xrIBe7PDSUHRasYW8BAeu1mIA
         OqJKYp8qx/OQPPf8MT3TZsV0t5C2zgYQrKAKIIYgCtqqaLBjiFJR+Daz7PzCaZwJFa
         41ZhLjHLNKOkh4ftovODY/QDIunrAR6B3rBtvNhLDI9vt0NEJIqqFViKy5Miy7Q1oj
         U2I8158bisz4g8TtqtOq11TpMaIrlr5EmVPmV5F32En6Mesw7ufVEy1k7bXm3yI86u
         /DWZmqNlMhJ5rXhs1kuumOSOs15EEqfAk6wnyNPwcDVPswkx6RRHOYCKhNDUeqCi+S
         MpEIWldFXqmKg==
Received: by pali.im (Postfix)
        id EA9DF614; Thu, 15 Jun 2023 18:59:42 +0200 (CEST)
Date:   Thu, 15 Jun 2023 18:59:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] gpio: mpc8xxx: Remove unused of_gpio.h inclusion
Message-ID: <20230615165942.hzgx4cvthe7r4uvo@pali>
References: <20230615162514.21195-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615162514.21195-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2023 19:25:14 Andy Shevchenko wrote:
> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/gpio/gpio-mpc8xxx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 3eb08cd1fdc0..35214e9de4ce 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -12,7 +12,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> -- 
> 2.40.0.1.gaa8946217a0b
> 
