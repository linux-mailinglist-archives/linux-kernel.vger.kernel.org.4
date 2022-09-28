Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10205ED1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiI1AXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiI1AXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:23:10 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982EA106F4E;
        Tue, 27 Sep 2022 17:22:52 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id w22-20020a056830061600b006546deda3f9so7312332oti.4;
        Tue, 27 Sep 2022 17:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4iEPMzc1B9dXKvZgVnbrYMfxfYXq8gYEUDW9nQWJMXU=;
        b=RdNBjWEFa01h867dp4y3orw4wNxkDNz7/HtzHmU62EtWTQTrLF14Wy5xWx0lanlMTJ
         HNVz+f+LSnvWJYK1LbML+c4IbJGcWoUcMOmHjk0MVHndbpqr0F8HTqS+LAZVY6GyuzES
         lP0Nul0LIkRZGlewt4W3xv3YzFCqI5RDED+Y0nQKkXdsb5sFiNaFJa4BKAIi6a3iykZH
         ouRWbe6DLpKlYDnU2hv2VhGDr18Zl09B/IIgE4IyDB6QPQuwnFyliOOUXqoXcVbxdXzc
         rN6bfZiu6a9Kyxo2Eu9M/MkvXGEmBZdTtCoJcfHX4tXGtrFrcrEfYuLlv+jbQyrXW8eX
         c7OA==
X-Gm-Message-State: ACrzQf0fVv8gUgNwrKBHHUZav4TuggEI1z4x2nbdhPmE2BjTMavLzTwd
        oR4tW3QFra9/dwK4CDcxeg==
X-Google-Smtp-Source: AMsMyM6HOF59u5vESnhdxP3krLLnmlx/Bw/2sYSvIvVGgUi6TwxM4+9Ba6X95fM18lks/64JsBxlPQ==
X-Received: by 2002:a9d:471a:0:b0:657:6a92:b5d2 with SMTP id a26-20020a9d471a000000b006576a92b5d2mr13447341otf.236.1664324571916;
        Tue, 27 Sep 2022 17:22:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s21-20020a056830125500b0063725d33561sm1379279otp.73.2022.09.27.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:22:51 -0700 (PDT)
Received: (nullmailer pid 2699956 invoked by uid 1000);
        Wed, 28 Sep 2022 00:22:50 -0000
Date:   Tue, 27 Sep 2022 19:22:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 29/34] dt-bindings: pinctrl: qcom,sdx55: use common
 TLMM schema
Message-ID: <20220928002250.GA2699826-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-30-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-30-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:57 +0200, Krzysztof Kozlowski wrote:
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
>  .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
