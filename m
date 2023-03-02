Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677196A83DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCBNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCBNxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:53:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFB136E9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:53:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u9so18401957edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677765225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZof/087BHj/A7Di0Gk0ZvGDmMzbyQKiyv3HZhGN3xw=;
        b=eIrtPDV/cG8h0VLLmJcXXTWUO8Jg3Qo6HxP4dQkg9P3u0Fn6CodkeQxrfuFSWYlIoj
         tfIZfDFPjIHCEBAJzzbDOFKm9caoaq/ph9xh8bmKh8AyGlpjlFEvOV4rXrtiIVXTIrBR
         23vID2oLuqovDF5EzpYqFN2O8vmNHGs8LJ7+7O0SiDuLFKL1Z13H4GCKPiglMKmMxeT2
         l2qcAWfjunTGjvlsMDG+mzt5qlHNipEcD9etIEHdgO3jpbgPMjeOtDMzFsCabgzjWJXa
         ABCSsGkpWfAjylMv7OyQ3r2TBByagPRD7uKsOEQQ+FMjkDfpcTP/qXCroIW86e/r98Cq
         E4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677765225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZof/087BHj/A7Di0Gk0ZvGDmMzbyQKiyv3HZhGN3xw=;
        b=z2fBXXif+9gr47h1kBo1x8s/rrSbcrvpFWzAb+KYhmqxn/Hjd15GtS63Qu3z7J/ZFA
         xzKGapEYvXRszmrq6Jh8s50c4uH2bk6VYLjip4Q4vAbBB60KBcPZK2FM2vpsiNDgYNE2
         lZQ/VKe7le8lwpFZRlgeRxPgoEJurXXt7mtitJrcH9HTdDplGSDWTAWM+iXev0U6sO2Y
         +8YAt28j8SkP/Fw0b/pPTHEwmSQjUs73MM0BSWXxwu1MhpbjFrPJG6ZAV9N8vH6DmtLK
         BxQD5xoPjgQj8ii5tN+0sJdJboTqiH54oR0iBC6mwzzSyYtxH1S6V8OfPIC/dQKscMSw
         wYhw==
X-Gm-Message-State: AO0yUKWPGg3zw2UIXZwaUGqDgOtS97nJTsKMdVFoRpBuJtivLiASAJqM
        YIwCgDmwAa9Bc7uFoueqV121lg==
X-Google-Smtp-Source: AK7set8qp/TQ+HJrn0Ii4dY4rTO5h8nKaJSn7kxrv2Kr+qtuoSVN+2tgswoIzGGoQ+TvT/Nh/UeqMA==
X-Received: by 2002:a17:906:dc90:b0:888:5d34:dc79 with SMTP id cs16-20020a170906dc9000b008885d34dc79mr14548417ejc.40.1677765225322;
        Thu, 02 Mar 2023 05:53:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z2-20020a5096c2000000b004bfc59042e5sm962328eda.61.2023.03.02.05.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 05:53:41 -0800 (PST)
Message-ID: <33edb557-f5c6-6ce1-2914-bcab2eca23c3@linaro.org>
Date:   Thu, 2 Mar 2023 14:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: display: mediatek: Compatible list cleanup
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230302133528.124113-1-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302133528.124113-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 14:35, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Several DT bindings of MediaTek display blocks make unnecessary use of
> "oneOf" and "items", and have some enums with only 1 element. Remove
> unnecessary "oneOf" and "items", and replace enums that have 1 element
> with "const".	
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/display/mediatek/mediatek,aal.yaml  |  3 +--
>  .../display/mediatek/mediatek,ccorr.yaml         | 10 ++++------
>  .../display/mediatek/mediatek,color.yaml         | 10 ++++------
>  .../display/mediatek/mediatek,dither.yaml        |  3 +--
>  .../bindings/display/mediatek/mediatek,dsc.yaml  |  4 +---
>  .../display/mediatek/mediatek,gamma.yaml         |  7 +++----
>  .../display/mediatek/mediatek,merge.yaml         |  8 +++-----
>  .../bindings/display/mediatek/mediatek,od.yaml   |  8 +++-----
>  .../display/mediatek/mediatek,ovl-2l.yaml        | 10 ++++------
>  .../bindings/display/mediatek/mediatek,ovl.yaml  | 16 ++++++----------
>  .../display/mediatek/mediatek,postmask.yaml      |  3 +--
>  .../bindings/display/mediatek/mediatek,rdma.yaml | 13 +++++--------
>  .../display/mediatek/mediatek,split.yaml         |  4 +---
>  .../bindings/display/mediatek/mediatek,ufoe.yaml |  4 +---
>  .../bindings/display/mediatek/mediatek,wdma.yaml |  4 +---
>  15 files changed, 39 insertions(+), 68 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 92741486c24d..d8d78abd6c6c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -25,8 +25,7 @@ properties:
>            - mediatek,mt8173-disp-aal
>            - mediatek,mt8183-disp-aal
>        - items:
> -          - enum:
> -              - mediatek,mt2712-disp-aal
> +          - const: mediatek,mt2712-disp-aal

This was I think intentional - it will grow. The same in all other
one-enum cases, it might be unnecessary change which soon will be
reverted converting back to enum.

>            - const: mediatek,mt8173-disp-aal
>        - items:
>            - enum:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index b04820c95b22..e72d2884bb49 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -21,18 +21,16 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> -      - items:
> -          - const: mediatek,mt8183-disp-ccorr
> -      - items:
> -          - const: mediatek,mt8192-disp-ccorr
> +      - enum:
> +          - mediatek,mt8183-disp-ccorr
> +          - mediatek,mt8192-disp-ccorr

Such changes are fine.



Best regards,
Krzysztof

