Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8668A6338FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiKVJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiKVJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:48:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DF2F034;
        Tue, 22 Nov 2022 01:48:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v7so10323334wmn.0;
        Tue, 22 Nov 2022 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl1tm9PBQRn+U8KTXYVM7yfK2dKQwpuC0dLGysAV9zQ=;
        b=HncGcit0JoF2eoepnzm5Rv32O9ZhxWzVNhT7fpQi/1ZmJGUeAbzWvDcx9M3pZ3oIwx
         ldJmCOWN4Z6eqtDSMq5LPBLAbtiUjRYIswQgC1C0R0psNdmJTMCo1rejd6YUYDz+cVeH
         sC/A5nf8K7kNntAGI0Iv2CziEE67b/UBccc2zi5HKiRavU4EZ+KxmgVCf9UJRc7dhK4p
         6NqWVOu6DBKbyqlcI3v+sA9I6nxvOHLtHR1XEnUgs5bG1JjTbHJreWkKf4Z+iahunve6
         LLwr54w5OIK7goNbOfvqBmRG7xdHslCdi32FSwsk2KL+mGk3ADXGg2mmApbLaCP8IBVV
         asxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl1tm9PBQRn+U8KTXYVM7yfK2dKQwpuC0dLGysAV9zQ=;
        b=RjvrSrq9Ak0QSCAVw3AUwZ2PIpMrgsLwZZh5PaW78XfzSJcEBtZdDfpxWh+7RDS84r
         96RZA7DxBe+h5O135b3P4VFB0Rp5f+e0BM+jmXzDzayLSSxzpalqaFxsP+fqqqJ2sWcq
         RQqgjM5bzqhWoOtpwmkCM6A08RmmGpG92YA4BnHGi4cHSDbBDYwe9/c97DEB0cROHoNE
         aX9pZnBwG7ELCxxkjidusLIJUwk0iy4v4KmUUvFZA1RZS5u6YGSFsmBGsNXF3ZrC/3W4
         98LZjJ1SWhxokjOWcGtScLqzaZy6UK1KhtORsW2qTWhjjwZkcrvurK9dh2nwpVUW6lct
         VcRw==
X-Gm-Message-State: ANoB5pl7+p3EsACZZ2umSz+8KWRwqwEGp45ayOafpx1ksSAJMviJ+mss
        f1AqPkFzqAyO+HNTpf7wcoA=
X-Google-Smtp-Source: AA0mqf4VO8MfjcSudJMvl2CWKuZCsx4k/rCFtYAaXTgc4VK3ZNFtczyk6V0r6HIhWkk5vTZ91wqM2g==
X-Received: by 2002:a05:600c:4151:b0:3cf:6fd1:d94e with SMTP id h17-20020a05600c415100b003cf6fd1d94emr15195821wmm.61.1669110505672;
        Tue, 22 Nov 2022 01:48:25 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003cfa26c410asm23525460wmq.20.2022.11.22.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:48:24 -0800 (PST)
Message-ID: <412024b7-c4ce-bae6-edd0-b415c930c088@gmail.com>
Date:   Tue, 22 Nov 2022 10:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] pinctrl: meditatek: Startup with the IRQs disabled
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
References: <20221122-mtk-pinctrl-v1-0-bedf5655a3d2@chromium.org>
 <20221122-mtk-pinctrl-v1-1-bedf5655a3d2@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221122-mtk-pinctrl-v1-1-bedf5655a3d2@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2022 00:38, Ricardo Ribalda wrote:
> If the system is restarted via kexec(), the peripherals do not start
> with a known state.
> 
> If the previous system had enabled an IRQs we will receive unexected
> IRQs that can lock the system.
> 
> [   28.109251] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> [swapper/0:0]
> [   28.109263] Modules linked in:
> [   28.109273] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.15.79-14458-g4b9edf7b1ac6 #1 9f2e76613148af94acccd64c609a552fb4b4354b
> [   28.109284] Hardware name: Google Elm (DT)
> [   28.109290] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> 		BTYPE=--)
> [   28.109298] pc : __do_softirq+0xa0/0x388
> [   28.109309] lr : __do_softirq+0x70/0x388
> [   28.109316] sp : ffffffc008003ee0
> [   28.109321] x29: ffffffc008003f00 x28: 000000000000000a x27:
> 0000000000000080
> [   28.109334] x26: 0000000000000001 x25: ffffffefa7b350c0 x24:
> ffffffefa7b47480
> [   28.109346] x23: ffffffefa7b3d000 x22: 0000000000000000 x21:
> ffffffefa7b0fa40
> [   28.109358] x20: ffffffefa7b005b0 x19: ffffffefa7b47480 x18:
> 0000000000065b6b
> [   28.109370] x17: ffffffefa749c8b0 x16: 000000000000018c x15:
> 00000000000001b8
> [   28.109382] x14: 00000000000d3b6b x13: 0000000000000006 x12:
> 0000000000057e91
> [   28.109394] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffffefa7b47480
> [   28.109406] x8 : 00000000000000e0 x7 : 000000000f424000 x6 :
> 0000000000000000
> [   28.109418] x5 : ffffffefa7dfaca0 x4 : ffffffefa7dfadf0 x3 :
> 000000000000000f
> [   28.109429] x2 : 0000000000000000 x1 : 0000000000000100 x0 :
> 0000000001ac65c5
> [   28.109441] Call trace:
> [   28.109447]  __do_softirq+0xa0/0x388
> [   28.109454]  irq_exit+0xc0/0xe0
> [   28.109464]  handle_domain_irq+0x68/0x90
> [   28.109473]  gic_handle_irq+0xac/0xf0
> [   28.109480]  call_on_irq_stack+0x28/0x50
> [   28.109488]  do_interrupt_handler+0x44/0x58
> [   28.109496]  el1_interrupt+0x30/0x58
> [   28.109506]  el1h_64_irq_handler+0x18/0x24
> [   28.109512]  el1h_64_irq+0x7c/0x80
> [   28.109519]  arch_local_irq_enable+0xc/0x18
> [   28.109529]  default_idle_call+0x40/0x140
> [   28.109539]  do_idle+0x108/0x290
> [   28.109547]  cpu_startup_entry+0x2c/0x30
> [   28.109554]  rest_init+0xe8/0xf8
> [   28.109562]  arch_call_rest_init+0x18/0x24
> [   28.109571]  start_kernel+0x338/0x42c
> [   28.109578]  __primary_switched+0xbc/0xc4
> [   28.109588] Kernel panic - not syncing: softlockup: hung tasks
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
> index 65d312967619..27f0a54e12bf 100644
> --- a/drivers/pinctrl/mediatek/mtk-eint.c
> +++ b/drivers/pinctrl/mediatek/mtk-eint.c
> @@ -303,12 +303,15 @@ static struct irq_chip mtk_eint_irq_chip = {
>   
>   static unsigned int mtk_eint_hw_init(struct mtk_eint *eint)
>   {
> -	void __iomem *reg = eint->base + eint->regs->dom_en;
> +	void __iomem *dom_en = eint->base + eint->regs->dom_en;
> +	void __iomem *mask_set = eint->base + eint->regs->mask_set;
>   	unsigned int i;
>   
>   	for (i = 0; i < eint->hw->ap_num; i += 32) {
> -		writel(0xffffffff, reg);
> -		reg += 4;
> +		writel(0xffffffff, dom_en);
> +		writel(0xffffffff, mask_set);
> +		dom_en += 4;
> +		mask_set += 4;
>   	}
>   
>   	return 0;
> 
