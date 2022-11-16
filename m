Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8843162C17D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKPOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKPOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:55:39 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D41163;
        Wed, 16 Nov 2022 06:55:34 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r76so18708072oie.13;
        Wed, 16 Nov 2022 06:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k52RsIpzmIjTbZWyy00dgymBBcd65eObrR5Yxdag1M=;
        b=rJBbZhKeQgNJPfy4SygCeT63cyc5Y1HAVKmrG4ZzgmrKWPn1g+qyR3ufgAsSWmp+go
         UDq8EwtBUjO8/qDfPYnryVzfspFJEVbjX38KLX04pFSQ+kU7TzY7n2nQYjq8/v9jALaW
         x4wspu3KHCvfstQPgFt1C6TdhVPfJ6+sqh6mnmRUtBKHXnKhBCRtclhDmUEMF4zD7FO/
         ErwFamhQ7p3D2N34JFrkdixA5fpLeiov7LgCxlIfoKorJN7xWNUR8Hf/AVXvI4vapZnX
         SiWfsrTYhGb0Xvd4pcEwLm7d4EQ5KAWEM/FwZnaHqhvnXsCp3ZOKZAz6gZ40qHKiM3L5
         eH4w==
X-Gm-Message-State: ANoB5pndhRMFAxptbASkgjm7FmFVr7mLIe4x+0izNwY4DEPDWHDIwAGo
        14veuuSJcnoBEwldVKUORA==
X-Google-Smtp-Source: AA0mqf4m1imWn+Vx90xbRU3LajAp2Wwgdv5+qbG6dWiLmAoZvRNxUkQS+t7NODLtlefTWzNnPKfKcQ==
X-Received: by 2002:aca:e082:0:b0:35a:4069:85d8 with SMTP id x124-20020acae082000000b0035a406985d8mr1821869oig.101.1668610534178;
        Wed, 16 Nov 2022 06:55:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n10-20020a4ac70a000000b0049f07909c5fsm6141421ooq.3.2022.11.16.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:55:33 -0800 (PST)
Received: (nullmailer pid 3837304 invoked by uid 1000);
        Wed, 16 Nov 2022 14:55:35 -0000
Date:   Wed, 16 Nov 2022 08:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-arm-msm@vger.kernel.org, quic_plai@quicinc.com,
        quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 09/11] ASoC: dt-bindings: qcom,q6core: Split to
 separate schema
Message-ID: <166861053490.3837248.6746478589858183717.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:33 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the
> Q6Core service to its own binding.  Previously the compatible was
> documented in qcom,apr.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/sound/qcom,q6core.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
