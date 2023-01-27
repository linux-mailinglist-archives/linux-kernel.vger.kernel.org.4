Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9042A67E209
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjA0Knh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjA0Kng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:43:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFD3403E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:43:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3136890wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ELPk4cIfJ4+PiwiHUhZZetyZuRD3muePWK/0fV2iAc=;
        b=v4ho33PFue2bpumzgy7d364xijm7cPI9djH0k66jX3gyQQd8GqTUT4FvYBpgzRKAP/
         rUJFW0xLkS41TYqvzCkbt4KRTlaF+lAEVtThP6YR2QtHhF7QICW1Cze0b/Wlthr/iznK
         J4MUxCfXqzWmSZN16GbTUT3BVSdpCL/nPTeUUsrtieIux9ptfyOuyMGOmr5iUb4YVZoO
         KTSZPz4T2fwjug02vFnJIppJCj/xXw0sGt7thd+DjjieSP1AQjlWpejtyZUqGyipflmy
         m+muB7DlEtAO/UrCqh7664pokPaYaVc90L02BGAnCcB05Riljx2s1LcED8qEYuwp330O
         G+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ELPk4cIfJ4+PiwiHUhZZetyZuRD3muePWK/0fV2iAc=;
        b=MUyKLF/W+UNMlEn5pyixRrGbI3F+2G0gDN2Sb5R006sUV26h3hK/o/kh4oURYPUq06
         TktJxtKNxLiFexda9SLzMIhxpkNgDggBJE/CQn3nmdyzBxZDI1bENoyhl1zEGuIqasSm
         pXIo9xpcjQeJHE5pr/kL9qls+fce2TKR5tMh0MdSZEa04vfcdeKjcTvxer/ZhazFeB/G
         RK0DWGpOl+k31V/bkJoZxvO+uWqFR0AjalPg6A1PwQlTyThCfOaBDe+x6twzU1n7cr7y
         2y7R8xGKLXWLH11KjlhmjfbBRwCrZWTY7afc5vuGaPw0SIACkgRYqXt8jQxNQwImYqaj
         8zcw==
X-Gm-Message-State: AFqh2kqQqtSK0tnRcEpPSMYXvnBs7fSyUN3KJOo1wq8hbzf6QuWWFHbw
        mbuJZKQb/3N1dE3BAYMoy5DsYjZtTP6i9IGQ
X-Google-Smtp-Source: AMrXdXsIE4keFHDVmx0lF9HUj2mb2OEtDeerqs0/F0JTXQnBEfBVE9TdsF8EAdX3QvM8xDh0YquZ1g==
X-Received: by 2002:a7b:ca52:0:b0:3da:f4f5:ad0f with SMTP id m18-20020a7bca52000000b003daf4f5ad0fmr39484433wml.10.1674816198311;
        Fri, 27 Jan 2023 02:43:18 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b11-20020adfd1cb000000b002bcaa47bf78sm4026997wrd.26.2023.01.27.02.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:43:17 -0800 (PST)
Message-ID: <92c2a978-73df-4bde-c28c-bc0185934605@linaro.org>
Date:   Fri, 27 Jan 2023 10:43:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: stm32: fix OPTEE dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230127094200.2451839-1-arnd@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230127094200.2451839-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2023 09:41, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The stm32 nvmem driver fails to link as built-in when OPTEE
> is a loadable module:
> 
> aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
> stm32-bsec-optee-ta.c:(.text+0xc8): undefined reference to `tee_client_open_session'
> aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
> stm32-bsec-optee-ta.c:(.text+0x1fc): undefined reference to `tee_client_open_context'
> 
> Change the CONFIG_NVMEM_STM32_ROMEM definition so it can only
> be built-in if OPTEE is either built-in or disabled, and
> make NVMEM_STM32_BSEC_OPTEE_TA a hidden symbol instead.
> 
> Fixes: acdf68bdf2d4 ("nvmem: stm32: add OP-TEE support for STM32MP13x")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

thanks Anrd,

Applied thanks

--srini
>   drivers/nvmem/Kconfig | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ed8ef7460be2..ae2c5257ed97 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -295,8 +295,7 @@ config NVMEM_SPRD_EFUSE
>   	  will be called nvmem-sprd-efuse.
>   
>   config NVMEM_STM32_BSEC_OPTEE_TA
> -	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
> -	depends on OPTEE
> +	def_bool NVMEM_STM32_ROMEM && OPTEE
>   	help
>   	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
>   	  trusted application STM32MP BSEC.
> @@ -307,7 +306,7 @@ config NVMEM_STM32_BSEC_OPTEE_TA
>   config NVMEM_STM32_ROMEM
>   	tristate "STMicroelectronics STM32 factory-programmed memory support"
>   	depends on ARCH_STM32 || COMPILE_TEST
> -	imply NVMEM_STM32_BSEC_OPTEE_TA
> +	depends on OPTEE || !OPTEE
>   	help
>   	  Say y here to enable read-only access for STMicroelectronics STM32
>   	  factory-programmed memory area.
