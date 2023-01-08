Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE55B661927
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjAHUNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjAHUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:13:26 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B9C67;
        Sun,  8 Jan 2023 12:13:25 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id u8so3975155ilg.0;
        Sun, 08 Jan 2023 12:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ekCum+mkWklgiFQqDiLnxNkjMJuXkERlOwwi6tiZmE=;
        b=Ai1HNblA3ChOPsel3Zl3FRw2jGxaGBYOVKlx9YUBJFKt5Q/f9tY4iCCSD0CQbDKY/S
         lYisBKoMefVYOfieh3I+/IYQ72tnFgPMKF+DoGuhTZepB+fj+YtaMzeMrB/IlpsDAFLN
         D9RcDLnOXRMUunFfz6vrJAbUJ31mONBLRhG65FBMeDi5gsJqS8NJ+M8IhgxdNMd+MmgO
         MxETJZBJaYc5DQWdPHYhq98GEJsHTLo+xJw+Fh2MjOV6GykcK3JOBCX+LTZSMMW2mnkc
         ZQeLCcudFjwjsd0HqCbRJtH0IBEw1B41AJ507trLbouWMVcVNqei8uuPcy7180PemA5J
         FYFw==
X-Gm-Message-State: AFqh2krMpCKwFa930vXpb5RWm2vSwpTPPFnP6ZEjUV+HSkz1MxJK8Bak
        E+sjVwKSThfmPZGiEiJBcA==
X-Google-Smtp-Source: AMrXdXswrCacsXxRQuZMa8mL08hl/Jp+IGjRRL0QTYlwrxB+aANNp8aJEwSO4wN9jNSOt3O346Cpyw==
X-Received: by 2002:a92:c528:0:b0:30b:e320:a6f9 with SMTP id m8-20020a92c528000000b0030be320a6f9mr55921532ili.14.1673208804682;
        Sun, 08 Jan 2023 12:13:24 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id j2-20020a026302000000b0038a48cfededsm2197991jac.15.2023.01.08.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:13:24 -0800 (PST)
Received: (nullmailer pid 218636 invoked by uid 1000);
        Sun, 08 Jan 2023 20:13:20 -0000
Date:   Sun, 8 Jan 2023 14:13:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Bjorn Andersson <andersson@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 7/9] dt-bindings: pinctrl: qcom: allow nine interrupts on
 SM6350
Message-ID: <167320880013.218579.14734007153028250420.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:43 +0100, Krzysztof Kozlowski wrote:
> Almost all Qualcomm SoC Top Level Mode Multiplexers come with only
> summary interrupt.  SM6350 is different because downstream and upstream
> DTS have nine of the interrupts.  Allow such variation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml      |  4 +++-
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml      |  4 +++-
>  .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml   |  4 +++-
>  .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml      |  4 +++-
>  .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml      |  4 +++-
>  .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml     |  4 +++-
>  .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml     |  4 +++-
>  .../bindings/pinctrl/qcom,sdx65-tlmm.yaml        |  4 +++-
>  .../bindings/pinctrl/qcom,sm6115-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,sm6125-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,sm6350-tlmm.yaml       | 16 ++++++++++++++--
>  .../bindings/pinctrl/qcom,sm6375-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml    |  4 +++-
>  .../bindings/pinctrl/qcom,sm8350-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,sm8450-tlmm.yaml       |  4 +++-
>  .../bindings/pinctrl/qcom,tlmm-common.yaml       |  5 +++--
>  34 files changed, 113 insertions(+), 36 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
