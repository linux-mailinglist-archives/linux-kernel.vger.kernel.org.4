Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE472F870
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbjFNIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFNIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:54:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D4194
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:54:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8d65ecdbbso2901755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686732871; x=1689324871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snH+loVfOznkpDFhlCy8HcgmvdnAaXTs0yrnln7lob0=;
        b=s0kOMwQ4xJVjkXjayFWoow6uQ+k6dYlVeEog+Foepr8qFcnEZsaLdmkDTIhfjxKPKX
         MesRdFIBzjbJeEHXJAyZo3/j/2TZZ965vWwd78DwD0geKhxCSXdo3+Vz67fECOo35dTE
         8TGBf7C8MgMaLHTm+bjmWtu7OpSFqpkjozfTaxsfu8Q52/CPlmkT6SEIQdxV1buxHEwC
         ZQStYtZ0HP4jgOQ+7bV9bk/yzQP8E3PMF8j7sOtz+32CjIsg5/LH6IcjJLE1O0tDSg4L
         1QLQ+d+drYprzxR8q9/4qYAgwX7O1ikKSXHOiUnNWCYj7Zbc6trhSekhGkE5Dh62ZlH+
         70gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732871; x=1689324871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snH+loVfOznkpDFhlCy8HcgmvdnAaXTs0yrnln7lob0=;
        b=XEnoNGZE66bOxYh891JjkagABOCAIpIYyJIvzjblGKDDwW3WRxGaH5W3e9L7cFw7KO
         5WU5n7spxrZ/BkXNA0x+J+6UzfAnOq/6f5mpfjhMiiP9a9AFBxuNBEw4okbuPBXdL0vH
         vQBt9mzGW2aYxhduFT69P+Ub+uI4Hv6JmnGp2QTvF8EJPpagMgtG6Xtmh7y4/cMXl9+2
         KTi53Jt5yO47GVx5wyrnfWu22hscjbaZanSxQ8PVicZj2L1aVJ4ChOhGVES1MD34D4YD
         wKVqVbIFVgCnHLun0Bcajlz4G7YSGmWNoUBM/m2NzYGy7+F6ZVmT2XVUXgSqt8R4ZnP1
         PEDw==
X-Gm-Message-State: AC+VfDwFXz6KHKOQh4r6/Sk5VlkBz1iRPjg9xNPTM8ot/TVEkBVaM29G
        ROJZhaVMDWDvvaEOh3XEem6H5g==
X-Google-Smtp-Source: ACHHUZ66Oj/2Bv++NgqYQDA9cXbpm/TdjaP1WChPPZXdSktfCmJ9ADiGvB7Qfm8kgggA3JKZ7LPPlw==
X-Received: by 2002:a05:600c:292:b0:3f7:33da:f218 with SMTP id 18-20020a05600c029200b003f733daf218mr9493140wmk.35.1686732870588;
        Wed, 14 Jun 2023 01:54:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d6bf:b78b:2fff:653a? ([2a05:6e02:1041:c10:d6bf:b78b:2fff:653a])
        by smtp.googlemail.com with ESMTPSA id r3-20020a056000014300b00307972e46fasm17505258wrx.107.2023.06.14.01.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:54:30 -0700 (PDT)
Message-ID: <7a38b3a5-1594-569f-ba3a-6113b0de803d@linaro.org>
Date:   Wed, 14 Jun 2023 10:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drivers/thermal/mediatek/lvts_thermal: Remove unneeded
 semicolon
Content-Language: en-US
To:     baomingtong001@208suo.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        heiko@sntech.de, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230614084536.6911-1-luojianhong@cdjrlc.com>
 <aac85dc1a7070a84697f7e38e5bb7217@208suo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aac85dc1a7070a84697f7e38e5bb7217@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 10:48, baomingtong001@208suo.com wrote:
> ./drivers/thermal/mediatek/lvts_thermal.c:522:2-3: Unneeded semicolon

Please elaborate a bit the changelog when submitting patches.

I did not see this warning/error when compiling. So in which 
circumstances this message appears?

> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c 
> b/drivers/thermal/mediatek/lvts_thermal.c
> index d0a3f95b7884..1a5ae51b2c51 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -519,7 +519,7 @@ static int lvts_sensor_init(struct device *dev, 
> struct lvts_ctrl *lvts_ctrl,
>            */
>           lvts_sensor[i].msr = lvts_ctrl_data->mode == 
> LVTS_MSR_IMMEDIATE_MODE ?
>               imm_regs[i] : msr_regs[i];
> -    };
> +    }
> 
>       lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

