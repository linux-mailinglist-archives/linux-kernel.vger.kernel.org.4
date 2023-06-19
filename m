Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAB734EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjFSJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:00:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7CAD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:00:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9b37cd58bso2600605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687165219; x=1689757219;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bCBr4oTjiVPYqPEUo0CydkQP5zohM2Xp0GU5zTzP8rs=;
        b=UJjm17SJlTP86cw43v7G8uuapaedwpHHlpiVfaCIAfpJDh9mcTbe6iVbg/gcMnysB+
         87IpUyo+vWUqhB0dGOigtlbttsSDoJVO5gy37LfrXMIJ6yGfdFFcwaBnX6nNbYyKglc/
         G3YyJJs/jlYA2I/lYMIolWZchurQImO9KY6Kt5BQQb18X6hvYeAVaCFnNp9kyUJ8bSQl
         yfv2iv1zRUTlSbpmjibQBuwEmaDivJ55zRuFKLsmu7jPjf1qAwie/6mDZHwEWe8L5ai0
         lduXdoSr/FLxjcHNEGwjR3WCUruJ2Ewdg4dFR1MPSC1Ngsl3SR0+oNXwTQ/0o8ZBHy5k
         sCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165219; x=1689757219;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCBr4oTjiVPYqPEUo0CydkQP5zohM2Xp0GU5zTzP8rs=;
        b=Gmg60c+PDI/+1KlTNOoPMtav8UdadOX4Z5oNqC0rcB1CYZAQPsDcSoVCHUkPfMfW4J
         mobcoSKGPF2EEjCkr03KpyR7BqTBqLR8b0/uxc+VtpyEy/abDxhmI08eWkqdjOGLIan3
         e59PDM5iR/FHKrePx6juaBiYfw3Gk/7rQA3rzThIPWZld12gx9TUMhcJ22jX06/NGq7e
         ghHPQngkzHHS/FOEn9Tx4uyUbs4d7t1rXKWcgrQxhcMSSTMZuwF2CsTtM4fVdRlIWLQc
         P2n0XehrqerjUPZHj4HRWQFll/O/avvAIdcVauvnw6lOzaZnsZgnOoloq9474HabFTm8
         sJ5A==
X-Gm-Message-State: AC+VfDyfnvdEgdxFRBHb4IVpvhH+QpcCqyOU5gOswiM9In7jLdFR2feb
        T+xeAdDy7zDhCLI+epCRwacwvQ==
X-Google-Smtp-Source: ACHHUZ4kTHBI7R/neEMBwF3PvF3KlSrrEUcjqpnITUG/q4ykuPe3Q7fTVaE+jrDwycnvmT9JU+o9uQ==
X-Received: by 2002:a7b:c045:0:b0:3f8:dac6:58ee with SMTP id u5-20020a7bc045000000b003f8dac658eemr5842223wmc.5.1687165218801;
        Mon, 19 Jun 2023 02:00:18 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcc14000000b003f8044b3436sm9970750wmh.23.2023.06.19.02.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:00:18 -0700 (PDT)
Message-ID: <0d50047b-b30a-9c20-1754-2ee4fc4f7e18@linaro.org>
Date:   Mon, 19 Jun 2023 11:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: meson: secure-pwrc: always enable DMA domain
Content-Language: en-US
To:     Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-arm-kernel@lists.infradead.org, kernel@sberdevices.ru,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230610090414.90529-1-avromanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230610090414.90529-1-avromanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 11:04, Alexey Romanov wrote:
> Starting from commit e45f243409db ("firmware: meson_sm:
> populate platform devices from sm device tree data") pwrc
> is probed successfully and disables unused pwr domains.
> By A1 SoC family design, any TEE requires DMA pwr domain
> always enabled.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
> I'm not entirely sure if this domain should always be enabled on or it
> should be separately enabled in dts file. Comments are welcome.
> ---
>   drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index e93518763526..25b4b71df9b8 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -105,7 +105,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   	SEC_PD(ACODEC,	0),
>   	SEC_PD(AUDIO,	0),
>   	SEC_PD(OTP,	0),
> -	SEC_PD(DMA,	0),
> +	SEC_PD(DMA,	GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
>   	SEC_PD(SD_EMMC,	0),
>   	SEC_PD(RAMA,	0),
>   	/* SRAMB is used as ATF runtime memory, and should be always on */

It's fine to keep it enabled.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
