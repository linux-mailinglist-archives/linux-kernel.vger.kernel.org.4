Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3AF5ED18C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiI1ARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI1ARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:17:30 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72EF684F;
        Tue, 27 Sep 2022 17:17:29 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so7293938otu.7;
        Tue, 27 Sep 2022 17:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z211sHksy/3gvQT8k5f5iY0qgXEgDC8vCPuVYwgHLKE=;
        b=xzzx/WhrPgvApKCHffChLJACX973UGS2hsPGRYXZjTkDO3K9NSFqKw5t+ldv2FAT7J
         TwHelE36MYLavO3UhrEEFb66LvemV9qui+iewkpCVzlDa3njYszFb3fmqryquwix4kuG
         z1B6WdDyDYC6Rv5T8UkJ1lYnywwxon/v9qnRFyNVdU3dG5MKvKpgVzoSOWBWM15JmXBn
         ezpkmrM9zklDlCAEu0Fx0LvaJEZh08n3EkMAyevjALrZl6UcC8TF3aAKL2KjTKjaNrtu
         tBc8axCFBX51OcMN5nFve1duZwl7C8UL1bn6BGiTFIEsYrQAuOasMb0av0MflFjB8p7J
         W/YA==
X-Gm-Message-State: ACrzQf2E2hjm9tfL3M17sAHhVepyrwGEcI9EaZ/y3upHvclDUQFkype6
        6s4rVt1N1KPiNg6h5PuboYMgUM5Grw==
X-Google-Smtp-Source: AMsMyM7b5/v745diEwgzXlbyHAiPCTnVzhUrmHaOox9LhMsF1ZrABDoF4ex+CjbZifhbSLh9MSmO3w==
X-Received: by 2002:a05:6830:314e:b0:658:5246:af2 with SMTP id c14-20020a056830314e00b0065852460af2mr13639983ots.53.1664324248954;
        Tue, 27 Sep 2022 17:17:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x13-20020a056870330d00b0012d6f3d370bsm1670467oae.55.2022.09.27.17.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:17:28 -0700 (PDT)
Received: (nullmailer pid 2662863 invoked by uid 1000);
        Wed, 28 Sep 2022 00:17:27 -0000
Date:   Tue, 27 Sep 2022 19:17:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/34] dt-bindings: pinctrl: qcom,ipq6018: fix
 matching pin config
Message-ID: <20220928001727.GA2662780-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-12-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:39 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
