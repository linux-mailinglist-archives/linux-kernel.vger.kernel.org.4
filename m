Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEF6443D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiLFNCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiLFNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:01:57 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80650D2E3;
        Tue,  6 Dec 2022 05:01:40 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id a7-20020a056830008700b0066c82848060so9199336oto.4;
        Tue, 06 Dec 2022 05:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Hbffxdj76xYFdF4l0QY3Nbhb00ty2h6F92vl5ePeM=;
        b=6kAyYs1M2ThjzIkzDnoEyHEa38QderaRNDg/PbER3jZ9GFwE9+4drloPukSGJgX0sN
         +WjfTsm42efZ2Ar5eJnjuDj5dNz8nPadSMDqI/M8vd5fK6QQFUA5RqSlaUfZ++e7Qm2w
         JJ4KmKnrCHwdVD0WL8TgfD1+PtYOJn0yv9mdg6ImUrGohwGn7+Rr+mbMpfw7jFz8zrFg
         afscIx/iDljDbJdQKIfE3bWOfE6kWYcNJqsm4gh3PeFx2vBtOVn+9wXqemUejp+bZMH/
         ZxOiXJKUJ+SN2FTzYLVpNxkvzehgWjevbrDF8yCd6+BuC77s2HKarEKakyeZ5HZeMWH/
         IBJQ==
X-Gm-Message-State: ANoB5pnxSqk7QbHDymHL5MWhwJRCS+b9GI7Zk46Mofo4HsSOkBAljhTh
        mlj5Yf4UwoHHyY3xO5iPEL3gdOss6w==
X-Google-Smtp-Source: AA0mqf4k5ByXOavEm8wTJJndBCnqCb7kXMspArChR3P/1CC6EiJONndeKfl7Me39LQ6wRjgZBQUqlg==
X-Received: by 2002:a05:6830:110e:b0:661:c5ac:7324 with SMTP id w14-20020a056830110e00b00661c5ac7324mr44543682otq.179.1670331699671;
        Tue, 06 Dec 2022 05:01:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g33-20020a9d2da4000000b00661af2f9a1asm9201988otb.49.2022.12.06.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:01:38 -0800 (PST)
Received: (nullmailer pid 224048 invoked by uid 1000);
        Tue, 06 Dec 2022 13:01:37 -0000
Date:   Tue, 6 Dec 2022 07:01:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joe Tessler <jrt@google.com>, linux-media@vger.kernel.org,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        linux-amlogic@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeff Chase <jnchase@google.com>, linux-tegra@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/9] media: dt-bindings: amlogic,meson-gx-ao-cec: move
 to cec subfolder
Message-ID: <167033169684.223985.8563268980146610337.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-2-krzysztof.kozlowski@linaro.org>
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


On Mon, 05 Dec 2022 16:18:37 +0100, Krzysztof Kozlowski wrote:
> Move amlogic,meson-gx-ao-cec.yaml bindings to cec subfolder and drop
> unneeded quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/media/{ => cec}/amlogic,meson-gx-ao-cec.yaml     | 4 ++--
>  MAINTAINERS                                                   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/media/{ => cec}/amlogic,meson-gx-ao-cec.yaml (93%)
> 

Acked-by: Rob Herring <robh@kernel.org>
