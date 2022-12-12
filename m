Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C364A5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiLLRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLLRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:32:49 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B47DC9;
        Mon, 12 Dec 2022 09:32:47 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1322d768ba7so9248710fac.5;
        Mon, 12 Dec 2022 09:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c0Q/vD5iPPOpm9+SZu8G9CtEcI/+Ys6P4p1qjE2xVw=;
        b=NZCPXy3aOCthiuS0IxbdyQ5vLioRtXok3qceUecQtesFg824qoDLRLSjHu2tm2PFbG
         MFrSHhr35lqAiDFtZLQDh3pPIM+48PhwtsI0LrYkNRXr3WHVSl05G9DJFmcuhivI230F
         QPzu7KqBO4K4mLxCkxAHYbnfsPt9j1OX8MWS59MnuLcRQIg19PnypqlA/Ep61jBt72Oq
         FqM6qJn+YKT8vPO6fl/mgA4/3L2y9uTdPDRRJyS+61O0ol6/XrZ82WarZlp5nhVrZIzZ
         IryLnIf/U48z46Lz95R/hv/aNsIpRg/Upe/aF2AJuSxVWf/17hTY57407R5LUO4HPigu
         N2Pg==
X-Gm-Message-State: ANoB5pm/RRSyDfExQdu33ScNbdsNi+SZVnnLRmi22wblDLGKRBauvgyp
        Jmhx+AcTpYfK3OfQMCNXiw==
X-Google-Smtp-Source: AA0mqf5PsnRpjqPKGdBWGgDCZdAgNhbyqlTcPwwBpTvVw9k5vDQwoMoTIyNNqsRM0T5EzRgviQXaIQ==
X-Received: by 2002:a05:6870:7985:b0:143:ffca:a9de with SMTP id he5-20020a056870798500b00143ffcaa9demr7920858oab.9.1670866367008;
        Mon, 12 Dec 2022 09:32:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a22-20020a4ab796000000b004a0a7b08d9asm156388oop.19.2022.12.12.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:32:46 -0800 (PST)
Received: (nullmailer pid 1173504 invoked by uid 1000);
        Mon, 12 Dec 2022 17:32:45 -0000
Date:   Mon, 12 Dec 2022 11:32:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: microchip: use proper naming
 syntax
Message-ID: <20221212173245.GA1171311-robh@kernel.org>
References: <20221212164153.78677-1-claudiu.beznea@microchip.com>
 <20221212164153.78677-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212164153.78677-2-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:41:50PM +0200, Claudiu Beznea wrote:
> Use the following syntax for Microchip ASoC YAML files:
> vendor,device.yaml
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ------------------

Deleting? Why? That's not what the commit message says.

>  ...,pdmc.yaml => microchip,sama7g5-pdmc.yaml} |   0
>  ...rx.yaml => microchip,sama7g5-spdifrx.yaml} |   0
>  ...tx.yaml => microchip,sama7g5-spdiftx.yaml} |   0
>  4 files changed, 108 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
>  rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (100%)
>  rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (100%)
>  rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (100%)

These will all fail binding checks. You need to update the $id values.

Rob
