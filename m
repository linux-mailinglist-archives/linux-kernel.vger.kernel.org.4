Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F616443FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiLFND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiLFNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:02:49 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF17CE2B;
        Tue,  6 Dec 2022 05:02:45 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id v62-20020a4a7c41000000b004a0a214dfbaso1323821ooc.9;
        Tue, 06 Dec 2022 05:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4xw/+ywJXT3DJB58fwNh/xTT90tKd1q3hEDbHNq8ZI=;
        b=ZYNwcuuiBQBAyKRSpHw5WACLm0NwvJGdaM3vOakaePBjAEbIiYyn5nzIZW0+dQB/iI
         b8m8EffYiIZFVo8/XvE24CJoSVwSSOmgve2Z0KLfznhciE1oXWIDl4FN88gw6fT1OuGu
         prTJhQ33R7RlFxJVKBw0hqqmiHqnN08NL2iL+9YeMS2udxuPWevxRl+iE5TVfwz8Bbft
         N5tmxs4zBTit63I9XPCfJEkZDh8TFjRM87ol5SQ0+myPeVAiNJKny/L1HmC76OmQAGBp
         YFUqE6zfwDJMAtimtnxrv43VqTECk2hFrGA9EltAMVrrFER8TH6F9SsbdIIazCn7WfWg
         i6Ng==
X-Gm-Message-State: ANoB5ploFweeSjP2DY3toJvADfY3CnZQJ89EqBMmRcESeer/9GrFPZ5T
        EQHuNloQsC53sJHfJfNC2Q==
X-Google-Smtp-Source: AA0mqf43zncrSVF/3luC/HIGUW+nK43yAhxSLf/Tk1XAQeHQa4RnY5NNOQwlENA38AbtEYq7O7vwjw==
X-Received: by 2002:a4a:ad49:0:b0:49b:c0e:3d5f with SMTP id s9-20020a4aad49000000b0049b0c0e3d5fmr36865349oon.69.1670331764762;
        Tue, 06 Dec 2022 05:02:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s11-20020a4ac10b000000b00499527def25sm1547158oop.47.2022.12.06.05.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:02:43 -0800 (PST)
Received: (nullmailer pid 225694 invoked by uid 1000);
        Tue, 06 Dec 2022 13:02:42 -0000
Date:   Tue, 6 Dec 2022 07:02:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-samsung-soc@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, Jeff Chase <jnchase@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Joe Tessler <jrt@google.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 3/9] media: dt-bindings: cec: convert common CEC
 properties to DT schema
Message-ID: <167033176212.225636.18251903992063817307.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 16:18:39 +0100, Krzysztof Kozlowski wrote:
> Convert common HDMI CEC adapter bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../devicetree/bindings/media/cec.txt         |  8 ------
>  .../bindings/media/cec/cec-common.yaml        | 28 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 29 insertions(+), 9 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cec.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cec/cec-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
