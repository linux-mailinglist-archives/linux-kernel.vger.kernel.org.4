Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAE5FD4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJMGfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:35:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480EF41BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:35:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so731439wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ad6t0uqGWVJ44zoze6OqxJ+0EbFaaFeDJhLvuHxelJE=;
        b=gDZTDHiBofgyauaDwnqK6zQAfw+OCNIJIPu9vPc6qja1dciBLmpAgCFrjGifJ1s081
         P5s/9/i2Uvqtg7QkdvDS1tgNDfIIeAR/O1MfLpY0tqsAnBxjRF6rk8Ywrv/Slxs8QJIv
         Mk2koqyyZomyZ1/zXgAPOss4Y8V8uPPN9tQLtGzFfyIAUJ2Xoa/AaHlPE+n16XjSgvkA
         6ykhLRpdN5b+M6tLQilm4nxYWeCwi1yxqQpM9X8OEpyhpJgkeLXfvfjuGvMnpD5ZGA9A
         R6O8joG3vQB5klrMm7t5m+xDYhVBG63zkT7KYRYt0qoi+3pMuABV7FNKwQJc9kGGThCb
         BV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad6t0uqGWVJ44zoze6OqxJ+0EbFaaFeDJhLvuHxelJE=;
        b=G4ngjWSHqa3KQNWE3Lvb6D+olD1MrSeFCZJU2t5BIeAC5hCP518Z7NlmOMK84PQBAl
         pKdRKMDrcuGjLyB9CFYq1jaKDX/wg7Gh7YwSZDWRhZpzE7lOrnwKa2ixN4uJLRemHdLF
         2aIQ3PaNhX9F1Gv7NoXMzBbDfQ77RH2aq+xSpQh4BYdznVCM2r+6VOGhO+fdMYcvq7VA
         YEP5fdj2mb2dAiIESsd2ahdvMhKeSIHzn+ZkbkTNU/YhjKh4H2JM5jeMx3gQJsqVv2qu
         LIrsWshfDp6CYih0Jf0Ig6GP6kX8TWJA9trYWrHOwXh+RN67FHIBa/aR9TqDVLVwlN9f
         luBw==
X-Gm-Message-State: ACrzQf0knnv7SBXpmMIjnCQaDgRJ1S1jsiMytlvTAKt3sxdVjnvT6zJA
        CAUpVAGGuOyA99hMd2gEx6McQQ==
X-Google-Smtp-Source: AMsMyM7PeoryycruOSk5MAIFALAVpRMJZCn11Lyo/I45FavURextDXrWr/zktLQ2xOhVoujOtdzxoA==
X-Received: by 2002:a05:600c:548a:b0:3c6:dd03:2d31 with SMTP id iv10-20020a05600c548a00b003c6dd032d31mr1275616wmb.95.1665642933077;
        Wed, 12 Oct 2022 23:35:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cb49:9049:c0a5:d695? ([2a01:e0a:982:cbb0:cb49:9049:c0a5:d695])
        by smtp.gmail.com with ESMTPSA id az12-20020a05600c600c00b003a62052053csm4263521wmb.18.2022.10.12.23.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:35:31 -0700 (PDT)
Message-ID: <53df94fe-3a86-fa27-c32c-3177bc7080df@linaro.org>
Date:   Thu, 13 Oct 2022 08:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221012185234.never.936-kees@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20221012185234.never.936-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 20:53, Kees Cook wrote:
> Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> Sparse:
> 
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> 
> While here, fix this warning as well:
> 
> drivers/firmware/meson/meson_sm.c:85:24: warning: Using plain integer as NULL pointer
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202210122023.zF56nCzM-lkp@intel.com
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/firmware/meson/meson_sm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..4efde225a580 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -82,7 +82,7 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
>   
>   	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
>   	if (!sm_phy_base)
> -		return 0;
> +		return NULL;
>   
>   	return ioremap_cache(sm_phy_base, size);
>   }
> @@ -167,7 +167,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   		size = bsize;
>   
>   	if (buffer)
> -		memcpy(buffer, fw->sm_shmem_out_base, size);
> +		memcpy_fromio(buffer, fw->sm_shmem_out_base, size);
>   
>   	return ret;
>   }
> @@ -203,7 +203,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   	if (!fw->chip->cmd_shmem_in_base)
>   		return -EINVAL;
>   
> -	memcpy(fw->sm_shmem_in_base, buffer, size);
> +	memcpy_toio(fw->sm_shmem_in_base, buffer, size);
>   
>   	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
>   		return -EINVAL;

Thanks,

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
