Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CBE65BEDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbjACLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjACLXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:23:15 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2210BB;
        Tue,  3 Jan 2023 03:23:13 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id vm8so65920327ejc.2;
        Tue, 03 Jan 2023 03:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9rwcH+0z/WoMjVmt8n3b6QTLjPJpDlMLUWW/8CK+Hc=;
        b=sbkYZvQlx1xQrmDwJxYrggkGLEy9pMhkrV4xbFAK4KNTOxnn3DLRk7001Oe9sAzKRb
         1QQqdPxy6kxvmK5OYu86yDPjmhyC4HqlqsxiG01c5VLrRJMckuGqUZJy7W5Ojevlk7A7
         dNpKW/pt8Mvn3K9RmjzLf1e/JXnWWTQDR0ssCygVrBdtOqYQAV5Oo4XqEFy5S0S72XQ3
         PNSSVll4Lwhq8kZyryG7TbUDSAC0PzojSqgCKAEgcvAlliAT6DRgDAa2SXA4aWU8RrJY
         VjQouD6wUyo8PI7k2bzz2HmvyZgLvdERA5Ub3cKODXgatzi4GKaZ5zBa43gQllPWnMqu
         lFcA==
X-Gm-Message-State: AFqh2kp6awYvvtZFjhImLhbd/trlZJISaR20W7s6uwXOcRZKPDNv+Zh/
        cyBocSH/CmzpkIlPp2hVTCitvEcIlMM=
X-Google-Smtp-Source: AMrXdXvpVjg+/U4MZ59aolvSmlPbHjQ3tM40iF8+L7Uzh7pl9y9gysYH1szz6nr/9D2v4GFLJ70diw==
X-Received: by 2002:a17:907:6f09:b0:7c0:a877:1cf1 with SMTP id sy9-20020a1709076f0900b007c0a8771cf1mr41824868ejc.12.1672744991799;
        Tue, 03 Jan 2023 03:23:11 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id m9-20020a1709062ac900b007c0d41736c0sm13927489eje.39.2023.01.03.03.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:23:11 -0800 (PST)
Message-ID: <1c33a2af-cd0d-cdde-5bc7-49b418665784@kernel.org>
Date:   Tue, 3 Jan 2023 12:23:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] drivers/fsl_linflexuart.c : remove redundant uart type
Content-Language: en-US
To:     lizhe <sensor1010@163.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103110255.2699-1-sensor1010@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230103110255.2699-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 01. 23, 12:02, lizhe wrote:
> 	in linflex_config_port() the member variable will be
> 	assigned again . see linflex_config_port()

Fine, but can you make the subject and the commit message a little bit 
saner?

I.e. no tabs, no spaces before semicolons and colons. The subject should 
be something like "serial: linflexuart: remove redundant uart type 
_assignment_" and so on.

> Signed-off-by: lizhe <sensor1010@163.com>

Is this your legal name?

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

