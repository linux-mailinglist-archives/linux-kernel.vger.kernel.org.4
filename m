Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A291B613FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJaV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:29:27 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BD101C8;
        Mon, 31 Oct 2022 14:29:26 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id c129so2302080oia.0;
        Mon, 31 Oct 2022 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeSIifTj6jENNWHhoSdY8aooxwuhS3bnKLvqLnQk6FM=;
        b=O83JXc6Q7pEhEROwz1F1BwmKMNJoTK8Z38y+/8iWnMZGE0jzAwo+2txea5EUM4iKFv
         6Z4F6/oMDKoYr7Qyoiy3OsIpUr4rREWIto8kWVyZLIEkhM4hYcSZcAoX9e5EVspdqaY8
         7t0YTOdow/WydNEZKasBpGMvRIWHCLuxYl5sxlsn649H29/hCIcL84osz+4vNmuX4IDb
         JXT/zMiSbwp6yNFmnZXh3qbLZM98KPsCLr9wsNDKzEkwEly43XaXJ6o7Ij8zMA3yf8D8
         zCCVhcrODvCgsYzU5I8S47oqowTAwRJYz1GGveY5kpAbHr9fXr4kIJ4ruGOg09JTNDmn
         WIgQ==
X-Gm-Message-State: ACrzQf2pKzL+5PHuBQZ21ysnXOXcHxFx8JDi5bR7oXF9OijXdfomcyfF
        XjCU3n6i0Xr3Fp3qCm8fJg==
X-Google-Smtp-Source: AMsMyM6qEAaLeVn+yiCeyAv+duU6sO1sRWSWr15BGUoIMpYIzx+CIJrKX3SETaVHnmAJegD3ilgQ4A==
X-Received: by 2002:a05:6808:2387:b0:355:2641:aff5 with SMTP id bp7-20020a056808238700b003552641aff5mr7687183oib.44.1667251765670;
        Mon, 31 Oct 2022 14:29:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx12-20020a0568081b0c00b003539686cb7bsm2733852oib.53.2022.10.31.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:29:25 -0700 (PDT)
Received: (nullmailer pid 3605416 invoked by uid 1000);
        Mon, 31 Oct 2022 21:29:27 -0000
Date:   Mon, 31 Oct 2022 16:29:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
Message-ID: <166725176639.3605360.416860963509021396.robh@kernel.org>
References: <20221029022130.19914-1-zhuyinbo@loongson.cn>
 <20221029022130.19914-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029022130.19914-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Oct 2022 10:21:30 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v5:
> 		1. Drop dependencies.
> 		2. Add spaces after '='.
> 		3. Replace string loongson2 with loongson-2 in title.
> 
>  .../pinctrl/loongson,ls2k-pinctrl.yaml        | 125 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
