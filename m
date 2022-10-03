Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6115F3132
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJCNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJCNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:25:03 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515E1C40E;
        Mon,  3 Oct 2022 06:24:58 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-131fd187e35so9215867fac.7;
        Mon, 03 Oct 2022 06:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dp9Q43aEM0PPaQLtEehgy86DJM9cN8chhlldSX2/zbE=;
        b=h9OCJiwwVFOgpz7B3sueZwM3erDo0ko4JiMkUQ7Tl8My1W+VEcNKaLy2Nc2csVHfMr
         NLCJrW6MBOga7zlGcPUQYLmR7IHMI8e1WxWY9YKaK+NABrWIfExAhkbnys7Lvnvl54Oc
         I4Gh1vyeIHd8xAJmrK0bPC4/Jy+nmWIOFsWAKx+gmWoWdF9nKX82T99ft82WEFzC2eqG
         vN8XD0iYSRx8MvBnP5sC3zwLdvBLdd1I+bwIZM/sHXyEt45KCyPNrU+hsAOBJRVwrq8j
         XJQFJ9pmg0SQ/tBVd7NTX6x9mH3jI6KjkTkfFensjDqiArV/9GxN5/NfCJJPgwCSpX+S
         u9mw==
X-Gm-Message-State: ACrzQf1kL8r1A4bQ9/79bxpDOVR9Sc8oBhjOw18tBQZcq6dWktpFSXLL
        EAtqz5On49WMaTqlJxsgLA==
X-Google-Smtp-Source: AMsMyM7P6fWDgZWJ+pDZmkkAnk2LXEdlTXcYkaRZqBA/R/V40rxhbTlyp2FNBvV/KD5Twb5VdE5p6w==
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id ba36-20020a056870c5a400b001316edd3955mr5528184oab.96.1664803497375;
        Mon, 03 Oct 2022 06:24:57 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g97-20020a9d12ea000000b0065a193c08absm2397902otg.34.2022.10.03.06.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:57 -0700 (PDT)
Received: (nullmailer pid 1863803 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221001030546.28220-2-quic_molvera@quicinc.com>
References: <20221001030546.28220-1-quic_molvera@quicinc.com> <20221001030546.28220-2-quic_molvera@quicinc.com>
Message-Id: <166479587409.1658979.1716808349864966908.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
Date:   Mon, 03 Oct 2022 08:24:48 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 20:05:45 -0700, Melody Olvera wrote:
> Add documentation details for device tree bindings for QDU1000 and QRU1000
> TLMM devices.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:81:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:82:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:83:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:84:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:85:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:86:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:87:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:88:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:89:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:90:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:91:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:92:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:93:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:94:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:95:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:96:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:97:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:98:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:99:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:100:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:101:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:102:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:103:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:104:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:105:13: [warning] wrong indentation: expected 17 but found 12 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml:106:13: [warning] wrong indentation: expected 17 but found 12 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: properties:interrupts:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: properties:interrupts: {'minItems': 0, 'maxItems': 1, 'items': [{'const': 'TLMM summary IRQ'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: properties:interrupts: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'TLMM summary IRQ'}] is too short
	False schema does not allow 0
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: 'patternPropetries' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: error checking schema file
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml: ignoring, error in schema: properties: interrupts: minItems
Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.example.dts:21.32-30.11: Warning (unit_address_format): /example-0/pinctrl@03000000: unit name should not have leading 0s
Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.example.dtb:0:0: /example-0/pinctrl@03000000: failed to match any schema with compatible: ['qcom,qdu10000-tlmm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

