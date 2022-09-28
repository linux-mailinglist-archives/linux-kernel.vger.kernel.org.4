Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54C5ED1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiI1AWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1AWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:22:06 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E4113B56;
        Tue, 27 Sep 2022 17:22:01 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id g130so13664360oia.13;
        Tue, 27 Sep 2022 17:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RPeWLGvkPBKzfoH3cM8MB6C8/VkdREzbB4eDCU6wC9U=;
        b=GX5T9CIVg+5E+CO1iwZgZPER6eJZd4Nn8g2B+Yc2+dAoj6pI5Sa1rNq8dZown2OfYB
         wEYoXXmxZWG5iysWkkHu3QIrjrLynFYk8oOgp0kFjRKn76phi5tlDTIV0GudOZNUegeg
         RePqrhDbB5zUmKTDtGWvyIRe0oxNrWPUxgFb2K2YmxOrfhCDN8m2I2OurIPsjh2ruXp3
         OuX7GhO1kSPlFtoK2koz9HKQzKos3/CfX2pfkfyTNmSyZ0+M2Y25QiFU+cFx5jTFeen8
         b87C/kUBx57gU2ccLmH0IsLwLbnKoYmRnYU1PdwM7FSFecWKLwTurajexBN7IiZRLRXv
         5zKA==
X-Gm-Message-State: ACrzQf1RmxTv2FDDKFQQwZN4hlq6jmGgvku4CTcu2qi84jYKqzsgn+oW
        CLP46UrG8bXdvb/2TvxvXQ==
X-Google-Smtp-Source: AMsMyM4UdZtWuPdEwRqcGUQVsNzocQnHLNRtcDNd8J/rluvt5BwjMzAlDZsfmwMLt2wcPWcRADDj8Q==
X-Received: by 2002:aca:f1c1:0:b0:350:2dca:7435 with SMTP id p184-20020acaf1c1000000b003502dca7435mr3033791oih.293.1664324520442;
        Tue, 27 Sep 2022 17:22:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a056871068900b0013191b00f72sm1251257oao.17.2022.09.27.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:22:00 -0700 (PDT)
Received: (nullmailer pid 2694075 invoked by uid 1000);
        Wed, 28 Sep 2022 00:21:59 -0000
Date:   Tue, 27 Sep 2022 19:21:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v3 26/34] dt-bindings: pinctrl: qcom,qcm2290: fix
 matching pin config
Message-ID: <20220928002159.GA2693936-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-27-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-27-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:54 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml           | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
