Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F615EB533
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIZXNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIZXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:13:27 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FEAC393;
        Mon, 26 Sep 2022 16:13:23 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13122bfaea6so6182105fac.11;
        Mon, 26 Sep 2022 16:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/GOX4oLLOEAcOdQMFgtIV2BH6YmfCv4mZAsaXgTNcNk=;
        b=PuRe6GYqOr8w4yHxoKQj/KN2CqJnrz4vnzMIeCiJdUnDWGzQfTFVSgGdH3XUMX6xBY
         sK8n7EgwQsqzbxJbAq42/om6Ha7FcyxLJRqrGYV9u3FkEVvpXVl7eBajA7Yb9TpQlJTq
         z/breZjn2FiqFxDDGF67lNAD5FCqytWSEK6Tf19gabwLujF0h9PScl/28bv5QEsf5Nc3
         lWubFUZB4XUmf6P2ANn0Pen+i2yI7Tld5kUhe8U7xPx5FNQFTjciJ3ii85N4AAHE6krt
         Ch6R+c9IXcEi1xRYUYk/GmGkaslUkV1/YWtRX4PLEcMj8r89pml2Ok3JSGmJAGdhnMp3
         1rew==
X-Gm-Message-State: ACrzQf3A98SdPFd4ET9dOCETQFPQ/131AQVV0S1eMpx+Zn3P35CcMxH3
        O4ztiA+PLL6IhlsQ9fY9JtxIlmPMsg==
X-Google-Smtp-Source: AMsMyM5VFcXp33QC3V21osLPSDzEkS3UB1QeDgP6rUP4dKnc6s5JIVG9nWg12Lk0H9YLzncqyUOjnw==
X-Received: by 2002:a05:6870:1694:b0:127:8d30:5afc with SMTP id j20-20020a056870169400b001278d305afcmr656928oae.26.1664234003049;
        Mon, 26 Sep 2022 16:13:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003509cc4ad4esm7724560oie.39.2022.09.26.16.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:13:22 -0700 (PDT)
Received: (nullmailer pid 3147399 invoked by uid 1000);
        Mon, 26 Sep 2022 23:13:21 -0000
Date:   Mon, 26 Sep 2022 18:13:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-gpio@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 10/32] dt-bindings: pinctrl: qcom,ipq6018: do not require
 function on non-GPIOs
Message-ID: <20220926231321.GA3147326-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-11-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:04:37 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml       | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
