Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADF74C970
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGJBN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJBNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:13:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F70D3;
        Sun,  9 Jul 2023 18:13:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-38c35975545so3522615b6e.1;
        Sun, 09 Jul 2023 18:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688951603; x=1691543603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hJLG+AQK+Y2fLWIg7CPjEcw8wuS0FJ21Y91ogMUEDpw=;
        b=kiUEnwnNJ1Tc+7VLyMw5o8sHni9PMFChcAMePLS+k1SuVpLc7sn/F2x1mJ22vYZtO6
         0LC3D+D24hXaLsAf4oY6d0wzJxqRUN7SCoxpTJXXweSSQBZGWtEapdu0uFPI+iwrQacH
         F0ryJ3OUkCkhCUcZ6/lWULe1nfsITEnvp+01jxjyY/dKlkkkA8r3ND7t+NRNi/+iXMZY
         OtPzSfCFCk7bweljmn5E/8bP6eCMUCkxZyaiW5A/aFBMrnugK5XFYhFfudMzqgb9ceg8
         OY0zmHY4p5mcJ3IIHtcwEQj01gfRMHiFyzR7sP8aw4/YlukWAumcqgZJn7vV8U4Ql7WV
         rQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688951603; x=1691543603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJLG+AQK+Y2fLWIg7CPjEcw8wuS0FJ21Y91ogMUEDpw=;
        b=WMfaf2ppPdvGxbQr+9/WEN94nuucSrouQNeHJ4SmeYMkgXFlAPiStQtjaw5nvS+h2h
         LawfDMARCMEFdphbPvfgYc+wGZXGVQV4jKDeJiQ3cvWUvgx7dSD/BSkeqQUy/G0WjCoC
         WV348ezz3j1zUWTkUvWG6vj3lcvoXjhCyd6tt3ZSPgT1a3YcdtXWEf5wfrEGa1v0Xb35
         LWuFAsrp0GZOO9AI2t3nmMp5hpavWbegqdhTjyn31eFF29FlsoKySczAUgW6QO0Dqn0t
         pnrMSJ2H0v4la3F5DbanYnxJjqIFqyq0+zLkdTbtZZobwd4qD1aEXDQxfB2cHIELWkdp
         b7fw==
X-Gm-Message-State: ABy/qLao2CnsH/9ll+sQ7oXfq7WR4n8Q7eCDKTnRm8kZ12oLl+QkFic2
        mrclMArYYep27WtkZ4gepYJQlgIFNzY=
X-Google-Smtp-Source: APBJJlHyKx47Fp2rRZO6OcqZLaDqgwnaR4SuW0qf8d157LVg75z1g1C+ear4VhQ6MMSCjOOgDRNuJg==
X-Received: by 2002:a54:4e81:0:b0:39d:adbe:fa29 with SMTP id c1-20020a544e81000000b0039dadbefa29mr11408420oiy.4.1688951602923;
        Sun, 09 Jul 2023 18:13:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b65-20020a633444000000b0054fe6bae952sm6222943pga.4.2023.07.09.18.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 18:13:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net>
Date:   Sun, 9 Jul 2023 18:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL
 demux
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/23 04:15, Geert Uytterhoeven wrote:
> When booting rts7751r2dplus_defconfig on QEMU, the system hangs due to
> an interrupt storm on IRQ 20.  IRQ 20 aka event 0x280 is a cascaded IRL
> interrupt, which maps to IRQ_VOYAGER, the interrupt used by the Silicon
> Motion SM501 multimedia companion chip.  As rts7751r2d_irq_demux() does
> not take into account the new virq offset, the interrupt is no longer
> translated, leading to an unhandled interrupt.
> 
> Fix this by taking into account the virq offset when translating
> cascaded IRL interrupts.
> 
> Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Highlander and Dreamcast probably have the same issue.
> I'll send patches for these later...

dreamcast doesn't build in linux-next, just in case you didn't notice.

Guenter

> ---
>   arch/sh/boards/mach-r2d/irq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-r2d/irq.c b/arch/sh/boards/mach-r2d/irq.c
> index e34f81e9ae813b8d..c37b40398c5bc83e 100644
> --- a/arch/sh/boards/mach-r2d/irq.c
> +++ b/arch/sh/boards/mach-r2d/irq.c
> @@ -117,10 +117,10 @@ static unsigned char irl2irq[R2D_NR_IRL];
>   
>   int rts7751r2d_irq_demux(int irq)
>   {
> -	if (irq >= R2D_NR_IRL || irq < 0 || !irl2irq[irq])
> +	if (irq >= 16 + R2D_NR_IRL || irq < 16 || !irl2irq[irq - 16])
>   		return irq;
>   
> -	return irl2irq[irq];
> +	return irl2irq[irq - 16];
>   }
>   
>   /*

