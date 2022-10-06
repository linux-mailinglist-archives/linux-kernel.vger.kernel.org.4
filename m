Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA45F6F25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiJFU2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiJFU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:28:16 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47472BEADF;
        Thu,  6 Oct 2022 13:28:11 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id s192so3344409oie.3;
        Thu, 06 Oct 2022 13:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/p6Lh33TNDomwnPtEt0K+Q9z2znn41mK/BcoE/gVzU=;
        b=zgOxi1Ciz9Q7QgkN1CAzqMd/d9QS6/RN5KrgCORD958kNif/Uo5XajDLVT834pzpzE
         AiHlEHt2XK14wSmPTHrYFTH01pQHEew+TpQMAy0ZLlo0cJeKCZwhXqHIiqD4QIOSSK3T
         XM9XnqqvcoDmwmmjaGYHPVGJQLtHF5ul4U/fq5VkFhBzJmHDpSKCBYAvwa99ni69g6P2
         k623Yh09mlF3g61j7U0f/WYYxdGzj8SaY6Y///4aY3OnSG7iICOIZZpW8fLof0D5+plj
         bAQJtxiwpJjlMyI7JRVYP7q75qLd8VjVEmcOqHvw+bUtBvKWBPxMTHBrOP+0G5nxOinZ
         XwLw==
X-Gm-Message-State: ACrzQf3WaJgg/5Lc3ZPoXQc5bfskWsPuMl0e1mxzad8TiI+IyJI9gUnm
        GZSD/xRV4rRc5DwmGBVasQ==
X-Google-Smtp-Source: AMsMyM4ngNRHK4in8EuO6Kr1puRTrTx2AG6P2hT/ki4H3omHFTjTYRdbY5gGnWaRXZqTv6vtK4odtg==
X-Received: by 2002:a05:6808:11c6:b0:34d:8fb3:65b1 with SMTP id p6-20020a05680811c600b0034d8fb365b1mr747833oiv.29.1665088089556;
        Thu, 06 Oct 2022 13:28:09 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id a25-20020a056870a19900b0012c52bd4369sm341239oaf.19.2022.10.06.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:28:09 -0700 (PDT)
Received: (nullmailer pid 107638 invoked by uid 1000);
        Thu, 06 Oct 2022 20:28:07 -0000
Date:   Thu, 6 Oct 2022 15:28:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Martin Botka <martin.botka@somainline.org>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: Re: [PATCH 14/34] dt-bindings: pinctrl: qcom,sm8350: drop ref to
 pinctrl.yaml
Message-ID: <166508808666.107592.14738999784946358386.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:17 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml         | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
