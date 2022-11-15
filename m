Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A216294C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiKOJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbiKOJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:47:53 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020322B15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u11so16731805ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUwrnHBXFfPXV3HqM0uSLgjBuLQrs42kFBoLnffmkPs=;
        b=P3NDqMAdFm/ODTPPACk2XXmDdfzl2y260/cRWUSMQjUuxxouuR8nlQFVMfsSXnOLG/
         i5lw2ObDCRnar1nt0O2QrfmEq0zHRdpK5WZDq3BC8PK4DFDeUpXEnPLxq2Rnu09Sy2Mn
         8wbxzL2pnLdwRt2yyk+jyamULm4ZP/fsSl2gyp76yMe6znxy9ude95We0cxpsPlI3i//
         CcmOASLJf1pethdYNtpnpZTDYZ00SmrIrZO471wGiR89y1v1zmJpvern4KV3LmnSVJiE
         Snbc3D3Kd8vbH0s4TTu4pQdr2SOiGf5i85FRviHxmuKDB+JSAk5Yee8Wjr6SHliqHL/C
         UNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUwrnHBXFfPXV3HqM0uSLgjBuLQrs42kFBoLnffmkPs=;
        b=PWID/YSWIm5Y8wUlH0jRrbQyzJ327DN/FXLZl7YpWfIyOd33hvussH67t/3pJ+jNDS
         v7p0/DYuR3U1uCxuo9KGzSE671futHNWpFjeObrI/sjkhWg0HYLuQ9uTkXvRPMnjSMZ0
         G1Q1bA0mKqsw7M3rtMLgAKdWs24RV5w9PmkUS++2G/vBiT+jC3tOhKzn69vV40OxS3ti
         arBtPFv5KAv05IM9OuTYs8EuI8DlV8AJ203kq5yob7xUHUk7DMVzD7w4sSsr8fE2VCEz
         RXoPjUzMkCh/6TneR+5DxAIEgksr+Ra35QHxJi0DFoQ4pG/jeERqEXAGYhhWk6TT3v9+
         eTRg==
X-Gm-Message-State: ANoB5pmrUFaHXZ2uOwB5t1LE3+Afgp6w8mkmBg7+9IVFvXn5Tk0P+rM9
        oP47KVXmxXUkjhf51iKPk/eLpQ==
X-Google-Smtp-Source: AA0mqf4rC091Nwov6Kwm9iDiTEHbcLI4s2hQscMtz8VZdIaK9BzMaSpjan3b7sqN2N2RKLparq8/tA==
X-Received: by 2002:a05:651c:491:b0:277:21c8:a94f with SMTP id s17-20020a05651c049100b0027721c8a94fmr5072964ljc.28.1668505669598;
        Tue, 15 Nov 2022 01:47:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t7-20020a192d47000000b0049c29292250sm2144019lft.149.2022.11.15.01.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:47:49 -0800 (PST)
Message-ID: <2762e722-5561-4aa2-75c0-db9fd03ff4ff@linaro.org>
Date:   Tue, 15 Nov 2022 10:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 15/15] dt-bindings: arm64: dts: mediatek: Add
 mt8365-evk board
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-16-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-16-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> Add bindings for the Mediatek mt8365-evk board.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

You document a patch after using a compatible - that's broken order.

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index d76ce4c3819db..6781fcdb9fe69 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -246,6 +246,10 @@ properties:
>            - enum:
>                - mediatek,mt8516-pumpkin
>            - const: mediatek,mt8516
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-evk
> +          - const: mediatek, mt8365

No spaces in compatibles.

Best regards,
Krzysztof

