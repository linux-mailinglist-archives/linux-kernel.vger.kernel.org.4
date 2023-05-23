Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC970D88C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjEWJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEWJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:07 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB8118;
        Tue, 23 May 2023 02:13:06 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f7bf29550so634954066b.3;
        Tue, 23 May 2023 02:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833185; x=1687425185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e65v/JQ0YakfdpO5WAozFB3zrVj1i6YIZiY4qha6yIU=;
        b=cherXCFnt1MF3SeL1NDhtsI3G8BZiSMjAyAEDUQaiIiN//oSZwZAR6xeJWVgPnEXwY
         mmlUL98Cg01OdUCaDi5zFGTu4qCEE0WvBGgKObClHQ7xp20c1lntctiZEIq/Ufg/QsHa
         ME5RhpqM1BE1zfNaBtENfkxO87yJNwrROJ2P//6rrkjHX9dyUUdC35zGV24BEOx0rOnP
         e+PXh4mS3FVl8f9/NHv1t8FLfQf4gM7nv7qcrDl3FFUnQPd1R9CCqOVHaqaGpZYCkyBu
         jJlRzL9lSVKNX5xADR6UZBJnk9C8DupMZV36Vmm9cKNUHdx0DPMWaMapWlTOtAj8qjS9
         dxJg==
X-Gm-Message-State: AC+VfDw/iVKpy3+WtYViWQu/oBvDccd3fQruZUDhBYNsKxzSrZj0G3Fy
        oA+/h7/oQU5ugOOG373vDRaEXWolKyw=
X-Google-Smtp-Source: ACHHUZ7RCSSHlTvlKn5S49Hw1Z7qGeq8+J1cF4YtJ4wYDQ+mU0uyNA3Z4JuVX1vTGl6Lc5SU2Hiv7Q==
X-Received: by 2002:a17:907:9408:b0:965:6d21:48bc with SMTP id dk8-20020a170907940800b009656d2148bcmr11601570ejc.75.1684833184311;
        Tue, 23 May 2023 02:13:04 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id h26-20020a17090634da00b0096f7e7d1566sm4147570ejb.224.2023.05.23.02.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:13:03 -0700 (PDT)
Message-ID: <012b7c3d-1411-e5e1-662a-33369bfca610@kernel.org>
Date:   Tue, 23 May 2023 11:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] serial: cpm_uart: Fix a COMPILE_TEST dependency
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
 <20230523085902.75837-3-herve.codina@bootlin.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230523085902.75837-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 05. 23, 10:59, Herve Codina wrote:
> In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
> the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
> set.
> 
> Without this dependency, the linker fails with some missing symbols for
> COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.
> 
> This lead to:
>    depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)
> 
> This dependency does not make sense anymore and can be simplified
> removing all the COMPILE_TEST part.

Then it's the same as my revert:
https://lore.kernel.org/all/20230518055620.29957-1-jirislaby@kernel.org/

:D

But nevermind.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
> Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
> ---
>   drivers/tty/serial/Kconfig             | 2 +-
>   drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 625358f44419..de092bc1289e 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
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
suse labs

