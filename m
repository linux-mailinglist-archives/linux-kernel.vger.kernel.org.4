Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A016434EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiLETxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiLETxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:53:04 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4E25EF;
        Mon,  5 Dec 2022 11:51:33 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q83so788706oif.7;
        Mon, 05 Dec 2022 11:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH6SbxBuuvHch1HGDkRle9F3v8RNk6ODU5z55XTJJVc=;
        b=E8c8d+t/irigIh9OZIso+GtPSPjZTdS7OvvYpsL3IEXV5JB6alo01I89t0g+6K/jPi
         /BfHgnrjritqpK8wI2cZ25EEQM2BIxd/HgzWO1aHz6rbP1xLxCuLZuDwQRK3Hhr6ltYy
         x2q26lq03rlQclFlclWQxlTqOwhJumyknhQrMcYAHu4VcZH/jQZVnGepErMDM4A5llhR
         fiq1l3rlHHC2TC1W2djUm4Phyc7xnR8jae037ZDmb9Ita0eMpK+A+OA3+1cDmiqpx+im
         tnYNK6ybHUTPwL/yjaqSxkGC04co3fbJ6FZushXgYPO+eKJMmOWIdKQHYO95HuyYzgOY
         yLig==
X-Gm-Message-State: ANoB5pmWDnqXEX3bwchnpzrLDBW2znKCTmfqG7mqKR1K0XlpXSaxqAj5
        wtmtoIa+6kgWS76+VEyILRH7t6hVFg==
X-Google-Smtp-Source: AA0mqf4u1BmM4BAx15hamKRx6MuFrkM6AngNUJSun6ImjNQWKO3Js4gJI3L96/mmMiOOb3SjmKl5gg==
X-Received: by 2002:aca:d8d4:0:b0:359:d035:e81f with SMTP id p203-20020acad8d4000000b00359d035e81fmr40495084oig.78.1670269893206;
        Mon, 05 Dec 2022 11:51:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n64-20020a4a5343000000b004a065c72a05sm3079642oob.2.2022.12.05.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:51:32 -0800 (PST)
Received: (nullmailer pid 2484205 invoked by uid 1000);
        Mon, 05 Dec 2022 19:51:32 -0000
Date:   Mon, 5 Dec 2022 13:51:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 11/15] dt-bindings: remoteproc: qcom,sc8180x-pas:
 split into separate file
Message-ID: <167026989177.2484166.4169969547561903763.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:29 +0100, Krzysztof Kozlowski wrote:
> Split SC8180x remote processor Peripheral Authentication Service bindings
> into their own file to reduce complexity and make maintenance easier.
> 
> The binding is incomplete due to lack of upstreamed DTS - no example and
> not all power domains defined.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Drop if:then: for the clock and put it directly under properties.
> 2. Merge two if:then: clauses for setting interrupts.
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 27 ------
>  .../bindings/remoteproc/qcom,sc8180x-pas.yaml | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
