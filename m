Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378417079D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjERFts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:49:47 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333E1724;
        Wed, 17 May 2023 22:49:44 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-510c734fa2dso1621773a12.0;
        Wed, 17 May 2023 22:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684388983; x=1686980983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2rxVNj3wVpEz9gh5N1QQBTQxKKD3sXh7yI31LQUZbA=;
        b=YC5kzIgxgn5J1xkqHuW1Pm3jA6jqtGKaAyHaztxNcbpLCy/TkxXJOp+UiERmw82+Rp
         9V3Yo986GdzGMPcoIQb/dSkLg3N90uAXb2B33JGap386t8+UPK3gqtY1DqOozYaFWKdP
         DRzONCqhGXFKQy1D7eNJmV+aSv8Cxu5IVXFXTnP35g6HcOqJ8v2IeuoBToTsHDTFmK52
         PnmTKRNKeYWeJ03083LFNB1sVfME9/EGJRBrcG0v5J/7xmaRMg1xruYz2A/wGHwp7V21
         CZdkh6NFqgOPcjC23Gon9ml9wJYxrfEUfjRdECpmQK2EhLE9KKH4YB20Q1dzujvd7Kpb
         K/KQ==
X-Gm-Message-State: AC+VfDzafljl4ybAMkmglwEYqOniAKtJ588jqQQHGkVP4xhDyIVHJG/2
        jqfZN10MckP1hRAXDJY2jUg=
X-Google-Smtp-Source: ACHHUZ4bGnaOviuoEXOf9iiQiJhxmbfPvJyAY0ASQyO4AxZQEyfEUahNvq6bHBDeeggIfkOPDGPh9Q==
X-Received: by 2002:a05:6402:51c9:b0:506:94db:f4fb with SMTP id r9-20020a05640251c900b0050694dbf4fbmr3329778edd.20.1684388982947;
        Wed, 17 May 2023 22:49:42 -0700 (PDT)
Received: from [10.223.1.187] ([195.39.106.162])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402164400b0050da1edb2e4sm166727edx.31.2023.05.17.22.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 22:49:42 -0700 (PDT)
Message-ID: <b16040e8-06f4-5c0e-7379-daa8226dc2a1@kernel.org>
Date:   Thu, 18 May 2023 07:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (config SERIAL_CPM)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20230515141235.0777c631@canb.auug.org.au>
 <1538d954-864e-3a07-594a-dfe6d3178a72@infradead.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1538d954-864e-3a07-594a-dfe6d3178a72@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 05. 23, 4:51, Randy Dunlap wrote:
> 
> 
> On 5/14/23 21:12, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230512:
>>
> 
> commit e3e7b13bffae
> Author: Jiri Slaby <jirislaby@kernel.org>
> Date:   Thu Apr 21 12:17:08 2022 +0200
> 
>      serial: allow COMPILE_TEST for some drivers

That commit should be reverted. I didn't realize it wouldn't link, while 
it compiles fine.

> See this portion of that commit:
> 
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -783,7 +783,7 @@ config SERIAL_PMACZILOG_CONSOLE
>   
>   config SERIAL_CPM
>          tristate "CPM SCC/SMC serial port support"
> -       depends on CPM2 || CPM1
> +       depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> 
> 
> When PPC32=y and COMPILE_TEST=y but CPM1 is not set and CPM2 is not set:
> 
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_release_port':
> cpm_uart_core.c:(.text+0x598): undefined reference to `cpm_uart_freebuf'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_set_termios':
> cpm_uart_core.c:(.text+0x8e0): undefined reference to `__cpm2_setbrg'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_break_ctl':
> cpm_uart_core.c:(.text+0xb10): undefined reference to `cpm_line_cr_cmd'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0xb6c): undefined reference to `cpm_line_cr_cmd'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_startup':
> cpm_uart_core.c:(.text+0x1d48): undefined reference to `cpm_line_cr_cmd'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_request_port':
> cpm_uart_core.c:(.text+0x1ddc): undefined reference to `cpm_uart_allocbuf'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2170): undefined reference to `cpm_line_cr_cmd'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_probe':
> cpm_uart_core.c:(.text+0x2474): undefined reference to `cpm_uart_map_pram'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2724): undefined reference to `cpm_uart_unmap_pram'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2838): undefined reference to `cpm_uart_map_pram'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_shutdown':
> cpm_uart_core.c:(.text+0x2aa8): undefined reference to `cpm_line_cr_cmd'
> /opt/crosstool/gcc-12.2.0-nolibc/powerpc-linux/bin/powerpc-linux-ld: cpm_uart_core.c:(.text+0x2ba4): undefined reference to `cpm_line_cr_cmd'
> 
> 

-- 
js
suse labs

