Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA05ED1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiI1AXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiI1AWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:22:53 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46431138F4;
        Tue, 27 Sep 2022 17:22:40 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id r34-20020a05683044a200b0065a12392fd7so7293808otv.3;
        Tue, 27 Sep 2022 17:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gvRG5H3Rr2ZAW+b0TY5LqPbHj17gicjEw19d0hyAp08=;
        b=aWFolNuEhnuBoKnbhRdp3qJklnSUwW3zWP4To9M0rjacuL9CKZyzrFJzSauk90p4Jh
         h4phUGwKymXBKWlp3WZr8dvA0hTgaa4KSYDNn/6Urjg7Zv6cegM0iCEcrLwbbD7KIDmG
         yYuTu2KVWK0BZQI4LXmGHGmXL2wtRMGgEOvTTnlF+CgTRtJz5YcuIHIz9vUdjeDCjQkA
         Ul6O3/i0JIo+pv+XV1qSqP8JRReWwq7lq6L7o6GcIYyxtmhiqVfJvfO20XRRwFIxzCqX
         h8lou+alp8SR7FtJL+yXWXWPVpYBKt6TKX5b+YGnLvu5r8QqR/XPEZXj8wv0nqN9Jtnt
         hvtQ==
X-Gm-Message-State: ACrzQf2ASKXnM6HQZynGSfHrc4yhA1pYLZdnrACUlfOLWWwHiD7xJOm7
        LuH/6nvHR7EUj72A8Vg9kA==
X-Google-Smtp-Source: AMsMyM6OGgcWFJ9+wHq/TCOJ/WtKSfTyJxkMWJaqdsk+IfdqZImDSSki0osWrk1inejuXJPcujErbw==
X-Received: by 2002:a9d:5e8e:0:b0:65a:275c:7979 with SMTP id f14-20020a9d5e8e000000b0065a275c7979mr14037089otl.3.1664324559515;
        Tue, 27 Sep 2022 17:22:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a05687041d400b00127ebb410a4sm1735594oac.11.2022.09.27.17.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:22:39 -0700 (PDT)
Received: (nullmailer pid 2698492 invoked by uid 1000);
        Wed, 28 Sep 2022 00:22:38 -0000
Date:   Tue, 27 Sep 2022 19:22:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 28/34] dt-bindings: pinctrl: qcom,sdx55: fix matching
 pin config
Message-ID: <20220928002238.GA2698415-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-29-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-29-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:56 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.
> 
>   qcom-sdx55-telit-fn980-tlb.dtb: pinctrl@f100000: 'pcie_ep_clkreq_default', 'pcie_ep_perst_default', 'pcie_ep_wake_default' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 
> This method also unifies the bindings with other Qualcomm TLMM and LPASS
> pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
