Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973FA5ED1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiI1AUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI1AUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:20:19 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD62D4DE8;
        Tue, 27 Sep 2022 17:20:17 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m81so13754074oia.1;
        Tue, 27 Sep 2022 17:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rVyT9+8Fp7S/kZHb+65ZfGNFJ9je17sRXutQSRnwqKU=;
        b=A7Vog3e5rCxFmxy56ygQypRZqrNBTb5hFxwlQXkMj7syrTu3az5NH8A1Ol8HX9H4a4
         DJ7Ql3qCZnJioT9uMXQ/EZAKmpSTqd25KIHLW4/Gv9V3hOnJsiFAJH4sh27b967mnV+U
         CpkWQVCMrnChzQl20LPxZ85Syeewl7+ZN4eEiYJDOFapt1HIvQph0/FJfH7GWDw9EcVf
         OXZllzpkUhhRHo1mUmSjwFgy1tMyEFtcXoZyoeVwB+V4h2uiRNcRaAo112hF4PpL+dwj
         jxCNSQ1EoLdkwTCHtbvkyD29Fd1K9/mi5PjofGwRtu0+mUmK7W+gAssqwTFeViGETFQj
         heVQ==
X-Gm-Message-State: ACrzQf0CcwwTVG7IWz0xNRTiJOF9DVzYF8EIWl/YB9rPZGp8XXbKJ6jf
        iL7PnXWNChFLSVuT7facrw==
X-Google-Smtp-Source: AMsMyM6CDw3Yguhk2MMS9Gmhu9v7/YXzzPInUyUfgiv/aqFbn2o3ZMbI8WR27JQLabR5y+nTdDnDWg==
X-Received: by 2002:a05:6808:d52:b0:350:9a6a:3c82 with SMTP id w18-20020a0568080d5200b003509a6a3c82mr3050142oik.197.1664324416113;
        Tue, 27 Sep 2022 17:20:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b8-20020a056830104800b00637190319eesm1395468otp.29.2022.09.27.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:20:15 -0700 (PDT)
Received: (nullmailer pid 2681120 invoked by uid 1000);
        Wed, 28 Sep 2022 00:20:14 -0000
Date:   Tue, 27 Sep 2022 19:20:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 20/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix
 indentation in example
Message-ID: <20220928002014.GA2681033-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-21-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-21-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:48 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 60 +++++++++----------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
