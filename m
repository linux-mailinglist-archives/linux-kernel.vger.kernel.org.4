Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E8700CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjELQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjELQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:18:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51C76BF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:18:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96aa0cab88dso159825666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683908306; x=1686500306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrz9w0tFb2bEDTavGbd5fDgs1thiabqypf9MHkMZM7E=;
        b=az2gzunWnoFGTedzrfM2TIbgTMGezLZi0Pxftg0z4G7WBcjClypX1MFYbz8i8Ffkpy
         rIPd+p9IvKeMHmW8j0rdOgWCBsgeKRSnUSDfyt1Vi+6WnmNExmMvNKsjWXnRovJQXfKW
         448lS9q5BRTaRG5axAPCUHKPpTDMtBNaadOB56e9URD71wbzPywTpB6wAAkG89cJmDrs
         BGIDgPXrsRgwWJ5tFqT1Ijehw1cql0A+ytkZnF6yCl/IyGvkD3S5HckHcMHX66OWzRz3
         zXAksm8dqrKTDHLbPan7w3A5gRaD13FQcWspRlIoW4Nysu8LdJMknrr3IeNo+/koT/M1
         jpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908306; x=1686500306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrz9w0tFb2bEDTavGbd5fDgs1thiabqypf9MHkMZM7E=;
        b=LaWcsu8oxX77KoWLaBTHG6bn7g+VMGKygliergW2LoOSbxCdUWrPTmRAcYZzKJfkPG
         utswstuoFQmday6Kd01Jzy0rTL53RPIbnguuQW48PH5g+ogzYLdJTM/tgn/ibFDZx2Zs
         EC0O93/B3NTMlD5E75p6OtkgfP+HHrtBcEp0cZgB5cvnxEit1t629VaBU/KzrUmAanCe
         RHNKyrdTEQrlXz6M1MlKWKfeiY4/pJjKSxMzG+xAL5sqKIi1C2f5xE9zzK9h+dTuKc0Y
         jwP7xHiPN0QI9ha8dCF+6b5cYov3CL0usGTIA7BgYXDIMaAPh5F8PGhL2jukHHhkVbX2
         4oGw==
X-Gm-Message-State: AC+VfDxa6ul4xLDefibOOrQCaTO+ds6Im/aa/6MnbnCEudfg3nN8qppS
        U2q3NKUjbt4/36oHgowNLz3Ucw==
X-Google-Smtp-Source: ACHHUZ503Yw3/dALYytrKZ2MlhWOUd6bkVlyqT/PlDFv2HMBJY003CZ/7QJHED8qAmAK9YRj0Ft2Mw==
X-Received: by 2002:a17:907:6e12:b0:96a:78ee:7e27 with SMTP id sd18-20020a1709076e1200b0096a78ee7e27mr5822051ejc.59.1683908306071;
        Fri, 12 May 2023 09:18:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b00959c6cb82basm5544589ejc.105.2023.05.12.09.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:18:24 -0700 (PDT)
Message-ID: <3b382277-e992-39a0-a4ba-c3fd88bfc41e@linaro.org>
Date:   Fri, 12 May 2023 18:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: da7219: Add Jack insertion detection polarity
 selection
Content-Language: en-US
To:     David Rau <David.Rau.opensource@dm.renesas.com>, broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230512081030.5138-1-David.Rau.opensource@dm.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512081030.5138-1-David.Rau.opensource@dm.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 10:10, David Rau wrote:
> DA7219 can support 2 kinds of insertion detection polarity
> - Default polarity (Low)
> - Inverted polarity (High)
> 
> This patch adds support for selecting insertion detection
> polarity to the DT binding.
> 
> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
> ---
>  .../devicetree/bindings/sound/da7219.txt      |  3 ++

Bindings are always separate patches.

Consider also converting them to DT schema first.

>  include/sound/da7219-aad.h                    |  6 ++++
>  sound/soc/codecs/da7219-aad.c                 | 34 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
> index add1caf26ac2..357d1f61de1d 100644
> --- a/Documentation/devicetree/bindings/sound/da7219.txt
> +++ b/Documentation/devicetree/bindings/sound/da7219.txt



Best regards,
Krzysztof

