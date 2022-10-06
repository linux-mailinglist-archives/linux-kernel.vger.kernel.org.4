Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DE5F6F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiJFUiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJFUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:06 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9BC6941;
        Thu,  6 Oct 2022 13:38:05 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-131ea99262dso3529530fac.9;
        Thu, 06 Oct 2022 13:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O1ap/ZE5y17mDgs+zZ0YjlUoxnB9V8dafCS4iYQQds=;
        b=6oZ84eBGM/RA3tWC8MAWURaH0DjETHkwzktnmQrc2TZOuwLxIgU9Qi9uNcHgwR3Cde
         l0chNTR1b2uj4xD7Y8dO6J5cIdUiUxtcaD0nbM+Xg25tSEie36VrLr6ePlKuxk7nm/Jg
         39YH08mDE6PXhQuAKwK63PiStGgV0rhb7bu1KkCxueBmcDWRfCJXZKUdXeXjv+lLG2iB
         YJuJzk7ohrSjl3ynxTggJawOelAYi7LiJHAIUG+miRdfLYgmMJj/vFyuM3SnVyuaFOPI
         tgIBcCz10NHYOiio7NcuBVLVwH8Odmy/l41o2nefYeHAKoQNIwzxUoTIGYE+31INpao3
         vADw==
X-Gm-Message-State: ACrzQf2301dd1X/IxY+aOx/UuA1n5EiAxrgSATBvbo10FdJtzDfIcFe4
        vSyXWHdrq3vFpLNX4NRj7ocx4URgig==
X-Google-Smtp-Source: AMsMyM5y0f0HPkjz9ou/ZUBOXjGVwu2iGMRUG08JOcHciNslPGquXEdhbyBvCFNipkqKrRB/gduoLg==
X-Received: by 2002:a05:6870:a114:b0:132:8139:f640 with SMTP id m20-20020a056870a11400b001328139f640mr6460654oae.198.1665088684825;
        Thu, 06 Oct 2022 13:38:04 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id z3-20020a056808064300b0034fbbce2932sm68368oih.42.2022.10.06.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:04 -0700 (PDT)
Received: (nullmailer pid 116101 invoked by uid 1000);
        Thu, 06 Oct 2022 20:38:01 -0000
Date:   Thu, 6 Oct 2022 15:38:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: Re: [PATCH 19/34] dt-bindings: pinctrl: qcom,qcm2290: minor style
 cleanups
Message-ID: <166508868082.116040.2955881559297050798.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-20-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-20-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:22 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml         | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
