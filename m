Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD83D5F780D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJGMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:39:52 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBB205F3;
        Fri,  7 Oct 2022 05:39:51 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id p186so3497674iof.5;
        Fri, 07 Oct 2022 05:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiHvebRQ8izw3xHUBaApA8sZABOqhO5201jaVL8EbC4=;
        b=ZIBLdDFnYRWP5yFZ3qrfDx4vaP7M+hmnhIebdC/5URdOgKvQKPUehkIXLA9dYIfR3q
         EsHiIEfH2j9ssea0XM0TWUXEXb+aBSucMU7ur4jNH363O9MvxHBDhPZHpEn5Q/GLmMke
         dC0Ne2RFj8JrJmYJQ4iM6hs4MnV8arpUXzURH4srchJxkUjs61fHhbnqLB0gGc3gEm3R
         Epc8apzASTsrd4DhAbTMP/dwWLsWVvo/nx3hlj+omzjToABjHe/T7BEX5dou1qQC2xoQ
         d9Prb1SYXOCL2ex0HrnHrCoiVkvT9lp78NzxKy6fiYDt0PRd/noANyd4uEZlcD0EjKUx
         ZSIQ==
X-Gm-Message-State: ACrzQf3KWIy5vnpq1tSQ4ev4Y8Se4R2x+MYhSH/e5KOWhgcplSW59M44
        t0er4GxxMmXtzy9cOhBMCr5nTvI9xw==
X-Google-Smtp-Source: AMsMyM7V4GSAphi5v5xSoxERaOtipv6nPn7H4JgbZqoQqJGSLh/AiFmmMT/+ytBZCxwFLhO6OyuvoA==
X-Received: by 2002:a05:6638:1655:b0:35a:6ee2:402d with SMTP id a21-20020a056638165500b0035a6ee2402dmr2446416jat.138.1665146390434;
        Fri, 07 Oct 2022 05:39:50 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:17de:d2e8:8e7a:471f:1892:c117])
        by smtp.gmail.com with ESMTPSA id y7-20020a92c747000000b002f8d114ca84sm890521ilp.17.2022.10.07.05.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:39:49 -0700 (PDT)
Received: (nullmailer pid 22073 invoked by uid 1000);
        Fri, 07 Oct 2022 12:39:47 -0000
Date:   Fri, 7 Oct 2022 07:39:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Message-ID: <166514637708.21847.15986899611169493380.robh@kernel.org>
References: <20221007093437.12228-1-allen-kh.cheng@mediatek.com>
 <20221007093437.12228-6-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007093437.12228-6-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022 17:34:34 +0800, Allen-KH Cheng wrote:
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
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 77 +++++++++++++++++++
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>  2 files changed, 77 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
