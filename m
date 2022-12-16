Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D064EA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLPLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiLPLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:20:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3FDEA6;
        Fri, 16 Dec 2022 03:20:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1498153wmp.3;
        Fri, 16 Dec 2022 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6rJOMn7C23Skjh05sZtrGyFbRX+KxJmq2HKTjescBA=;
        b=qg7teXP6fiOQiKldcNczsQqbtZOU/V9iOr23m0M5Q/bRhWnPzdYnxG4fJ6l5USVyQb
         I5MG+/+OsIYUQbT8szIrQfwFaKZ3ydyrAcsqnkYuCOZ/pgcIqXnv0hnLOucCxSDnE4OG
         uEiIfyVrHWxvpIrsBCR0Da0ZaS216fMSyppRbXJkoSn25H7ZdJWiM1lmKRc2TKChEcLn
         mUyYkXTL3jUHPFmlngbUwPPzZOCJ5smVlW25CDyrgqUWJwLJYqZnf09M8tnVFsCvOr33
         W4eCf5upz3a0/AITLh4S/crrpPh4UYjwRs9mdBoWwyGMUOZnzY1pcFDgEV0vCJvNlD7h
         qNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6rJOMn7C23Skjh05sZtrGyFbRX+KxJmq2HKTjescBA=;
        b=F4bUc53V/+us+QW72U7VlJI5kxtXrMohDfYGXwC0GEA3Iz9Mj/WJ5/C0LXKYH6uljO
         Mlayg/+MFXvrKl9R+JYU9B0cbHwucOo8UGzMPnsqywitOzAiGjriSkhjzpW5HWgaR7GB
         1/S9rKUFkiSalv8MWybaCz2j0Y1tVdcAYtsS6ZcJXzAdxTnzZ3yDQ9vfJI1H7C/feqJb
         arSAfhVGSdy2Rj3C/GrdlhdIiSTM75TfXe/Glvpl3nAhKP49RXwZw23gW8E+1JRuj8nm
         zIf+fWooRTv+dV5bMoeJdN02kSffZdh0P1ZGZhxms0d3z3YA6ggng7lA2dFvbdkzW5ny
         mabw==
X-Gm-Message-State: ANoB5pmj4EAqDCK3QwRzLbd+LPdsYy1UYT8bqBGw5Qd5ktmUFgUhJXNZ
        R8PVgEZ936fQunFz7wGAv0Q=
X-Google-Smtp-Source: AA0mqf6jQuaToMJJezs8ZJuNep7ptUzLIx4D+Qs7heEC/M6wGzD3F3viBPGs6CBe7yGdkl8qVp6TYA==
X-Received: by 2002:a05:600c:4451:b0:3c6:f8df:b2c7 with SMTP id v17-20020a05600c445100b003c6f8dfb2c7mr25258759wmn.22.1671189653316;
        Fri, 16 Dec 2022 03:20:53 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b003cf71b1f66csm2579285wms.0.2022.12.16.03.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:20:52 -0800 (PST)
Message-ID: <f16a68a1-46e5-8e5a-2d41-3b8d23a9f41f@gmail.com>
Date:   Fri, 16 Dec 2022 12:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-6-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221213234346.2868828-6-bero@baylibre.com>
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



On 14/12/2022 00:43, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index 7168110e2f9de..d2655173e108c 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -28,6 +28,7 @@ properties:
>             - mediatek,mt8188-mtu3
>             - mediatek,mt8192-mtu3
>             - mediatek,mt8195-mtu3
> +          - mediatek,mt8365-mtu3
>         - const: mediatek,mtu3
>   
>     reg:
