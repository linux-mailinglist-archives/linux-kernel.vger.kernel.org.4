Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A571FC22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjFBIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFBIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:32:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B018C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:32:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f53c06babso245208366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685694774; x=1688286774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6o32+EXqkQOwwvwWTyyFIWUzWvHCRd3bW8dtLzYc0M=;
        b=SF+7px9QcZH1m1Vj1b2GfXALro+NdRTuZIllFGdKVav7TEBvES/2uDpWKVI9xCZWZj
         Iv4bT38X4VR2ZAahaID8tl7YnfQCN+dfYwrgfbmTjOg1U7rD7NSOfjpjrWHShz7TJyZY
         YcTLPTBP6SIuO7QCpCu72aRFZO6EQUipoA2O/r+AmyTKNT45OebGXlQrEew7g4fHcWMF
         OVrAocSDqDleCKKAaH70gdYegshPK3bxyqFB5qSxqTmvtlaZcG4jmIc5e0rMFKGEzSJA
         Tysc9o6h3haQDhWXsvkxQhM8zCT2RaiSSLJOfFY3rkol/FC7XZY12Jh9hC8Fk6fX5yEm
         ajHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685694774; x=1688286774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6o32+EXqkQOwwvwWTyyFIWUzWvHCRd3bW8dtLzYc0M=;
        b=YBvOk6JonjBi46KQ/CM5dW8tWaDarQ6mbArQKoeWZwDbcfhIFqIiKUBztsURccmZ4O
         XOBUeSsW6NA+4Zhc5AC1ZQNEYRCHaWLWvoT8ePz65AWkxN8HR9N7+JKlfcIqwszwh75Q
         6G1ubkQOIVsw8Tx8IErXtFE9pc0fgLviwEoz3sYKz6FTlLSkV1WSt4FROOjvseo99kOd
         FvLUoTmk+Rm6qsHo/myKU9lZG3TQg5UJAV0cLzWn7hcijZXWc7/WNDCR1adEfX/fJwkc
         y8d1kU+0YDYlJ28F+afzLoLH5rXCamBX/Aa6HPCLfXD5qHlFpwjXRiB8tbi0bvZNl5Gs
         S00g==
X-Gm-Message-State: AC+VfDzC7qgetTp1H7+lgBskCVM12QLcxDUY+EkC3RpWTx3P7ypzqb7B
        BDadIRspXHfol2w++NvlGJeA0A==
X-Google-Smtp-Source: ACHHUZ5bbkg1zhdbdLCCj6ww+0OpxboaT0r5ApjCE5h604Y3MUUFQIlVUcvBkPvczEmb5mkg4VqJdw==
X-Received: by 2002:a17:907:a42a:b0:96f:912d:7922 with SMTP id sg42-20020a170907a42a00b0096f912d7922mr9551134ejc.53.1685694773958;
        Fri, 02 Jun 2023 01:32:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090668da00b00947ed087a2csm461979ejr.154.2023.06.02.01.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:32:53 -0700 (PDT)
Message-ID: <75d78713-fc8f-24a9-a422-2b4d57c5d488@linaro.org>
Date:   Fri, 2 Jun 2023 10:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/8] dt-bindings: leds: leds-mt6323: Support WLED
 output
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601110813.2373764-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 13:08, AngeloGioacchino Del Regno wrote:
> Some PMICs have a separated WLED string output: add a property
> `mediatek,is-wled` to indicate which LED string is a WLED.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> index 052dccb8f2ce..904b2222a5fe 100644
> --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> @@ -30,6 +30,7 @@ Optional properties for the LED child node:
>  - label : See Documentation/devicetree/bindings/leds/common.txt
>  - linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
>  - default-state: See Documentation/devicetree/bindings/leds/common.txt
> +- mediatek,is-wled: LED string is connected to WLED output

Why would it matter to what the output is connected to?

Best regards,
Krzysztof

