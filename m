Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDC6DED52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLIPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjDLIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:15:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D40FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:15:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb34so26888338ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681287304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFt2X04+gRJHM2+VI6ttu8hA+NrhkWSLmAUSA85EMys=;
        b=Z6I6MrMH/lfo0t0Y0h6nvWLZnvjhnC6NwFLDT6uewKACghnLMh/GTj1v+inaNlz+Kl
         wZ6na2RHpYTyWT781486puPTghs6mXJXOHSICprqmvDRjdYwykvupA3XID25f/nf6F1K
         oUbO4bgP7K3rjUPhiLbcIDtHgLpEL9FFNzsDXZTHKUj5hE3YkoLANTGk6bH61+tEbAGR
         x0IDS7wMevWHc/rOtJOTKoYkVrlXH+X5akkL+HXcioyVHDYsikBJSZ17zaFwMlAtWEkD
         qLPqlTep0SpYlat+X9ZZOf/iVvD1wgfr1MUuns1XiI5imaP3LgX/Ls+Gfyw4UcVCQ1bR
         XZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFt2X04+gRJHM2+VI6ttu8hA+NrhkWSLmAUSA85EMys=;
        b=6aavkKGVUGGO7Qsyh0Z4dwsu9cphHkQ0KHsCQrUxCOW7fgNqn0zAsHBpD7SXK7BwCK
         GKX36zFn7GJQiOgDeYGv/791C3Fzro8mmjDW7zvoqNblH8+us8ot4KYLrcP9IxYBvmO3
         CV+S+VqVLYRTpha6MMEHnG1fJs6RMMK4PIobtiUps15f2bqdVLoK4asxtZKWMYQn4BnA
         ns5E/EL5DRSrCSvfgBR72ZPNPkrY4fLkmwyHEw4uXaMVqo5OfV1pu2ZiJsVx1xu2InTY
         WC66XIfKEunk0HX5vYF5syJqF6fiQ+jFabH9FrDcCgdJEQA08ti3YaE8wYd40supCFIS
         dsVQ==
X-Gm-Message-State: AAQBX9dKAmRhQ0fYyTzE3BhPFPBvZ1AXGuQtmBpUPfv7AHoX4SIdiEFs
        EKKJ14r09cTsP8Zl7yZ4padCYw==
X-Google-Smtp-Source: AKy350YN+rstwkL7t/fiU5nlz3Ynak5pPMW0pVAEUiLlmM3URy4db0+sE67ofxpCGhmf8BuykmLBKA==
X-Received: by 2002:a17:906:6494:b0:94a:653b:ba40 with SMTP id e20-20020a170906649400b0094a653bba40mr1571344ejm.15.1681287304232;
        Wed, 12 Apr 2023 01:15:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id wt13-20020a170906ee8d00b0094a8115e148sm3103930ejb.87.2023.04.12.01.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:15:03 -0700 (PDT)
Message-ID: <e1f83f5f-c139-c1b2-5e42-00fce804e548@linaro.org>
Date:   Wed, 12 Apr 2023 10:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 16:04, Souradeep Chowdhury wrote:
> All Qualcomm bootloaders log useful timestamp information related
> to bootloader stats in the IMEM region. Add the child node within
> IMEM for the boot stat region containing register address and
> compatible string.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/sram/qcom,imem.yaml         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 665c06e..9998d65 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,sdm845-imem
>            - qcom,sdx55-imem
>            - qcom,sdx65-imem
> +          - qcom,sm8450-imem
>        - const: syscon
>        - const: simple-mfd
>  
> @@ -48,6 +49,26 @@ patternProperties:
>      $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>      description: Peripheral image loader relocation region
>  
> +  "^boot-stat@[0-9a-f]+$":

Konrad,
Just like for RPM Master stats, didn't we want to call these just "stats"?

https://lore.kernel.org/linux-arm-msm/20230405-topic-master_stats-v2-1-51c304ecb610@linaro.org/

> +    type: object
> +    description:
> +      Imem region dedicated for storing timestamps related
> +      information regarding bootstats.

Description is okay, but you ignored the rest.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

