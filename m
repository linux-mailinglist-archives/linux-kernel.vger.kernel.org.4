Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7646A19C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBXKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:16:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFD2689
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:16:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1743493wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK/pgDUArBGDlWlhMCFaCK72bY1hOVuO3X2s45L1HUw=;
        b=XS8QLB4b2RJCaLW8agzMJqOk0+FJG90O6WobXXNccvnc5zyr7zB25DOu5qZRchPc0M
         ZZbmYY/+2XdvjHgZXPnF7Arl0/IOqd7U150pjvCJcyDBueSWS/FWN4YZrFdQvFGqjSxT
         s4+DWXzmXf9/muGQ9ZjWcD9UsxzXvAILT1/8ObNutwF9QRRVzBYVMJBOFqSvPD8qQ6aN
         n2jrTiAlK2/pO1aUqYLDjnwtECVm8nfcsl3Rnc9rbOBYoIqCWgj7RRBtu3ENHGNYO3GA
         la/L/wWYi/kimn0tiNeSAB5PlAnZwLde+xEfP6mkWLQxnfEm5Cy3MHpUPb8+B4Wttdp/
         vxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK/pgDUArBGDlWlhMCFaCK72bY1hOVuO3X2s45L1HUw=;
        b=EvBjY0jVRv48hiGcQIyvqqGSkbRVRpaxdT+8bJWhrbURJ07C3rhCJ4r8jqCS7vr/YI
         l6NnUIIOdHfC84XQPIhOCR8o0BK00knZvLKsillCEqnyU0q/iy+omDLOH9duvcexLYKS
         y+W+SRjjvSKRBjzhYyX1C4p7CO5qvDC69dqITLkXpJ024zScV0jb5k23e6GO6gpcY5it
         obrwUw8ylhvsOdI8OzwiU/H2xGMQ29F7IiS75Jk+uO1i1K3eTOKxa9c+qM8D19pwlVz1
         JHKx/pW48I1zKdhu36uSQlh+ZOrfXpe+G0h/xwJIWp1Ime9XVBYpWeNC/UkBI6t7FdzX
         LBKA==
X-Gm-Message-State: AO0yUKULt356RQuvWuC0GPYG4hhMccmw8W0TTjML3izeSp7g/8w2wC2I
        sSCBqVLgtDdA16vV0c4yY9eiYw==
X-Google-Smtp-Source: AK7set//sOeJ6yfMcZNqW9A5CgabKnheWeFJx+hUkJlWbpQd1DFPL8N1VUfsNnQ6RDhMmSaYyDmGuA==
X-Received: by 2002:a05:600c:13d4:b0:3eb:29fe:70df with SMTP id e20-20020a05600c13d400b003eb29fe70dfmr347817wmg.35.1677233759199;
        Fri, 24 Feb 2023 02:15:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003e214803343sm2220728wmr.46.2023.02.24.02.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:15:58 -0800 (PST)
Message-ID: <f754b5a3-3268-9e97-858c-8aa9e5b8c55c@linaro.org>
Date:   Fri, 24 Feb 2023 11:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/11] dt-bindings: gpu: mali-bifrost: Add
 power-domain-names to base schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223133440.80941-2-angelogioacchino.delregno@collabora.com>
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

On 23/02/2023 14:34, AngeloGioacchino Del Regno wrote:
> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> In commit a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek
> MT8183"), "power-domain-names" was added to the mt8183-mali sub-schema,
> but was not added to the base mali-bifrost schema. Because validation
> happens for the base schema and any sub-schemas separately, this causes
> errors to be emitted when validating the MT8183 device trees.
> 
> Add power-domain-names to the base schema to silence the error.
> 
> Fixes: a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 78964c140b46..02699d389be1 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -65,6 +65,8 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  power-domain-names: true

Symmetric to power-domains, so min/maxItems.


Best regards,
Krzysztof

