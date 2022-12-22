Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0F654765
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLVUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiLVUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:39:57 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF024977;
        Thu, 22 Dec 2022 12:39:34 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1322d768ba7so3828031fac.5;
        Thu, 22 Dec 2022 12:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpT8R1Rv+Nm5XIJthL+2JjEda6upkRaZYMhbehQvjd8=;
        b=CZ46ljM1ZFaE0Dk6EFsq0LucUk3sYTbkAKu562F+EkqLG6XAqKUeywq2dR2hUH6QCt
         Gi1V66oNHfhKJJ5qJi8Dcb+GVBB0yWIVu+wKTg1e3Ew0Yo+hr1bfdDVI0/wnIJMidQ3S
         px40RHlDdgCUyVc9uI/q1ZtoFVTlKMdQ4s1DEgdXerK+eHDhyPNHgT06220/1UOXD/Cz
         u3JEg3zutRR/qSVc39uHJJD86eb76upEXry//lCbesU5wc/s6nVjgzIFjl6zlCiCNaY2
         fJ5ams87cSxKkok70WCn4FfCuew4Dgyn/toUrH6dqVf3t1yz4etmFRqZt1J/6AS0REDn
         6lpg==
X-Gm-Message-State: AFqh2kqHE7uElL3YMhij393vIrbOHu2v9qd0eQA8SXZ0VxYY1dQo/1X2
        lI5Gtnzd4PgIS7Ilcq82hw==
X-Google-Smtp-Source: AMrXdXuxMOhZ9CB4M20W0IRTPaF1HVPtXYoHPVef1+Ha2t5/a0xpc0Vt0pNC5vAIaFdy1xWar3bFNw==
X-Received: by 2002:a05:6870:815:b0:143:be53:bc15 with SMTP id fw21-20020a056870081500b00143be53bc15mr3452785oab.17.1671741573613;
        Thu, 22 Dec 2022 12:39:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r42-20020a05687108aa00b0013669485016sm708870oaq.37.2022.12.22.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:39:33 -0800 (PST)
Received: (nullmailer pid 2080731 invoked by uid 1000);
        Thu, 22 Dec 2022 20:39:32 -0000
Date:   Thu, 22 Dec 2022 14:39:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: add
 input-enable and bias-bus-hold
Message-ID: <167174157218.2080693.3036143873208701568.robh@kernel.org>
References: <20221222161420.172824-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222161420.172824-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 17:14:20 +0100, Krzysztof Kozlowski wrote:
> Allow bias-bus-hold and input-enable properties (already used in SM8450):
> 
>   sm8450-qrd.dtb: pinctrl@3440000: dmic02-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'input-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Compact the properties which are just set to true for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add input-enable.
> ---
>  .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
