Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50667D06A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjAZPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjAZPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:39:34 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458402B091;
        Thu, 26 Jan 2023 07:39:29 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id i18-20020a4a2b12000000b00510ebea37bfso274887ooa.6;
        Thu, 26 Jan 2023 07:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8OyUzZZcNDwmAtXS1x+xMHt5sX1Ua0I8k7dbZu+PLxI=;
        b=kKAvncRpc3H3GB8jyTy3UNq8AO0r5dIDe+Xn4wKy4shTvW8JEiSq8rgamRxmdqfjaE
         z2j7XWre5xqIF+Ijf+R8asIZVcNIEdlpSC66eozSvRZ8eTl2qydM4QgeOSsjzlMzvEgc
         IViDKDW2Ze1d+OkYGxvU33KE49cbvJUL8PluyovXIK91nOYKmPnFCOhmcy+f86tQSn7c
         PDuTJ6JpHaU3Bn3swdrH50Hf4K+EuJ5aBs39gup4UE5xbFdJ4zNR6KtSjsxP68Kvqh90
         yytsvP/lvMWc5WniqF+lk/hruCKgHvW34+hoJH1s369ZYNVs8abGEajL3niLBEQo/XXZ
         BYmA==
X-Gm-Message-State: AFqh2krDvgDhVchCUywnujqiWB8odV4Ly7pJiG7hyr23+RB90yw3G724
        NPzvZZrrKRmFDV1f8N+mxw==
X-Google-Smtp-Source: AMrXdXuzl12U2eZ6cBhuAvI3012MMIRRpbGZ866zX4YAmcPm4utJKeTyVgTyrj2wbI4b32brKc1sDQ==
X-Received: by 2002:a4a:d6d8:0:b0:4f2:2e05:4fe0 with SMTP id j24-20020a4ad6d8000000b004f22e054fe0mr17851159oot.4.1674747568485;
        Thu, 26 Jan 2023 07:39:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k26-20020a4ad11a000000b004f29c6fb6besm630136oor.31.2023.01.26.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:39:28 -0800 (PST)
Received: (nullmailer pid 1544999 invoked by uid 1000);
        Thu, 26 Jan 2023 15:39:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-phy@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230126135909.1624890-2-abel.vesa@linaro.org>
References: <20230126135909.1624890-1-abel.vesa@linaro.org>
 <20230126135909.1624890-2-abel.vesa@linaro.org>
Message-Id: <167474700388.1532445.1638627474554677881.robh@kernel.org>
Subject: Re: [RFC v2 1/7] dt-bindings: phy: Add qcom,snps-eusb2-repeater schema file
Date:   Thu, 26 Jan 2023 09:39:25 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 15:59:03 +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 repeater found in PM8550b.
> Add a dt-binding schema for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qcom,snps-eusb2-repeater.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.example.dtb: pmic@7: compatible:0: 'qcom,pm8550' is not one of ['qcom,pm6125', 'qcom,pm6150', 'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8841', 'qcom,pm8909', 'qcom,pm8916', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmd9635', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmm8155au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,smb2351']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.example.dtb: pmic@7: 'phy@fd00' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.example.dtb: /example-0/pmic@7: failed to match any schema with compatible: ['qcom,pm8550', 'qcom,spmi-pmic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230126135909.1624890-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

