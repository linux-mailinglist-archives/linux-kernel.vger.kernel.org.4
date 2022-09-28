Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E55ED19A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiI1ASm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiI1AS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:18:29 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C561100AA8;
        Tue, 27 Sep 2022 17:18:25 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-131886d366cso3761042fac.10;
        Tue, 27 Sep 2022 17:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oXpgommVfL1ZXaivZi/LbLJ7GannQeoIi/KGM5V5YbE=;
        b=kQJ3pIDRT0SLtzQGK94FyCgy9mdtTuuEwDi4CeuzzsAAihG47szOxBuBvahmRe0HSZ
         jtr0pDwbZhn0hRPXI1BA4tbifU4mmJa/3QZ85sOfuOfk7C1IxlqvGW5+H+NY+srcXG4c
         KH2xNa7JThfIM6WUae0ppx5vEklsdjtHphUfpEkSletCQtH4A7Bai5L6Fh/+Wbc3YjDf
         P0QXXw3t+3TL4SLoM1b31zMWNVG59yg332qt/XuGkhOOgv8XxUb0VqJDrIHVJ6hBRtqm
         Ud2GDLFPH+7G9RqkRBE57tUc0UlrzyfadOb8J1PyfNyJxeX9I/HwANcIKwBdH7uhFGol
         YKfA==
X-Gm-Message-State: ACrzQf0Kh8XrHEvEDqaKZjDcmNIZvl10gb6h8MoPnF2q0h+m4f0h9dXP
        sMGYnomd+zAWBhZPEzBxPw==
X-Google-Smtp-Source: AMsMyM6UAWSmFlDTU3A9wC0Iuxspn/obbiJ0780le7giRqC5u3bxJCViV7Avo0GynU7zF2Bw5zK/JQ==
X-Received: by 2002:a05:6870:4624:b0:11c:afbd:c678 with SMTP id z36-20020a056870462400b0011cafbdc678mr3759187oao.168.1664324304587;
        Tue, 27 Sep 2022 17:18:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a4ab487000000b0044b22632d51sm1219699ooo.2.2022.09.27.17.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:18:24 -0700 (PDT)
Received: (nullmailer pid 2669642 invoked by uid 1000);
        Wed, 28 Sep 2022 00:18:23 -0000
Date:   Tue, 27 Sep 2022 19:18:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 14/34] dt-bindings: pinctrl: qcom,msm8226: fix
 matching pin config
Message-ID: <20220928001823.GA2669557-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:42 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
