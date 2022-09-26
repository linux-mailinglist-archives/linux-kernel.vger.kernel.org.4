Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E85EB278
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiIZUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIZUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:42:17 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DCAB4EC;
        Mon, 26 Sep 2022 13:42:05 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id e24-20020a05683013d800b0065be336b8feso5217499otq.8;
        Mon, 26 Sep 2022 13:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4n0zzF8za7s/qhUkEAj/8fvq00/7FWulmYmfEXglZkU=;
        b=DrTyUWwSLjZGM+YbKm2cKwF7uX1YiwETGyrX+Q3KSdpD9dVV7rVn9vxNHwvwc0luRP
         FBbW79Sg6y8vQgY/SpR5g2YHp8iWA2kZPCcptEy7fWiBjxMJ2bY+yNhjTfU86zMC8vza
         FY4iAsE9bJbal2k8hLmIpWqjo2QD4oZT5CxEl4SEfAvxWTQHH/kfxCyFJ/N/7fdntSol
         Q/g2dQu3ogejOsP9c6UgeIsn0pj++TqXdCtx6+V5dDY2d4pRKx761yabmKIl85bSkxGF
         O7Se3imnXM6ZUJeNws9A7tZvFtfIotOUF3ytctEwk8FY2usfLanO7oxGh9E+X+RzTB9u
         02sQ==
X-Gm-Message-State: ACrzQf29WDOoMSd9GPviOW4+GdlA9l+bb2Mr1nw9kTVmflavRjQmhukj
        eXtrv/noeJpi5ZxhM21unw==
X-Google-Smtp-Source: AMsMyM7UCa1J9doE98pQ4tKnf1kQISQgMn1NWxPT7w1h9o2BF9PhgS4q1DNLVv1GSX7rFWMl7G+NDA==
X-Received: by 2002:a05:6830:6b0a:b0:655:f16d:fa4b with SMTP id db10-20020a0568306b0a00b00655f16dfa4bmr11098397otb.164.1664224878723;
        Mon, 26 Sep 2022 13:41:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r65-20020acaf344000000b0034564365bf2sm7607479oih.17.2022.09.26.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:41:18 -0700 (PDT)
Received: (nullmailer pid 2773928 invoked by uid 1000);
        Mon, 26 Sep 2022 20:41:17 -0000
Date:   Mon, 26 Sep 2022 15:41:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/12] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add
 bias-bus-hold and input-enable
Message-ID: <20220926204117.GA2773872-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-9-krzysztof.kozlowski@linaro.org>
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

On Thu, 22 Sep 2022 21:56:47 +0200, Krzysztof Kozlowski wrote:
> The existing SC7280 LPASS pin controller nodes use bias-bus-hold and
> input-enable, so allow them.  Squash also blank lines for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
