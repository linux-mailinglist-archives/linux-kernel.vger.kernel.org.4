Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B425B8D73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:47:15 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4D54679;
        Wed, 14 Sep 2022 09:47:14 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso10748122otv.1;
        Wed, 14 Sep 2022 09:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nx/BhNRVvudK8AcmKzKEeABUr5hW6bgb4H8HtATz2WQ=;
        b=wpmLLqihBK6toKLWFgPNlUmjQ3klv4/QU+hUlVlol6ZSpyxLEqwDoZ0uszdWAFWCA7
         D3U7p7/MxAPl2QDRMTio3XNXRitXN1smmAJwL1mI9DpbNqVJgMwig3PffI4WTrAncq3K
         E9U3LUK6DHaAECf93h1+zpLoyQEGRt7mVr3I9pQFmtQOtWCEUWuJAFZSAncB1QnMZDjU
         MWsctbNiY/drdSsxK79A/0RiNkRELAjFc58nuHDKoRIwTApapT3hC5CWPcFTw0GVhw+7
         exn9tPF0V4/QMpL6deISXSO6kX7l00IZVWiJ+HE2Px7iGpy7CCFK9bqeFFM1Eadg1WHA
         pzxA==
X-Gm-Message-State: ACgBeo1C5H7z23gtU1tuX7LBmrirHcrOceEuMRZsV2FpDq+lQKcGjxmg
        5+o8WXttvZcMBxH8s11ALA==
X-Google-Smtp-Source: AA6agR6yzCen2kN8Qy5hZq0jlsU9pT9nwfGysXG1l71aovpSGsOPJSAUTVM/roXXrQ+4DRroEyF2Sg==
X-Received: by 2002:a9d:6398:0:b0:655:fffc:cd2f with SMTP id w24-20020a9d6398000000b00655fffccd2fmr5149066otk.179.1663174033521;
        Wed, 14 Sep 2022 09:47:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k19-20020a4abd93000000b004357ccfc8bfsm6784458oop.7.2022.09.14.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:47:12 -0700 (PDT)
Received: (nullmailer pid 2567037 invoked by uid 1000);
        Wed, 14 Sep 2022 16:47:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, linux-clk@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marc Herbert <marc.herbert@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Justin Tee <justin.tee@broadcom.com>,
        devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20220914142256.28775-4-ansuelsmth@gmail.com>
References: <20220914142256.28775-1-ansuelsmth@gmail.com> <20220914142256.28775-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Wed, 14 Sep 2022 11:47:10 -0500
Message-Id: <1663174030.732936.2567036.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 16:22:54 +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


clock-controller@2011000: clock-names: False schema does not allow ['pll8_vote', 'pxo']
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: 'clock-output-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2082000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

