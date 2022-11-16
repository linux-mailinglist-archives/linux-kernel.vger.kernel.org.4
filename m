Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C562C292
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiKPP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiKPP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:29:26 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC013F1B;
        Wed, 16 Nov 2022 07:29:25 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso20405831fac.13;
        Wed, 16 Nov 2022 07:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XPzMQJE0sIInrmJgvIUaGCOnQHQglKZ2xgPC26zj0FM=;
        b=32too+zWllgn++nYu+Vt3C6rYb3saEYWF3cK3g9hBwtPI/cyg++FJnCfHuB5/SEwf3
         hh7d29xm0sqyEAzyP3lN/HiEgG3obn9W/5usP9YUttoD+D3XAOBzTv2MwQnXLmYBqrpp
         d9ZWUFw1Gj3bD9ki01bhjlPiCix8xEMiT63UK0zVBXUGts2omdJsGvDBgUoM/sYeCIe1
         9lymaLWukjOU9webVvB8Fa+qtVHhpIl+mYGhBRSE6CxPkSYzdU2ALtreI2RBwfp5gbuM
         gCXd1BXcn6wJ08H/STlJ1Jgb8FYVzWctRxk9FDERPCJSzZdMi3CCpMKO/RJiir8o95WG
         TGUA==
X-Gm-Message-State: ANoB5pm+svmjRdRv6CdmyppzDh8OggOItWF0CwyrymRiaGPB/Ham+FEm
        0s3/9Q5A6pTdrNKpwnpMwg==
X-Google-Smtp-Source: AA0mqf5WtlQBm6tGUxpRuJD+A87MvWsxy0LPjPhNylxH3rll3lgbTL4A8p0bL4mc8zLXTg9ySeG0ag==
X-Received: by 2002:a05:6870:b529:b0:13b:d2ae:ee0e with SMTP id v41-20020a056870b52900b0013bd2aeee0emr2039111oap.19.1668612564707;
        Wed, 16 Nov 2022 07:29:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t37-20020a056870f22500b0013d6d924995sm8178831oao.19.2022.11.16.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:29:24 -0800 (PST)
Received: (nullmailer pid 4083494 invoked by uid 1000);
        Wed, 16 Nov 2022 15:29:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-scsi@vger.kernel.org
In-Reply-To: <20221116123019.2753230-3-abel.vesa@linaro.org>
References: <20221116123019.2753230-1-abel.vesa@linaro.org>
 <20221116123019.2753230-3-abel.vesa@linaro.org>
Message-Id: <166861225059.4037759.2587193031779915176.robh@kernel.org>
Subject: Re: [RFC PATCH 2/3] dt-bindings: usb: Add qcom,snps-eusb2-repeater schema
Date:   Wed, 16 Nov 2022 09:29:23 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 14:30:18 +0200, Abel Vesa wrote:
> Add dt-binding schema for the Qualcomm SNPS eUSB2 repeater.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../usb/qcom,snps-eusb2-repeater.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,snps-eusb2-repeater.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,snps-eusb2-repeater.example.dtb: pmic@7: compatible:0: 'qcom,pm8550' is not one of ['qcom,pm6150', 'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8841', 'qcom,pm8909', 'qcom,pm8916', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmd9635', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmm8155au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,smb2351']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,snps-eusb2-repeater.example.dtb: pmic@7: 'usb-repeater@fd00' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'extcon@[0-9a-f]+$', 'gpio(s)?@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$', 'pwm@[0-9a-f]+$'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
Documentation/devicetree/bindings/usb/qcom,snps-eusb2-repeater.example.dtb:0:0: /example-0/pmic@7: failed to match any schema with compatible: ['qcom,pm8550', 'qcom,spmi-pmic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

