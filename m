Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6115EDCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiI1Mis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiI1Mip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:38:45 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C75FDF;
        Wed, 28 Sep 2022 05:38:43 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id o64so15189548oib.12;
        Wed, 28 Sep 2022 05:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MVE7K3TrhAl4+bBgRcalQ9xAo1RSSurrDIzau4FAdiA=;
        b=J9HUrJ6Z3bmfY36G1y0e+yZTpqwYPCVpzYdolYvn3oYEf7G5jCEUdoyforxyd/+eNM
         DJK9DkApjj+uiJqOLtgmOoHKrdz0xQOKRkwHiugS1cByLGiWyFipV2CbRi10RF4lH5ZY
         lHoY7uBxz1IkvUh7ubwZEASn8zQpB5/Va4XL4FqUXxvZ/d2VB7mqSAPuZ63CjNmG7VB1
         fnd2utfdhRZqTarCjUJff+Cj45U/hhFNHeBvHd4lHi7YcBchHGKo7mFpAshXlRJeHoVb
         ZFQBYzCJG+iNEER2Epdj6mP1uTNK8sUJPIQEfYMFtrvBNVkd++zhXWb2me+7rnFfO1+e
         cB5A==
X-Gm-Message-State: ACrzQf1LnRjBt8rWwgRZ8BmW6HrNQz3nnha6H2G4/Mmbvb7y3l0ncmTF
        NBXm67FrhLAM4NJ8lho5PC2z3N0BJQ==
X-Google-Smtp-Source: AMsMyM6gmQL+Dwu1iC9t3a9GqCF7S4OOJ6ebtc4RVLBssqrpheYyby+MPcboUXEzzAY54JgKCPmtLw==
X-Received: by 2002:a54:4105:0:b0:351:6350:5f73 with SMTP id l5-20020a544105000000b0035163505f73mr3024696oic.226.1664368722083;
        Wed, 28 Sep 2022 05:38:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i42-20020a056870892a00b00127a6357bd5sm2382714oao.49.2022.09.28.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:38:41 -0700 (PDT)
Received: (nullmailer pid 4136674 invoked by uid 1000);
        Wed, 28 Sep 2022 12:38:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_subbaram@quicinc.com, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        quic_collinsd@quicinc.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com> <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: add bindings for QCOM flash LED
Date:   Wed, 28 Sep 2022 07:38:41 -0500
Message-Id: <1664368721.029242.4136673.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 10:42:39 +0800, Fenglin Wu wrote:
> Add binding document for flash LED module inside Qualcomm Technologies,
> Inc. PMICs.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/leds/leds-qcom-flash.yaml        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dts:21.17-32: Warning (reg_format): /example-0/flash-led@ee00:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dts:23.23-31.19: Warning (unit_address_vs_reg): /example-0/flash-led@ee00/led@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dts:33.23-41.19: Warning (unit_address_vs_reg): /example-0/flash-led@ee00/led@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/leds-qcom-flash.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

