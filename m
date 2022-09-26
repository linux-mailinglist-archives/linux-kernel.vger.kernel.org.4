Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358885EB23B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIZUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIZUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:37:46 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2D8F96B;
        Mon, 26 Sep 2022 13:37:45 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso5226961otq.1;
        Mon, 26 Sep 2022 13:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Tv0AY7MIM9gNxoh3YrRffewHQKSHuuCX0JjlbWw8kr0=;
        b=vWlFcuVcwzABZHyuvh2PEOXoyZjGGcsm85lgukHHsAQiSr1a1z/DdreTs57IZBJzT2
         mNyZb6kn8yPSN8zgI+rqYRml1dL8ozdduWzEKOoHQLvBs2A+277lR+CbADfufu1niUcE
         cJvbZjkfG2uKwzwbdGwD5WrF2cqjYzTsyxDpsXfD5og9x7vmR9Haru22kwYlBChHeGQ0
         ozqwWYB8PmFgpLUckUci+RJL4Q0mq5ujrWNKXvOu+fCFIagzN93TSwOgTPd0wfsJD3uW
         T5+/gApC0S3dkUUpeCT1xlW5gGyZWXaAwrwPnA/QaidSuRMYUm/c+7BpR7fbM5P72aMZ
         3lew==
X-Gm-Message-State: ACrzQf0Q02olgtRLBqf/gEw6HVf0kGg2pVQ6cSQULuYdx4u8JUkmYTKm
        1540/VBbYeHGhBs3VIlw9A==
X-Google-Smtp-Source: AMsMyM52ZZz2Puys5ZO8CoKEuiRNlgaRErKzdYx0Jq+Dy/m0LX4BzagQYNLa90AfuLpzWv5XIWM6Cw==
X-Received: by 2002:a05:6830:1351:b0:65b:e0a8:d0e8 with SMTP id r17-20020a056830135100b0065be0a8d0e8mr10676435otq.190.1664224665118;
        Mon, 26 Sep 2022 13:37:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g20-20020a056870a71400b0011e73536301sm9608693oam.52.2022.09.26.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:37:44 -0700 (PDT)
Received: (nullmailer pid 2767526 invoked by uid 1000);
        Mon, 26 Sep 2022 20:37:43 -0000
Date:   Mon, 26 Sep 2022 15:37:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/12] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix
 matching pin config
Message-ID: <20220926203743.GA2767165-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-5-krzysztof.kozlowski@linaro.org>
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

On Thu, 22 Sep 2022 21:56:43 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
