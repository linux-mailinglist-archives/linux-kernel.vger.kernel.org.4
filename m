Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FC5ED1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiI1AVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiI1AUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:20:53 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC36C132;
        Tue, 27 Sep 2022 17:20:48 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id w22-20020a056830061600b006546deda3f9so7310219oti.4;
        Tue, 27 Sep 2022 17:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q+ScntMva2jPKtLZKdkSzHoGETkBDxvpMCSUEYYFiR4=;
        b=rFyP39/qhECmu/GnUgPVV0qSkewf2QWtjuoc5pvtvOfMGq2sXznwqyGfXZtsmmNDNs
         tvUtJ6fdiopUud5toLrl+6El37ZN2zjBXD63taVpN0BzzJylw65gJC8Bk85Dl61wXKcQ
         JGb3HCVlCgBj5pEpdD2VLTk7ZfCB9ZH7D6LnuG2nrb+YVxUUKngsQRZ1H0SwWi9DQ1/B
         S0avB/eAngNmmET8dSI9+ZLH/fsd0EDS8sn8ZlzMfbwbOsyMlaAwbpn8mJXO6I8X+wLM
         S2ocAjTqT+KR3yJi3lPxHxJNuVmIDzaQ7c18NDRNGzdjt6T4tTJPXWlRqDlyxGe2j3Gu
         DyfQ==
X-Gm-Message-State: ACrzQf0d5dhALAdFIC+PuvtyL92TIlY+pB6DD7jzyMZmURJyFkdCjEaT
        rbHffmZ9fUaPudNzSAEgCQ==
X-Google-Smtp-Source: AMsMyM4fQN3g7llxA3xo/25Ij0YfZnOS8REY2DUSxJCQ3+ijQ/nJMoYqCZPorkuhWVcChr71xete+w==
X-Received: by 2002:a05:6830:33e2:b0:656:170a:9641 with SMTP id i2-20020a05683033e200b00656170a9641mr13391698otu.54.1664324447796;
        Tue, 27 Sep 2022 17:20:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d5-20020a9d2905000000b00655bbb53c55sm1373975otb.15.2022.09.27.17.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:20:47 -0700 (PDT)
Received: (nullmailer pid 2684729 invoked by uid 1000);
        Wed, 28 Sep 2022 00:20:46 -0000
Date:   Tue, 27 Sep 2022 19:20:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 22/34] dt-bindings: pinctrl: qcom,msm8953: use common
 TLMM schema
Message-ID: <20220928002046.GA2684568-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-23-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-23-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:50 +0200, Krzysztof Kozlowski wrote:
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
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml    | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
