Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884F6F0BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbjD0S3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbjD0S3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:29:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A94494;
        Thu, 27 Apr 2023 11:29:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b603bb360so8621428a12.2;
        Thu, 27 Apr 2023 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682620168; x=1685212168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7ab0uNFW98iuvjPHQi6nmFc33X+FneWQ9yUEiExG+8=;
        b=QJU5pMJXmsiurfixLvJuicvg2EPKuXqO1QjsrrRXTxF/Au/+RssVsX8E5+VyUcItru
         ryTXz7dvIqxd/6v1gi765lY3nz51/9nTrNQ4llsJDsBNZoGL/GCUV446DkUrLjchzgeI
         B0Z/arM2F/MsxvCOzTHm8Amfg2CNfy416hdsG2xa4MG2QQjOKkF07M+LufBTNpZCqDk/
         8stDzvKYrdXlCKcQi1BoU9ZXuHFhfHm01804G3EwNSBUu0BQeupOjp9n/lQc0dOIqApG
         2wUr3Dygq/XCOzRL9V+IzLtnt0aM/hNQ9p/XgugN7N0In1O6TdAoyv4W9dWhWncYbYmr
         HD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620168; x=1685212168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7ab0uNFW98iuvjPHQi6nmFc33X+FneWQ9yUEiExG+8=;
        b=Khrirg1HFcvuX0iK9gPFrj3RZltowyglNp4fdWimAZxydDIQkU8VuGI0kgepwcmGDD
         iRpO8tjVY4KIKIOIvlhWI8rApQGd9EUJZwsd26HZ2WOWNrxu4Fr4mf0c0IwS5Y0quGNv
         6SuBzd1N4HcIHxERuLrFBed0C2GmCMrfQGTt8ceU+XoOVlgXvMSgCDNyAuDb7s4rK5qE
         FNr2j63QZoWkyhKoEok/iqJQ9xAzn6D4eFpZSCoKD7OiSDGdTMKxhmL2tjpmBdcxiqu8
         V9MlmWGsj9Je+QXVCxua5PnRqY3A6/wIywE7ziDKpNjFeqJelPvknK0pqOYr52GxMwQk
         td9g==
X-Gm-Message-State: AC+VfDxVHGvegizHPyb8ZBt5XfP7176sH5nUlZYgCBjBTTsHKgQSMKlj
        2ShST3rmx1+G1NPkyNa3j9FxDmXWGV8=
X-Google-Smtp-Source: ACHHUZ5gcNxTHdITc6sgRyyPCh1gMKHpoD9c9c3Q7qoMnHI7WefsPpWgcA1RQqhoeDR6LDQfeNT+rg==
X-Received: by 2002:a17:902:e153:b0:1a2:23f7:20f with SMTP id d19-20020a170902e15300b001a223f7020fmr2051917pla.28.1682620168237;
        Thu, 27 Apr 2023 11:29:28 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902864900b001a800e03cf9sm11884347plt.256.2023.04.27.11.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 11:29:27 -0700 (PDT)
Message-ID: <e16612a6-abb3-c11c-bfe1-ad82cedeee50@gmail.com>
Date:   Thu, 27 Apr 2023 11:29:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [Patch] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
To:     XuDong Liu <m202071377@hust.edu.cn>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424125100.4783-1-m202071377@hust.edu.cn>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230424125100.4783-1-m202071377@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/2023 5:51 AM, XuDong Liu wrote:
> Smatch reports:
> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
> 
> In the function brcmuart_probe(), baud_mux_clk was not correctly released
> in subsequent error handling, which may cause memory leaks.
> 
> To fix this issue, an error handling branch, err_clk_put, is added to
> release the variable using clk_put(), and an err_disable branch is added
> to meet the requirement of balancing clk_disable and clk_enable calls.
> 
> Fixes: 15ac1122fd6d ("serial: 8250_bcm7271: Fix arbitration handling")
> Signed-off-by: XuDong Liu <m202071377@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is discovered by static analysis, and the patch is not tested
> yet.
> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index f801b1f5b46c..b1670558868b 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1023,7 +1023,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   		dev_dbg(dev, "BAUD MUX clock found\n");
>   		ret = clk_prepare_enable(baud_mux_clk);
>   		if (ret)
> -			goto release_dma;
> +			goto err_clk_put;
>   		priv->baud_mux_clk = baud_mux_clk;
>   		init_real_clk_rates(dev, priv);
>   		clk_rate = priv->default_mux_rate;
> @@ -1032,7 +1032,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	if (clk_rate == 0) {
>   		dev_err(dev, "clock-frequency or clk not defined\n");
>   		ret = -EINVAL;
> -		goto release_dma;
> +		goto err_clk_disable;
>   	}
>   
>   	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
> @@ -1119,6 +1119,10 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	serial8250_unregister_port(priv->line);
>   err:
>   	brcmuart_free_bufs(dev, priv);
> +err_clk_disable:
> +	clk_disable_unprepare(baud_mux_clk);
> +err_clk_put:
> +	clk_put(baud_mux_clk);
>   release_dma:
>   	if (priv->dma_enabled)
>   		brcmuart_arbitration(priv, 0);
Thank you for bringing this to my attention.

-Doug
