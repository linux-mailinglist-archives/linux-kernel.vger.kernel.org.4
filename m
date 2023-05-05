Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE66F8B88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjEEVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjEEVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:46:15 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF810C6;
        Fri,  5 May 2023 14:45:55 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-38e12d973bfso1240213b6e.0;
        Fri, 05 May 2023 14:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323131; x=1685915131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY/eXSCNgcg1l+d5z3txUiSd1IDYl3P2//k5Gq9XXUY=;
        b=WONLNqPYemslfHTz3Yvq+2XeYy/iqE74TKjV1HpK1q39gczkXGJQoY5Eb+TkZ8huaL
         qka6dEetDhSSFAXWnutGMNNAyyA9XnClSbcvLryynOSamQ5ciSlNdvCO8kGJVqtM5VOS
         Na35l83q7sBR+5dalHjwP59gek4dEWEaZbATOcycMs67o0Jl2QKcOBHJ/uTOggznUfiX
         mvUHlnHK4c90kMKGuDttm9dv2gukNfpv8i62KlyfqX3kSP65HFovrOxY54OS6W8E4f2T
         fDtIAyR/cLVfZn1g7aHlxQvbYJYtHOjJmOsrZUrVB0M8ipqsJko/PyIpyPMyyEJHDdbJ
         5Vpw==
X-Gm-Message-State: AC+VfDwMHeUcCM09fuFXHUij80ZvsxJ0L/CniA9rl5tBXgWTAWnJYcs4
        r2Ndu/6bzkca+JLtsq/O9Q==
X-Google-Smtp-Source: ACHHUZ4C5l8ALq0mTUv2IjXe/kxKCI1lSv66O5mZNz9Pe/is9TVS3MYfOyhEyPYDZp5nqgCqoOxcMw==
X-Received: by 2002:a05:6808:aa8:b0:38e:aa4:e4a4 with SMTP id r8-20020a0568080aa800b0038e0aa4e4a4mr1289438oij.8.1683323131028;
        Fri, 05 May 2023 14:45:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id du3-20020a056808628300b0038bffe1332dsm3173068oib.57.2023.05.05.14.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:45:30 -0700 (PDT)
Received: (nullmailer pid 3616075 invoked by uid 1000);
        Fri, 05 May 2023 21:45:29 -0000
Date:   Fri, 5 May 2023 16:45:29 -0500
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
Subject: Re: [PATCH v2 1/2] dt-bindings: display: novatek,nt35950: define
 ports
Message-ID: <20230505214529.GB3609047-robh@kernel.org>
References: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:00:35PM +0200, Krzysztof Kozlowski wrote:
> The panel-common schema does not define what "ports" property is, so
> bring the definition to enforce the type.  Panels can be single- or
> dual-link, thus require only one port@0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Rework to add ports to device schema, not to panel-common.
> https://lore.kernel.org/all/20230420160905.GA2952736-robh@kernel.org/
> ---
>  .../bindings/display/panel/novatek,nt35950.yaml           | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
> index 377a05d48a02..c93cc1018b41 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
> @@ -47,8 +47,13 @@ properties:
>    vddio-supply:
>      description: regulator that supplies the I/O voltage
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports

Similarly needed on this one.

Perhaps what you want here is a dual-link panel schema?

> +
> +    required:
> +      - port@0
> +
>    backlight: true
> -  ports: true
>    reg: true
>  
>  required:
> @@ -59,6 +64,7 @@ required:
>    - avee-supply
>    - dvdd-supply
>    - vddio-supply
> +  - ports
>  
>  additionalProperties: false
>  
> -- 
> 2.34.1
> 
