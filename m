Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E95B8D99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiINQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiINQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:54:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8280E92;
        Wed, 14 Sep 2022 09:54:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f20so18690666edf.6;
        Wed, 14 Sep 2022 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=KHbbeW7fbV3V2cMMEyuQ19OX9xB4aQp4eSigwqcNR4Q=;
        b=gd2mfBZmWNgZYQjv4h2CicvZehIFDKq9mjhayF1ogfuYhpADuHTVo4M3L2mqs+y7pB
         Gk+kAyhXC+6hsMmzlztHfk9GCRKLLaVqOLXoXKp3o4IUMRE4YWwi/4qdUXBVoMtypTlH
         3EQUqAF5zZQfY9vBCz62NvmdaxS8cZ0B+YfQoSlaMtzk18dBQAy9XPmNu510uW0y3uiG
         0ykxEsRNLSN02kykph7jgxuS3TOp6AyTUO3whbU+AeczWMjysNOJbHHEH51S490XzbhU
         BSb/sIcXATVdoBZm8YEFggqBX85ziOs+aGEHhpDqpme3MR5VtylwEzMMQoFNaeJ0YyQ7
         njPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=KHbbeW7fbV3V2cMMEyuQ19OX9xB4aQp4eSigwqcNR4Q=;
        b=yPOEXnJTRJyE2kwmy/GrpYC1rA9JGFAC9Oq2Nz4T0fyFHRkO3riJpkFpFbYjT6nHVN
         Fof0a9wKQV8HixsZ1sx4tnSc5gKlXtVfoV0Hghh6QFuGtE23J3Immd399kSXAxXvgg0g
         xXuStFXAAQE8Lr7wpxa8qoxQfGDeCyW/rRI+/99oJkAUMXXJwBbwtKoJBAd+Oceqa2m/
         pqEC2cfSLlNDH4FGyH+UPWIc+ZjrTRQTrj7J76JoB6OckXgBNl2YVNFa9Ql6qMCRiFTp
         lAIXswnPRwZtliN4SY258el3deyEbYPvWGR5zobmxNF+QeP5sGCeJr3wnPQCJjXTc29F
         qQEA==
X-Gm-Message-State: ACgBeo0oyL4azPrZqnEWH1kMFPX/1zoVLo+WxLG7jUUVlpXChkrojpBY
        F/ltiW7xYX4sPQaJVfvPhac=
X-Google-Smtp-Source: AA6agR75LFiStJpHcwoF8nYcILsszixk+vHZdYffy0tHEDjfIzw57aT7h3CF4e7w4Z1IJ9Hb5/l2LQ==
X-Received: by 2002:a05:6402:1946:b0:44e:a406:5ff5 with SMTP id f6-20020a056402194600b0044ea4065ff5mr31734748edz.14.1663174450803;
        Wed, 14 Sep 2022 09:54:10 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id x24-20020a50d618000000b0044e01e2533asm10232480edi.43.2022.09.14.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:54:10 -0700 (PDT)
Message-ID: <63220732.500a0220.f190b.97f9@mx.google.com>
X-Google-Original-Message-ID: <YyIHMHDq8K3vY0tS@Ansuel-xps.>
Date:   Wed, 14 Sep 2022 18:54:08 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-3-ansuelsmth@gmail.com>
 <1663174030.721715.2567034.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663174030.721715.2567034.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:47:10AM -0500, Rob Herring wrote:
> On Wed, 14 Sep 2022 16:22:53 +0200, Christian Marangi wrote:
> > Convert kpss-acc driver Documentation to yaml.
> > The original Documentation was wrong all along. Fix it while we are
> > converting it.
> > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > don't have any driver that expose additional clocks. The kpss-acc driver
> > is only specific to v1. For this exact reason, limit all the additional
> > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > v1 and also flag that these bindings should NOT be used for v2.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
> >  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 49 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> clock-controller@2088000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@20a8000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 

Hi,
I fixed these warning in the last 2 commit of this series.

-- 
	Ansuel
