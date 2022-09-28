Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061DB5ED1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiI1AXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiI1AWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:22:35 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133F10FE2E;
        Tue, 27 Sep 2022 17:22:22 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id c81so13709358oif.3;
        Tue, 27 Sep 2022 17:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MdAHnbOEIIrleHmz/ug5foh28fBF22dYGu0HVyUQSOw=;
        b=6Va1wepiYHxrdTrtoQabUAfMCMcXVYGh8l/4tb3uNVjgrnhSALqGuHUONlRhOMtJOa
         LiFPNQQE9Bc97BQ7+Ke5oXp9nwJJfj34xZCUupR0fhs1pEQerL+Z0MV9FT8KyBmJaBJ4
         ZDW93mTsCP2sVgxr8vFgvg6Ve/6xe2dm1wMZsNB7OZcuiVBKSHMhpKop+iGN1s6IuG45
         T8y/LqZVWZFNng43wR9dFtGWFk1R6VCqKXdduQGzlqnbXMapoxaiInMgJiOGr29vEWoN
         Ko4BpXW9snSA4Pp9t+pqTAVPe9yCV++jn75xVFqjio11zU/JCJ37uGRIrorq94vI0YMe
         PQUQ==
X-Gm-Message-State: ACrzQf3F0Z1xFTXJZs+sEMqzWrrKF7SGZ+SxBTQXDZWZIXB4oyMV1Y0o
        Ai3+T9YBLgFSa6yUzrplj2H7ylwENQ==
X-Google-Smtp-Source: AMsMyM7V0d5yS9t6NTOzUt9WArgZGdSjM0iND4IY4mywmEzqW8PrfkvCcjqgneUhhGDgIp4vQ+DyqQ==
X-Received: by 2002:a05:6808:7cc:b0:34f:9881:7f9a with SMTP id f12-20020a05680807cc00b0034f98817f9amr2936688oij.62.1664324541347;
        Tue, 27 Sep 2022 17:22:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870e24800b0012b298699dbsm1895714oac.1.2022.09.27.17.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:22:21 -0700 (PDT)
Received: (nullmailer pid 2696671 invoked by uid 1000);
        Wed, 28 Sep 2022 00:22:20 -0000
Date:   Tue, 27 Sep 2022 19:22:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 27/34] dt-bindings: pinctrl: qcom,qcm2290: use common
 TLMM schema
Message-ID: <20220928002220.GA2696588-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-28-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-28-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:55 +0200, Krzysztof Kozlowski wrote:
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
>  .../devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
