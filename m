Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E75EB53D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIZXOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIZXOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:14:05 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB728B0B14;
        Mon, 26 Sep 2022 16:14:04 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id c81so10110960oif.3;
        Mon, 26 Sep 2022 16:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t25O+P5rq5Lv+4NNF5Miq43wTxUJYsrzS/1Wdb4d70E=;
        b=OJKgJq6OrwgwDVSX1uaeBTFPK9NEwT8ZF9eAZtKm0S9KOYLnjtkNs0Kwnsa+EbKr0V
         LERZMMgPsq+mE96fwB+dc7wnzz3uCk/FTfsV7YcV5Dg3+Ci56W26oZEV4L54+yBpMzx2
         1zY7+xpIgAzCtCg8bWmBmJO5qkE8BQe5TE6VB7PJC+OEfC88pwTG12APEhKZOXH53UqN
         YaJ0o/GtkWtPX+sGX/P/rpQnDz6fLaV2yd0Q+/o78DSMB8HzOHttk0Xi/3aiwaleaVR1
         qmHjcOTebgYvEC8G+SNRRrVwQyus6oaZDvALbFkL56Prq82pxk+hEo2qdI7mUB0IfvL6
         GfAg==
X-Gm-Message-State: ACrzQf2d+MgK+k3wne50F+wkxVORF2Bw4XOxsYIrmHYKpmN+yt0nWS+U
        gFQgHNVbkfAemcmw7hh55Q==
X-Google-Smtp-Source: AMsMyM5LBpqUlaf8z15MasarAEA8XV/OS8Uld1fg8gFAIwcf5HaqnT99Bm/9jxm90d4ByWIRi/6xDw==
X-Received: by 2002:a05:6808:13c1:b0:350:edd9:d315 with SMTP id d1-20020a05680813c100b00350edd9d315mr535720oiw.193.1664234044170;
        Mon, 26 Sep 2022 16:14:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v188-20020a4a7cc5000000b004690f05af86sm7212322ooc.46.2022.09.26.16.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:14:03 -0700 (PDT)
Received: (nullmailer pid 3148910 invoked by uid 1000);
        Mon, 26 Sep 2022 23:14:03 -0000
Date:   Mon, 26 Sep 2022 18:14:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 20/32] dt-bindings: pinctrl: qcom,msm8953: do not require
 function on non-GPIOs
Message-ID: <20220926231403.GA3148877-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-21-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-21-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 10:04:47 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
