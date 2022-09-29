Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A225EFE85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiI2URt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI2URq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:17:46 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7957D14C073;
        Thu, 29 Sep 2022 13:17:46 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131886d366cso3131975fac.10;
        Thu, 29 Sep 2022 13:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IVA+NrMANs4JcKoWxiGjDSoZB/KJJG5M2ElGXAEd1LQ=;
        b=BDMWSj+7x6siv1+ejEfvi2SaQPvYV9DtSQGgROb55Zvf6l5ODcjChhw/5RTww0w7F5
         1QSUFhgBPN2GVAU0CgC/qNE90szofIXND6qM7sMS2S9Uop6Q1lCana7MLd/dfmGcvtzX
         zeYU1cKbl38HrseF1GwqkRwYkSZEWwrV58d55zQ5SXd7XtG5cVkJJTLhtlUdBiNuFysL
         IiBjFAZhe1CedAKkuG52YnaT1Q5yk1SAp8+mbcCvn5MCfdjuz31ANyb5iJWvHCuvjl9v
         yzKEzAqPMhRxM3g7U0xVsZvuk+UsE8N61Jnb4CkWKc1nfQTUR3OC98hPrYY5n52axv7z
         k3GA==
X-Gm-Message-State: ACrzQf2QzAcSyl9jNRgS3Kz2+b89sV4K5fuuDPNini2zNNs8RDvI29TH
        m/zswDvmBR9NX9am2P6glQ==
X-Google-Smtp-Source: AMsMyM5hetl0HHDC2qK6ExH1+h4F7f6dnhMO81xHxrvx3iFO5iw/K+DsIgpZIaC0Sw6VbUCwoC2ioA==
X-Received: by 2002:a05:6870:ac0f:b0:127:c036:d61c with SMTP id kw15-20020a056870ac0f00b00127c036d61cmr2825034oab.278.1664482665739;
        Thu, 29 Sep 2022 13:17:45 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x93-20020a9d20e6000000b00657865c9827sm149014ota.46.2022.09.29.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:17:45 -0700 (PDT)
Received: (nullmailer pid 2668356 invoked by uid 1000);
        Thu, 29 Sep 2022 20:17:44 -0000
Date:   Thu, 29 Sep 2022 15:17:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 15/15] dt-bindings: pinctrl: qcom,sc7280: correct number
 of GPIOs
Message-ID: <166448266385.2668307.7265164290114312879.robh@kernel.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925110608.145728-16-krzysztof.kozlowski@linaro.org>
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

On Sun, 25 Sep 2022 13:06:08 +0200, Krzysztof Kozlowski wrote:
> SC7280 has 175 GPIOs (gpio0-174), so correct size of gpio-line-names and
> narrow the pattern for matching pin names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
