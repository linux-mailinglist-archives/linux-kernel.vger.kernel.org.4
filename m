Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAE68E204
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjBGUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBGUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:39:55 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D793CE39;
        Tue,  7 Feb 2023 12:39:53 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso4607804otl.11;
        Tue, 07 Feb 2023 12:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+MMAdZlfw/9O4oUybbbQ4cVQfeOgnkULR9gIWh8BDo=;
        b=f24Qm1NClOVqveEkCJSlOiYgvcNRW3tdpA5Rs9HSBJA3Siu1AJZWPG46g0EqjiyY7w
         NwTswCLR0j7Spv9cGthu03jV2YBYFn3mp0IE4QgInPLua6bSQZS8sefiMt0I06V9eicq
         oWIm8hvgd97L3SSWpZgpNvJekTMaHnLGwFqkraGEAyyvcR4XnTl0kk8KBdTv0O+N0tVI
         YHLh9otndB9Lklxkyz6cqU974idgoSnr0+Vc5FdtKayF5SJXc/pE5pl5pjcVy3pxA20K
         4woMy1EahXKUKUV2YsQSBcJVQEu8Tl5FQ0qvDyfMIYqzrw7/6bnTcSZ7VTNIxnr29xBb
         OnMg==
X-Gm-Message-State: AO0yUKXURid3PxJaojXiNRX3P/JHniGw1q9pFjUFreDYoBPQRcqzcNWl
        wF8yzVhlzfPbmmYwBdfu+w==
X-Google-Smtp-Source: AK7set+Xb8y1929C/3ir/6OF+cXnTSlLAjlNzMxZ14b7jdJhUthzb5BwWTe/EnSQGuz0NzYLhHXWMA==
X-Received: by 2002:a9d:4681:0:b0:68a:ed8b:caf3 with SMTP id z1-20020a9d4681000000b0068aed8bcaf3mr2591459ote.33.1675802393043;
        Tue, 07 Feb 2023 12:39:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cp23-20020a056830661700b0068bdd78f763sm7083449otb.29.2023.02.07.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:39:52 -0800 (PST)
Received: (nullmailer pid 4117410 invoked by uid 1000);
        Tue, 07 Feb 2023 20:39:51 -0000
Date:   Tue, 7 Feb 2023 14:39:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-mediatek@lists.infradead.org,
        rex-bc.chen@mediatek.com, mturquette@baylibre.com,
        edward-jw.yang@mediatek.com, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, johnson.wang@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        kernel@collabora.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v3 3/7] dt-bindings: clock: mediatek,mt8186-fhctl:
 Support MT6795, MT8173/92/95
Message-ID: <167580232739.4115577.9212468332187095949.robh@kernel.org>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
 <20230206100105.861720-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206100105.861720-4-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 11:01:01 +0100, AngeloGioacchino Del Regno wrote:
> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
> compatibles for them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



