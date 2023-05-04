Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7D6F6516
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjEDGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEDGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:32:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02C2122
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:32:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so95028a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181975; x=1685773975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RBEhpd3xEUlZ6Us/X/cjuw9/V+kcP7bYejuz1B4OPg=;
        b=IhGqbZGuMUF4xJ8W9u/Pr1NiZ3uruaJUW/ekux+SG7T1u60WXizi9DkjVmlg+9J96c
         fkwWuvCI4mb4POHNlsUxFJ07dd4xIPTeYzVpq1RmCFeTCsiGXNsSdJyc4dLZQWPLLkYC
         n5BQXDGfVnCYnTtk+k57tCmH+y0/CxM2MWvQAm9VDTOhazq9RcZMhNfAo+9FIGhKdNHZ
         mqzH8pPxTbOju4k7zJYeOSJO8mX0IQLfHLooxIflhBum1dmDmqxROVVncQEljT/CCJpS
         ZfGIpjR1stIiaEEc06rHAzIT+Ix9bxibCMdIH8N+TJWIQDfI3cGdNcq+Zpml9ExW38w5
         XaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181975; x=1685773975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RBEhpd3xEUlZ6Us/X/cjuw9/V+kcP7bYejuz1B4OPg=;
        b=XH/ft2q3aN4ug2+00m0VYWxrcrbNogeBBUosQSUy4TmtUKpOpaA8cR2r1BRTb7AN3K
         j00L0TdzLwi1kS2HVbpdn9uDSCOwoyVqhwgUVZIDlHbiiPKxSelx1+jNCEVnwN6u8jnb
         KQWSYQOCeBA+Sn/5HCatMzkvsgf/6Ry84Lb6cNd8QfInUofXFGKgKAQ2Pa6de98eqHjI
         y+VsR1U/62/tdyteDcjBSG0IUZXAA+xmb61fMDM1U//yEF2reTD1bQD3CUgseVdE7ctQ
         FG9if9l7LbHP6Caa8s0yJcjCgG7dHVUtaOmJyT4dWSsZwBt9Sb6vQu+y/HLCzHUaMOX2
         LUug==
X-Gm-Message-State: AC+VfDzaSSj0UjusVyrxHfEfrkvI9r/gtnfW6R9RRdgHY7ba6Hj/GvGV
        3QOLAVvcHDyLPjHl2cuZIM9anQ==
X-Google-Smtp-Source: ACHHUZ6cU1GIx7gdw1AGNelLdQi0YhZ6hCvTdTZP7dgeRkG1vnyMmM+bjaey386+6gjK3w0+zCTr6Q==
X-Received: by 2002:a17:907:31c4:b0:94f:e00:c8c9 with SMTP id xf4-20020a17090731c400b0094f0e00c8c9mr4344851ejb.34.1683181975206;
        Wed, 03 May 2023 23:32:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id vh7-20020a170907d38700b0094f31208918sm18056053ejc.108.2023.05.03.23.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:32:54 -0700 (PDT)
Message-ID: <8ce93998-84c3-0640-a6e1-76ff17b3953c@linaro.org>
Date:   Thu, 4 May 2023 08:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton
 MA35 platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-2-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-2-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  arch/arm64/Kconfig.platforms | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 89a0b13b058d..c1f277c05569 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -236,6 +236,15 @@ config ARCH_NPCM
>  	  General support for NPCM8xx BMC (Arbel).
>  	  Nuvoton NPCM8xx BMC based on the Cortex A35.
>  
> +config ARCH_NUVOTON

Either this should be ARCH_MA35 or you should integrate it with NPCM.
ARCH_NUVOTON means all Nuvoton platforms.


Best regards,
Krzysztof

