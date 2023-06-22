Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2277394CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFVBm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:42:28 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACA129;
        Wed, 21 Jun 2023 18:42:26 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77e2df49a91so217076139f.2;
        Wed, 21 Jun 2023 18:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398145; x=1689990145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYwve6hqLcxhq723ERB1a1o5pJtdB4TzWL3ZG3uBOdk=;
        b=ld6UhAKO1Z9voPqSqiqPV1f+4narHPmNhBwa1lRt5kITAuAsoTvHATUTMzjPkjDnJp
         RqupTrXLO12pg2Unfv3vBqk2GwKFqB5JWfD4xsvFPrnXwghdccRoBR9p5+DVhElPi6RC
         XUE+q8/PLxfLKxCLcg0JbvBvJ1Nn44RdaGNKzuePv8C5I0CpFKFWPTBH4BGA2YZCNRU+
         INfbFbjgqCX7yU+aEpjUEkOAgfewUTkmSoUUcyDZpmJvs7JeulGESvo2rnLd+Nw/jeWe
         cCrPak9XSjqfNT2Fr9bMTdpktD3EBleVCr3aeb+fxjR3mqNl2Nx1DH7E2//f4ngjat33
         pvKQ==
X-Gm-Message-State: AC+VfDxcCEDIlmeaam8ZwrnnX3D6oykOWooA29v9zv8R1cOACmGPfvcc
        tuMU4EYpNpGY5R79EGdtWw==
X-Google-Smtp-Source: ACHHUZ5A5nXob6MqVQ1dpKVvOe1QBpovcfDXr5TldZBrmszKyL8555YE5803sFOTnKwkojHRXI+gJQ==
X-Received: by 2002:a5d:9f1a:0:b0:780:bfc8:ad10 with SMTP id q26-20020a5d9f1a000000b00780bfc8ad10mr2154423iot.1.1687398145175;
        Wed, 21 Jun 2023 18:42:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 16-20020a5ea510000000b0077e3943aeb3sm1746545iog.54.2023.06.21.18.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:42:24 -0700 (PDT)
Received: (nullmailer pid 28560 invoked by uid 1000);
        Thu, 22 Jun 2023 01:42:21 -0000
Date:   Wed, 21 Jun 2023 19:42:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, Singo Chang <singo.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: reset: mt8188: Add VDOSYS0 reset
 control bits
Message-ID: <168739814113.28500.13763614675316462646.robh@kernel.org>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-7-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614073125.17958-7-shawn.sung@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 15:31:16 +0800, Hsiao Chien Sung wrote:
> Add MT8188 VDOSYS0 reset control bits.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8188-resets.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

