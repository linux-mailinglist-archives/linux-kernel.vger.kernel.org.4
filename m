Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D245F12C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiI3TgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiI3Tfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:35:41 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B917E00;
        Fri, 30 Sep 2022 12:34:47 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-131886d366cso6559901fac.10;
        Fri, 30 Sep 2022 12:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AkkQdaDNOYZMSLUtzMLUyqsxir9M4nKI8xzeqoUNUqg=;
        b=26dcBt7HyxsmUjpUduSVK1yi1IfQnd4pkNbCJxU1tlFcMHv0d9luCinesPUwqlit9k
         10TNiToOTtomezPIqlWUA1l6NmaEeOTzEDPIyEmGedUn5TQV2T6qv9NVDJX/noH6sGBT
         dM9WBVcGDviNn0XljVsQ3pOWSEPqgxfCZVDYp4PRj+oBRgxfHh/m3TXo8uve/Mz92rbi
         KpaqwUlU1P0uP+8dzNDMMmEh2GiDNToA700P3ArIsNsJ65wQmHLHbz+2r0od00WilhpG
         b7kMOdW2hWBWoxPlV8XiNLXpTcs9WAhI4e3+k2X3EC1+O9YdpYiQTnuq5no22aWWTKM2
         q1VA==
X-Gm-Message-State: ACrzQf3o9L49nEQttGHw/3fy7Y3nQXZF0ZWH4j4XByMII/dODbbzP3LH
        FyNpcJrc1kZhTPr/rP2bEA==
X-Google-Smtp-Source: AMsMyM5Veku3oHrh2CrG3IifJOQGymTa3zsIQ8rtoCCekJEK7OtgxQ9USLdqDC3TTRMYEL41zH8kMA==
X-Received: by 2002:a05:6870:ecaa:b0:131:e816:b6a5 with SMTP id eo42-20020a056870ecaa00b00131e816b6a5mr3355975oab.229.1664566485639;
        Fri, 30 Sep 2022 12:34:45 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870738900b000f5e89a9c60sm939654oam.3.2022.09.30.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:34:45 -0700 (PDT)
Received: (nullmailer pid 754872 invoked by uid 1000);
        Fri, 30 Sep 2022 19:34:44 -0000
Date:   Fri, 30 Sep 2022 14:34:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: timer: mediatek: Convert to json-schema
Message-ID: <166456648367.754820.4078509083909702972.robh@kernel.org>
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
 <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
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

On Thu, 29 Sep 2022 14:29:01 +0200, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek SoC timer txt binding to json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
>  .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
