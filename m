Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAF5ED17C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiI1AQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI1APy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:15:54 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBABEEB43;
        Tue, 27 Sep 2022 17:15:53 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-13189cd5789so3637290fac.11;
        Tue, 27 Sep 2022 17:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kRo13wpMLJOzS3jqPig2M6HHXDz6HFbiXe3zyizsBp4=;
        b=Qritu37bu7vUcQJ7oyGxEbBpSMflU/hFkYBz8U5ftftXIEg9ObyDtFsTqUcC9//EbT
         Iet5e7HUD/tti7SznD2Nqab6Q1XCil5WiPBxHmKy1FJBA6m5bhe06e/Bkf/nsDfLnUjt
         W0s+Uc+IDFIdyXuKsDQp6QCFi2ttxUv3zA61/7h0UM+kL1AVM4q3+QM2JWpFeBXeUTxU
         PUU1VjMxGa5to0o5V5+gNS5hqYGvOvLi9dcAwXjV6uU9DZxU4E8YEkDoyQ+h/ce4xdlO
         gd05IyMv7UlfU9P6XkplqSJp95wZs5azO8OITjkbDZETyi8HtxMFUZ/XUd70GkZxn36v
         Cb5A==
X-Gm-Message-State: ACrzQf29EruX1lgosOTEKIdgUAOyDLLcGGCaaQd6Hav2LUoiE2hmTcSq
        EzSJty9VkdP1ziq5wyn+eQ==
X-Google-Smtp-Source: AMsMyM41JupW+/MsHGatWUd6mELxlzIr+bCVHnyn0CZXWct3hcKmXU/EBbJ1kOe+feoW1ywwQhX8kw==
X-Received: by 2002:a05:6870:64a2:b0:12b:7db:b8e1 with SMTP id cz34-20020a05687064a200b0012b07dbb8e1mr3742030oab.212.1664324152397;
        Tue, 27 Sep 2022 17:15:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i6-20020a05683033e600b0065bf42c967fsm1349027otu.19.2022.09.27.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:15:51 -0700 (PDT)
Received: (nullmailer pid 2654350 invoked by uid 1000);
        Wed, 28 Sep 2022 00:15:50 -0000
Date:   Tue, 27 Sep 2022 19:15:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 08/34] dt-bindings: pinctrl: qcom,ipq6018: add
 qpic_pad function
Message-ID: <20220928001550.GA2654250-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:36 +0200, Krzysztof Kozlowski wrote:
> The IPQ6018 pinctrl driver supports qpic_pad and DTS already uses it:
> 
>   'qpic_pad' is not one of ['adsp_ext', 'alsp_int', 'atest_bbrx0', ...
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
