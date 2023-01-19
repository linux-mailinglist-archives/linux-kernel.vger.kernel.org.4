Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027A673E45
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjASQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjASQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:08:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954649425;
        Thu, 19 Jan 2023 08:08:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3911517wmb.2;
        Thu, 19 Jan 2023 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXxv4f/GrzSHSPu/QzcHkyK4EnmsjXpwAUc8WugyuBY=;
        b=C1lMrrVx4bxj9zX1x/HNOWUgVfK4+6w+sbcqfAxU0BO8dfhmUvSl511zCVyOpOAUlu
         rabqut5ECP1iUkMafoskAChJhOM3IIgczRnAZ+k1NVX6MH5WDI7aScfamWfhihq3SC3N
         6DoyRntCpYgjrS9ZS357UbdY76LKm/zKp9RVQd8AOoMMH4OJgrTGwnsAu8uzBvN6xzeE
         6jeU9GYiD0vVd6tGfc3VGmOMYccvbADx1K+/3oTfvUj9U7pUEWdQcq8jKfT96XxXKnHy
         Hy5L3pKxRjsoL/GUpPbDa7ugLBA20zdmAAy5zPcKo9J8tiEsoXfIcC5nD1/zXag5Lkyy
         KseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXxv4f/GrzSHSPu/QzcHkyK4EnmsjXpwAUc8WugyuBY=;
        b=68+y6wmAEyHoyFQXLRAQ9Z1fYGEdLHC9Y91j/HHArinlcSIeVoha5A0udljbzWu9md
         GtcEh7s6/JRvaMAkno6+rcrRzL4xzJiFiQbomkI9CkRUsEpyfc4GznH6o2Zk9MLiITUT
         /1oQrSyW5VEOUgb7Y2XYI0RoUE0gkScq0H1DLBCTc9uUN/CpZY6csQN8nURCz/8FiGvy
         Xym3vcF0Aeu4xdesCCxtbnX//5xNY2uV9E5G7vqvy9ns80BFzWRhitGnVs19cOW5IPl2
         enJX+9MwtejAfvFyF0J8hdqCcjy5sReixfgAEx1t2U1VeoZl/7lJxZkmSKsjzRQFsk7/
         vbLg==
X-Gm-Message-State: AFqh2kplI8qeKsBcDOXh5vwp4b1UAmsElsm7o8k4Q603F+Qlgww+72rC
        6cdK3mZZ+l8zTeGcCNGIPlI=
X-Google-Smtp-Source: AMrXdXuHd37802o67zKMA0vSXhoL6McWWKMzRHrp3BkFuf9/dCjllHInE53NvVEDqDJ4iZmyFfmG4w==
X-Received: by 2002:a05:600c:1912:b0:3db:f0a:8707 with SMTP id j18-20020a05600c191200b003db0f0a8707mr7630059wmq.40.1674144529818;
        Thu, 19 Jan 2023 08:08:49 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id be12-20020a05600c1e8c00b003db06224953sm6249655wmb.41.2023.01.19.08.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:08:49 -0800 (PST)
Message-ID: <8ae4469e-ed2c-5019-605b-013a49af77ea@gmail.com>
Date:   Thu, 19 Jan 2023 17:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-2-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118031509.29834-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 04:15, Moudy Ho wrote:
> MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> populate device by platform_device_register_data then start
> its own clock driver.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Stephen, if you want I can take 1/4 and 3/4 through my tree. 3/4 shouldn't be a 
problem, not sure about this patch. In any case if you want me to do so, I'd 
need a Acked-by from you.

Regards,
Matthias

> ---
>   .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> index 17fcbb45d121..d62d60181147 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> @@ -28,11 +28,9 @@ properties:
>             - mediatek,mt8195-imp_iic_wrap_s
>             - mediatek,mt8195-imp_iic_wrap_w
>             - mediatek,mt8195-mfgcfg
> -          - mediatek,mt8195-vppsys0
>             - mediatek,mt8195-wpesys
>             - mediatek,mt8195-wpesys_vpp0
>             - mediatek,mt8195-wpesys_vpp1
> -          - mediatek,mt8195-vppsys1
>             - mediatek,mt8195-imgsys
>             - mediatek,mt8195-imgsys1_dip_top
>             - mediatek,mt8195-imgsys1_dip_nr
> @@ -92,13 +90,6 @@ examples:
>           #clock-cells = <1>;
>       };
>   
> -  - |
> -    vppsys0: clock-controller@14000000 {
> -        compatible = "mediatek,mt8195-vppsys0";
> -        reg = <0x14000000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>     - |
>       wpesys: clock-controller@14e00000 {
>           compatible = "mediatek,mt8195-wpesys";
> @@ -120,13 +111,6 @@ examples:
>           #clock-cells = <1>;
>       };
>   
> -  - |
> -    vppsys1: clock-controller@14f00000 {
> -        compatible = "mediatek,mt8195-vppsys1";
> -        reg = <0x14f00000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>     - |
>       imgsys: clock-controller@15000000 {
>           compatible = "mediatek,mt8195-imgsys";
