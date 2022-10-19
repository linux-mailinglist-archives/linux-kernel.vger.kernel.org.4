Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84F4604084
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiJSKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiJSKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:01:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C112277E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:39:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so28171660wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CAFlOUOSDNnpuoT+qdniJV4n8MjtoOiXZ0ZGelulaWU=;
        b=mxBYSXH83a8R2gqazBpTtCz7VO9xqsgjj2vXwj9nr1M6ylxMyqTveNpscOoPWCYCsA
         eEzTpwgls/8waiWeVGKE1584hYuc3sHvIlMuh2rMc6NtmsDkFxefJBunGnAM739QREkw
         vXDCNujfYlxtUAxITdcNpDx8WcahP+aq6jxtMM/QxXVOmZIJlcj0n/dQfH9gndSAliMu
         vjOeW/8L13HSd457fpcbjtjfs9kPcBAT0NorhP0seOW5+RFoxm0L/GlCHESgl+4gpjmz
         wt7sXgWS/b+c4gxd7/oc+uBTTE5IAjaxt1yE6VrtceXlFZizLGuPFtrtVyfJHf1mBMEE
         wtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAFlOUOSDNnpuoT+qdniJV4n8MjtoOiXZ0ZGelulaWU=;
        b=JYzEbbAOiHcE5WCAVdGwusQwxg0J5UB7+Q55CMuTovVhVPtvsemNXFfdHvgt/PkHzz
         zvSjYzcOgu4aPGb5SjMVoPxa3NPI3GYP0c3/gFnZKQrnQR0bpC7X/UxKi0Alo0yDspWt
         Sk1HJ9bDiTfdo6202eG9B8SPFc+VfJ4mpRyqMaL8P1No5Bj5FuNVeg43JiPH+Qg1Zc5C
         xDdVUE/TiQvI2VB7tSjpR3RJPM4IHE4ZHAOeh9QJ2Dx1Ugfnd8jdVeowKutSbddQgJx2
         htgEhaPgdWYLbe7Q20hhQV51r97iqGHWD6ukI9b5+pHBDCcrAPqs+/x1IfImw/a2JwqW
         SbdQ==
X-Gm-Message-State: ACrzQf3NPds5aHQEkS7fG80VFt/a0Sa/cnvPS9ElBbQwVuc4MoKqGM4W
        eyiQTOL6mh3THLjgV3lxqqloOA==
X-Google-Smtp-Source: AMsMyM50f/3OOKH1f22KJUuMMnPFOXKp4tez4aGFwbvdlYy/HHNOVo7/VLqR1PmpIjtixY1NE1R44g==
X-Received: by 2002:a05:6000:12ca:b0:22e:6529:a764 with SMTP id l10-20020a05600012ca00b0022e6529a764mr4484971wrx.153.1666172206880;
        Wed, 19 Oct 2022 02:36:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b15b:4b56:592a:c397? ([2a01:e0a:982:cbb0:b15b:4b56:592a:c397])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6290000000b0022ae4f8395dsm12834601wru.96.2022.10.19.02.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:36:46 -0700 (PDT)
Message-ID: <010ea9e1-4a66-61d4-94c5-2bec20ef928d@linaro.org>
Date:   Wed, 19 Oct 2022 11:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 22/44] serial: meson: Use uart_xmit_advance()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
Organization: Linaro Developer Services
In-Reply-To: <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 11:11, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/meson_uart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 056243c12836..74110017988a 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -162,8 +162,7 @@ static void meson_uart_start_tx(struct uart_port *port)
>   
>   		ch = xmit->buf[xmit->tail];
>   		writel(ch, port->membase + AML_UART_WFIFO);
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>   	}
>   
>   	if (!uart_circ_empty(xmit)) {


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
