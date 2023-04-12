Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F846DF797
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDLNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDLNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:46:22 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142010DE;
        Wed, 12 Apr 2023 06:46:17 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-18782426c4bso624926fac.9;
        Wed, 12 Apr 2023 06:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307177; x=1683899177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9LJNXi7ThfER3Q1hIKQ2Q7ZDEK5eNuLphLK92f+qek=;
        b=h314+9TjN8iXFAG2xSugw92og+7SqLVq0GmU7Bim1foPPeCIVMJkTM2hJE/bMYCaib
         /S5ofYFXa7Ke8VdrrcMkKqU0yjtqUoIzw7aTLB6xqokhfXOPSXKl71YABBrjr4LFtvzL
         pL0LOA1B2dL+1+JoCeZjOVMdrhGauoekZNDAS0LiHtgeQQaQ5IWMCceMA6HXD7CF+mRF
         BKuzGPiYrJq6acZOuh1HusN8BhRPYgVVFDC1MfM4ocilivjGV1xBvTaHnmXezy/xoOsx
         KW07fNqbysafky9pxp1YEAXAsku7NmtrSQpr0FjlZgYk4t8s5V5DEbe79LgzPRQxM4Tn
         Qdiw==
X-Gm-Message-State: AAQBX9cEJMi4J0FbT47UHpO39AqWLrLyVUMFCMiuFVN9h9lXmWQ7b358
        8HcKhL+8a6vYNqrqeU6Ozw==
X-Google-Smtp-Source: AKy350bWdptJOMt5Rq/RspEgq7+COWs65y9hDkmpUsYoMkj/BLsWgSwRgWLmHLHU7QpMyjUQJT6+1g==
X-Received: by 2002:a05:6870:9593:b0:15f:e044:23b2 with SMTP id k19-20020a056870959300b0015fe04423b2mr1550794oao.7.1681307177033;
        Wed, 12 Apr 2023 06:46:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u4-20020a4a9e84000000b00524faf3d2d7sm6926840ook.41.2023.04.12.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:46:16 -0700 (PDT)
Received: (nullmailer pid 2217552 invoked by uid 1000);
        Wed, 12 Apr 2023 13:46:15 -0000
Date:   Wed, 12 Apr 2023 08:46:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     mturquette@baylibre.com, jian.hu@amlogic.com, khilman@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jbrunet@baylibre.com, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, sboyd@kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        rockosov@gmail.com, neil.armstrong@linaro.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v13 3/6] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <168130717511.2217492.4753998979663647449.robh@kernel.org>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-4-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405195927.13487-4-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 22:59:24 +0300, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 PLL clock driver, and A1 PLL
> clock controller bindings.
> Also include new A1 clock controller dt bindings to MAINTAINERS.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/clock/amlogic,a1-pll-clkc.h   | 20 +++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

