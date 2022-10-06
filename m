Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F905F660B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJFM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJFM2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:28:11 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCB0A0259;
        Thu,  6 Oct 2022 05:28:08 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id v134so1801836oie.10;
        Thu, 06 Oct 2022 05:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie2NVaibuJVOQuIOjeuf0bg2Uj2OCg4BSeKdkXj8/qE=;
        b=Q0QnV20rMXb3zHWI5NmLFjkIHlPBdiayEbUt9KChlI8Z5z2kfB4VG3kp1dwTz7uXYs
         58U8ZjA2rMqtZ/rUemRAPmxeMgKG6Xx7vWk3q8zo4l1ArmXSabKfX9PzIBQdpaML0IxF
         zqIEiMAVnPmeICF6073MaAXOkY6lkq/aLurJ5yJuBQbbYk8vvn0RF+dElRw5/omujuak
         JSTOkmU3l15o+814By/9Jwh8JL/xO8n3FgKIDUMLTk8MJ1KvPs4WMc2G36fTxr7LQYeG
         qvvck6lj8/MOdeuz0Ig46IEUR7AtJahoihkVfwU3Ho1Fr6Y1ikyDHaPfZYS8D1a5mgOr
         grXw==
X-Gm-Message-State: ACrzQf0URPcamhWQKdWGTm7NDY5LLR+9hP4YHjKye+ekvaBGD83NqyuC
        VJpAx/1KfTRkm2DYMpJLYF/oHIQuSQ==
X-Google-Smtp-Source: AMsMyM4nYeOID395+fMyqW4zTjfssuMAcg2266RidlXN1+HuyB61zkhBpt6VKV7/LUttUI8UcGRV/A==
X-Received: by 2002:a05:6808:1704:b0:351:43bc:5e52 with SMTP id bc4-20020a056808170400b0035143bc5e52mr4675081oib.107.1665059287689;
        Thu, 06 Oct 2022 05:28:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a056870708d00b0012779ba00fesm2131618oae.2.2022.10.06.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:28:07 -0700 (PDT)
Received: (nullmailer pid 1613455 invoked by uid 1000);
        Thu, 06 Oct 2022 12:27:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Andy Gross <agross@kernel.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-6-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org> <20221005-mdm9615-pinctrl-yaml-v1-6-0cbc006e2a30@linaro.org>
Message-Id: <166505883191.1602730.12398385623531260133.robh@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: soc: qcom: ipc-rpm: refer to qcom,ipc-rpm-regulator.yaml
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

On Thu, 06 Oct 2022 09:58:03 +0000, Neil Armstrong wrote:
> Now we have bindings for the expected regulators subnode, refer
> to the right qcom,ipc-rpm-regulator.yaml bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


rpm@104000: 'clock-controller', 'clock-names', 'clocks', 'pm8058-regulators', 'pm8901-regulators' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

rpm@108000: 'clock-controller', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

rpm@108000: 'clock-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

rpm@108000: regulators:vdd_ncp-supply: [[10]] is not of type 'object'
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

rpm@108000: regulators:vdd_ncp-supply: [[50]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb

rpm@108000: regulators:vin_ncp-supply: [[48]] is not of type 'object'
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

