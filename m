Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043C265FBCA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjAFHRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjAFHRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:17:00 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BA6318E;
        Thu,  5 Jan 2023 23:16:59 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso496363wmp.3;
        Thu, 05 Jan 2023 23:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3oD7bMS69zVKw5Q7q+cfUlP0OCwYHUp/5JgUO/Td48=;
        b=1Bp+4ppmvJ+iv+deHms5dkcHhNjgLr9GOSjikcRecY1e7sMAspSYs+7M/nCWrQL3AT
         sIdokC6Hygt0cuptnkGRGN7+Z1ZWr/bRGjp8LkpwpZ3vc5izqbnADnk7GVwOa5GzzV5R
         6osCJnJewwDtx5r3AYigZqpvKUytA9ZUgxMJUDm/nFTUQfE+kzcK5saQQH1+mbThdg22
         ZkQbQ+NSqXPvkpi4oZkCAtFMUP10PW6pxJnqdSVkU03WkmWxOuNPLfLZ4c74tDv8eNbw
         mL+997JoJltaOFrLAMtZxMfneE3r2duj5+WJN7EsCAaxmDKd8/MOM1g5LcbJS1ymLMb5
         A4yg==
X-Gm-Message-State: AFqh2koPPM7mbPqA76Qbd6iEv2ibdXY4hK4ssGl+gey13M1FAG+Xn25t
        fbwjZtD0VJHK+tmZVmwBk7Y=
X-Google-Smtp-Source: AMrXdXsuo3Q9oGVFFKSoI/xq2ikhuLa+PSk+sys8M1Ur5DY43mC27VP00GbopeuAHdJfTB/8K2hm9w==
X-Received: by 2002:a05:600c:b4d:b0:3d3:49db:d84 with SMTP id k13-20020a05600c0b4d00b003d349db0d84mr37638594wmr.20.1672989418331;
        Thu, 05 Jan 2023 23:16:58 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003d9980c5e7asm639177wml.21.2023.01.05.23.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 23:16:57 -0800 (PST)
Message-ID: <67a7681a-ca4a-0ac7-97b6-2c7db8f2bb3c@kernel.org>
Date:   Fri, 6 Jan 2023 08:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     =?UTF-8?B?5p2O5ZOy?= <sensor1010@163.com>,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230105170437.4437-1-sensor1010@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v6] serial: linflexuart: Remove redundant uart type
 assignment
In-Reply-To: <20230105170437.4437-1-sensor1010@163.com>
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

On 05. 01. 23, 18:04, 李哲 wrote:
> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()

I wrote to v5:
Please use capitals when you start a sentence. And periods at the ends 
of them.

> Signed-off-by: 李哲 <sensor1010@163.com>


> V4 -> V5: Link: https://lore.kernel.org/all/ddcf396b-7b91-00f3-8c16-7de5dc891aef@kernel.org/
> V3 -> V4: Link: https://lore.kernel.org/all/2f726128-29c-b7dd-ad8-f8b536fbe5f@linux.intel.com/
> V2 -> V3: Link: https://lore.kernel.org/all/8f433e5-fb46-d3b8-431b-4bddcc938f6b@linux.intel.com/
> V1 -> V2: Link: https://lore.kernel.org/all/1c33a2af-cd0d-cdde-5bc7-49b418665784@kernel.org/

This is not the proper way. PLease see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

> ---
>   drivers/tty/serial/fsl_linflexuart.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 6fc21b6684e6..34400cc6ac7f 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
>   		return PTR_ERR(sport->membase);
>   
>   	sport->dev = &pdev->dev;
> -	sport->type = PORT_LINFLEXUART;
>   	sport->iotype = UPIO_MEM;
>   	sport->irq = platform_get_irq(pdev, 0);
>   	sport->ops = &linflex_pops;

-- 
js
suse labs

