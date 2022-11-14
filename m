Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FC628860
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiKNSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiKNSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:33:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB52D774;
        Mon, 14 Nov 2022 10:33:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b185so11799754pfb.9;
        Mon, 14 Nov 2022 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loAdI/H0UjgK1hXFwm2WMoco4kfb4Re1pr9WlgqpSEE=;
        b=DKn2UkZ/IByAeJ35xYGQ8wBbKigRAkvnmJFSnAckCSD5YOYMGyixbY58G1uO8YymnH
         OjK2J5qVLpTt/LifFSw8BekJ7W7MszrALSl08MnXpQiDeMlea1XviCgO0zd0BCgZ2grh
         b/pUS/SSzUB0wnlB1FCOZSibmUV+cgL1YId/GuzcpztIcGyOVH7g2VujgSGSAHi1SB78
         G3Z4bmuVjD0VuCjj1GEXK+jQKR4Lmvv8ZHaQ5YBpqPJeE3H6Q/PA5GBBaISoB028b5vr
         qsrNgDIMNcWDZlS9uQQZ6MQ3wuD4QjHEsqlYxWKcp4nkok4jENgeQ9lNuTUqiy/oOILU
         M/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loAdI/H0UjgK1hXFwm2WMoco4kfb4Re1pr9WlgqpSEE=;
        b=uPYJQMd6o8Y+B42u/0Kfj6ihQC7w+axKLu2VKNJIGcUOw5/DMDcvqxMMuTG58vxP3K
         nynfq0eoAANd3VdeHpmgQ+9yvxWzyymBuZIb8ap0TE+AF1Udt7ZOpbXfxeSl05TIJHdk
         rRFqWtorjQQOW6kRWgglHrCQJMPBtqdXcZZS6f7BJ3wxda3q4egjzkghOagkj48gYO3i
         Bl6B1mofZ3Hop2Bd2j2AG/7Zk1cAS8m1b0t3YWIBJjs0pvqvl5wl6kOCAHLB/HCJSzXV
         sjjuR4gbBf3tJGjEmri1bjLAz/IXKzFdHUO8YeRG5nx+l0/Hx1gRJrWXp9QzbGPfb6Rg
         4PAQ==
X-Gm-Message-State: ANoB5plVy7R3/9mTQK8LouN2daIxumRDPOs8fiNFLB4L2ftcMo1IQ6bJ
        3BtWgSHNlc6mD+FzjZJkbmLw72AyXa8=
X-Google-Smtp-Source: AA0mqf6Nt0BOJymsx+EjDxjxZ25iE86vqkZlwt3jKPvHvSf0m/lqQ/LiBiQrt+pVZ2PfShek6WgqQg==
X-Received: by 2002:a62:ea15:0:b0:56c:d93a:ac5f with SMTP id t21-20020a62ea15000000b0056cd93aac5fmr14864165pfh.48.1668450797960;
        Mon, 14 Nov 2022 10:33:17 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c17:fc5a:f127:5bb5])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902c40300b00176ea6ce0efsm7915345plk.109.2022.11.14.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:33:17 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:33:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/mac_hid.c: don't load by default
Message-ID: <Y3KJ6SOD5PEwj1oe@google.com>
References: <20221113033022.2639-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113033022.2639-1-linux@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Nov 13, 2022 at 04:30:22AM +0100, Thomas Weiﬂschuh wrote:
> There should be no need to automatically load this driver on *all*
> machines with a keyboard.
> 
> This driver is of very limited utility and has to be enabled by the user
> explicitly anyway.
> Furthermore its own header comment has deprecated it for 17 years.

I think if someone does not need a driver they can either not enable it
or blacklist it in /etc/modprobe.d/... There is no need to break
module loading in the kernel.

> 
> Fixes: 99b089c3c38a ("Input: Mac button emulation - implement as an input filter")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/macintosh/mac_hid.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
> index d8c4d5664145..d01d28890db4 100644
> --- a/drivers/macintosh/mac_hid.c
> +++ b/drivers/macintosh/mac_hid.c
> @@ -149,8 +149,6 @@ static const struct input_device_id mac_hid_emumouse_ids[] = {
>  	{ },
>  };
>  
> -MODULE_DEVICE_TABLE(input, mac_hid_emumouse_ids);
> -
>  static struct input_handler mac_hid_emumouse_handler = {
>  	.filter		= mac_hid_emumouse_filter,
>  	.connect	= mac_hid_emumouse_connect,
> 
> base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
> -- 
> 2.38.1
> 

Thanks.

-- 
Dmitry
