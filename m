Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3967D828
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAZWFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjAZWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:05:50 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24F28D16;
        Thu, 26 Jan 2023 14:05:49 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id u13-20020a4aa34d000000b004f5219f9424so415004ool.5;
        Thu, 26 Jan 2023 14:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9zvA6aaRxT5oA+vWQpnnbfeU47UvhMD3eanCgwim0e8=;
        b=xYHbqplskkupYptyDToOpBB1J0tOjt5D6YIOKq9jxgE1RbdxGajZctF/P3slwHhs1w
         3VzEcK+b2EvtmZvoP7aPJo2l1kdS/ZggEbjvWtEf+vFjbtLycg/AQq2Zw6LrmRE2h9xJ
         NyWhIJM65geGvwx0M6eGuo0cs585TfRlb4/45RtD7xu5huxnKPY66CdPO6yTDMBv5uIH
         8v0bjYr/Ug3zHm7R+38ovznKRpYsmyr3m/NjDRfzVX2n3Alub7NKqx570xYsKtxRtwgD
         a2qVqHeTJGYQ8y/KVjcTSDLGZF7Msb/2+2QuCOP7lt5/p0gWl7QOEtfA4x04FnJJPgHf
         /4VA==
X-Gm-Message-State: AFqh2kp2Qfxixug5/4XOpH7+mPL4IMH9GcyFF+8O9dWSqvtbbp4TaGsj
        gZDWPSyFKBevJ+G7SU4PkA==
X-Google-Smtp-Source: AMrXdXsvaBNueDbm+FAsWOVEltyyLIwFN/xjB4zgkZ/QVZx+C93Cg+LW+hQsXWhlIx9Od+L1CajrIw==
X-Received: by 2002:a4a:b5cb:0:b0:4f2:f0f8:b7b5 with SMTP id u11-20020a4ab5cb000000b004f2f0f8b7b5mr15440701ooo.7.1674770748256;
        Thu, 26 Jan 2023 14:05:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o20-20020a4ad494000000b004a394578e14sm990927oos.32.2023.01.26.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:05:47 -0800 (PST)
Received: (nullmailer pid 2669511 invoked by uid 1000);
        Thu, 26 Jan 2023 22:05:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20230126150026.14590-1-ansuelsmth@gmail.com>
References: <20230126150026.14590-1-ansuelsmth@gmail.com>
Message-Id: <167475624070.2087166.4816561741085643801.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Date:   Thu, 26 Jan 2023 16:05:46 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 16:00:24 +0100, Christian Marangi wrote:
> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> - pre-cpr that doesn't have power-domains and base everything on nvmem
>   cells and multiple named microvolt bindings.
>   Doesn't need required-opp binding in the opp nodes as they are only
>   used for genpd based devices.
> - cpr-based that require power-domain in the cpu nodes and use various
>   source to decide the correct voltage and freq
>   Require required-opp binding since they need to be linked to the
>   related opp-level.
> 
> When the schema was introduced, it was wrongly set to always require these
> binding but this is not the case for pre-cpr devices.
> 
> Make the power-domain and the required-opp optional and set them required
> only for qcs404 based devices.
> 
> Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v4:
> - Explain why required-opp needs to be conditional
> - Split additional ref part
> Changesv3:
> - No change
> Changes v2:
> - Reword commit description
> - Fix condition order
> - Add allOf
> 
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 62 +++++++++++--------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml: 'anyOf' conditional failed, one must be fixed:
	'type' is a required property
	'properties' is a required property
	'patternProperties' is a required property
	hint: 'additionalProperties' depends on 'properties' or 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml: 'anyOf' conditional failed, one must be fixed:
	'properties' is a required property
	'patternProperties' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230126150026.14590-1-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

