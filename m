Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3316DF987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDLPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:15:49 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D0C6A68;
        Wed, 12 Apr 2023 08:15:48 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1842e8a8825so14084272fac.13;
        Wed, 12 Apr 2023 08:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312548; x=1683904548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qMBh9PLBLy4EbJbiAowRQcryITBr0aH6b8M8X9uBZE=;
        b=CzUXAifPKCbTQWdjTeUKlxkO8SSPROJ0aEPev/skJNs6Xtnae0sMkuLFph4jW/apiz
         ru95j+MMpRoewjrC4LCszuhyzf7SLwMZFZmFrGz2tLwwj3J+QyA2okowJ321VXxEykRy
         amUs3kQReZcgDaxMb9mbRAHzr+yXaLEv8nQitweQv/nAnAOpVTPzRDvNt7o3/2JRAe/h
         CTBH69NV3i4TCPUhqbKRqoTvctulp7MioAeJ7KdbtCawnQH5MXPfHHVcjoxF4gF7dJ15
         E0DIdI8y/hFKs7Gs0c+LfPsp9PotPdn18ErDWskWWBPLY6V2no29xPKkHVi6gdeXkFNX
         sx3w==
X-Gm-Message-State: AAQBX9f5pkcnMHF0DPQVsgI9+MRZziNl9L+P3WK/adQtnm8ncuiomSEM
        cWgOkOPABouDdMdgJvcC9Q==
X-Google-Smtp-Source: AKy350ZOWCx5lPIgeT1SpnWoh/G+QQqTXYtmo4cc5x5wgiP3rYjvI9SoTDi6oJXZpTMIZ4hoJtWf9A==
X-Received: by 2002:a05:6871:54f:b0:184:1d37:f215 with SMTP id t15-20020a056871054f00b001841d37f215mr4173131oal.27.1681312548056;
        Wed, 12 Apr 2023 08:15:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yg21-20020a05687c009500b0016a37572d17sm6376364oab.2.2023.04.12.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:15:47 -0700 (PDT)
Received: (nullmailer pid 2449292 invoked by uid 1000);
        Wed, 12 Apr 2023 15:15:46 -0000
Date:   Wed, 12 Apr 2023 10:15:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing
 bi_tcxo_ao clock
Message-ID: <168131254634.2449233.13149369292385306341.robh@kernel.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 08 Apr 2023 15:48:18 +0200, Krzysztof Kozlowski wrote:
> Without actual explanation commit 76bd127e6ca5 ("arm64: dts: qcom:
> sm8250: add bi_tcxo_ao to gcc clocks") added bi_tcxo_ao clock input to
> the GCC clock controller, so update the bindings hoping this is really
> needed.  This fixes warnings like:
> 
>   sm8250-xiaomi-elish-csot.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too long
> 
> Fixes: 76bd127e6ca5 ("arm64: dts: qcom: sm8250: add bi_tcxo_ao to gcc clocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

