Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2934A65E5A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAEGcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAEGcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:32:12 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE615830;
        Wed,  4 Jan 2023 22:32:10 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id gh17so88009935ejb.6;
        Wed, 04 Jan 2023 22:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je2r7+CxT5pAVTg5Pl8B98GwNMe7+bxsaMRzY561mHs=;
        b=L5cfES0BIzyPRykOIuT7lkIES1oR8TOf99eB7hZPLsBdui4qv4Txbk5toMzjqEPuKN
         mLHAVdR2Ik3fbaXB0IicbX56qGXf1AFF4/ZZqH6zp0v4olcFqeTV7zz41oaYfGyEATFk
         qxT+n4IiEbpVUkkY6jxgwnhFiDGi4gEyvocRcCnZFXaEdjXIpwS5WdGfdkMOozU/gQYu
         dTazGAHfHfw5utFYRy6rhl3Oiim6K7slnme5IAPrWhSNWk1DE61JDAUhKzgeCMNfbAZM
         izbDDZcpNK0BlFBZYIm9qPrL1bBT1KzXX0mBEJVGHmTz7/ZvYZcURZ+PDSEfydCG4D2w
         CtVw==
X-Gm-Message-State: AFqh2krmjhFP7gS5GBubgEkTF6owRx9dtNtR9eD+IsgkiClabxH5yYhE
        RE+MFemeR21iP5HVP3xjNYPT18QGTD/jTw==
X-Google-Smtp-Source: AMrXdXt0DoBuNDqVonjXogWNInw7nOCS9aijerrR/Q3DaFmN7WkNQZGYSymrqOOhWda395b8++8QCw==
X-Received: by 2002:a17:906:2457:b0:7c0:ff72:e828 with SMTP id a23-20020a170906245700b007c0ff72e828mr40664430ejb.54.1672900329190;
        Wed, 04 Jan 2023 22:32:09 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906310200b0084bfd56fb3bsm14063065ejx.162.2023.01.04.22.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:32:08 -0800 (PST)
Message-ID: <ddcf396b-7b91-00f3-8c16-7de5dc891aef@kernel.org>
Date:   Thu, 5 Jan 2023 07:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] serial: linflexuart: remove redundant uart type
 assignment
Content-Language: en-US
To:     LIZHE <sensor1010@163.com>, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230104164311.3788-1-sensor1010@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104164311.3788-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 17:43, LIZHE wrote:
> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()

Please use capitals when you start a sentence. And periods at the ends 
of them.

> Signed-off-by: LIZHE <sensor1010@163.com>

No, Lizhe was fine (or use your Chinese name. We support unicode so that 
would be fine too, as Greg stated).

But you didn't include changelog to your previous v1-v4 patches; as 
stated by Ilpo.

> Link: https://lore.kernel.org/all/20230103170948.3777-1-sensor1010@163.com/
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

