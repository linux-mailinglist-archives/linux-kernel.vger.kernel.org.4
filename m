Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101763721C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKXF60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKXF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:58:25 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9051C38;
        Wed, 23 Nov 2022 21:58:24 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id n21so1837111ejb.9;
        Wed, 23 Nov 2022 21:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/bFtmd6FQomyYZ+7kwXZ3DFmVsdLuYZqVbmeZcl7wc=;
        b=8JQO6crCUJxYZNZ/G4wLvjdt7xa/OqbfXBaW4o0PUTL/bkzHG7EpHrUujgwxBEtYAr
         Lzn3YvEuALzLV0RuEHEJmeVvQA+mXqYlnN8ffexQVgYD7zl9iHXRBkIfO4OfANlaxUL0
         /4QoMB4liJEVVQ/MAJ9T6bBAajv0eAIhm6/zw4ckXANHa8nLEWY/6xDsm+x7lToXk9AS
         McWHII0jB/1slyTH9jRigXPMQXHTXiKR0CiMsucxUCaI8qekCkISeMi6DW8F6fXFt3pJ
         QHOU2J3mXEILhgYRXVnLjInvyEIe0kOHM83UtyKqvL9M4dDKzLdivbMpRV7z7dInec7n
         592Q==
X-Gm-Message-State: ANoB5plGEgys94uNmkRYTfErhcRgPbHvvlOau9wGD/v9fYcYNAE9mWoa
        ruvby6bJjb2OqcgPIOu7jqw=
X-Google-Smtp-Source: AA0mqf7s7MKyMu33w+Uv9Sbfu2jAozp92ShCagDysdn1FoNT/0tnLuVesMX1ubvlS160BsqmIIBscw==
X-Received: by 2002:a17:906:3549:b0:7aa:ffd0:cbec with SMTP id s9-20020a170906354900b007aaffd0cbecmr26542828eja.758.1669269502635;
        Wed, 23 Nov 2022 21:58:22 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id a2-20020a170906670200b0073dc5bb7c32sm59109ejp.64.2022.11.23.21.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 21:58:21 -0800 (PST)
Message-ID: <83146e51-2b63-c2eb-65e3-8122921a89ea@kernel.org>
Date:   Thu, 24 Nov 2022 06:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/1] earlycon: Let users set the clock frequency
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221123-serial-clk-v1-0-1f0554a46ad1@chromium.org>
 <20221123-serial-clk-v1-1-1f0554a46ad1@chromium.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221123-serial-clk-v1-1-1f0554a46ad1@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24. 11. 22, 0:29, Ricardo Ribalda wrote:
> Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
> witch makes it impossible to use with earlycon.
> 
> Let the user select its own frequency.
...
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -120,7 +120,11 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>   	}
>   
>   	if (options) {
> +		char *uartclk;
>   		device->baud = simple_strtoul(options, NULL, 0);
> +		uartclk = strchr(options, ',');
> +		if (uartclk)
> +			port->uartclk = simple_strtoull(uartclk + 1, NULL, 0);

uartclk is uint. So why does it make sense to do ull parsing?

thanks,
-- 
js
suse labs

