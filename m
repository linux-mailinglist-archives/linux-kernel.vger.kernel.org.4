Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1485D6A838B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCBNbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCBNbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:31:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517053B3F2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:31:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s11so3633503edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677763909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQfK7z1cF5xS5fOpKIQMzf1W9EJ2G3anNgIELaiZ9Bo=;
        b=YHV9vkfYEQ5XB5RagRNB5k0JDRHatmunEcxAGzm6oUMEOVF4goGuoImpehzDh98KzX
         dASgB5AP2AaumHEaPw1djqryok7FWg0hDiDLHX6TtwcCyhCKU9oR/UzPmwPzlt0aQDgz
         0lAK4zabgv+STpu9Ha/crrLFrOWpz3UwNf8dgWYeF3C1Lc8/ZXm0FzF/X9e6rVbFlXzW
         ZX7NanDIKJ1VsfUNSHwhIR1DxpmnMXy93YSc/Osbv/KamSTpgR/JITZGMMhos/PEa5C8
         F6WClSGtMYvtAsnEW8qyBc7yLtd/r1Sq5mLeXIzfqSauhFAgQmJW0jOgaKVDN2lrIKmf
         RZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677763909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQfK7z1cF5xS5fOpKIQMzf1W9EJ2G3anNgIELaiZ9Bo=;
        b=BhF02KSnWKJCah5PCZgoT0AF5znjDjz8HITMaE7Lkj7Aqh6DIJKJx/Iwizvk3IrD66
         Ce/EejYTaYqxPrRJ8/WlPzNbcmTXT6qszi5/Ceejp5K0IVpavKyvOvVq5/ATSXsKOy1D
         NRfvOsa+69LLiu++QIE4Sjogm10IfBXWoXwTY/9BDXDEZGWzEtXJ41Z4QMAsbbgAuvTn
         NZ43EeKdXai+R+c3CWlW1/dHys34UqQa3IVq51HxrzwNw5P2xbKzAqaRjk6E/bXtZOEY
         1QM1awnx/2IKAE85UXp5ZaGTCTLCgqfnH5iTEJKecbRrlCm3TO8E+vjj6JmidKpErPwM
         2nPA==
X-Gm-Message-State: AO0yUKVVDaZPkRfhHEPXJlgPykP9MmClpCoyd9kqrYTbK0v08SAVBs/y
        ZFiHlynPLhXZwUTIq6rwI62RcA==
X-Google-Smtp-Source: AK7set/hE11XFsgkWSODqUZuAE6McTZ3VVe++bAR2CRMf/+3Je9cNA7pKsuG2Wvx1Mf6z9RFNKo8PA==
X-Received: by 2002:a05:6402:1acd:b0:4af:51dc:addb with SMTP id ba13-20020a0564021acd00b004af51dcaddbmr10658613edb.19.1677763908847;
        Thu, 02 Mar 2023 05:31:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id co1-20020a0564020c0100b004c0239e41d8sm771780edb.81.2023.03.02.05.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 05:31:47 -0800 (PST)
Message-ID: <53975f44-83cf-7942-ff2f-727a2d9a0bc3@linaro.org>
Date:   Thu, 2 Mar 2023 14:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: maxim,max9867: add "mclk" property
Content-Language: en-US
To:     richard.leitner@linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-2-aa9f7f25db5e@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302-max9867-v1-2-aa9f7f25db5e@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 12:55, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Add clocks and clock-names properties to require a "mclk" definition for
> the maxim,max9867 codec.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> index cefa43c3d34e..152340fe9cc7 100644
> --- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> +++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> @@ -35,9 +35,17 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: "mclk"

Drop entire property, you do not need it for one clock.

Best regards,
Krzysztof

