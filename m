Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9885F1A6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJAHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJAHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:00:16 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97704491E1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:00:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j7so7643386ybb.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PJKsBdmry9pp/p4qjkmtTRbPY3WNcZCpKNJJCK49xuc=;
        b=l33IBhwzFr8JMiWB6aVikVWjK/TOsxDzaHohFGJCq62lfESb6uWgORm5Nx1+Bplids
         4pKokXzPrVyJm+gL2Rronk7oBJjfiwEo30yo6rYl+njXmSVggA4hqcGLSe8D1hcejipQ
         TByJsrkkzCv78q16bhSgyTRYQI3xsmpbLmZqhb5xlmKVSiZmLv5gjy5Yk43wcIaUPQlQ
         7yLxJGis5H/eMH5opHarreBzyDZCXoNVN4Hj7YMSYao3au3cTNSu41LWwTDkzu56/X83
         nLB4sC4IivKOaLwiRFznZCv7xN/CumrjQnVvEYx2BpD3zEfWfoawwHlY5BaVkCxFl/uH
         OiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PJKsBdmry9pp/p4qjkmtTRbPY3WNcZCpKNJJCK49xuc=;
        b=aa2L1Pv3C4KWnCBhAUDxBepmT/GRn+er3U7ENeEOXoE7NQuVChbgiUI1AvKMzTyDqG
         fcD/sVbGBUuvspox2wYy1sRxA0lgWnVqrgYfcc8FYhRr6JXZIaqIF1NQIjLzpLmJb4kT
         2i+RJ6p5ZPHO3SVCxpdrRVLW8ebk9lMbC02jQmUAK2nLedtccdow5FicgqJsc3Qq4bfL
         BFA7SpYLq85r3rfnZkZHB+3UswoXo56wa91lTfRp1KvcePtV4iKy5pg30hNfOpYI8jDr
         v9uHcVNa2X602zqrRQS95GGJ6yCSlXxGu3IPtKZ30mjaBKw1YQIfBih0XPA3Md41R7e6
         Sm8A==
X-Gm-Message-State: ACrzQf0fy0gr1cwjb0M/T8F3aqwb7QzTKl2En+qwIwKDoNRv9p8VjQyN
        50wkp/ICEEsx+mmMcR0iy+nFJvyBXuaxAMuuq+JhuA==
X-Google-Smtp-Source: AMsMyM5OzN8oBMlFfj9MHDQboYmmjpF5OxhNHqvlAZcsHyutiAbNkTzvP4NCKy0Mi4D0mrNTDILZrjjl2MWl2AJhDiA=
X-Received: by 2002:a25:a502:0:b0:6bc:2835:a88a with SMTP id
 h2-20020a25a502000000b006bc2835a88amr11254803ybi.15.1664607604880; Sat, 01
 Oct 2022 00:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030403.27659-1-quic_molvera@quicinc.com> <20221001030403.27659-3-quic_molvera@quicinc.com>
In-Reply-To: <20221001030403.27659-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 09:59:34 +0300
Message-ID: <CAA8EJpr2ZnEC3=WMns8AGNY1DwARM9xnadtaBkzctOyNLv3=Zg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: Add RPMHCC bindings for QDU1000
 and QRU1000
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:05, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add compatible strings for RPMHCC for QDU1000 and QRU1000.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> index 8fcaf418f84a..d613156eadb0 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> @@ -29,6 +29,8 @@ properties:
>        - qcom,sm8250-rpmh-clk
>        - qcom,sm8350-rpmh-clk
>        - qcom,sm8450-rpmh-clk
> +      - qcom,qdu1000-rpmh-clk
> +      - qcom,qru1000-rpmh-clk

Alphabetic sorting please. Q comes before s.

>
>    clocks:
>      maxItems: 1
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
