Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FE6DF5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDLMod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDLMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:44:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8368A4A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:44:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso11532854wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681303440; x=1683895440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYHWVPNh478r6tCKBA2XsNzS4QSLnNlCpvhx3l9GU4M=;
        b=p/2nW88iXr9gE92aTk/lAd1quH/zW8Dnq9X3aW1rn5NMsP3Rn0SPqsEuUYsn+pfwMs
         4PqmXUSTkVT9QT3i+DZkbs+d9HTxOTFrbPTYUybrqjBFntXpnmVGZxouTezFZqDbw2Jx
         JDsERxKmawk+qK3T1DgPRjfPVr48/HPubE0TlyDLfyOH5UyW+5acRF9jdxq80J6NkO6M
         N3ROEqNhRNas9s0Qy4843x6rJ6Ctzw3BjSsukC+VE+gN9X18wFbzNb4SZweTnCRSEqpI
         5z93hOpNpac+/nBLMZfMjv5/7oqOPRmAZ3TO1IhMFaOSeEEecOl0FdCLJ5RE8im4kGQ6
         j1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303440; x=1683895440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYHWVPNh478r6tCKBA2XsNzS4QSLnNlCpvhx3l9GU4M=;
        b=lwXdzzniRi7DQ4dlHGWq7E0eK1/7gqhM4LkDGzCFFplOqudPQ2joqNU3RwWyvCZlOH
         MaMin+6ejXG+Nj3f7RYtFgoDVTwxVB2RADktJcshCyUKAjJ83ujAMJBEH8tkEJiArfmq
         sDLJv7RbdiE13CAVjN+FysUcMWyqWep4srGv7Pph3tzCUm4wD5YbwR35WSWuM46Yhlt3
         IheTgYiYA15DX8o8eeW/aRrZ/ykBXOutM0InO4/gLeK7jKDz2ZfDx9+sHzrORMgmp+RB
         vaYEGpTKbunrJl7Uo/q4iclt9PlnD9erAJmFFgw+RJyKOvaf0k2Qfw1NR34gXbS0LaV8
         a1bQ==
X-Gm-Message-State: AAQBX9cdajtiGXumLGAaxeg0YlYWJbbwWl3JSnRs8whbgvYD7w2ZZS23
        rVe0jWYiHOJ/CT6BqR11mJ+KBg==
X-Google-Smtp-Source: AKy350aucULWK67KJKFtAg2sbmdsH9C74uYTVOZ+9GeoLa97rJpS2at3kqBAm7R2cg7ApgGk95s6yA==
X-Received: by 2002:a05:600c:c1:b0:3ed:9ce3:4a39 with SMTP id u1-20020a05600c00c100b003ed9ce34a39mr9981692wmm.26.1681303440384;
        Wed, 12 Apr 2023 05:44:00 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003ee58e8c971sm2261465wmm.14.2023.04.12.05.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:43:59 -0700 (PDT)
Message-ID: <7d567846-a000-1bd2-6e43-7ca170366d76@baylibre.com>
Date:   Wed, 12 Apr 2023 14:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
Content-Language: en-US
To:     Haibo Li <haibo.li@mediatek.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        xiaoming.yu@mediatek.com, Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230407033341.5139-1-haibo.li@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230407033341.5139-1-haibo.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 05:33, Haibo Li wrote:
> When unwind instruction is 0xb2,the subsequent instructions
> are uleb128 bytes.
> For now,it uses only the first uleb128 byte in code.
> 
> For vsp increments of 0x204~0x400,use one uleb128 byte like below:
> 0xc06a00e4 <unwind_test_work>: 0x80b27fac
>    Compact model index: 0
>    0xb2 0x7f vsp = vsp + 1024
>    0xac      pop {r4, r5, r6, r7, r8, r14}
> 
> For vsp increments larger than 0x400,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>    Compact model index: 1
>    0xb2 0x81 0x01 vsp = vsp + 1032
>    0xac      pop {r4, r5, r6, r7, r8, r14}
> The unwind works well since the decoded uleb128 byte is also 0x81.
> 
> For vsp increments larger than 0x600,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>    Compact model index: 1
>    0xb2 0x81 0x02 vsp = vsp + 1544
>    0xac      pop {r4, r5, r6, r7, r8, r14}
> In this case,the decoded uleb128 result is 0x101(vsp=0x204+(0x101<<2)).
> While the uleb128 used in code is 0x81(vsp=0x204+(0x81<<2)).
> The unwind aborts at this frame since it gets incorrect vsp.
> 
> To fix this,add uleb128 decode to cover all the above case.
> 
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> ---
>   arch/arm/kernel/unwind.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 53be7ea6181b..e5796a5acba1 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -20,7 +20,6 @@
>   #warning    Change compiler or disable ARM_UNWIND option.
>   #endif
>   #endif /* __CHECKER__ */
> -

Why delete this line ?

>   #include <linux/kernel.h>
>   #include <linux/init.h>
>   #include <linux/export.h>
> @@ -308,6 +307,22 @@ static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
>   	return URC_OK;
>   }
>   
> +static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block *ctrl)
> +{
> +	unsigned long result = 0;
> +	unsigned long insn;
> +	unsigned long bytes = 0;

Alphabetical order please.

> +
> +	do {
> +		insn = unwind_get_byte(ctrl);
> +		result |= (insn & 0x7f) << (bytes * 7);
> +		bytes++;
> +		if (bytes == sizeof(result))
> +			break;
> +	} while (!!(insn & 0x80));
> +
> +	return result;
> +}

Please add a blank line for readability.

>   /*
>    * Execute the current unwind instruction.
>    */
> @@ -361,7 +376,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
>   		if (ret)
>   			goto error;
>   	} else if (insn == 0xb2) {
> -		unsigned long uleb128 = unwind_get_byte(ctrl);
> +		unsigned long uleb128 = unwind_decode_uleb128(ctrl);
>   
>   		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
>   	} else {

Great job! I'm aligned with Linus Walleij's feedback about the need of 
few comments to explain the decode loop, even if your code is clear, 
light and robust.

-- 
Regards,
Alexandre

