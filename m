Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FB616401
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBNps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:45:45 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814AF28729;
        Wed,  2 Nov 2022 06:45:43 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v81so10554314oie.5;
        Wed, 02 Nov 2022 06:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bAqvSJEZ+guwj+qloaOt8zYLbUkpNm/7tiGBTvyTWc=;
        b=mBsqzAH2Ew/EGSfz1FoyUc6WP0Grai43wzyEdkmPNdCLNK26kSJ9/BFpFi5wJxQV4s
         EY9hZ/GaW+q93PNRd3Ej/yUDcOGYyeYEdhoGhtGN6OuP9AXn/kH6O7AgfLdYsd6kkLkD
         AN5nyMAzppnIMKLW5BAZH45aglaKFd5R14WT4HJuTD6K5O4X22aztiu7P1KrJhhE9zFG
         jYFLv0DSEkqE+kWmupwvzjyR9SJHMihOWxd0yxOwCVaVyhWQ2QyjvcSfDtQVt79PasSG
         SSOUg6ts5wKhoNzCuzbITsPG1ewZ/55NRiyd2wn1ZSuA7HbYGQI8H1pfPAUuXS9tXmuG
         VJYg==
X-Gm-Message-State: ACrzQf1GO6m11MDrMeTG22T6yvqBvoJDYE7OqUrOZO3BH7xZgssguQhi
        uIeWsSIGkabEBl2YuQoOUg==
X-Google-Smtp-Source: AMsMyM5AcUQiotU2fWCryazKaslO18NGjgudyyG/DGMJmnEewQHVnEqMMgovTr2TkuUjq67AqL/+Tg==
X-Received: by 2002:a54:438f:0:b0:359:f40e:582 with SMTP id u15-20020a54438f000000b00359f40e0582mr11302800oiv.237.1667396742754;
        Wed, 02 Nov 2022 06:45:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b11-20020a056870390b00b0013cd709659dsm5100071oap.52.2022.11.02.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:45:42 -0700 (PDT)
Received: (nullmailer pid 3701804 invoked by uid 1000);
        Wed, 02 Nov 2022 13:45:44 -0000
Date:   Wed, 2 Nov 2022 08:45:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
Message-ID: <166739671999.3701102.17178567473930656481.robh@kernel.org>
References: <20221102085800.28910-1-zhuyinbo@loongson.cn>
 <20221102085800.28910-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102085800.28910-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 16:58:00 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../pinctrl/loongson,ls2k-pinctrl.yaml        | 125 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

