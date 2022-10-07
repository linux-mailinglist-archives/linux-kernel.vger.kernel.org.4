Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5F5F74A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJGHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJGHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:25:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28039B9E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:25:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 10so6058037lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=z6pbeOdotLRHHyLhHXUxZEFAlmYdp5RIPKSKkUaT36I=;
        b=kWfYkegF/+NHSvikV88fmsB5HHGNrSmdsbvrlTz+ZjHyvsTnFHTHErFlERfNG4k+mX
         iXEV5AmyM6hlAKwP9J62BWOrqMCDJ11vqIWOx3qBQJ73nvuy4/4nGEwbFjtg99qZLFUD
         5YxJFG8AGtHAiOr2F+fh1i6CKLV81PHMY0PDq1nrfeRxWm9+ySayR865kxIjGHDoWkMg
         YeOBn0+1m2t1a56kyIq7EMWZYkrf7Vixenscdlz9WOaXSwQQMq0utTS0VOEDKTHtdhl2
         yzqG2R74Nq3zEQZqLpKKVRCN1Wb0oZ4yEDgQGJDuD36I9woMxY1p+/LJNE72rey95LPe
         GtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z6pbeOdotLRHHyLhHXUxZEFAlmYdp5RIPKSKkUaT36I=;
        b=ZLLLujqBUJXkDOt/ti83yY553aha2M7a46qmRoy2M/8qSkui3vdoowrrX+qxxLJXF8
         EwaVP+W8xhwdNXijBSdAl8jVcXxQQutBcn1HfsxvXikDJT0hdSGLRazOGwrMDDObUgAw
         AMU60R/DF7YnHkqcWldpOXFn1Dlx/3GnrOsuLaYdZblF6Fk0ktw0SraYaR4t4y/EQVcA
         daPXrs1mmpBN4Kf1rqFFJnlEcsCiP7X5mxgc0xAsrPPy2cDALEihBLBDIPW/NAVEjQvB
         CpDuPeLfW1AARk5Bwqs6e9NbZlOIhHeOvUmN9sKpPD6MN8nAYlKNpfrVJZhmSgPP3acT
         Nalw==
X-Gm-Message-State: ACrzQf1vom6Bxnu4AogvlWzI8AjNIZ9tRKWRLqa6a5YXiALwaxqJt2xQ
        qXVlXoTMocvanu0X4PEyr+6vTA==
X-Google-Smtp-Source: AMsMyM7SxRlA7vcJhHDTJ/TZj8w8L3BIV84OHGGZg8Q4LrVBRLncdVeqKKKFwQSWXpyYZn2PkGvmkw==
X-Received: by 2002:ac2:4e03:0:b0:485:74c4:97ce with SMTP id e3-20020ac24e03000000b0048574c497cemr1273773lfr.13.1665127507027;
        Fri, 07 Oct 2022 00:25:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b00492dadd8143sm182607lfr.168.2022.10.07.00.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:25:06 -0700 (PDT)
Message-ID: <e9fe9674-8b33-dd6f-2db4-1ea4ed8d17af@linaro.org>
Date:   Fri, 7 Oct 2022 09:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-6-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006120715.24815-6-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 14:07, Allen-KH Cheng wrote:

Thank you for your patch. There is something to discuss/improve.


> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description:
> +  The watchdog supports a pre-timeout interrupt that fires
> +  timeout-sec/2 before the expiry.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:

This is just one enum in "items", so no need for the "items".

> +              - mediatek,mt2712-wdt
> +              - mediatek,mt6589-wdt
> +              - mediatek,mt7986-wdt
> +              - mediatek,mt8183-wdt
> +              - mediatek,mt8186-wdt
> +              - mediatek,mt8192-wdt
> +              - mediatek,mt8195-wdt

Best regards,
Krzysztof

