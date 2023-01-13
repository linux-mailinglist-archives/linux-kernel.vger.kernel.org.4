Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629066A2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAMTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAMTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:17:43 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F2765D;
        Fri, 13 Jan 2023 11:17:43 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id i5so217113oih.11;
        Fri, 13 Jan 2023 11:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4CJajujD5LCHqYKQc7DCfZ+S0748YjEApgV0a2xuDw=;
        b=W5v317U8G27FBDal8bjW2/NpybMg4c1KEukViquBLBUw6UBs77MIXcrBIX2388nHgN
         s6DmIp6fJOgcE4X3s/Ueu5s307oUyp6ynR5T0HPgXkQ7gF37Yt/NBEzupRTWxOo7g24k
         eoH2Jdrc9teoVxXKYZjGRePdY20s+Wrzg4Uypzg/3O0Lod8fdoxWT9r/OOk8iumyDhyZ
         TLKTv7rsUjl0bT3KUP7WgiCdtvB8Pr74DriFAw2toKqJ8ryg2UhSq9kQVA1ahCcjLr3O
         4k3fq3AAu0hQ9fS29A2qWs6Zcd1VmxlnPzydSSfVRkQjsHu2E1vBmT+t61hWdkMZsvO5
         AEYQ==
X-Gm-Message-State: AFqh2kpb93fIOmdmPZbxHDW24OP0gS8jslAYNFSVmoitKZeUimvyTD0a
        RB+3TXnSDQXrnsZgDTuV2g==
X-Google-Smtp-Source: AMrXdXumnqXHmHJ9OSjT0qtZ37tvwGUWU+z1M/2ahtBoZIkYl48Ps2exVXHLlOF9YRZTNrnHNwii8Q==
X-Received: by 2002:a05:6808:2744:b0:35a:33d:5651 with SMTP id eh4-20020a056808274400b0035a033d5651mr30880409oib.14.1673637462562;
        Fri, 13 Jan 2023 11:17:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020acad90a000000b00354932bae03sm9543137oig.10.2023.01.13.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:17:42 -0800 (PST)
Received: (nullmailer pid 2757784 invoked by uid 1000);
        Fri, 13 Jan 2023 19:17:41 -0000
Date:   Fri, 13 Jan 2023 13:17:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        hsinyi@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: spmi: spmi-mtk-pmif: Document
 mediatek,mt8195-spmi as fallback of mediatek,mt8186-spmi
Message-ID: <167363746062.2757569.16048285089924690318.robh@kernel.org>
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
 <20230111123711.32020-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123711.32020-3-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 20:37:04 +0800, Allen-KH Cheng wrote:
> The mt8186-spmi is used as compatible with mt8195-spmi on the MT8186,
> document this situation.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml   | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
