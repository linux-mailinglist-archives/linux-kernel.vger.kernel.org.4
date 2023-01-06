Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9A65FC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjAFIQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:16:24 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB8919C1D;
        Fri,  6 Jan 2023 00:16:23 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso3010603wmb.3;
        Fri, 06 Jan 2023 00:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzn+fC87PtV3ySGJzwCU5mfDve+3HpOp/GtT1ffSV+E=;
        b=Yp1F6pys/bPvIZk+X3WxpOKu+qsaZLwxc7z5tJy6KYtBwDcwLmr8C6rsw/j+2V/fH/
         2R0WrBS5b0+2VgSXq52z2bic3m7o9ysCojnQtDaj7RDrfXy5U5II/KrM9HhPnUNlDtoK
         8s2Ix9RMxtioymeJX5lCFiQHLRLIFzQTD+fSqfsiYunO3LUUdmvlewQZP6dto5Xy48gj
         ckjQUYMi0+uYnFhyPxZh4AGJqcI8q6fSBqxGyIqYogPq2BCikMenIybjlksr6kAkxIbC
         y5IPARebiyUt01LXSUwWYYoNTzuydYOG9UiMJx4nUWficL1bAEAdND8q+LWZ4N+WS6DV
         FWfw==
X-Gm-Message-State: AFqh2kpoPMFJIyGC8k2AketHWXRKHTtu7C6Hd7CuTEhh+o4YIzMrtycO
        fUNhXJoiTGetB4IOUCBE1mld1hWr5Xs=
X-Google-Smtp-Source: AMrXdXtpWRNe5q8yMTB+/W75VSsW4BtQSDDq/dieL+0yb8xs2nILPbtlyIQybvyfMu8mqzWqgNma2Q==
X-Received: by 2002:a05:600c:c87:b0:3d9:73fb:8aaa with SMTP id fj7-20020a05600c0c8700b003d973fb8aaamr29003169wmb.8.1672992981845;
        Fri, 06 Jan 2023 00:16:21 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm5269919wmc.2.2023.01.06.00.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 00:16:21 -0800 (PST)
Message-ID: <7c569ef3-4dc5-8901-ee12-e5567a21ead9@kernel.org>
Date:   Fri, 6 Jan 2023 09:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] serial: 8250_rt288x: Remove unnecessary
 UART_REG_UNMAPPED
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230105124744.105950-1-ilpo.jarvinen@linux.intel.com>
 <20230105124744.105950-4-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230105124744.105950-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 01. 23, 13:47, Ilpo Järvinen wrote:
> As unmapped registers are at the tail of the array, the ARRAY_SIZE()
> condition will catch them just fine. No need to define special
> value for them.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_rt288x.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
> index 3015afb99722..7399fea6dfc1 100644
> --- a/drivers/tty/serial/8250/8250_rt288x.c
> +++ b/drivers/tty/serial/8250/8250_rt288x.c
> @@ -14,10 +14,8 @@
>   
>   #define RT288X_DL	0x28
>   
> -#define UART_REG_UNMAPPED	-1
> -
>   /* Au1x00/RT288x UART hardware has a weird register layout */
> -static const s8 au_io_in_map[8] = {
> +static const s8 au_io_in_map[7] = {
>   	[UART_RX]	= 0,
>   	[UART_IER]	= 2,
>   	[UART_IIR]	= 3,
> @@ -25,18 +23,14 @@ static const s8 au_io_in_map[8] = {
>   	[UART_MCR]	= 6,
>   	[UART_LSR]	= 7,
>   	[UART_MSR]	= 8,
> -	[UART_SCR]	= UART_REG_UNMAPPED,
>   };
>   
> -static const s8 au_io_out_map[8] = {
> +static const s8 au_io_out_map[5] = {

And what about making them u8 at last?

>   	[UART_TX]	= 1,
>   	[UART_IER]	= 2,
>   	[UART_FCR]	= 4,
>   	[UART_LCR]	= 5,
>   	[UART_MCR]	= 6,
> -	[UART_LSR]	= UART_REG_UNMAPPED,
> -	[UART_MSR]	= UART_REG_UNMAPPED,
> -	[UART_SCR]	= UART_REG_UNMAPPED,

thanks,
-- 
js
suse labs

