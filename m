Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10664B68F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiLMNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiLMNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:46:38 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60047D96;
        Tue, 13 Dec 2022 05:46:37 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id w4-20020a4aaf04000000b004a1ab217cecso2354536oon.13;
        Tue, 13 Dec 2022 05:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUpWkWz4Vv0wsvz9uDOTnai0IvfXmx1Vsyjc/A/wmtw=;
        b=CwfzTmCfoqRoOzF2tU1g2rbr4potbxAToYP6MT+Jik0uai2lHi6tgAl1SiOjIqDU8v
         FwqqmlZHUxVbP+PwyYLw6lT3Lr9I6z4Wq+Cjh0nc5gN9utJDR/XgSMAK4/i6RvR4cKNB
         5iVwyKSRGsi13AvnidlCPvPfvQIM1vA0LlpN1/iFqpvtWpHC3Ps5yVgna9uzOq/WEOE/
         OxpFbgK6ZVnBdYSYnND71dPuzygjHLATrmzNOBWqVNlpPD+sT2221N1Su0ah0SKAdk+5
         mOjoaf+hfiVddAbGjku+P1D8WWJ0Uxj2xofMdV2WWk68MVYYytHK0V5n3o/VICgx984C
         gQFQ==
X-Gm-Message-State: ANoB5plVvdh5dLnIKBUGq3pTJAFpcrUZikXyCqaxTb/PvW/HM+Sd7inW
        P0g8bRWjI2ckvJxMK4NufQ==
X-Google-Smtp-Source: AA0mqf5OsBRPDO5DOlaOV3v5rME9etlVbzka/W6QkyoSF+lRcupp5sHYKakrHN7OEWWtY9pOfOJ6pw==
X-Received: by 2002:a4a:41cc:0:b0:4a3:e7ac:d31b with SMTP id x195-20020a4a41cc000000b004a3e7acd31bmr4249074ooa.5.1670939196576;
        Tue, 13 Dec 2022 05:46:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m1-20020a4add01000000b004a3c359fdaesm1124023oou.30.2022.12.13.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:46:35 -0800 (PST)
Received: (nullmailer pid 914674 invoked by uid 1000);
        Tue, 13 Dec 2022 13:46:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kun Yi <kunyi@google.com>, Jonathan Cameron <jic23@kernel.org>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?=2C?= Jean Delvare <jdelvare@suse.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Luka Perkov <luka.perkov@sartura.hr>
In-Reply-To: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
Message-Id: <167093911583.912886.13512120412056690614.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in examples
Date:   Tue, 13 Dec 2022 07:46:32 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 10:26:41 +0100, Krzysztof Kozlowski wrote:
> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
> i2c node name and use lower-case hex.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
>  .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
>  .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
>  .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
>  .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
>  .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
>  .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
>  13 files changed, 102 insertions(+), 102 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/adi,ltc2992.example.dts:22.24-38.15: Warning (i2c_bus_reg): /example-0/i2c/ltc2992@6F: I2C bus unit address format error, expected "6f"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221213092643.20404-1-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

