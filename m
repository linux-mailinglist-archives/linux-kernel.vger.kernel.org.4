Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C25BEA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiITPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiITPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:25:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6656B9B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:25:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z20so3454705ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DhU36xf+kkHEB9Z3O8FzZRfYoFwRwILvA55dsayFWs8=;
        b=a9N0xBcJWqgFz3GGJcXD8noE97lXy7QNax86oqqGfMegWL/Dh2tp9gz2Z3Ikqlukzv
         3e+4GE+r5E07iK9mF5PrtLSQCkKDewNzSaZLdic4FZ672ohjn3Z4xIqIuNgP3zihMtet
         vB6027D4Y+e4Y3aLvPV4tJNYvNEG9s3Y4g3fUP6EmVfdChD8jr46ymBXbn6sD5PYwMSW
         2QiCsGRFiCKAP3iaDo7gmf1+1bN3vhn9BPFkROD+laaz+nPyltaD3cDBhAbfrm0spB7Z
         bwKxuCE9boCqnhmqHhPQ4MyVzhUCkLoPeCKRbIba2oTAUI0ToIs39vvXjNMSbdHb3rP4
         6PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DhU36xf+kkHEB9Z3O8FzZRfYoFwRwILvA55dsayFWs8=;
        b=ft/JeFy9AzNR+Dtqp4oobVgj4tKog/3AH3eDu7Zn/C+Lwsbd6fT+Q2K2dacLmm8uAW
         0ftV4dDUd3sSpU7QwoShGWi+iuv3HisINv6TtwVqQ7LExZ3sJl2BtFwWlwAQN6zCGlV5
         WzuQDGyxpssou0YQqRTIUw8Ov1H5udDLY4wiiLXRtVcX3Opo9oPK+d55Cfmh7JaYqHD2
         xoR69xAgrT34NSgJroqo9FBFta4Wf1YetdW7Pj4tA+UrB+nI7CLYHPqjpbvR4Dw2/2DF
         0tAwjYRxtd3bbLaxKMRX1fCqtzQwlD13Y9hPDHgOkJ8iJUE/8iKGVItcv+IG+eS5upds
         IchA==
X-Gm-Message-State: ACrzQf23iTCrK2um+o8ISmTpP8StgHjpbVTgq5yYnIi5FS/6NJGukx86
        aXa2CEKJNTDKvFPTXMwkaghi6g==
X-Google-Smtp-Source: AMsMyM6Cgpbl2F9f16R5noJsi+2UR6Jgk4PA7Ag+UQOv1ct+XWi4TWMoVvX8yvs6ZaX+q3DNo8e0LQ==
X-Received: by 2002:a05:651c:10a7:b0:26c:5d3e:d040 with SMTP id k7-20020a05651c10a700b0026c5d3ed040mr900959ljn.182.1663687505132;
        Tue, 20 Sep 2022 08:25:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b0026c453c51b7sm7459ljo.68.2022.09.20.08.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:25:04 -0700 (PDT)
Message-ID: <65c93c5d-941a-267b-408d-95be83dc2454@linaro.org>
Date:   Tue, 20 Sep 2022 17:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220920140145.19973-1-jason-jh.lin@mediatek.com>
 <20220920140145.19973-2-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920140145.19973-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 16:01, Jason-JH.Lin wrote:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..df9184b6772c 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -38,6 +38,10 @@ properties:
>            - const: mediatek,mt7623-mmsys
>            - const: mediatek,mt2701-mmsys
>            - const: syscon
> +      - items:
> +          - const: mediatek,mt8195-vdosys0
> +          - const: mediatek,mt8195-mmsys
> +          - const: syscon

and why mediatek,mt8195-mmsys is kept as non-deprecated?

Best regards,
Krzysztof
