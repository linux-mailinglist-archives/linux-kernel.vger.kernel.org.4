Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906BD688102
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjBBPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjBBPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:03:56 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013821A08;
        Thu,  2 Feb 2023 07:03:37 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id r28so1652158oiw.3;
        Thu, 02 Feb 2023 07:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eaGBuW2eiAUWLAbhvcH7sX8zp4za8aw/4jDrYwgHmCA=;
        b=lHj4tFYCjqudewVrreBSLAFExfFuQzgGYtvV/u7yvsxKcKK/kt2i+ytI8rG5um1y8H
         AqGY5dvLu4XqBPsQLslIYIECgih2E1ZBpyjgQsfxrWPkq9m+OC77MO8HWqLMPNEuSjkM
         jtFIlMxMzO2zcW/Z9srje7ozIwwz/sET31agWwczsq8mz26uUl3ElpKW8Q6aNT4oUS7I
         naz0Qh7He/59cQD5zjYFBk94loX25B2VFkuGjJ/Wfud8tZ892NOElX0m2aS9XXKiA/cV
         E+SfSWHrQyCR5hlWJ7yWkhqQBIPMfhg1WayaokAzhgoi48Yrlx/NT++5elCUfxT5WV21
         c7bg==
X-Gm-Message-State: AO0yUKUfgcavOy31aos6KuwRHEpyfVI+1d5KmKVEe+iihRZqmcRiuUJr
        G0dvS8Ool58ajiR2Hj/146G1+aIGYQ==
X-Google-Smtp-Source: AK7set/zJDHBmEsnM2EiuNQ+EOQRgpUewV4nbZTL+K+udzmJHwcrQzAad3Em6PvVUuZy6oh+DZt6ig==
X-Received: by 2002:a05:6808:221b:b0:365:367:7c7a with SMTP id bd27-20020a056808221b00b0036503677c7amr4142713oib.11.1675350216914;
        Thu, 02 Feb 2023 07:03:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g131-20020acab689000000b0036e9160f57csm8075076oif.20.2023.02.02.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:03:36 -0800 (PST)
Received: (nullmailer pid 1858082 invoked by uid 1000);
        Thu, 02 Feb 2023 15:03:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, vkoul@kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-phy@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20230202133816.4026990-3-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-3-abel.vesa@linaro.org>
Message-Id: <167535003913.1854224.16066209140007684917.robh@kernel.org>
Subject: Re: [RFC v3 2/7] dt-bindings: phy: Add qcom,snps-eusb2-repeater
 schema file
Date:   Thu, 02 Feb 2023 09:03:31 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 15:38:11 +0200, Abel Vesa wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230202133816.4026990-3-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

