Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E6614A04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKALz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKALzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:55:55 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52302180;
        Tue,  1 Nov 2022 04:55:54 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m204so3907054oib.6;
        Tue, 01 Nov 2022 04:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrbh15qgzMA/o8yBcJMyagirxvUvQI4PNn4V+H8c/rg=;
        b=Ax7GBXRv1S1hkBnBuu7+tPl3apAHTznfkDadcJKWQJZukz+g2vTm2nt93t+4Lqfa8Z
         MJYwDI5NWK4KRm5U6ndJY74UK8HtpEKuBdEYPMnwUEPKRF4iFFOXnjfy0qthaIGBNsId
         cwFvgoiWmCniwL5y2bOblAzsEN1xXPJnvMywLEcdpQwVdVp1KaqIiNqUDEGhZ/6aoKAZ
         R6yLBlGoiabhSYHGLNKWdPIMdmFY3fr5Zy4fGyTOzbwEc6f1CCsjqXNrNelfZNYMKN0m
         JDT1btjH97eNUr+PEATqjzALuTH+SpH5hw5Hh1047k1XGsYpwG+6LxTr5cipgeJEQK/p
         05bA==
X-Gm-Message-State: ACrzQf2NrHNWP+i/DHS9FOSFVYFyNDne/tlCh3hb9CViQTDoiy5KHQA7
        4Huin2U4nIWWtiSNwuApCQ==
X-Google-Smtp-Source: AMsMyM4pERgMl8sfVIJ1EjXYDJ/RrYpu6vIqrK8Rp006zt48Esh3m/jh7XQCueTC2ZfJMLybjWL0UQ==
X-Received: by 2002:aca:1019:0:b0:359:e535:bf92 with SMTP id 25-20020aca1019000000b00359e535bf92mr9605215oiq.90.1667303753505;
        Tue, 01 Nov 2022 04:55:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a056870f20300b0012752d3212fsm4314073oao.53.2022.11.01.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:55:52 -0700 (PDT)
Received: (nullmailer pid 909532 invoked by uid 1000);
        Tue, 01 Nov 2022 11:55:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?utf-8?q?G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221101064804.720050-1-l.goehrs@pengutronix.de>
References: <20221101064804.720050-1-l.goehrs@pengutronix.de>
Message-Id: <166730309295.897577.4866397087832832552.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add TI LMP92064 controller
Date:   Tue, 01 Nov 2022 06:55:54 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 07:48:03 +0100, Leonard Göhrs wrote:
> Add binding documentation for the TI LMP92064 dual channel SPI ADC.
> 
> Changes from v1 -> v2:
> 
>  - Rename the "shunt-resistor" devicetree property to
>    "shunt-resistor-micro-ohms".
>  - Add supply regulator support for the two voltage domains of the chip
>    (vdd and vdig).
>  - Add reference to spi-peripheral-props.yaml
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,lmp92064.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.example.dtb: adc@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

