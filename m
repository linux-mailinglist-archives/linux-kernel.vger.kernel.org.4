Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802775F660A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJFM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJFM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:28:09 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110A9F77C;
        Thu,  6 Oct 2022 05:28:06 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so1944045fac.11;
        Thu, 06 Oct 2022 05:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeL65/1U1Hoy7jWDjnXqoxK2kF0UFfaCh7UYp4Dp3Jw=;
        b=MCQyBSNDPwfe9vUn5cZe3b2R9toow5xR+OmGLZzhYFD7ORU4ZYq8MDJtMV1CKcVtV/
         FQ+pIix13QgpR/w42+QBpwQQbhoui1aLKGiQDxXY2qoBBJxvqpQnEGvr6sune9FL/1mM
         AGrmDqakpIZqHCh6148FJaVDpkHMR8FDCzgQVXe/S+HHGB5NaQEbVOrRUw4GgNo2art4
         7NrRmt6Oe/zn+TKo2y3w4VKAtRFvmcmtN0YTV6VFeRnDLfxvK9XQGlrqe4v0ZgutDTOf
         /TLk3+NErFgNMzpPgoEdj+8E14Aa8WGbQIzBSVC8JsnRON3qu5qhJCMJUQkxUNqG1poE
         oG6w==
X-Gm-Message-State: ACrzQf3Tg6EUDq2Mj3kQhfZDbYhEjcciibbc9pnO+yFO5VQIn4PrHicQ
        jVv1zxcN3ROHIijXyphrb+dvO9sitQ==
X-Google-Smtp-Source: AMsMyM421KNMgt8ANf2A8dt0mXutgzLVqwXNndxnN0wF7DyhRhAJBbWhiyC15nLv4JoNw2feAeaiDw==
X-Received: by 2002:a05:6870:3415:b0:133:197:3ca3 with SMTP id g21-20020a056870341500b0013301973ca3mr2093291oah.115.1665059286233;
        Thu, 06 Oct 2022 05:28:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cy21-20020a056830699500b00660ef042e17sm1575995otb.12.2022.10.06.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:28:01 -0700 (PDT)
Received: (nullmailer pid 1613457 invoked by uid 1000);
        Thu, 06 Oct 2022 12:27:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20221006104104.171368-4-krzysztof.kozlowski@linaro.org>
References: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org> <20221006104104.171368-4-krzysztof.kozlowski@linaro.org>
Message-Id: <166505883313.1602848.6191967643505476092.robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: pinctrl: qcom,sdm630: convert to dtschema
Date:   Thu, 06 Oct 2022 07:27:55 -0500
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

On Thu, 06 Oct 2022 12:41:04 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SDM630 and SDM660 pin controller bindings to DT schema.
> Keep the parsing of pin configuration subnodes consistent with other
> Qualcomm schemas (children named with '-state' suffix, their children
> with '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml | 189 +++++++++++++++++
>  .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 191 ------------------
>  2 files changed, 189 insertions(+), 191 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pinctrl@3100000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp2-uart1-active', 'blsp2-uart1-sleep', 'cam-vdig-default', 'cci0_default', 'cci1_default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'i2c7-default', 'i2c7-sleep', 'i2c8-default', 'i2c8-sleep', 'imx219-vana-default', 'imx300-vana-default', 'sdc1-off', 'sdc1-on', 'sdc2-off', 'sdc2-on', 'ts-int-active', 'ts-lcd-id-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb

pinctrl@3100000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp2-uart1-active', 'blsp2-uart1-sleep', 'cci0_default', 'cci1_default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'i2c7-default', 'i2c7-sleep', 'i2c8-default', 'i2c8-sleep', 'sdc1-off', 'sdc1-on', 'sdc2-off', 'sdc2-on' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

