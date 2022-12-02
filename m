Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AE63FF5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiLBEKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLBEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:10:10 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23ABD158B;
        Thu,  1 Dec 2022 20:10:06 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso2237279otl.13;
        Thu, 01 Dec 2022 20:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KwpvofZtZWOvE931Uob1EiKUjPOMVVWCH9lqebLD3Vk=;
        b=u/pobSQaUWg5vwx8P8Hh+0/Jx45KcAr9hr7tCshGXSc+kcUOcf0nrYkP+vtZsGEYeI
         m7mU9FINv3VmU2WN0/lPcTiGJMq2IV2LMhRqCZ4e+J5NHfpK50m+LNriIcYzq3P6O/cn
         mqtSLZ4qHbXyNzP6cBSEBQ0hdkbW0kqnt8USWi1h3s2raAWm3HI0WNirLV+9j2pAdr2o
         UNP6sbbyOaY8QS65OAsU/9IlyIw2RIAtSFdXIDNH6EZM4aQGbmq+q3h7V/rI5kufvkUu
         FbkvTu5+iiBIjjMTf5PouEGa07/9aBFLlXhWyqbbj0JaHAJra14jlMFdaxpXXIKyatB5
         AUDA==
X-Gm-Message-State: ANoB5plOgL1TdV+wtrIdr4NcxPYhNDGEa4gI+CeAv72dYlLkAwfSKU5n
        WiVNlOse9szg4xNE3A6OSw==
X-Google-Smtp-Source: AA0mqf5SsmaLvP52A2IYGBATobGjnwZZWGFa6BSCWZ/mMkz+D/PfdCTzcv4CbYGr+v+4OHkszkFltg==
X-Received: by 2002:a9d:7dca:0:b0:66c:6cf1:7967 with SMTP id k10-20020a9d7dca000000b0066c6cf17967mr34701459otn.139.1669954205964;
        Thu, 01 Dec 2022 20:10:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o35-20020a056870912300b0014185b2b3d5sm3581893oae.18.2022.12.01.20.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 20:10:05 -0800 (PST)
Received: (nullmailer pid 2118010 invoked by uid 1000);
        Fri, 02 Dec 2022 04:10:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org, khilman@baylibre.com,
        kernel@sberdevices.ru, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org, jian.hu@amlogic.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        rockosov@gmail.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20221201225703.6507-2-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
Message-Id: <166995398251.2089685.16059995540663317860.robh@kernel.org>
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Date:   Thu, 01 Dec 2022 22:10:04 -0600
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


On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.example.dtb: pll-clock-controller@7c80: reg: [[0, 31872], [0, 396]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-2-ddrokosov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

