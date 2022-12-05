Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E564366B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiLEVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiLEVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:05:18 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361D2BB07;
        Mon,  5 Dec 2022 13:04:56 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id h132so14521617oif.2;
        Mon, 05 Dec 2022 13:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CwjQnBpZhR3hfYFhEevn5e7QNaIh1B5bLQAi43lcrk=;
        b=ICZqOiSPYNMkvZGxbxj7S6tRa5U0ZJlu8/Kh+LZWJEpRbhtKuCaKaLNp5O0zMMTKPO
         vxAMqhgsDxQsnf7GBQeLQycKfzoAWIHJuVxFSIxBet5zNmRjucylkVhIX32QSC7k7TIz
         ZiK9CrAIT6OhRNxB0b/ABjilbHbAuSdMU7JP5+3DczBAA45DCdYgJxXAxH0nVo7CPUv9
         SqRSQhSyZkNcLYHX4i/hz6kMC17h1S6EufzXsfLjRqb5yjAuKpcmIbnBH4LQWB/Cf7ox
         yoog4QFHwD2+iPT9GN8K0IM32XzeOHO6/UnV9rWs1T11NJuIlIo+OBfeKvr4qq2CnNc2
         gWbw==
X-Gm-Message-State: ANoB5pnI8Og1HjXzN3nbPeFVp/x5NB9jvgdKChL7iosmJysnZUvrhPUa
        qKxrQxp+GrHnv61XKErKtp1FXXMsoA==
X-Google-Smtp-Source: AA0mqf6PNt36qq3YHqydspUbJJ2YLYagwBsN9fSedf6ZJgKdnwon8TbkB7Y9jzHiw1tuBJG4lDUmwA==
X-Received: by 2002:a54:478d:0:b0:35a:582b:e0f5 with SMTP id o13-20020a54478d000000b0035a582be0f5mr30964775oic.164.1670274295497;
        Mon, 05 Dec 2022 13:04:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a056870c20a00b0013b911d5960sm9684219oae.49.2022.12.05.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:04:55 -0800 (PST)
Received: (nullmailer pid 2619485 invoked by uid 1000);
        Mon, 05 Dec 2022 21:04:51 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dianders@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, airlied@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, dmitry.baryshkov@linaro.org, robdclark@gmail.com,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        vkoul@kernel.org, freedreno@lists.freedesktop.org, sean@poorly.run,
        quic_sbillaka@quicinc.com, robh+dt@kernel.org, agross@kernel.org,
        quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org
In-Reply-To: <1670267670-15832-3-git-send-email-quic_khsieh@quicinc.com>
References: <1670267670-15832-1-git-send-email-quic_khsieh@quicinc.com>
 <1670267670-15832-3-git-send-email-quic_khsieh@quicinc.com>
Message-Id: <167027422734.2617917.15803998013731491196.robh@kernel.org>
Subject: Re: [PATCH v8 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Date:   Mon, 05 Dec 2022 15:04:51 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 11:14:27 -0800, Kuogee Hsieh wrote:
> Add both data-lanes and link-frequencies property into endpoint
> 
> Changes in v7:
> -- split yaml out of dtsi patch
> -- link-frequencies from link rate to symbol rate
> -- deprecation of old data-lanes property
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties:ports:properties:port@1:properties: 'properties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties:ports:properties:port@1:properties: 'additionalProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties:ports:properties:port@1:properties:properties: 'anyOf' conditional failed, one must be fixed:
	'data-lanes' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties:ports:properties:port@1:properties:properties: 'anyOf' conditional failed, one must be fixed:
	'link-frequencies' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.example.dtb: displayport-controller@ae90000: ports:port@1:endpoint: Unevaluated properties are not allowed ('data-lanes', 'link-frequencies' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1670267670-15832-3-git-send-email-quic_khsieh@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

