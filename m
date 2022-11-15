Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD562A346
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKOUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKOUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:45:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5906D63A9;
        Tue, 15 Nov 2022 12:45:56 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x21so10397035qkj.0;
        Tue, 15 Nov 2022 12:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BtXbBABgo0H5/POSbS5zs2QbNbB+wIA7vTbJVeUtOU=;
        b=ZkqmNSlcU9tb+Sr1x16dLNwCqTlZz/9UIOEGoB2IUtQbz08uP3JKnUHS5AAGDV5KDv
         mbLm/cz03jbmvMQVU41BLFtSTurrvwUBdSPGajoI3MRGWZa9mzQbgz4LugjIM7/ujcGq
         x0BS9611+fNsC6mkoCAS6D7mywRTJT8P3V09njUSaGKpkQAIq65PVwa2eyeMs/y2Rg8I
         nbn5M+0bXWKaJ2gckndHbflRWyb7Pwo+h/HyxuJ3nR9ZtLWrCs109mmb0DJpGtty3x7a
         sQpAd9IH17mVf7ZLPqYc0zFWksq1R4+vdy55f5/SmcNpaNG9XNEU6D1UlCdILexQfV2C
         03zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BtXbBABgo0H5/POSbS5zs2QbNbB+wIA7vTbJVeUtOU=;
        b=1FsIi6q553mV8sFh5q/yDY8PsfoeQzkRWKRSTkdnELrIZh8F+jEdYsAjUbrzsMdqS6
         DHPmZOMBVrlxRXae20L7r8R+6CucSb3zFidhFWMDTUgst9RisIqRzqNBorjxYV1MZt9S
         66uneu8Ik3gHPHlhfuWnM+0mYSgwEr8QPstXMafoQzVlJuov3/PQvsypeUTCogQ/hPXA
         T5kPfApZrGOtcvDtSNQ8qwScygGsDz7ATGEHwrWLafWUpOsTlQfx0g+9kuuI/CPdI8iX
         ktV0/3eh4sSDdT0UbrWZvxrUfvcdjsBrVi8FVyJUtXiNQBBSRofCWyAe0MJi805baCkN
         f8WQ==
X-Gm-Message-State: ANoB5pmX63CzQ0tHVkPIHQVqFH+BR/PvoDrNrE2McQys104p/YzgDPxm
        AJJmDqvKNuRT0zVTVhdU3/QdT1Rv7n4=
X-Google-Smtp-Source: AA0mqf4RPayW1TgKEZCypkaacG26N45Dme4i3MHtuz9gu7Wy9rdyiJtQGmOKj/rgH/9QdjHgPn8bxQ==
X-Received: by 2002:ae9:e119:0:b0:6fa:398c:e7c2 with SMTP id g25-20020ae9e119000000b006fa398ce7c2mr17167818qkm.517.1668545155427;
        Tue, 15 Nov 2022 12:45:55 -0800 (PST)
Received: from [10.4.10.38] ([96.237.180.62])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b006fa9d101775sm8833476qkj.33.2022.11.15.12.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:45:55 -0800 (PST)
Message-ID: <56c0d9b4-222e-e92f-4508-458d51e19761@gmail.com>
Date:   Tue, 15 Nov 2022 15:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/4] ARM: dts: imxrt1050: increase mmc max-frequency
 property
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
 <20221115193244.10484-3-giulio.benetti@benettiengineering.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20221115193244.10484-3-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 14:32, Giulio Benetti wrote:
> According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
> let's increase max-frequency property to 200Mhz.
> 
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * set max-frequency to 200Mhz instead of removing it as suggested by
>    Bough Chen
> ---
>   arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
> index 114465e4dde6..5b1991c32748 100644
> --- a/arch/arm/boot/dts/imxrt1050.dtsi
> +++ b/arch/arm/boot/dts/imxrt1050.dtsi
> @@ -93,7 +93,7 @@ usdhc1: mmc@402c0000 {
>   			bus-width = <4>;
>   			fsl,wp-controller;
>   			no-1-8-v;
> -			max-frequency = <4000000>;
> +			max-frequency = <200000000>;
>   			fsl,tuning-start-tap = <20>;
>   			fsl,tuning-step = <2>;
>   			status = "disabled";

Acked-by: Jesse Taube <mr.bossman075@gmail.com>
