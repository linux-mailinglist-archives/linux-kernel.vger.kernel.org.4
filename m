Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16715B8D75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiINQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiINQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:47:17 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333D54679;
        Wed, 14 Sep 2022 09:47:15 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1225219ee46so42585936fac.2;
        Wed, 14 Sep 2022 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=J9v0TxzceA4IzgSQn1QFwOODoXlLwoXp7shQjhzCcwg=;
        b=Xp7B8ydWlzMOqG/LoGptTP28WXeAASQAWDOhCq6OC3fezKDIsG6vc0Bhvy/k+zPO2w
         oqnT6qIfLsYNLGj8bm0OMeAyyeE5EDvpyWRoENumiKimsW/iq5jkYT/oLKHFWQmAiQl+
         wB61Nl0Mer44/pEk45Gv74rV710ZeDcw+ZmyWg8IJrQZywAkam4kydlk83EOWKfY4GJR
         gf+JJnCLXodH80CUgILKN+OLKX5K4EAdz3ZHw3zLrdsNHBmCV0JQ3ogtb2cNtu8GGKFL
         ir7rKu22tinaQheydHyVcAwqLg2K4HMiZgRyl4NGla3WvEktx4WIQUP5GYBjDF/amvf/
         JGBQ==
X-Gm-Message-State: ACgBeo15owNS3yyxTN2+Sz+eepEsOW3t+o6wajdJe1S0jmMkU5/+wpX7
        CsJeiGajpDctCGX+3vKhwA==
X-Google-Smtp-Source: AA6agR5B5ZOXcJewGyt/2b8Kz6mWYvb6F2vCMyU4CO/MLC6belaBC1Y9RX/HwgbM7op4h8TAPpHb9A==
X-Received: by 2002:a05:6808:168f:b0:34b:ac91:6f5f with SMTP id bb15-20020a056808168f00b0034bac916f5fmr2395844oib.254.1663174035184;
        Wed, 14 Sep 2022 09:47:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i34-20020a056870892200b0012644cc4feasm8665297oao.55.2022.09.14.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:47:14 -0700 (PDT)
Received: (nullmailer pid 2567035 invoked by uid 1000);
        Wed, 14 Sep 2022 16:47:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     James Smart <jsmart2021@gmail.com>,
        Marc Herbert <marc.herbert@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220914142256.28775-3-ansuelsmth@gmail.com>
References: <20220914142256.28775-1-ansuelsmth@gmail.com> <20220914142256.28775-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Wed, 14 Sep 2022 11:47:10 -0500
Message-Id: <1663174030.721715.2567034.nullmailer@robh.at.kernel.org>
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

On Wed, 14 Sep 2022 16:22:53 +0200, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> v1 and also flag that these bindings should NOT be used for v2.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


clock-controller@2088000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2088000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2088000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2088000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2098000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2098000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2098000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2098000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@20a8000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20a8000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20a8000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20a8000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20b8000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20b8000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20b8000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

clock-controller@20b8000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

