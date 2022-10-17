Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521DA601669
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJQSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJQSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:35:43 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCF6C942;
        Mon, 17 Oct 2022 11:35:42 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so6303680otu.7;
        Mon, 17 Oct 2022 11:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOFeRgc8x0+ScO8vLGWZow6v2G5REBOQcbT+S+kaKbM=;
        b=BI8jNRiVYBoKSDk1eW9VnkA+6UEvIMnQwx5FdIWMdjmxCQA3GWlr7ysU6zgl72kpia
         hki9TXhS/8i+7NFQ9bQ1iQ3mIqnVo8IIrclUkVZkqWLAy8gW1/c2msy1iPQQokeltRd7
         3REGCvsl/lmY8iMkPCtKsTfpUMMWyjefgA0UHnn7NxCfL85tjdnl253dRwAZxKNFVCA0
         Q8ehwIb7MN3pp7/lRBcFvI7MOB3iDeT+ZXHpmQE1kEbD09r/1aEnv53F9eTDHB8elgCA
         EWZXiDJ4cA0DfIwZtCP9Ot0iwNZMy7iq4vGzO0XrA1AWeOLHuD8bb7pTf6HpojyJilTc
         P9iw==
X-Gm-Message-State: ACrzQf3Py5J67aIID54sG29WDHu5/aj7z4JXaUtbL2K9N9/hlwPlVSNI
        3Juxi3yGSolTUxdi+qxoXw==
X-Google-Smtp-Source: AMsMyM67dYJeLL/IE6ygb43XYBBFNxbd3kYg7iYHm2CZ++WJg8fR+93mmKUh6kMD67+Rzq4Y4l4YDA==
X-Received: by 2002:a05:6830:246b:b0:661:b802:41e4 with SMTP id x43-20020a056830246b00b00661b80241e4mr5605066otr.56.1666031741270;
        Mon, 17 Oct 2022 11:35:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i9-20020aca2b09000000b00354b1edb60fsm4593995oik.32.2022.10.17.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:35:40 -0700 (PDT)
Received: (nullmailer pid 2256306 invoked by uid 1000);
        Mon, 17 Oct 2022 18:35:41 -0000
Date:   Mon, 17 Oct 2022 13:35:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: drop minItems equal to
 maxItems
Message-ID: <166603174058.2256267.12966526494787404406.robh@kernel.org>
References: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:36:25 -0400, Krzysztof Kozlowski wrote:
> If minItems are missing, they are implicitly equal to maxItems.
> Dropping redundant minItems simplifies a bit the binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml          | 1 -
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml  | 1 -
>  2 files changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
