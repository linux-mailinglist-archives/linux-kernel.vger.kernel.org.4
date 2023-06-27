Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D873F87C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjF0JNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjF0JMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:12:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5A270B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:12:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a152a933so30319721fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687857153; x=1690449153;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MwXCm3w9KvNw8TG6/YFSNlXC4qr8SMmlk1RW+cwukN4=;
        b=CiZEqjlcfKhnAchK8fxDZcHea1pCM6CXXmrhHRKMyEMSM1IhoFu1EtEAqEc6IhbdHj
         qh72wiI1Ei2WoWifKTmCEHd5B6+e5Rgcs09JxJINgIZvmiigtR5mXmrHjuqd5a6G6Dpo
         5OsKgMIaS0wOyEXb4g8pVQbqGzXxohBnnuu/d4z0HTIPz2xAAkPDIOBO3okiabclha+j
         je6ncpKoXpT+HR9SkODE+vf+/BRcejLrBgUU55kIX0iMyngZNkuK++U7O55bwyclt62K
         BLg5lZ3+dxeUAR5y/AY/CH9eydv34VMvjO9NICXaaKEZmA1JXouRaH0ZU/Se138VtAfM
         vhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857153; x=1690449153;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwXCm3w9KvNw8TG6/YFSNlXC4qr8SMmlk1RW+cwukN4=;
        b=Oa0HV5qq4CcO4v7XZHvZmC4/DtRTdESIADFVLf2RrT1ZITPH9//2fYY+Hqhqqr0Ekk
         skzXhgvCCyT9UBe+hLSFc66jRljz/pkG61NMxll+HhsD+IIVRdaB/TDx5opdjJiZSldn
         cI7iFOP91OcrcsgKtQat55NPoyn5jesMaTvzQOOtx57jlbrV6zuXefHRD5wbXoVFKmDg
         mSDsapcFpJ2ZN5xeQ16RjQ1sxY5Q9Y/erpSnx2+sQ0MBTX9VVixuLzIgWa21SZ9psM5G
         NRigWt4IrAsg+2Fuqdjla2CBhNzF/EdzXkFHeOBgQpqJ/wnZmbCObMS/apxF5q66TXxh
         SgpQ==
X-Gm-Message-State: AC+VfDwtB3t5FwqlUZkvEP3kGW0/7TQNaT/NP5SPeov8zqedqmohJT4S
        xh4xIkrugVFIMJFcOFKKRz843Q==
X-Google-Smtp-Source: ACHHUZ7rNhQ854F9BOz5TRA9Vw5SDjSPF19fWlHT4iiFUUWEwxVtbf7M6d/ZqbJms+y4Q+qS3gUAOw==
X-Received: by 2002:a05:6512:10cf:b0:4f9:657d:e4bd with SMTP id k15-20020a05651210cf00b004f9657de4bdmr9901842lfg.24.1687857153046;
        Tue, 27 Jun 2023 02:12:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cec9:2929:7a19:7afa? ([2a01:e0a:982:cbb0:cec9:2929:7a19:7afa])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c290500b003f9b66a9376sm13102500wmd.42.2023.06.27.02.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 02:12:32 -0700 (PDT)
Message-ID: <3570635f-99ab-7127-0441-53852688a59c@linaro.org>
Date:   Tue, 27 Jun 2023 11:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230627091007.190958-1-tanure@linux.com>
 <20230627091007.190958-4-tanure@linux.com>
Organization: Linaro Developer Services
In-Reply-To: <20230627091007.190958-4-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 27/06/2023 11:10, Lucas Tanure wrote:
> The new Amlogic T7 SoC does not have a always-on uart,
> so add OF_EARLYCON_DECLARE for it.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/tty/serial/meson_uart.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2501db5a7aaf..c24e105a98c5 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> +		    meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>   #else

I've reviewed last version of this patch, please keep tags for minor changes,
or explicitely explain why you didn't keep the tag.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
