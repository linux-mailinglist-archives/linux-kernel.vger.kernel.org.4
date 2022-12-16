Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9168C64EA1E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLPLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLPLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:18:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A15FEA;
        Fri, 16 Dec 2022 03:18:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so2158636wrs.6;
        Fri, 16 Dec 2022 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUbUQYdA9uIL1gANrRpWzNy+A6oN/aPQMxaVdqIc/Ec=;
        b=mZEodglBC9sPGG0EG0nvzNC65qvpe4Uk2UG2Jrp5/L6DgghUYDo5VOddfYhHemaO62
         T0PygbRqTcQr+iS1lwL9RXwyoAb+1T4ziqmXXMOKQPVcSPiZ2hbrEnkrITmhSKHKqDsI
         JResed6REfZi9iXIwgd31FkqZ7JArZ1cSAlstKPFiq8RB8n5fCrc29T2o9ev2Pn0Wm+b
         SXsc/ApwEBkm4N3J4Fg9mdxrVch4Rw9Ax5OYmYXQrw1Rr0FW2YjAg8PwrFWLfWyWyvRL
         k2e17WqfYDqjTuPG1dqPYjyo6NPbzIEOYrMX8mBgTxYTk84yUexGSWXZISu2wo2cAZhE
         CmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUbUQYdA9uIL1gANrRpWzNy+A6oN/aPQMxaVdqIc/Ec=;
        b=AUJY7LlE8QmsbpzXB+x/QkqY9ZznPy9Sg5P/wqi1CHRexN/WfkaWaUK+ekqCYVOpbe
         c0jmjUCd1UIpd8hgI5n48ZPFv0xydU3PxYffAYClkz6fXK+ophoU7RH9coaHQw5Tw4Ag
         U6K3CRzt3M0ZzLycDlYBzElnd5Z/GB+ZI6YLsohEe5WilLHlRrneNyjQ3xVFC2e2hLN/
         Kq/K85hECb791wT8LVUj72YXH18TvSYkazetXE7YAW8DwM+lb4hGSQvnj67l/bM4kxzP
         rG3g9CW6KTqCrA2cMgB0GRbo1LBG/KFR8jJk5jFth1TuadluXg3gSA9Z/OYUhVaYkW/u
         13HQ==
X-Gm-Message-State: ANoB5pmmGzBApKvaN1+eDkH7HLzImTUMTpAzVi+KvN8+teK/7HOU8EXD
        PLg2q62VnXmQmdr/eNiDekXWlh3Wc3M=
X-Google-Smtp-Source: AA0mqf4il1eAeR7CBxxr2GgBBR+dVprN/eW6AJZaB3Fn0BlHgV+EVyRhEstZQzUij6LVFR3n5nYLEg==
X-Received: by 2002:adf:f5cd:0:b0:242:3eff:6855 with SMTP id k13-20020adff5cd000000b002423eff6855mr17365159wrp.54.1671189534544;
        Fri, 16 Dec 2022 03:18:54 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b00241fea203b6sm1965853wry.87.2022.12.16.03.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:18:53 -0800 (PST)
Message-ID: <3270e0fe-2f45-62d4-e1bd-0f55546cda6c@gmail.com>
Date:   Fri, 16 Dec 2022 12:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 1/7] dt-bindings: arm64: dts: mediatek: Add mt8365-evk
 board
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-2-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221213234346.2868828-2-bero@baylibre.com>
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
> Add bindings for the Mediatek mt8365-evk board.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 2275e5d93721b..ae12b1cab9fbd 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -244,6 +244,10 @@ properties:
>             - enum:
>                 - mediatek,mt8183-pumpkin
>             - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-evk
> +          - const: mediatek,mt8365
>         - items:
>             - enum:
>                 - mediatek,mt8516-pumpkin
