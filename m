Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E36443DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiLFNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiLFNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:02:09 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3012090;
        Tue,  6 Dec 2022 05:01:59 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id l8-20020a056830054800b006705fd35eceso216317otb.12;
        Tue, 06 Dec 2022 05:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxyzSpVUM6V4RTMjWwsFrePRYZPHGH5eY9Ph8J0tqOI=;
        b=ql7osWVXKtDNN1BuZ12bj/VFNLNsBPGbdHjxhdTJ6CNWztJTsBWO1nlCQ2vQ/ZgRUM
         ImjkXrIqmhNAmzL0Jta9CG5iGxfbimvixYrT7K8SUmd1PbnZP2brWFURAbFTc3DBK4vx
         k6NZhH8pcMTfx1zYlwlvlQZF/Wx8GGrRbP9oal1FVAcJi0J2hPAG3xU5x4u2qgrbka1J
         ST2kCHZ9aJ4YHGuwUksAieNM0QyfyxEUx/gx7+k8TrDDSQiGt8F1i8YPI2DRPTLiUQsi
         0W1qznB5U3PQbKYYMlLBE7uXppub8EOv7T9TCdIvRNq5AX72AUyf1svG1zc6O6Or1qmp
         TlTw==
X-Gm-Message-State: ANoB5plhVB7+WE86NaAI5tHHHH2MSv0F3FN4TifOUs1f51L7pobt/cUH
        tOWkRA2fSgM2MVuSp6b7uw==
X-Google-Smtp-Source: AA0mqf5JtrErllTMHorfM6i5uxzu4uWCVJfdLClwhU/c9p+zrauUfEIH4B6EJ8k4ODNVyVX99wU39Q==
X-Received: by 2002:a9d:6c10:0:b0:661:94ac:a555 with SMTP id f16-20020a9d6c10000000b0066194aca555mr31883302otq.291.1670331718884;
        Tue, 06 Dec 2022 05:01:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y35-20020a056870b02300b0013bc95650c8sm10618089oae.54.2022.12.06.05.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:01:58 -0800 (PST)
Received: (nullmailer pid 224573 invoked by uid 1000);
        Tue, 06 Dec 2022 13:01:57 -0000
Date:   Tue, 6 Dec 2022 07:01:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jeff Chase <jnchase@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/9] media: dt-bindings: st,stm32-cec: move to cec
 subfolder
Message-ID: <167033171648.224515.10474001869932196398.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-3-krzysztof.kozlowski@linaro.org>
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


On Mon, 05 Dec 2022 16:18:38 +0100, Krzysztof Kozlowski wrote:
> Move st,stm32-cec.yaml bindings to cec subfolder and drop unneeded
> "bindings" in the title.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/{ => cec}/st,stm32-cec.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/media/{ => cec}/st,stm32-cec.yaml (89%)
> 

Acked-by: Rob Herring <robh@kernel.org>
