Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB762C119
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiKPOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiKPOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:39:54 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A1391EE;
        Wed, 16 Nov 2022 06:39:53 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id q186so18668049oia.9;
        Wed, 16 Nov 2022 06:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9UXnbSoKhr6B7CgP63atJ18eZu6ZT1APvR95IW+ans=;
        b=xJxsteN2fgcX7CKuYAhxoGQNxZbeLNCJMbvS9DJ7CsYHcThedH2xhQO4ss0nkzMG9r
         lZjGQnNDFb8spdyl6Vp1dpEn+6JFpExt4EiqiUhEQchMd9kUd20ShyzgeHsrAo/KUsZY
         a8HzjXfIUJWprPOIf/F0X7/RbgNjkdVkN2f5qjyVElm9DEN4uLFKGnsRzbmMSwPnBkiF
         kTsPUMGonbx2NerR3IBWqTnkOVtqDVgKMCYW/6trP9x8Gq+Ohyj6ibp99bK9LRPQa6Y4
         NIQCmTS3SA929jvXMSWXbxWE9LQPMNKcuvV209pFLSwxr+DFweQ6Ho1IdiKW+uNNTwEO
         C2Zw==
X-Gm-Message-State: ANoB5plwiYR0QyiGjt3s+2lT98VMKzyChtMfvS/B8K4yKqXqWHYYPIlR
        NlicCe+EVKWSNsatRRG0+g==
X-Google-Smtp-Source: AA0mqf4T7Fo/pti2o4JPr1i2O1m/JYwIz+DCgvmPSrrQefb0jUu3FeWGi8/7WtA320N6H+Sqw2v/ew==
X-Received: by 2002:aca:3f43:0:b0:35a:8a2b:e901 with SMTP id m64-20020aca3f43000000b0035a8a2be901mr1789982oia.249.1668609593171;
        Wed, 16 Nov 2022 06:39:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w23-20020a056830145700b0066c7733be43sm6594248otp.30.2022.11.16.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:39:52 -0800 (PST)
Received: (nullmailer pid 3818195 invoked by uid 1000);
        Wed, 16 Nov 2022 14:39:54 -0000
Date:   Wed, 16 Nov 2022 08:39:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, quic_plai@quicinc.com,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: dt-bindings: qcom,q6apm: Split to
 separate schema
Message-ID: <166860959282.3818114.17932974394029745059.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:29 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6APM
> service to its own binding.  Previously the compatible was documented in
> qcom,apr.yaml.  Move most of the examples from its children to this new
> file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/sound/qcom,q6apm-dai.yaml        | 19 ++-----
>  .../devicetree/bindings/sound/qcom,q6apm.yaml | 51 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
