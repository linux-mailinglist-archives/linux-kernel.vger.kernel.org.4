Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA642654729
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLVUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLVUc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:32:27 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD7101CE;
        Thu, 22 Dec 2022 12:32:26 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-14449b7814bso3830445fac.3;
        Thu, 22 Dec 2022 12:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKo5x56fWEtHMHUJX8UIjgCshUFHEZto8Kui+GBxvYQ=;
        b=v1QSFckPta7Ht44+rhWlypEtxrmLpB+NeFAFSUh7NAteUHQvekEjR9dQYkc6kkvFFy
         7F7Liv5dUI1Vy+Cycw+ldrat1B9zmiloDMcV7ySvGv5Qv7x8b7SyBCYretp+jm2+aY5w
         vrvQwtffAc3kfrOx6UjRJ5dbK6axlDQiC/0UiWoyZvizls6kbxaAUzapwG08V/wqkdo3
         Jj31XymFzixg+ymySh3oynVH5HiDiWL7OT4L699De2HeDlkyEsBxKtVS2749q353HDh4
         cvZRWizBvFN/XJpvNGBWOK93RJaxshY/Yb9U+qByP/U/1HtoMmxrt0qk5vHcrkyUrTsD
         ZFcQ==
X-Gm-Message-State: AFqh2krKf0esRGYgR5fyOJRlqi2a7cCMbyczPPO4FtpaEQ0CIOcbzewm
        /H3AiNLxb94Y/cVE0Dwx5Q==
X-Google-Smtp-Source: AMrXdXsAQG+TQ1J9PaH2VrGeouezowxbWsEDBr58x+MvvBVdVq1BeKeiqTbSzSgb9jKcEk9x4SRB1Q==
X-Received: by 2002:a05:6870:4d16:b0:144:a626:218b with SMTP id pn22-20020a0568704d1600b00144a626218bmr2904414oab.56.1671741145508;
        Thu, 22 Dec 2022 12:32:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp15-20020a056870658f00b0013ae39d0575sm695769oab.15.2022.12.22.12.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:32:25 -0800 (PST)
Received: (nullmailer pid 2072929 invoked by uid 1000);
        Thu, 22 Dec 2022 20:32:24 -0000
Date:   Thu, 22 Dec 2022 14:32:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jose.exposito89@gmail.com, edward-jw.yang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        chun-jie.chen@mediatek.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        rex-bc.chen@mediatek.com, linux-kernel@vger.kernel.org,
        johnson.wang@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v1 2/6] dt-bindings: clock: mediatek,mt8186-fhctl:
 Support MT6795, MT8173/92/95
Message-ID: <167174113268.2072682.12279599468554479055.robh@kernel.org>
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
 <20221222155147.158837-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222155147.158837-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 16:51:43 +0100, AngeloGioacchino Del Regno wrote:
> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
> compatibles for them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
