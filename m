Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F6620DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiKHKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiKHKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:51:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D24385C;
        Tue,  8 Nov 2022 02:51:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j15so20324123wrq.3;
        Tue, 08 Nov 2022 02:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZW+it9gAVgvNTLwS9dPm0WTYzAoEQ3VftkRv9uUVk=;
        b=Ujs8FDtI0g8RDiTm1SkcwABjS2X8XHfP6L5VlsrL2jSPPbfr95N0VsMY/6eCCVG8AB
         FlBsTIU1CvFBa+uoM2sfmkBhorlUopsBrhGzvYQ9qYTBlbSRuxzMR95lL3YAnJf6drJh
         e535dnguPOKiBTPhNUmhgjOw6mpYcf17L4sjbsWkRQWJ8jEoRt7Mc6irHSGazz82D6pK
         W/Pw8nUw4FEMFkmVTEhogB2g8Tk7pz+pLbfQZp3GQeuJnazqnOwudk87jY8HViT4ZX5j
         FW2HSnH86lqmwZw7vujYK2GiLHETb/SRdu5/iBnxU+IItsindtQRASnvprBfILHq5W1I
         uwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZW+it9gAVgvNTLwS9dPm0WTYzAoEQ3VftkRv9uUVk=;
        b=UmmxC/3pg6yDI3uNVW6BhYhyEY9h6mZkGiBi3BUHc/PNd3BOlF+YMak/RrbzOzSlT8
         5fuulBBiwHqnnS1jm9QC3XBslD+bChE5gkxRBrDzLn/9T3AB6H9iU2OLIqEqjUVl/nJ7
         8YGsdwcT3zhyMz2s68AtXbyUlLWcP8HMU2wViaRiFRHGIlNAC1Pm8NdJAlKdmy/STNO8
         dNmyqzCmMmleK6NdDMmPoFVNB0sM85mvaUrb09J6iPd3n55DSHKOZck4QnEopSJf3n/s
         yoCv58Af9PXYYqGv5p5TfunlLWNcWeO74R4hcLTqAWiiVLLdaO4gUy2MQamkcFXpVbEn
         FroA==
X-Gm-Message-State: ACrzQf2DD4tljERwgIG0GOqh2RbmIOPESMKRKUYRsX5w1IgXePpSnGDQ
        BHUWNA4CIlwBkCzz2HWBNjM=
X-Google-Smtp-Source: AMsMyM6tqN1J3BpRuY/aDQn+DuJOiDBrsyIsvgctg6ge/1wrpIECRn9e0F15giQoo9bhIK7fkjVTRw==
X-Received: by 2002:a5d:61c8:0:b0:236:b893:9d83 with SMTP id q8-20020a5d61c8000000b00236b8939d83mr33497801wrv.354.1667904675056;
        Tue, 08 Nov 2022 02:51:15 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r2-20020adfdc82000000b0022ae401e9e0sm9966170wrj.78.2022.11.08.02.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:51:14 -0800 (PST)
Message-ID: <2fcfcdf2-baf4-5e16-2f10-f56dff68035a@gmail.com>
Date:   Tue, 8 Nov 2022 11:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 6/7] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6795
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221108033209.22751-1-allen-kh.cheng@mediatek.com>
 <20221108033209.22751-7-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221108033209.22751-7-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/2022 04:32, Allen-KH Cheng wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add the mediatek,mt6795-wdt compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index b3d2273f323b..d9d4aa7e27e3 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -22,6 +22,7 @@ properties:
>         - enum:
>             - mediatek,mt2712-wdt
>             - mediatek,mt6589-wdt
> +          - mediatek,mt6795-wdt
>             - mediatek,mt7986-wdt
>             - mediatek,mt8183-wdt
>             - mediatek,mt8186-wdt
