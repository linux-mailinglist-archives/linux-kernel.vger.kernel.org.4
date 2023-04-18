Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05386E6DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDRUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDRUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:54:01 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A47EE3;
        Tue, 18 Apr 2023 13:53:28 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id bg38-20020a056820082600b005421db6ed5bso2644561oob.12;
        Tue, 18 Apr 2023 13:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851200; x=1684443200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7OwgyFYxvUdy54LeDh4J8bkZyrATaQx+kfaOB/n8Aw=;
        b=FK63sBy4zdasy/Ps2y+60WEZfHnIIzEURceGffBNME8hFq1HCEK9eAn7e3qqUS+K0M
         5PDbgXQTw9BtVoUFC40j8gTaZmVNv4XmeZmjP6Fo6nle6/soqXfggDQsCzZzxNz69ej1
         zwDbKFEBaNCbmkk6fEr00gJbxAhB/ZRUf0zIyLYZsiqYPKfG+1sOGApBZCZZE0uSt3Oa
         a2THQUHvydYPzRUs9GBtkw2fBg00xRy95phSnzMUpExC4tyeR63McWKimvnlCDi8MjBb
         Q0a4uy3/XKGy0axAqAf318X/t/zh04CNDkzGstD3dXJr5FOuZ1+rM+NPlOo2g72KdflW
         bi1g==
X-Gm-Message-State: AAQBX9ckjTCfrlQb3tZYM40IBaj8/d4Y8pCSgHXoKYM7GfeI7s6z5R8J
        2PrYFqKtDnNtOs5TfFBgYA==
X-Google-Smtp-Source: AKy350b/EDQ8ntn392NFJwpfJRHYL6UKPciQC7U7cGvat7A1qfFG6PLLKiTz+v/L8nLz3JGXjYYDtw==
X-Received: by 2002:a4a:410a:0:b0:542:59fb:949e with SMTP id x10-20020a4a410a000000b0054259fb949emr6393003ooa.2.1681851200085;
        Tue, 18 Apr 2023 13:53:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m21-20020a056870a41500b0017b21991355sm6045739oal.20.2023.04.18.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:53:19 -0700 (PDT)
Received: (nullmailer pid 2322029 invoked by uid 1000);
        Tue, 18 Apr 2023 20:53:18 -0000
Date:   Tue, 18 Apr 2023 15:53:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: simplify compatibles
 syntax
Message-ID: <168185119638.2321910.8021835045798003240.robh@kernel.org>
References: <20230414083311.12197-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414083311.12197-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2023 10:33:11 +0200, Krzysztof Kozlowski wrote:
> Lists (items) with one item should be just enum because it is shorter,
> simpler and does not confuse, if one wants to add new entry with a
> fallback.  Convert all of them to enums.  OTOH, leave unused "oneOf"
> entries in anticipation of further growth of the entire binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: angelogioacchino.delregno@collabora.com
> ---
>  .../bindings/display/mediatek/mediatek,ccorr.yaml   |  7 +++----
>  .../bindings/display/mediatek/mediatek,color.yaml   | 10 ++++------
>  .../bindings/display/mediatek/mediatek,dither.yaml  |  4 ++--
>  .../bindings/display/mediatek/mediatek,dsc.yaml     |  4 ++--
>  .../bindings/display/mediatek/mediatek,gamma.yaml   |  7 +++----
>  .../bindings/display/mediatek/mediatek,merge.yaml   |  7 +++----
>  .../bindings/display/mediatek/mediatek,od.yaml      |  7 +++----
>  .../bindings/display/mediatek/mediatek,ovl-2l.yaml  |  7 +++----
>  .../bindings/display/mediatek/mediatek,ovl.yaml     | 13 +++++--------
>  .../display/mediatek/mediatek,postmask.yaml         |  4 ++--
>  .../bindings/display/mediatek/mediatek,rdma.yaml    | 13 +++++--------
>  .../bindings/display/mediatek/mediatek,split.yaml   |  4 ++--
>  .../bindings/display/mediatek/mediatek,ufoe.yaml    |  4 ++--
>  .../bindings/display/mediatek/mediatek,wdma.yaml    |  4 ++--
>  14 files changed, 41 insertions(+), 54 deletions(-)
> 

Applied, thanks!

