Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF55F6608
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiJFM2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJFM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:28:00 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754AD26CB;
        Thu,  6 Oct 2022 05:27:59 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w70so1844367oie.2;
        Thu, 06 Oct 2022 05:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/qMcI83/+cvVNEmTgwYayNkACvWt97Gapu8NRbXz6w=;
        b=byzFjmyhwm0skP4u1eDtYo1U6UO4kbkUxPfQQOCdkWzAre5yT6/Ps3c8ILaRl+Dy3Z
         jvzmVBEdqsVmV5NCmEj37q9XdFcxBdGl/gJLdXglZihMhjMJtPEapI6WVjymhEQjN+cM
         Nggh/iiEv7SLhQ061TDPWnBJ4P+hK/uVtpEhAO6a+m/OY47SCgz2MbQFUthD/YV6A5sH
         bCubCObw9yShEwMaDUImHoOe5f2eo/xwH8YWRsXulG92i4ykEYqArgCtDL0M0mnIrW0L
         T83qMeYXjPSsq6wv8lKJTgzKQqwDQGRWB7lycLveJOyQCuZYfrcTTd5qq9g1pmRRFFRD
         2www==
X-Gm-Message-State: ACrzQf2WjG7FTXqaTXm6DiwE2L9varHJqABVhFkYrUM2Nk1gOHyZiQ/9
        hqptNb1UsfvcSu7J6MrzQA==
X-Google-Smtp-Source: AMsMyM7H+i6e9zG8qzhT3jdngZaC60x0QVGMBtaSwrDy8lqyPfrleCbv2O8B/+BF8yxZhK6JQOkbtg==
X-Received: by 2002:a05:6808:e8e:b0:353:eff5:f4a6 with SMTP id k14-20020a0568080e8e00b00353eff5f4a6mr4605186oil.98.1665059278752;
        Thu, 06 Oct 2022 05:27:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a544f02000000b003436fa2c23bsm2951500oiy.7.2022.10.06.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:27:57 -0700 (PDT)
Received: (nullmailer pid 1613453 invoked by uid 1000);
        Thu, 06 Oct 2022 12:27:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-5-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org> <20221005-mdm9615-pinctrl-yaml-v1-5-0cbc006e2a30@linaro.org>
Message-Id: <166505883074.1602650.1580325629975634757.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
Date:   Thu, 06 Oct 2022 07:27:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 09:58:02 +0000, Neil Armstrong wrote:
> Convert the non-SMD Regulators  bindings to dt-schema and remove the
> old text based bindings now we have migrated all the content.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 246 ---------------------
>  .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++
>  2 files changed, 127 insertions(+), 246 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pm8058-regulators: vdd_ncp-supply: [[30]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

pm8901-regulators: lvs0_in-supply: [[8]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

pm8901-regulators: lvs1_in-supply: [[29]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

pm8901-regulators: lvs2_in-supply: [[10]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

pm8901-regulators: lvs3_in-supply: [[31]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

pm8901-regulators: mvs_in-supply: [[8]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb

regulators: vdd_ncp-supply: [[10]] is not of type 'object'
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

regulators: vdd_ncp-supply: [[50]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb

regulators: vin_ncp-supply: [[48]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

