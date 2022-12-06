Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC21644407
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiLFNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiLFNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:04:49 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739F2CCA0;
        Tue,  6 Dec 2022 05:03:26 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id q186so16796742oia.9;
        Tue, 06 Dec 2022 05:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/rhl8A2LmGiFpiqJZUQMjFZh8zPPfjZ5d/GnnGY7hE=;
        b=c1nD+zCZMVprYOsBebWptwfqpFQipjmbwHCL6jX2w581fQXFQrzxFzLhkc0oejqzjC
         CpEqrBF8Ax0DyL8oUoi3kyC4idAWab494ZM11UuX18GG/czl1SnDx0gMe9qD6xJ5D9gV
         h6c6pLYC4YbjbmeQBt6OBWt2aBLzLRz1VtR7wfQYuXBIugCtqOjKzxjNXzSSMVOOxSOL
         wx9p1UIH6TPR+3xjCsu9h9Qu8IbhwGNnbzPN03KZek97qspkgUlSMegHEU4eXqcK3WO3
         Hq0o3ZcKG5r3EGv8GSa0Gx+A/b4Sc0OfaYHoHwxajTOx4JiXHNM/oupX5cn17ETJlrHx
         8Lug==
X-Gm-Message-State: ANoB5pmpbZxKdR1+AL/hwYFIOojopJTtIBlW5JUYjH8Is3HbgJpUrmSG
        bSycA6APxdZ9uh/KPYxTwA==
X-Google-Smtp-Source: AA0mqf7Ot/umK5fnMfyAlv+iZ1LRDQEusBhDifCXxjp48bJ1W4lhwy7s7Mz6V/1NxN8Ex6D5o4LGSA==
X-Received: by 2002:a05:6808:1452:b0:35a:812c:3eae with SMTP id x18-20020a056808145200b0035a812c3eaemr42973469oiv.218.1670331805265;
        Tue, 06 Dec 2022 05:03:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a05687105ca00b00143776f70d3sm10638605oan.29.2022.12.06.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:03:24 -0800 (PST)
Received: (nullmailer pid 226920 invoked by uid 1000);
        Tue, 06 Dec 2022 13:03:22 -0000
Date:   Tue, 6 Dec 2022 07:03:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jeff Chase <jnchase@google.com>, Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-tegra@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/9] media: dt-bindings: chrontel,ch7322: reference
 common CEC properties
Message-ID: <167033180245.226868.8088580036081648142.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 16:18:41 +0100, Krzysztof Kozlowski wrote:
> Reference common HDMI CEC adapter properties to simplify the binding and
> have only one place of definition for common properties.  The common CEC
> binding expects also node name to be 'cec'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix node name to cec.
> ---
>  .../bindings/media/i2c/chrontel,ch7322.yaml           | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
