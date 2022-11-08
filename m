Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14A620DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiKHKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiKHKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:51:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957C120BD;
        Tue,  8 Nov 2022 02:51:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so20272171wrt.12;
        Tue, 08 Nov 2022 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmR2gwQyBIIv5dH4/maIZAZXpAasRwezdpF3Bi70/gY=;
        b=ndsRlJ9mvDTTRtj69GkF4zUMWLofBaLY8RXsaa8eWq3e14obMsvlS1yFUES4/dPh9h
         p9fe0YbhiQecSuVe0nXHjVc4fE3/YcPJ1rUAUVEJnUwwbX8ZdyYyCDIhvIxK5QnnsuQ/
         2z2G9FrtCw8Wz4CYbzlhvuC/cqikWzZ5kr62L3t0yvLO+qY6cODOd1yPcICRJq4/98F0
         xNbUru5snUvoqKzxcXyCmDG0qGM1V1zSCaX44FP9xUTNWNQhr5+GYt3CWL+JutJ9zRqa
         OKIsGLsSwQ6c6gljETGPL2i0IJukKCF0Kd2MQ3O4k9Rbux44GdD088Q82fUMEa6FTNde
         2QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmR2gwQyBIIv5dH4/maIZAZXpAasRwezdpF3Bi70/gY=;
        b=gkIX5HdSuZ6NhLwbjBKkPGOth2QWtEeu6XUYRe1PIhV5m42f5tXe+Lvp4HxjgaO+Zb
         5leMlVjghBgVIex97zLdgNbpV4obr/kvxYOVopTk9KHUNnSqf6x+FOO+ERbFM8cI/dpY
         lg5Z8Nlyu8J4Hu4e0+FNSqc3lEyooggy3ubBe5sRg5KfjxqhMMpOULZj0rXohsgJsyH2
         dY+A2U3YT+/PmybqRg5ntx+wF9iU1LJ4MpJg6Om/V89JcaLUw62pihjO3EANbjPx+/zB
         h/u2Glev047Uyij0L1x5gVe1nE5nHbOnNJWGA0SJ3lfQ1guManuoCQaCvCQoDw5ckWH2
         4r2Q==
X-Gm-Message-State: ACrzQf1ShBRrI4AwLvBZ5jYs8i/ksIuqD/FMSfLfm/ZbsXUrtjsqN6rV
        Dki7dYZUb5Q5zhxxuoeJTB8=
X-Google-Smtp-Source: AMsMyM5XHhQmnbJXNKYRgdyg4VzWQzjipRFA07QQ/LYAHmHuE9SY0flHtWh4hsSakLlFmrSpDXes0Q==
X-Received: by 2002:adf:dc51:0:b0:235:4db8:2d3b with SMTP id m17-20020adfdc51000000b002354db82d3bmr33772138wrj.589.1667904712653;
        Tue, 08 Nov 2022 02:51:52 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm18084882wmo.27.2022.11.08.02.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:51:51 -0800 (PST)
Message-ID: <5c909107-f529-5029-f7e9-d7299f45fdf5@gmail.com>
Date:   Tue, 8 Nov 2022 11:51:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 7/7] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT8173
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
 <20221108033209.22751-8-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221108033209.22751-8-allen-kh.cheng@mediatek.com>
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
> Add the mediatek,mt8173-wdt compatible using mediatek,mt6589-wdt as
> fallback.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index d9d4aa7e27e3..58055a1aed92 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -37,6 +37,7 @@ properties:
>                 - mediatek,mt7622-wdt
>                 - mediatek,mt7623-wdt
>                 - mediatek,mt7629-wdt
> +              - mediatek,mt8173-wdt
>                 - mediatek,mt8516-wdt
>             - const: mediatek,mt6589-wdt
>   
