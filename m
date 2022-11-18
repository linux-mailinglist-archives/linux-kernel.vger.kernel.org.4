Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B064662FFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiKRWJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKRWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:08:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F38E00A;
        Fri, 18 Nov 2022 14:08:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d8so4398678qki.13;
        Fri, 18 Nov 2022 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcKcVBH7wK8BhvZwwW+6MGN+YNjp16mTIOHZ3TURRMY=;
        b=DVEI7O12hJR7kEJybAwc+YqScVXn9LLLd6GLBfY+8tZMBnUzZVqbFPvP1NeuTHhT3Y
         yaJdx7XPpVvoUkuESIVuqg7vgpqfgMnaOtXsnVC/LahYaOYgFHmhjeU0cORlbBHEsofr
         elpe3G0wS/jpFYHxoKbYc6ojctyjGJiBogr9T6o4vgf1f/lGVJauYjhOZ8QwfCYFTODr
         DvWLBJX32SGconmepJIv5f8pI28iew5n0lf+BRDxFeBEA6sukKKP3EysNKM8Jv+rdwFy
         GVVZM8GEY0LG0pthfQ87kbgsogOCpsFe1twVFB37D4IzaV2vUILQG4Aqlw8PZKf/n7fU
         V+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcKcVBH7wK8BhvZwwW+6MGN+YNjp16mTIOHZ3TURRMY=;
        b=wjBjFlUbGwDskNzAZ/g8ZYL1ip1rXt5gk6I8y/KdQdqwglesFRsYG8NLP8mlnqQyOZ
         O584eO53F5ngoRac7JrLD+ZQlkk3qvwlmpyOttjMqBtuAxmGnfqI7uAOHGMspyCwPDHN
         3Sw9Lt5WYmzRlw4ZbnDh/4au/lTPkZcxKYJ/gbo2PYvS43naM0pO7+PYdhaZtwaAzB7u
         nEXKywnzM8y3+OFTgMzrGrgxFH1TgNZmPyuy3JZ+57ogGv1Lm3n5ekOYwFPMnU9wIvQx
         1HHamsUFeIcmzy7pVKBt9EucGquyhEc4Wem/XWP8QKqk3snZgPbUQ7Il0D+DOjrTFyL7
         R4Zw==
X-Gm-Message-State: ANoB5plWixsfNP4DidwpbYmS/LnVPZWftKhQ+2bjzqxkdX4oWEHkQV0T
        VOQxAT+BokicZIffayWXlKKTMa7JP4E=
X-Google-Smtp-Source: AA0mqf6ehzYeAS4E8lRLghHoj+vCUkTOs8uz0dSQaY6gzN/o992YMeO2hOEQhXs5mBylI2ImhU6RqQ==
X-Received: by 2002:a37:9a15:0:b0:6fb:6221:18a3 with SMTP id c21-20020a379a15000000b006fb622118a3mr7801623qke.230.1668809316075;
        Fri, 18 Nov 2022 14:08:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006cfaee39ccesm3181956qkb.114.2022.11.18.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:08:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 14:08:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] watchdog: dw_wdt: stop on reboot
Message-ID: <20221118220834.GC685644@roeck-us.net>
References: <20221118150809.102505-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118150809.102505-1-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:08:09PM +0200, Cosmin Tanislav wrote:
> HW running watchdogs are just watchdogs that are enabled before the
> Linux driver is probed, usually by the bootloader (eg. U-Boot).
> 
> When the system is shutting down, the mechanism for keeping a HW running
> watchdog pinged is also stopped, but the watchdog itself is not stopped,
> causing a reset, and preventing the system from being shut down.
> 
> Opt into stopping watchdogs on reboot.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/dw_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 52962e8d11a6..462f15bd5ffa 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -663,6 +663,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, dw_wdt);
>  
>  	watchdog_set_restart_priority(wdd, 128);
> +	watchdog_stop_on_reboot(wdd);
>  
>  	ret = watchdog_register_device(wdd);
>  	if (ret)
> -- 
> 2.38.1
> 
