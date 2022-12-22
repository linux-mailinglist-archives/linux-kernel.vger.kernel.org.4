Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7D65475D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLVUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiLVUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:39:52 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3862127D;
        Thu, 22 Dec 2022 12:39:22 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id s186so2937226oia.5;
        Thu, 22 Dec 2022 12:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki4lwTscVS3IlU5RYPxIYPK7qzH6rEJ04zLCGk6yM9I=;
        b=cxAgTZCYCM8tX+pqDaZGN+MpAYR9dTAhtVQOOEgoCaFT6xeFD7ffev/rp+zjFi3yzU
         BDwUgD8ak08y2+YPESbybh7VVLa0/kRYlTkpAgRl1TDrmgIowq7PoFM8O/PTIIXp8iDk
         YNrIDxMxwG2/qqDh70GZAEv3IZquCFdTxUqvipk6egceDAE3FeuT056NkWXn7yqlhxz/
         Zmrqtthesc5SMtJmXldi2UDqRabj6Lumfj3a8QO44Zqm4rNPhqwCK5mx5JqHtEltO8/p
         UaSyA62zmi5InRhacrGxBZQyLd8PKpg56fQEpdhdwzG3k21eGsVwWwatZJvjLf2Q9foo
         4lYw==
X-Gm-Message-State: AFqh2kq9S6V8E0WiQSOvMHQ1/4g2Njk/BjjUPQo5Bz+LhYzidGJBYLPM
        qrDq5GwgjDrUFwLxgNLL3Q==
X-Google-Smtp-Source: AMrXdXtAKjbq03CllV3FpbA38j1VmE/4ngJUNggs3tcvxO36cZnkkTuPeW6YxIGsyLOsqP9ap1Cbdg==
X-Received: by 2002:a05:6808:2103:b0:361:273b:36b3 with SMTP id r3-20020a056808210300b00361273b36b3mr3937355oiw.28.1671741561474;
        Thu, 22 Dec 2022 12:39:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r14-20020a056808210e00b0035c073aa0d8sm744301oiw.18.2022.12.22.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:39:21 -0800 (PST)
Received: (nullmailer pid 2080415 invoked by uid 1000);
        Thu, 22 Dec 2022 20:39:20 -0000
Date:   Thu, 22 Dec 2022 14:39:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: add
 bias-bus-hold
Message-ID: <167174155991.2080357.3312622066668105315.robh@kernel.org>
References: <20221222160904.172070-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222160904.172070-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 17:09:04 +0100, Krzysztof Kozlowski wrote:
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
> ---
>  .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml      | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
