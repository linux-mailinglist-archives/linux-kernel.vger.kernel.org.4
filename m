Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029B5ED1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiI1AYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiI1AXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:23:33 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F91C99D0;
        Tue, 27 Sep 2022 17:23:29 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id g130so13667210oia.13;
        Tue, 27 Sep 2022 17:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1ql8osKKiX11AWgBttLdJc5/t2n/m0cIIQ1QiFmAs3w=;
        b=IC6FYM0WB5rTyXwv0Wgm1DL20/O2iw9W0YGoax3PsTsrNVRr5ZZwk/azuyWyXeCeZM
         8d6gRxWn9W/5T5iiyK9iLCiXsicKXrqxbnIVAHCMZ0n+7SCuG+49KuUxkKQQYKJAQpox
         RwDc4joW+wGDvuTJdFQmyOw6uhDl5/b42yAeElulrJ/HgwrxreL6L3+ygogO/HyJWGbH
         +tBCzI7d5FRP9DHuNfsc+YdiJ/4z9k0yi8ZVyKlI0xkgffaYyGt2wOMqBmgEZjR5NEyd
         aSFj09g02zX8MCkmXi+U24Tk57hxaAqfCkhYVP+9wxHqTvICO4nrbKSqD6yuG52W6/wZ
         lLrw==
X-Gm-Message-State: ACrzQf0Ew1I7mcTImAntAOonPu4LWjp3Hv/dMV/CRuVKuI733iBGrrT/
        7ZG5OTKDjoyRMxW2fJeRJw==
X-Google-Smtp-Source: AMsMyM6jbmgRBwx7KFoiQ23aOsU9B7nN/s/muKdM5IPIrLOOO31hrlzupf0VienQkJUR2xWe/hJFHw==
X-Received: by 2002:a05:6808:1390:b0:350:45fd:7d31 with SMTP id c16-20020a056808139000b0035045fd7d31mr3226331oiw.253.1664324609145;
        Tue, 27 Sep 2022 17:23:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b21-20020a4ae215000000b0043540f7701esm1217122oot.31.2022.09.27.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:23:28 -0700 (PDT)
Received: (nullmailer pid 2703254 invoked by uid 1000);
        Wed, 28 Sep 2022 00:23:27 -0000
Date:   Tue, 27 Sep 2022 19:23:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 32/34] dt-bindings: pinctrl: qcom,sdx65: use common
 TLMM schema
Message-ID: <20220928002327.GA2703186-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-33-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-33-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:37:00 +0200, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring other
> regular schemas and additional checks, like function required only for
> GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> ---
> 
> v1 was reviewed by Rob, but patch was changed since that time, so not
> adding Rob's tag.
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
