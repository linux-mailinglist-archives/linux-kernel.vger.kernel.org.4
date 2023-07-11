Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBED74E6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjGKGH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjGKGHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:07:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF51E5D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:07:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6f943383eso83278911fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689055667; x=1691647667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87JKbcUVRlq+DNPw4nB+PH/NAlnJ1RS5NBqs41gMEOU=;
        b=hDyquc9TF089XR4hezU48avSlN536ZzYIGYagcXMkHzFtDub0l9RyYcfFRHc+NxyM6
         5D+j5tlFni5gn4Y2MJZkY3PoSwMtih+IATUuQkWmkzTdFP0BfrlZtSpXA24jaKNQLmXB
         szWHNBNGW28L4XwWj5Ir0guBDFc8kKQIWQhN8QTb7jE1drN3czpXDk7GVovoa+TRj5VB
         0NZbQXIdq8SOTHl+8h+0ZAZijSAaqQGtDLUGdgFtTqitWuqAM2I8z4wqWiTKCEvNLQZI
         Xi095NLulQqjZ76wW/lUKDFDmaiZCEYwISsZQQjTEUbUeKBjrbCTLfgC6uQ6pB/TvogJ
         7Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055667; x=1691647667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87JKbcUVRlq+DNPw4nB+PH/NAlnJ1RS5NBqs41gMEOU=;
        b=VqPPGtyaEurELEFXs6jWD+DsjsngtCGs0BgukyJtFik+aYiltq1Qq1mk8gujUtkS3J
         IilHw4mbAODnplYcRn8TBpds39C4KZDQTzzR5Wnf71pJPOSiWyN81YCnut6z+043Ftq4
         DiSz9MG/BcWcSkTIHS+8XU9Btp4JlCTB2/IZgTsG/fWrb3UGwBB6P7hgjl0Q8t2en04A
         rA/xaxk99So/iThdep0PVVTti9SlwPpifslT/nsUQSGZSnbx65lTJtosV2q1sPheXYjL
         WbY8IeXRMQOInJ0dEn3+66ivH+Z2N07uQaU584qnbukktXmKcK9EOGjlxEPq17/TzgJQ
         1ueA==
X-Gm-Message-State: ABy/qLYSqpAQBHQ64VdaWsxKloQuO1PVv1Tw+M7HbnJI+njOHbONyORj
        +LJm4w608s90dO12omlXamxjHw==
X-Google-Smtp-Source: APBJJlGxS08q6S0u3P36CbSj4k2nCgfEdYovOwC7kb/zhvIVVpsqy8GgSc/0CcDKHxo8YOxQLLirMg==
X-Received: by 2002:a2e:7a16:0:b0:2b6:ee6d:b647 with SMTP id v22-20020a2e7a16000000b002b6ee6db647mr12391356ljc.28.1689055666942;
        Mon, 10 Jul 2023 23:07:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906261a00b00992f8110a2bsm668980ejc.150.2023.07.10.23.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:07:46 -0700 (PDT)
Message-ID: <84847777-bad0-0aff-5279-9b80fd95c2d5@linaro.org>
Date:   Tue, 11 Jul 2023 08:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230711023929.14381-1-jason-ch.chen@mediatek.com>
 <20230711023929.14381-4-jason-ch.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711023929.14381-4-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 04:39, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> Add MT8188 PMIC Wrapper compatible to binding document.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index a06ac2177444..c2f22e7dbcfb 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -50,6 +50,11 @@ properties:
>                - mediatek,mt8186-pwrap
>                - mediatek,mt8195-pwrap
>            - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pwrap

Why do you add duplicated entries? Test your DTS before sending patches.


Best regards,
Krzysztof

