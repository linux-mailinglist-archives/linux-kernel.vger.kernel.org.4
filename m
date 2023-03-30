Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76066D0C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjC3RRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC3RRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:17:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8CF0;
        Thu, 30 Mar 2023 10:16:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l37so11379275wms.2;
        Thu, 30 Mar 2023 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8gFRk6npXZUFsEh6okDavKy5iOSV5lNNvjAZq8dGGQ=;
        b=Xqxw08Vr4ij2tYYkX+zcETwPPckqyN+pCYWhay+i+vFGCC1ur8xR+PGWB6X5RqJxcz
         6G3HYbXACggrpVucvh44NtMuxmPIbHuThNE6K9OMcEY5kWl7ZKkCT+i9HkSW6hH5BRNY
         rVHHqMrzIHOUbm7rbhGHle5f4Y9AU+2q/Nb785UhbLTISjEQ1tfBEKtJg4x+eQSTOVwS
         iNb85SOiFW3gT2Lb4HFTz1dglpp6p1mewGxWpy6nr94k0K/mK15zwotK8GjFJ4pzQMa/
         lzoenhLO0stw5fqzXXxlq8a4gcNfIa3bX5XKgF/VU3jz2cufTBkKYwKcZBCUnHNmbgjE
         TV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8gFRk6npXZUFsEh6okDavKy5iOSV5lNNvjAZq8dGGQ=;
        b=ddr3/4D24QV27DkUcZKU868eLKbt+DbKRDSM8skF70cvIWB2pHdJDMsgi1t+MffU5o
         xy74CNJ/10+n6QZ+O9HK0tEBcDR+UqM4iA8vmFjjMQ/HxhGCfoqxw5GCVzdMUz4gr/vR
         e+53dBBX8JeCLrr1dTQzGbn9xx1n2ZWmkGJjxky7+8GolBGmewHJDEq9hGS8T7czpNaH
         9poPbXm0T8u4Ofa34rHLX7LJaz1591falCWHMXOqJqkPj7zM6+mCObabtkl5jkTfAwGP
         +oIcdMpg0xrztGP7DbfvBXyCX51fTFDKc3Y8siEkxLL3iE4Dvq44fButM9+Vk4MJm7PX
         kHqg==
X-Gm-Message-State: AO0yUKWxMo1iAsGUAsd0/6hgyZop/nOP57avDZaVwyMp+fp2VGx3tNrx
        EIntcY2t7JekznbzhI6QPCslD5841Oj+gw==
X-Google-Smtp-Source: AK7set92ZY/22pauXvcejr1Pry9EPukTCSQrrUreYCewWLNmuq2Q45DRuWZmp0KGJgjsRAQnql1X/Q==
X-Received: by 2002:a7b:c3c7:0:b0:3ed:fddf:b771 with SMTP id t7-20020a7bc3c7000000b003edfddfb771mr18578210wmj.12.1680196618247;
        Thu, 30 Mar 2023 10:16:58 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003dc522dd25esm6406727wmk.30.2023.03.30.10.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:16:57 -0700 (PDT)
Message-ID: <7dd96d42-e43d-9e49-a549-07f3969dfba1@gmail.com>
Date:   Thu, 30 Mar 2023 19:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 01/17] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-1-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-1-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 10:54, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-wdt
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 55b34461df1b..66cacea8e47f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                 - mediatek,mt7623-wdt
>                 - mediatek,mt7629-wdt
>                 - mediatek,mt8173-wdt
> +              - mediatek,mt8365-wdt
>                 - mediatek,mt8516-wdt
>             - const: mediatek,mt6589-wdt
>   
> 
