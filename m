Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4CF5EBEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiI0JcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI0JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:32:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E804D5899
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:32:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a1c440a000000b003b494ffc00bso924568wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=c1lTYvs/G0HbGldaQkXL4iF+w5hjI0Lt6tEy56lMY1U=;
        b=IIG8Bui+zHL7IWfR8G2NjDQAY580zeTo35G1wuYkB90CgyhrECnuu83P5MnZHyU+Z9
         o40JqMrbCNFzCh8Rm1b2EUMajcyX720UytdUliqsF1ZPJiBeiqurHYLE4aKKxOUAqF3U
         7XPoC8XwwMsBrLo5b7M3f0F1viQgrnNsgv/Ie683OlLUSoj/2d7SSaH/pq+HJnRxOO3x
         niWNwcXveTTLcqLUHDhKCzbOBnonFaUfnpfgS5xEoGBjvANKx/n4KqyBiN+DOsTgzLdX
         YYxaHZTN3WzqOL0J6nGgIVc1hY4q8u6IkgImMFuIXZ3yhsZrmzc2PLIU+CsVY3PSlzoM
         3w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c1lTYvs/G0HbGldaQkXL4iF+w5hjI0Lt6tEy56lMY1U=;
        b=3tplWy7gGnh2yw/BOpSaM/t5/FERCHAz9HHn3zfKrAK3Pn1s6DpuifUTkatwyp8GcQ
         SnkFcz3DSon/MykSzlogN1bkHKj5Vg9vZxQZWISRVZx3ZsKdb3/vCkXi2lej4R+BQEOw
         cHsvId0ih7SkXCTvZUekhcGzIoLRUyH12U20ALjvn32391pVYx/l1TRobVCySoqeEUnv
         RJwlawPfSre7XVmk+eojxRdr+SSwdTs+uLoGlhkm4bo3JrsEHlBNAxdSjU33CqcNUnVx
         b4gsEjsmX2ReW+p0SmEaqf0FpCKikFdcM24e3w6OuKaIfNFt/B5L+u+xf0LLjBK0W2fh
         FwvQ==
X-Gm-Message-State: ACrzQf3LFknXwcLPfxiKoK/AA2/TMv1uIf0otAfGCP9bWuX0hHOselys
        pYquqkBlyiBz9l/xz/Lkrhe2bA==
X-Google-Smtp-Source: AMsMyM5qZ1kw/vB9fxScsIF7Ne1Y4ixIPht8M9DgMcU+/hZEyowsK2KJZjeeFC2AA7UntPiPU5rVew==
X-Received: by 2002:a05:600c:284:b0:3b5:3360:3f8c with SMTP id 4-20020a05600c028400b003b533603f8cmr1931059wmk.83.1664271138724;
        Tue, 27 Sep 2022 02:32:18 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r9-20020adfda49000000b002258235bda3sm1337746wrl.61.2022.09.27.02.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:32:18 -0700 (PDT)
Message-ID: <68389021-ffcc-9554-f874-98cc8379df5b@linaro.org>
Date:   Tue, 27 Sep 2022 11:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] clocksource/drivers/arm_arch_timer: Fix CNTPCT_LO and
 CNTVCT_LO value
Content-Language: en-US
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yang Guo <guoyang2@huawei.com>, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220927033221.49589-1-zhangshaokun@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220927033221.49589-1-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 05:32, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
> 
> CNTPCT_LO and CNTVCT_LO are defined by mistake in commit '8b82c4f883a7',
> so fix them according to the Arm ARM DDI 0487I.a, Table I2-4
> "CNTBaseN memory map" as follows:
> 
> Offset    Register      Type Description
> 0x000     CNTPCT[31:0]  RO   Physical Count register.
> 0x004     CNTPCT[63:32] RO
> 0x008     CNTVCT[31:0]  RO   Virtual Count register.
> 0x00C     CNTVCT[63:32] RO
> 
> Fixes: 8b82c4f883a7 ("clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL")
> Cc: stable@vger.kernel.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---

Applied, thanks

>   drivers/clocksource/arm_arch_timer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9ab8221ee3c6..8122a1646925 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -44,8 +44,8 @@
>   #define CNTACR_RWVT	BIT(4)
>   #define CNTACR_RWPT	BIT(5)
>   
> -#define CNTVCT_LO	0x00
> -#define CNTPCT_LO	0x08
> +#define CNTPCT_LO	0x00
> +#define CNTVCT_LO	0x08
>   #define CNTFRQ		0x10
>   #define CNTP_CVAL_LO	0x20
>   #define CNTP_CTL	0x2c


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
