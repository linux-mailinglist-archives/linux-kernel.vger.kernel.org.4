Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740562949B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiKOJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKOJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:42:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EAD1C11F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:42:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a15so16758883ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcOuuVLMRPvcgqS609jqzO++6wCIprOGvA6tVBuXng4=;
        b=XOaPnkzJeHzIeFxXzzJIxzy7diDEbKFmS6PQm3Z7zr0fPgejLXIrGdXo//MJa/t1Sp
         AZxve7rHIszO989iH7FY2rwa7TRzIma4dyIiA4iksHmvt4O2TRXy31V/YegM7X/FlkdZ
         KyjY8CtE54wvqy1CUx9QoytAEbcJy1TxYmFqcUZXq6o8dYNffOgajutxMT9rmTvL1Pbx
         JetYZpPKewFpz61Ziu35LeEdQ048WI4+yCbDO9xi5da05TXBFf5+t7wXn/BSCGuEH/MA
         Z8tcz1TfOHRA1v33/rA2TR13Qd/3fnEv2vplLtWU/keuMeZRQvOTl3MxK/bxowD20fhO
         F6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcOuuVLMRPvcgqS609jqzO++6wCIprOGvA6tVBuXng4=;
        b=PG9wx3Md2rcSO61dIQNGAfsR0Z6xuLwz4OdrDemsqmQCIMtWOBVV28puLz7uMOKCei
         36fYyxUjrj3j7Capf4XP+XbPhwgJWZAnJtd1t35RxxF4FYSsvW5+9ZcNOZcJGa+6awsn
         92EHNRLAM9kNr71Q3lqZKF8tug51BHmcxhcfibkpl5CbbsJx7Dedim5wwzRqCLzuwGDY
         kHbv/ecg5bI9q0Hpv+gWQj55tbhHAE/cOJXmixEd4Q9VJbnom0dH3Yquiz5Zsf4+DIvW
         ZbUi9Dl91HxcNjDuHAPb9rk0P81y1BR7ft79U3/J5l7TFvGNY9+SonA6z7IPP2FQnc7w
         78KQ==
X-Gm-Message-State: ANoB5plcICaj1oqHl7KIP0QMpNyN739fKAcUs8qHwUlQIeVIajVGwMN5
        cktn8g6oAOryg05b6HMGB4mr4A==
X-Google-Smtp-Source: AA0mqf7o6HYdQ/m+T7fG4BO/aTBqHmWFwpCsdvzYlMBgLK7cFm3mEKNbwzJXoJqe4wSxsvb1xrvPFA==
X-Received: by 2002:a2e:5008:0:b0:278:f31b:2770 with SMTP id e8-20020a2e5008000000b00278f31b2770mr4703017ljb.310.1668505374162;
        Tue, 15 Nov 2022 01:42:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b00498fe38ea0fsm2163880lfg.174.2022.11.15.01.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:42:53 -0800 (PST)
Message-ID: <1a8608ee-bc9e-b5b9-b010-5aa76b799481@linaro.org>
Date:   Tue, 15 Nov 2022 10:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/15] dt-bindings: iio: adc: mediatek: add MT8365 SoC
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-4-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-4-bero@baylibre.com>
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
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding for the ADC present in MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>


Drop second, redundant "bindings" from subject.

> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index 7f79a06e76f59..ed582c6e7ea9c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt8188-auxadc
>                - mediatek,mt8195-auxadc
>                - mediatek,mt8516-auxadc
> +              - mediatek,mt8365-auxadc

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

