Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD75F6F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiJFUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiJFUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:31:03 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC4BB06D;
        Thu,  6 Oct 2022 13:31:02 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-12c8312131fso3527869fac.4;
        Thu, 06 Oct 2022 13:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKRSisZxSLKy45qEkeneKmm4UnjsZDuiqULfpdxKOXc=;
        b=6ZY76y1VJG/tq511j3oqbFzk4D1jOp7N+voW/tq6iVC3r56Z6Qh1PzMEaUUq2SvuIB
         NjtXXBKHdPH05I14e90z/InEif1vCY9jIN62ePEJqtfoW4+kvxBJO3AIHL0XhukIitBG
         xh3xs8/YAkaxb3EQPmkZ8eEWSz1L7Gny0PVV7CZNboweYs1sT/YuL1BbAr1vUO8RTfQ+
         dk1Knw30GWGgp2rlFd7g73ZkBN9EMIZR8yDtEcyB+EcBQ+aKZQlRQZ1J4YXnJZ9mrAZM
         L8zm1xhauDTeuvFO0+I5PHgRqeczNfzRQEjm//dhbRz7Yt7ga6TbupD9p29gFWRMkydx
         p6bg==
X-Gm-Message-State: ACrzQf3K3vsp6OZX+EW2KnZvPLkf9mG43INf3s/JHyQ80Oo+/DfJonw0
        KqtdsgkXPpKHGgtDOGXsfA==
X-Google-Smtp-Source: AMsMyM7twTgsx56JrN0ykHK8sHUyAHvyh24I+K32LdltRHhLb8WC36N4RKeDXY0ogYSDDNP2pajJsw==
X-Received: by 2002:a05:6870:6488:b0:131:a45b:a8ca with SMTP id cz8-20020a056870648800b00131a45ba8camr839804oab.260.1665088262162;
        Thu, 06 Oct 2022 13:31:02 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id bu11-20020a0568300d0b00b00655ca9a109bsm296509otb.36.2022.10.06.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:31:01 -0700 (PDT)
Received: (nullmailer pid 109978 invoked by uid 1000);
        Thu, 06 Oct 2022 20:30:54 -0000
Date:   Thu, 6 Oct 2022 15:30:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 15/34] dt-bindings: pinctrl: qcom,sm8350: drop checks
 used in common TLMM
Message-ID: <166508825308.109832.795677746487823566.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-16-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:18 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
