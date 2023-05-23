Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51E70D60B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjEWHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjEWHx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:53:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C361A4;
        Tue, 23 May 2023 00:53:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1330762566b.0;
        Tue, 23 May 2023 00:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828322; x=1687420322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nu/cDoOXs5TVBA/QD7O9cdrmYWXrhKeMaEH35tlFdtw=;
        b=WDwu0fsR00E7lDYF6bdiGMe/mfbJkWG5e1SM0ZdePwpDyVhYxAIZjnf1p9/IkP/LF4
         kXnc2rQDQCq0Laeo3UvBJGhl6xEq1Ml0qX/F8qQJebCzlC7cv/DN8DzLwYVr0qOUwf6m
         8mNEpcbCnL//7t+4No/eifhrIf+mcyrCT/gGSbYU/Hxrz4z1aSm3RGMhR6NDliC9L/Ar
         OTTL9+EJdofMlHF/XXTGaql13hMMrWseZMpuPp3NAXoNQe6qizNst5+oi6qenEk1DrVQ
         ruxZkbsnUSWENtWDA3TxtIqUWCWaRytpFUOPSyXUcybB2pzMMYKfSQHVuF0ej5kQ5gpA
         VeZw==
X-Gm-Message-State: AC+VfDzjaSYCSfb+sV8Q2gZbPyc1+glStBHBAVSMdYTfCUSmjYiQINP1
        F/ykgztu8y63KtlFixqxdSQ=
X-Google-Smtp-Source: ACHHUZ4cF4d+RcQ1dnyhjQGJi6YIELHknuY1Ue6me+Xi1cncPggsoYNjnFkzjIFNZaywgQfp4lzdEQ==
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr12495026ejk.77.1684828321864;
        Tue, 23 May 2023 00:52:01 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709064e1900b0096f6e836fa0sm4033655eju.27.2023.05.23.00.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:52:01 -0700 (PDT)
Message-ID: <d65bb452-80ca-7644-c38c-1bc0566661f0@kernel.org>
Date:   Tue, 23 May 2023 09:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] serial: cpm_uart: Fix a COMPILE_TEST dependency
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
References: <20230522082048.21216-1-herve.codina@bootlin.com>
 <20230522082048.21216-3-herve.codina@bootlin.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230522082048.21216-3-herve.codina@bootlin.com>
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

On 22. 05. 23, 10:20, Herve Codina wrote:
> In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
> the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
> set.
> 
> Without this dependency, the linker fails with some missing symbols for
> COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
> Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
> ---
>   drivers/tty/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 625358f44419..68a9d9db9144 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
>   
>   config SERIAL_CPM
>   	tristate "CPM SCC/SMC serial port support"
> -	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> +	depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)

Actually, does this makes sense? I mean, the last part after "||" is now 
superfluous and doesn't help anything, right?

>   	select SERIAL_CORE
>   	help
>   	  This driver supports the SCC and SMC serial ports on Motorola

-- 
js

