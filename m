Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362870D607
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjEWHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjEWHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:52:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8C9E65
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:51:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso1008686a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828172; x=1687420172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyPfE0nYrbS8SFfI3iTz8yv3O/fp21fYW6phEr+pAos=;
        b=StBCic2jWvJauCfxAbnkdRs91sqs0jAxFhaKyKtRQvxp4MBJJta2nAViJC1s6M62pE
         m78/shJcCmO3xLPpSlHPk/wYa8J34tXLD2udT9/KaQ8Qm+NBjqLsOQvkwEP6Pzd+U79E
         WUrosWtgbzArCXw9H3sv1L5ihnUmUiIUe9Cu7lW44faJPPBXgluwTAbAnqXR8Fpsjm/F
         GNbAgFNA9OsNYtTtLqXnmla/JeB0ygysKbQdJ8Q1Oubjs3KEVBL22C/QfApSfSgl8TEB
         C8Ge96eTHgnbQh8mBRMYcFL9gqXiF2ybietgT0tIAWzpFVxb98/ldRiinxCXSqEhBVW+
         JbeA==
X-Gm-Message-State: AC+VfDx73a4OL2mh3cynwuyt7JpA0gWBWu/qw7UycZWSIiySJwCgXlv3
        q5nT2th70tx+hnb2J4Riiy1zA0Q0d14=
X-Google-Smtp-Source: ACHHUZ45lZTbJB9CkKHwe3KtRYq8fkWUbO+8cPFiV68enh9cURFahbh3VoGwGYeJI4fGOABfm4UnBA==
X-Received: by 2002:a17:906:7188:b0:967:e015:f542 with SMTP id h8-20020a170906718800b00967e015f542mr10572950ejk.44.1684828171749;
        Tue, 23 May 2023 00:49:31 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id xa12-20020a170907b9cc00b0096637a19dccsm4114032ejc.210.2023.05.23.00.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:49:31 -0700 (PDT)
Message-ID: <8dbf6d6c-50eb-d0b0-9345-bdc266abd1f2@kernel.org>
Date:   Tue, 23 May 2023 09:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "serial: allow COMPILE_TEST for some drivers"
 partially
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230518055620.29957-1-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230518055620.29957-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please take these fixes instead:
https://lore.kernel.org/all/20230522082048.21216-1-herve.codina@bootlin.com/

On 18. 05. 23, 7:56, Jiri Slaby (SUSE) wrote:
> This reverts commit e3e7b13bffae85e2806c73e3ccacd4447bcb19ed partially.
> It turns out, the image does not link for CPM:
>    powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_release_port':
>    cpm_uart_core.c:(.text+0x598): undefined reference to `cpm_uart_freebuf'
> 
> So do not allow compile testing on this driver.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/tty/serial/Kconfig             | 2 +-
>   drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 398e5aac2e77..3e3fb377d90d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -762,7 +762,7 @@ config SERIAL_PMACZILOG_CONSOLE
>   
>   config SERIAL_CPM
>   	tristate "CPM SCC/SMC serial port support"
> -	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> +	depends on CPM2 || CPM1
>   	select SERIAL_CORE
>   	help
>   	  This driver supports the SCC and SMC serial ports on Motorola
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
> index 0577618e78c0..46c03ed71c31 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart.h
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
> @@ -19,8 +19,6 @@ struct gpio_desc;
>   #include "cpm_uart_cpm2.h"
>   #elif defined(CONFIG_CPM1)
>   #include "cpm_uart_cpm1.h"
> -#elif defined(CONFIG_COMPILE_TEST)
> -#include "cpm_uart_cpm2.h"
>   #endif
>   
>   #define SERIAL_CPM_MAJOR	204

-- 
js

