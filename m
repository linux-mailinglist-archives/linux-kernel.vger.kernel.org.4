Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336B714D04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjE2PbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE2PbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:31:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D69C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:30:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30ad752f433so1978616f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685374257; x=1687966257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlRZJO0ut9c74lCgp5ZPN8m5Etsewg93lsfpnPM+vgs=;
        b=gVwf/G88eNzL0qMQ/1ivzvl0XsXj9sJU+DXJbHKD2rZ1Y3lY9YdYeswXKln8SHZ7X2
         /C76MlnE2px8HQNiJFFsJ3wXK6me4k3wBO3sPTrq9MQGyrbqdF2xSpNkmSv78B5XHt2X
         BZPgTJORGPoQUBH1nTO12pexC1/2LmztkouxBO4bKrnWpGVWU1IDY9WTmuSQp/ATLY0P
         d9FZpRrYvMOy43ARbAfTNNJLrlna2AITtydrEjN3BT6fHpSChUB2fwzFZjjN8JUv2RRn
         NirKI7vY/AWGXOYrGjyBGq5IEahNOBdzU2upvYtwTIvoDKJ5VNECDZB7N4vVnl7Fqm/r
         P4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374257; x=1687966257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlRZJO0ut9c74lCgp5ZPN8m5Etsewg93lsfpnPM+vgs=;
        b=d3QYyoEaEnXoXzBLFw80LdtcTJr19FSGb7IHbOLRSST5flYxavMqe7vX6vTafYt8V1
         AO7zKGALU8CtF92JgLlblpY5CL8aAaN2wlPjs/yd7meUAuVN3y1oYfg6Aq780pqKJ9qX
         JwzBDCoFSe6LgZbRt5FJNia1y4azRZbEPbfKO88wqQtf1DlUaJ5vAYD0I9n4+YLsjsGl
         2n4JJyO0PyJ1/25tMAM7MR+5B6mG4Qea1m0VnVdswIyHOKLXjIvKwsE6mA0tOM+SztmL
         PeAArMEkW9vBTEp3p+S9ouOY9DFWOUCIQ2oc/w5YoBjwieyYiKLhBUimBz5+lOFRhSnV
         pVUg==
X-Gm-Message-State: AC+VfDwsUIWjo7XORMa799izD0os13voUN6GqnSgf/EZatuGAI40nqlm
        /+e5jsQxGyTYMda4bE0t8js=
X-Google-Smtp-Source: ACHHUZ4eFqwTB/2th5OmqHEyTwPBCv726w0w/8V7tz0hfE2Ltuwtb7NySmndjYIQGPqp+TiWL8DI4w==
X-Received: by 2002:a5d:490b:0:b0:30a:e7c0:de86 with SMTP id x11-20020a5d490b000000b0030ae7c0de86mr5894515wrq.56.1685374256958;
        Mon, 29 May 2023 08:30:56 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b0030aedb8156esm258207wro.102.2023.05.29.08.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:30:55 -0700 (PDT)
Message-ID: <1ae2e760-a06f-f76f-689c-804df00ea5f8@gmail.com>
Date:   Mon, 29 May 2023 17:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] soc: mediatek: mtk-mutex: Remove unnecessary .owner
Content-Language: en-US, ca-ES, es-ES
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230505061950.25977-1-jiapeng.chong@linux.alibaba.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230505061950.25977-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2023 08:19, Jiapeng Chong wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> ./drivers/soc/mediatek/mtk-mutex.c:1054:3-8: No need to set .owner here. The core will do it.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4869
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 26f3d9a41496..4aa0913817ae 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -1051,7 +1051,6 @@ static struct platform_driver mtk_mutex_driver = {
>   	.probe		= mtk_mutex_probe,
>   	.driver		= {
>   		.name	= "mediatek-mutex",
> -		.owner	= THIS_MODULE,
>   		.of_match_table = mutex_driver_dt_match,
>   	},
>   };
