Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29B66D652
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjAQG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjAQGZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:25:53 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D728870;
        Mon, 16 Jan 2023 22:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1673936634; x=1705472634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWGEQrSNu7n2i51Jq6UVFISoxARap5AIdYbs2OqP5L0=;
  b=FlqlV5nzu8DHgxwOe1OvB/0Y6YBH9fgKU1dMaErLxiLNAbACwg8g1cNJ
   QfvuyhrnRfCN9YqCeg8sbD8jwfda1zkE9iotPV4F2vS0i3JQv9fQYCcfs
   SkY5Sa2eWQgHJuvWrm7XYLDnkQjlHvNI8tZJOTUXsaSlJry8IiLeMpbeu
   CNk3KYL1+drVxMp/FlS3mvD7U41+UA97Nsnesu8n5aCZrqjuSqzos6hkG
   uCA2hjVbBwP+rK6sAslMtMuXdWQV2kfug+uq5Rwd6PRG4vz03V7r2y1Ig
   2EjSBZnKhwyV9mvQ5n1gwF9MuQ/3VnwgzH9KfzNuQPvUZkRWZbKL4HO4/
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669071600"; 
   d="scan'208";a="28463337"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Jan 2023 07:23:51 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 17 Jan 2023 07:23:52 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 17 Jan 2023 07:23:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1673936632; x=1705472632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWGEQrSNu7n2i51Jq6UVFISoxARap5AIdYbs2OqP5L0=;
  b=m0be11CoRRQvfhuFAVnvJisVlfyuZq66KFfztmTheD6PXddQ+mr7FP8l
   lEUDnDhEicsDg25cyGhlrbx487d/5Mr/+CBgardLiiaj4NG8bEihTQHM0
   wjjvzehvFyXFPPodM3F2okPP4XDZVXVHv7k6XyDkPEmPO0IK4soMHQpKD
   fX0ZO1hjMMN9nbMwZ7wyuxbifWSIqPN0Gwk3KaQxcCLoQjqPFCz+Kwlcc
   nz/UjNzrQcWD5V3ShKUoqOnO6V1HJk+pRu+w51S8Q2m2pQjOzNFsPEJdU
   5MQRWym3IndWjPYvnj1uMog5kLBGgzi9jzmTADDsNF+o2RwLk6jG8pvYY
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669071600"; 
   d="scan'208";a="28463336"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jan 2023 07:23:51 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id ADEDF280056;
        Tue, 17 Jan 2023 07:23:51 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.p@variscite.com,
        pierluigi.passaro@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Date:   Tue, 17 Jan 2023 07:23:50 +0100
Message-ID: <2403894.jE0xQCEvom@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230116140811.27201-1-pierluigi.p@variscite.com>
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 16. Januar 2023, 15:08:11 CET schrieb Pierluigi Passaro:
> Both the functions gpiochip_request_own_desc and
> gpiochip_free_own_desc are exported from
>     drivers/gpio/gpiolib.c
> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
> reasonable definitions in the "#else" branch.
> 
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/gpio/driver.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 44783fc16125..ed77c6fc0beb 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
> 
>  #endif /* CONFIG_PINCTRL */
> 
> +#ifdef CONFIG_GPIOLIB
> +
>  struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  					    unsigned int hwnum,
>  					    const char *label,
> @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct
> gpio_chip *gc, enum gpiod_flags dflags);
>  void gpiochip_free_own_desc(struct gpio_desc *desc);
> 
> -#ifdef CONFIG_GPIOLIB
> -
>  /* lock/unlock as IRQ */
>  int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
>  void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
> @@ -776,6 +776,22 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc
> *desc);
> 
>  #else /* CONFIG_GPIOLIB */
> 
> +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip
> *gc, +					    unsigned int hwnum,
> +					    const char *label,
> +					    enum gpio_lookup_flags 
lflags,
> +					    enum gpiod_flags dflags)
> +{
> +	/* GPIO can never have been requested */
> +	WARN_ON(1);

This will raise the warning on each invocation. How about using 
WARN_ON_ONCE(1), or even WARN_ONCE("Kernel compiled without CONFIG_GPIOLIB 
support")?

> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
> +{
> +	WARN_ON(1);

Same as above.

Best regards,
Alexander

> +}
> +
>  static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
> {
>  	/* GPIO can never have been requested */




