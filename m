Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AA5ED1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiI1AUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiI1AT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:19:58 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490D8E446;
        Tue, 27 Sep 2022 17:19:56 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id h1-20020a4aa741000000b004756c611188so1798264oom.4;
        Tue, 27 Sep 2022 17:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BxZaB0cQDODru40UTMXgtOPFcT0sVnVkUtTwkWTQ4ig=;
        b=7S5mlLiQhlIvWtmCxa97gTjN/KKH+cALz/BY+/L0ABQu9rIwl7gHW8HnDEikcToze0
         LyTfRdCiTgfIqtyVcoWIGGPjaIs5fkZI4s9cjxKLAcMayLesYDS5pMhZ8GyqtZhvI4Lm
         kia6FkAlx02XDNYFPbprtbeAQauNnAlFGGDAi7vA/KfFGLMJGW/cNjc/F3jMT5YSuNH7
         ZhMLjsbYJAZ7/iraQ7FgZxZNj6NUGyNvBlGjk/rOFJ7l3JaOEoL9sOjLK8NrRw2+seUP
         XNs7DD7RsNSiLQ4NSQBuHtSXDkdLnuM4Ki6MPCqFNRyY2Mbvn+d6IYHjKWWKY1Z2mTQp
         6pHA==
X-Gm-Message-State: ACrzQf0TVZTAeYwX2GHKoLn5rf/2JyhrxDG8QDEoZpGwnHiuXtx59Qcd
        tQgAvOp13IWHnzXFtDFsRA==
X-Google-Smtp-Source: AMsMyM7kL2l+qc/7dcpcaxAKDV95TXBw49Fu9hvP1S7WKCyusK2bomHiM1vU2IUm01hR8pcE6JN6/Q==
X-Received: by 2002:a4a:1787:0:b0:44d:f068:d0e2 with SMTP id 129-20020a4a1787000000b0044df068d0e2mr11946548ooe.27.1664324395262;
        Tue, 27 Sep 2022 17:19:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i20-20020a9d6254000000b0063975d170a8sm1396162otk.7.2022.09.27.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:19:54 -0700 (PDT)
Received: (nullmailer pid 2678835 invoked by uid 1000);
        Wed, 28 Sep 2022 00:19:53 -0000
Date:   Tue, 27 Sep 2022 19:19:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 19/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: do not
 require function on non-GPIOs
Message-ID: <20220928001953.GA2678716-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-20-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-20-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:47 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> ---
> 
> v1 was reviewed by Rob, but patch was changed since that time, so not
> adding Rob's tag.
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
