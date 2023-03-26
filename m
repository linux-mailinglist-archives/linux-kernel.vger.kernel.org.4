Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2B6C9507
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCZOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCZOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:11:33 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205983E8;
        Sun, 26 Mar 2023 07:11:02 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17ec8963db8so6689175fac.8;
        Sun, 26 Mar 2023 07:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679839823;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RI84tHAsFIA+Z9+3RM9Ce999KROH+/bxjRxCcU6olVY=;
        b=aAiivHeu/Tsv0dz4SKSXiaosIrrtpdO20RyVijglBIQSFePnfJw8aHDNss+5DIUrPr
         ZBITDtgL3ha4o2n7JoB7olDrYijdQLBI/mfMPzKRQoscY8sP7dTXAJbxL4sZkq2DsVZv
         JsY0xLCedFhueLhfXW/XHeGW8cehxf3xocLlQYtfpSXO1NRk0ADks5ov07xdFZeac0fv
         vCx2lxGlSACaDWqT+tyFxSircfW9guaQm/sxhlDpFR8+4tUB6u1oTOwUpohP5Pp/uHyp
         QQSNgzf5uMtWTk0/k+yguqpZZv5wkXO6OyDLIDn8fpaF/5KPVOBG8mdfm7xM0kAq+bAc
         NXLg==
X-Gm-Message-State: AAQBX9e4EGXZ7BfiiuTjZVtCVM3GQilSlhZ2ChFkk0TfNPWqzCUlQPIk
        Y/nkSwWVuJwo/hsv8Jth0g==
X-Google-Smtp-Source: AKy350a+wztBAVZCse1OmxrhNfzmyAzezy7grQ/X6mbQuuEsDbhoHnKJRF53Dr55qRBhmiRDuQzhDA==
X-Received: by 2002:a05:6870:ec8c:b0:17a:bf1b:cab8 with SMTP id eo12-20020a056870ec8c00b0017abf1bcab8mr6363964oab.4.1679839823002;
        Sun, 26 Mar 2023 07:10:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s2-20020a4a5102000000b005252e5b6604sm10485165ooa.36.2023.03.26.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 07:10:22 -0700 (PDT)
Received: (nullmailer pid 380188 invoked by uid 1000);
        Sun, 26 Mar 2023 14:10:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230325122444.249507-6-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-6-vkoul@kernel.org>
Message-Id: <167983963951.350350.7524342280614332456.robh@kernel.org>
Subject: Re: [PATCH v2 05/12] dt-bindings: interconnect: split SC8180x to
 own schema
Date:   Sun, 26 Mar 2023 09:10:21 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Mar 2023 17:54:37 +0530, Vinod Koul wrote:
> SC8180x comes with interconnects having and missing IO address space, and
> variable number of clocks, so split it from common file for easier
> maintenance and to fix warnings like:
> 
> sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      | 11 ---
>  .../interconnect/qcom,sc8180x-rpmh.yaml       | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml: properties:compatible:enum: ['qcom,sc8180x-aggre1-noc', 'qcom,sc8180x-aggre1-noc', 'qcom,sc8180x-aggre2-noc', 'qcom,sc8180x-camnoc-virt', 'qcom,sc8180x-compute-noc', 'qcom,sc8180x-config-noc', 'qcom,sc8180x-dc-noc', 'qcom,sc8180x-gem-noc', 'qcom,sc8180x-mc-virt', 'qcom,sc8180x-mmss-noc', 'qcom,sc8180x-qup-virt', 'qcom,sc8180x-system-noc'] has non-unique elements
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.example.dtb: interconnect@16e0000: reg: [[0, 23986176], [0, 53376]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.example.dtb: interconnect@16e0000: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230325122444.249507-6-vkoul@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

