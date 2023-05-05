Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D756F8B85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEEVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:45:37 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285CF2120;
        Fri,  5 May 2023 14:45:06 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-187df75c901so995036fac.1;
        Fri, 05 May 2023 14:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322991; x=1685914991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d67AXOmWylM0/SckTFt/S26gCo7UanrJn2W3elREHSg=;
        b=KGOhduR0G4vrj2UQUlurjilWxTxXRWSfMESL3oT0doWXrO2Mr4yfBiLXiytMnkYefF
         HtOGf/FauaYzm/7aa57VxoXzJHmfK1dMkTNSt7hpQ1eNpm+cmrdpwW5g0KrHN2zRRN94
         J0p2gzDRk2Vp053QfMCEurFh/hG6SUdkdbyY7jexaG9f4wiFUTRfL3y8b7cJMmKFNgiP
         9DF/Xxuy8RMiQtY02bHL7CdnOLy/lJoazCs85AolMBOD8NkZEcr2AYoyfh4icxqLznjq
         UR6JZ+CbG/9XGDRK84BlFsODe38Gh2bBNqEDDUbrnyK949PU6GJ2TPfC4SqhynDLdaVO
         d5yA==
X-Gm-Message-State: AC+VfDycRqrn32K9YbkblmpczXx1yL3GxMqTrD3mldKS1nrm0+rkt7ks
        67V5zOpmy1SmfKVbIi3QFwZvWBQbtw==
X-Google-Smtp-Source: ACHHUZ5uobplnVA6/byhUFmIwgQB1k0JkXUKu5NuHq3CLXccWshup491ufmc/AocnoMQfW8Cfk3Xzw==
X-Received: by 2002:a05:6870:d501:b0:184:5f08:a130 with SMTP id b1-20020a056870d50100b001845f08a130mr1196854oan.33.1683322991085;
        Fri, 05 May 2023 14:43:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t5-20020a056870e74500b001762d1bf6a9sm2303787oak.45.2023.05.05.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:43:10 -0700 (PDT)
Received: (nullmailer pid 3612999 invoked by uid 1000);
        Fri, 05 May 2023 21:43:09 -0000
Date:   Fri, 5 May 2023 16:43:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: display: novatek,nt36523: define
 ports
Message-ID: <20230505214309.GA3609047-robh@kernel.org>
References: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
 <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:00:36PM +0200, Krzysztof Kozlowski wrote:
> The panel-common schema does not define what "ports" property is, so
> bring the definition to enforce the type.  All panels described by
> binding are dual-link, thus require both ports.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Rework to add ports to device schema, not to panel-common.
> https://lore.kernel.org/all/20230420160905.GA2952736-robh@kernel.org/
> ---
>  .../bindings/display/panel/novatek,nt36523.yaml           | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> index 0039561ef04c..a2a8c4e39573 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> @@ -32,8 +32,14 @@ properties:
>    vddio-supply:
>      description: regulator that supplies the I/O voltage
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    required:
> +      - port@0
> +      - port@1

What is each port?
 
You need:

additionalProperties: false
properties:
  port@0:
    $ref: ...
    description: ...

  port@1:
    $ref: ...
    description: ...

