Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317668A5F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjBCWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjBCWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:17:22 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08264422F;
        Fri,  3 Feb 2023 14:17:22 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso643743ooo.2;
        Fri, 03 Feb 2023 14:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdFFG6e5zNezpTNwM1PWxAH3sXZ/je+CCAaVRvk1p70=;
        b=CsieBoqrDK4D0AsPd/Zic2vFJMLy5in1ULR56ORaEYdYsO2xqQOnlAmQm9P5bytDz7
         txMhqW0cfiLN1x8l10JgI4VfRzU+dMmcjfGgtFRNynb84jYYqp4hTXx1SxaUmJCXYNLR
         lU5FDArxiBMHNhwz//Ctq/C5xgAS3Kk3IFJJTgy7JMGI1U3XQE05VBlx0FSQ0cbt4HpH
         My8smTw7x1FI8drwt0GCPxSEZ95NbXX4CnLqv+mAD+KbudEqBLdKXw7QK+D86iVnd8mu
         WppLcTa0f1WTCoJSJd7rnnj99bUN7mtweGn2EA4khf9OIU49DjsmU6qGMJnf35nZtywB
         M/Hg==
X-Gm-Message-State: AO0yUKU7z5p7pXXz9qHFqRs538VDm1NoLxI8vHj73zAYVItWoZrP2jhE
        tgHKjSBY3POspAdrkyanTcvOGWTBrg==
X-Google-Smtp-Source: AK7set87z37xGexqfLG5lR7TRSaSTGORyFmZm2NQM/4Df/URUIo/9Ux5PMhDFkcKgEP5sWackw5Xtg==
X-Received: by 2002:a4a:bd16:0:b0:514:d8f0:45b0 with SMTP id n22-20020a4abd16000000b00514d8f045b0mr6009542oop.2.1675462641237;
        Fri, 03 Feb 2023 14:17:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c20-20020a4a4f14000000b0051a4b0ab2d0sm1408214oob.28.2023.02.03.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:17:20 -0800 (PST)
Received: (nullmailer pid 971676 invoked by uid 1000);
        Fri, 03 Feb 2023 22:17:19 -0000
Date:   Fri, 3 Feb 2023 16:17:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: correct
 GPIO name pattern
Message-ID: <20230203221719.GA962810-robh@kernel.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
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

On Fri, Feb 03, 2023 at 05:48:50PM +0100, Krzysztof Kozlowski wrote:
> The SC7280 LPASS pin controller has GPIOs 0-14, so narrow the pattern of
> possible GPIO names.

There's really no reason to split this up into a bunch on 1 line 
patches. They all go to the same place and get reviewed by the same 
people.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
