Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C555EB54A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIZXPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIZXPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:15:38 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CC13F32;
        Mon, 26 Sep 2022 16:15:31 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id s125so10113419oie.4;
        Mon, 26 Sep 2022 16:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TAlFPYLk2xWO6F4+VI9iTD2OoZ7IxyJR5rgJJm8AZHg=;
        b=2BWYRR6dc2d/Jfw1Jd0HV8nIR3pUgWE/3dHA98CbWAcxssYjmupk1zrAqFQw1iutH6
         dy4h9NvwF3pJ+0XDoXghrLGmFpc5ZiHNvWbcfbCnuGc98ATsdxBqYdcSw2dLBCjRiqza
         9bavaNnMlwtuZ9LR+9J6pFsZuONokMP8kCiUkRx0X9uh8KC3B+KIDJWAayVTw8sPqaDW
         mGxsVJxGgjKbzVToGrCu7SSps+shgjv1hqjvHqL9w8DRTlku7Zl9/ILepMFieXWWBzn4
         M1xMsc6Bt1ZFN6+EK4v6WxWv4RBzIXnV3Z+PGIhWg0UiK2ubA7RAEu+6mnLYFzOjYfcn
         4h2Q==
X-Gm-Message-State: ACrzQf0r7XO0kutRjok27Yvuw1w2zx1w7VqFUGVal0QbYXMdk/t7ew/U
        PSmb7Hn3CRb2nIPi9mrLWw==
X-Google-Smtp-Source: AMsMyM5sLZPfIfGnI9T9sBp7a/QrAxvEfYxiTYe+xBTrgGE2uYsj+kSB/+HXZTAk65tgSup8K/Jm9Q==
X-Received: by 2002:a05:6808:201b:b0:350:87c:a8c6 with SMTP id q27-20020a056808201b00b00350087ca8c6mr550814oiw.228.1664234129775;
        Mon, 26 Sep 2022 16:15:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a056870548b00b001278611f0f6sm9523685oan.32.2022.09.26.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:15:29 -0700 (PDT)
Received: (nullmailer pid 3151384 invoked by uid 1000);
        Mon, 26 Sep 2022 23:15:28 -0000
Date:   Mon, 26 Sep 2022 18:15:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: Re: [PATCH 27/32] dt-bindings: pinctrl: qcom,sdx55: do not require
 function on non-GPIOs
Message-ID: <20220926231528.GA3151351-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-28-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-28-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 10:04:54 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml         | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
