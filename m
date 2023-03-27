Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD46CA75F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC0OTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjC0OTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:19:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E4769B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:17:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r29so8941968wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926652;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pz8SlfpGIqrewSlPxPa2n2k6JV2RTms17Dv7m3grr0=;
        b=CI+yLzL4DhcLMT1dJ4emqbAt5YS3YorgcrVYDBmV2xyGs5JVw5VaOprpsMKjLglzQD
         ls0hwkkTA+BH29kBz5LuoKCyriZHaOPgttAfIOEAVgLhucpThxhRKi7FJy13c4WIUi83
         hOgCCLBIj64UcFQXZFgdE4w31QRoGqKqaZalRzi2LawOI14rd+gyxOUrTq9Z8Pi45KmF
         gJPmb9MMQYEMJE5ZjmxxpTXpgpBLeJ7yFSQLlK68GIOoxz7Sa8CCAzhPzyZMb0qH/Rcf
         366gi1NUy0C0Vbc0XJz57PHKNaqLml+F5J2gpv/TGYCtLnNC0y0KTGRw4g50egI0W7J6
         xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926652;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Pz8SlfpGIqrewSlPxPa2n2k6JV2RTms17Dv7m3grr0=;
        b=pSlpjYwRNM352LRrubraSOWMJJ+q1HROjcBTm2CimHUXCcg5LpzRyNypqYC90T8qZI
         9Q5TRVHHswnqmteqfoC+jZ0qWm17Ne5m/YGGJyUe25PEMSS2s8PX5p9jApPn195GG4qe
         L5s2ekXumHqT/gsFN9mNVuE84es7k55ItwOJXT1eB7Fjw5u/tlSs9G+512XOKDuOKf/b
         gDgASeB25GKqxGokIaXnBYBWs2SRbJhlFaKrZ8ipflQ9hkq8B9ylv/m263qmQV1cOzdf
         9MfbtOumJ/JYm2BRaXsPXeLIRunlyRaspEMjw4xnPorfUXqhq515XZr4t36VHqb17jzL
         Zvyw==
X-Gm-Message-State: AAQBX9fFTDD4dm/wyGWXmATzbg/8RVtSd/3xjeP3tdtImkrHePADFoaM
        roxrSDTR2Qvh/fOL7gUa3K4p8A==
X-Google-Smtp-Source: AKy350YjnRrnMZRO6+Nu8YQoSObzRMKhMioBXqD+JmX/Ot3qLy9BroLG7762nHwUDLQ1JE6W9sFfFw==
X-Received: by 2002:a5d:590d:0:b0:2d4:7e19:a7fa with SMTP id v13-20020a5d590d000000b002d47e19a7famr8656742wrd.50.1679926652222;
        Mon, 27 Mar 2023 07:17:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2? ([2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b002c55de1c72bsm25149264wrw.62.2023.03.27.07.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:17:31 -0700 (PDT)
Message-ID: <f0432ff5-7e73-1e7e-1745-6f3b679153fe@linaro.org>
Date:   Mon, 27 Mar 2023 16:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] perf/amlogic: adjust register offsets
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Marc Gonzalez <mgonzalez@freebox.fr>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230327120932.2158389-1-mgonzalez@freebox.fr>
 <20230327120932.2158389-4-mgonzalez@freebox.fr>
Organization: Linaro Developer Services
In-Reply-To: <20230327120932.2158389-4-mgonzalez@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/03/2023 14:09, Marc Gonzalez wrote:
> Commit "perf/amlogic: resolve conflict between canvas & pmu"
> changed the base address.
> 
> Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>   drivers/perf/amlogic/meson_g12_ddr_pmu.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> index a78fdb15e26c2..8b643888d5036 100644
> --- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> @@ -21,23 +21,23 @@
>   #define DMC_QOS_IRQ		BIT(30)
>   
>   /* DMC bandwidth monitor register address offset */
> -#define DMC_MON_G12_CTRL0		(0x20  << 2)
> -#define DMC_MON_G12_CTRL1		(0x21  << 2)
> -#define DMC_MON_G12_CTRL2		(0x22  << 2)
> -#define DMC_MON_G12_CTRL3		(0x23  << 2)
> -#define DMC_MON_G12_CTRL4		(0x24  << 2)
> -#define DMC_MON_G12_CTRL5		(0x25  << 2)
> -#define DMC_MON_G12_CTRL6		(0x26  << 2)
> -#define DMC_MON_G12_CTRL7		(0x27  << 2)
> -#define DMC_MON_G12_CTRL8		(0x28  << 2)
> -
> -#define DMC_MON_G12_ALL_REQ_CNT		(0x29  << 2)
> -#define DMC_MON_G12_ALL_GRANT_CNT	(0x2a  << 2)
> -#define DMC_MON_G12_ONE_GRANT_CNT	(0x2b  << 2)
> -#define DMC_MON_G12_SEC_GRANT_CNT	(0x2c  << 2)
> -#define DMC_MON_G12_THD_GRANT_CNT	(0x2d  << 2)
> -#define DMC_MON_G12_FOR_GRANT_CNT	(0x2e  << 2)
> -#define DMC_MON_G12_TIMER		(0x2f  << 2)
> +#define DMC_MON_G12_CTRL0		(0x0  << 2)
> +#define DMC_MON_G12_CTRL1		(0x1  << 2)
> +#define DMC_MON_G12_CTRL2		(0x2  << 2)
> +#define DMC_MON_G12_CTRL3		(0x3  << 2)
> +#define DMC_MON_G12_CTRL4		(0x4  << 2)
> +#define DMC_MON_G12_CTRL5		(0x5  << 2)
> +#define DMC_MON_G12_CTRL6		(0x6  << 2)
> +#define DMC_MON_G12_CTRL7		(0x7  << 2)
> +#define DMC_MON_G12_CTRL8		(0x8  << 2)
> +
> +#define DMC_MON_G12_ALL_REQ_CNT		(0x9  << 2)
> +#define DMC_MON_G12_ALL_GRANT_CNT	(0xa  << 2)
> +#define DMC_MON_G12_ONE_GRANT_CNT	(0xb  << 2)
> +#define DMC_MON_G12_SEC_GRANT_CNT	(0xc  << 2)
> +#define DMC_MON_G12_THD_GRANT_CNT	(0xd  << 2)
> +#define DMC_MON_G12_FOR_GRANT_CNT	(0xe  << 2)
> +#define DMC_MON_G12_TIMER		(0xf  << 2)
>   
>   /* Each bit represent a axi line */
>   PMU_FORMAT_ATTR(event, "config:0-7");


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Will, I've applied DT patches 1 & 2, can you apply this one via your fixes tree for v6.3 ?

Thanks,
Neil
