Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71337643D58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiLFGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiLFGxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:53:04 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019118E19;
        Mon,  5 Dec 2022 22:53:03 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id c66so12667500edf.5;
        Mon, 05 Dec 2022 22:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwtS9TDJJ7vIw83Se/GeNxatxjK+vLXoVYcIsIw2pCE=;
        b=S0sXAj7SOfM530NxQrt47d/CKYamGpsJDFPxxZwEbdKFn/kki0aInccH8jjr4bNGxa
         3VKUQ7HapM4RSp0Hm3QMh+uksmuCHuf8/Y8JrqRuob2t/F68btSFu8vFeisHG2c0OMWf
         o/x7FBwTekwItB/odd3029wY55+iJK6LdW61UHl5WBeLfBU4qwlRvdZYLr7FjClLeJhP
         wk3/JG0UZJE/FslfJp3tOTxnaDuO7Z3DLfOiD4PUQWGGq8xvJfw0QOIW8sxZGul81yAs
         /Q4q6GKD2r2E+d4vcsJjFDoc3J/AZUCrp2NuS/KO6EZIlErYxu5P2/q29rHd4S7GQNv+
         z9sw==
X-Gm-Message-State: ANoB5pm20fyTP7OdCdbBjEZNcBhKbOip6KHjqUDaEcAgc4K9rpfDVr6p
        RKhvS8mrSc44UOsr4Hj2mL3rWs29cHI=
X-Google-Smtp-Source: AA0mqf6dqcBoKY2qtVoQUNjNIl+EnIHecxyGvQiux6H57y+P29ImNa3L1/hmxyYKqmAAjQ5kDxc40A==
X-Received: by 2002:a05:6402:4289:b0:467:9864:9463 with SMTP id g9-20020a056402428900b0046798649463mr59324551edc.360.1670309581953;
        Mon, 05 Dec 2022 22:53:01 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id lb26-20020a170907785a00b00781e7d364ebsm7099422ejc.144.2022.12.05.22.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:53:01 -0800 (PST)
Message-ID: <df281b81-ba6c-4ca8-3da6-135d4ae09861@kernel.org>
Date:   Tue, 6 Dec 2022 07:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] earlycon: Increase options size
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
 <20221123-serial-clk-v3-2-49c516980ae0@chromium.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221123-serial-clk-v3-2-49c516980ae0@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 11. 22, 13:39, Ricardo Ribalda wrote:
> Now that the clock frequency is also part of the options, 16 bytes is
> too little.
> 
> Without this patch dmesg does not show the whole options, Eg:
> 
> earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8,480000')
> 
> instead of: '115200n8,48000000'
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index d657f2a42a7b..f555927195da 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -701,7 +701,7 @@ static inline int uart_poll_timeout(struct uart_port *port)
>   struct earlycon_device {
>   	struct console *con;
>   	struct uart_port port;
> -	char options[16];		/* e.g., 115200n8 */
> +	char options[32];		/* e.g., 115200n8 */
>   	unsigned int baud;
>   };
>   
> 

-- 
js
suse labs

