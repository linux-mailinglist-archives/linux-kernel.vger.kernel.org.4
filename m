Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59664441E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiLFNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiLFNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:07:29 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB6616B;
        Tue,  6 Dec 2022 05:06:05 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id c129so16878000oia.0;
        Tue, 06 Dec 2022 05:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrwbZJ2FtqdiY/vPwt8LzCwhlE5brQNmYQJ5C/oztSA=;
        b=x1Bv/D3kFN/KImPSMmrOs096m03q5bkzibxKEFuj6ZHOQ7R2WXVRp+SlttuaLDL2n0
         XLzgoejaCBH4d3C/5tG/z/isD3mVntm7LXMaa4rXxGiagF16yD2ng4NjjBE97Lvj0vTy
         spqfXrvfxtsw0BxnfvxA0fJMX/rJvn8cr0V1qwlBSeI1vIn9Ls890Mike+h1OzzuqXDG
         ZsWs4zvlCsq81yma4QvhSYB8zEPax8xQ+VpHT7sSghxPhFoUEVycgRl/Jo9TimIvET2K
         f7M6TcKF51/4S+9hWAxAhkzCoCCjgnnoPxXERk51ClFpznEL6mzuZioVpBEGrHsAZvSp
         +3NQ==
X-Gm-Message-State: ANoB5pkapfcDAY/TndvWQBZ1W/x37tg3U0ap+e25gyHHr8p9cjPlDdHG
        Zqs4DfD8xNtm2dsOg83mgg==
X-Google-Smtp-Source: AA0mqf7QB/v7IlggjKBD6x/KqN9IIBVSGh0duRfsvstQud3W+Q+pd6KBR5mHK5Q1z7FhTSzvoSRH5g==
X-Received: by 2002:aca:911:0:b0:35b:f740:483d with SMTP id 17-20020aca0911000000b0035bf740483dmr8132174oij.133.1670331925570;
        Tue, 06 Dec 2022 05:05:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l8-20020a05687040c800b0011f22e74d5fsm10626970oal.20.2022.12.06.05.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:05:24 -0800 (PST)
Received: (nullmailer pid 229892 invoked by uid 1000);
        Tue, 06 Dec 2022 13:05:23 -0000
Date:   Tue, 6 Dec 2022 07:05:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 8/9] media: dt-bindings: nvidia,tegra-cec: convert to
 DT schema
Message-ID: <167033192331.229827.9468903892650962280.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 16:18:44 +0100, Krzysztof Kozlowski wrote:
> Convert Nvidia Tegra HDMI CEC bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../bindings/media/cec/nvidia,tegra-cec.yaml  | 58 +++++++++++++++++++
>  .../devicetree/bindings/media/tegra-cec.txt   | 27 ---------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 59 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/cec/nvidia,tegra-cec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/tegra-cec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
