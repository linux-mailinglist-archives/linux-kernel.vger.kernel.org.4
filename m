Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91D45F6EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiJFULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:11:30 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B195C6978;
        Thu,  6 Oct 2022 13:11:29 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3493396fac.1;
        Thu, 06 Oct 2022 13:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNSqlgSKGtUFTFR78Kr37qdXCj0wDv0um9PT07unkQM=;
        b=UPebpCDWSgwDaQwVOlG6BBsEXCQsjq213cg5hn191+CP+NvhjMcPe4E8MUouGFfKMO
         lLIwDH//9upYas2eDnLBHuJP0EaCxvwLzPBif72YjMKER+lxl47wYzvT0V/mcQsWMj/J
         LOi4EVOkWGdHUQiHYQMb24Xif9/N5pevmpINM5UewTsSqlpMQuuK8GuJMc2TP523Rq2y
         N1isB/UKjxy+PvTnRDc8WEcpmMy0mzJiF1gqFOBY7uj0y1K32nqXSCnL1okwZcPNV9ea
         I18z9NF//J3TxKrC4jBq06INQI+aoWaS5md0pXB34NoGPh+HtAfCPa7OrfgxUug/EIvs
         6HAA==
X-Gm-Message-State: ACrzQf0FBXdKvkzeP0FJ6Ybsmo5qFXNCG3Zkba8dHlKlhmV3218x8vht
        HpuqcWdQ+TuO0qfI5aDnQiq3SvoqyQ==
X-Google-Smtp-Source: AMsMyM46fj19/QYMi6Z4y1YQn+olg8t5MJzGfn9ZPfJCaPFaGfEP9xbFVt7S9jLwI8IQ9n3BxHsjXg==
X-Received: by 2002:a05:6870:d204:b0:132:7810:d2a8 with SMTP id g4-20020a056870d20400b001327810d2a8mr836970oac.26.1665087088861;
        Thu, 06 Oct 2022 13:11:28 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id i14-20020a056870c1ce00b0013255d14610sm320225oad.16.2022.10.06.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:11:28 -0700 (PDT)
Received: (nullmailer pid 92463 invoked by uid 1000);
        Thu, 06 Oct 2022 20:11:26 -0000
Date:   Thu, 6 Oct 2022 15:11:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, nfraprado@collabora.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Message-ID: <166508708200.92361.1398358660025530702.robh@kernel.org>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-6-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006120715.24815-6-allen-kh.cheng@mediatek.com>
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

On Thu, 06 Oct 2022 20:07:12 +0800, Allen-KH Cheng wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Convert the MediaTek watchdog bindings to schema.
> 
> The original binding only had 4 without a fallback but there is a reset
> controller on the "mediatek,mt7986-wdt", "mediatek,mt8186-wdt" and
> "mediatek,mt8195-wdt". Since there is no reset controller for the mt6589,
> we remove "mediatek,mt6589-wdt" as a fallback.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 78 +++++++++++++++++++
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>  2 files changed, 78 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
