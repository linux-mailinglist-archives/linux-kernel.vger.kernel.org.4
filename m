Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2525636C32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiKWVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiKWVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:17:55 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DE248D5;
        Wed, 23 Nov 2022 13:17:53 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id p141so23905iod.6;
        Wed, 23 Nov 2022 13:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlGzPtaFyxT63ceQLXbSW4Fmxcnh3kelB9yPiEvgEPw=;
        b=Dei/jEdHgaR4K1VGrWuVROTLYOorjL2tbGE9iQQ7DH4Yzk8MeWSEs035yp6yWSj1jU
         UpH/hHCpmrbT9sDXyXd6FssDU4LcJ9PGSYP3O7IPsnlr93CCvxptEVrYdkSECraeGMJ2
         eMnZd4sFMFmLZfebU2Hh4lUCi+RrKYVuKNlrE9890rQH6eAAurJS6a3MCMO9FcNsWalw
         7BRXU2GVVuIS6Vfo5CZxCQmnx5qNqb7bLOnNysIymidYvESDPEDB3a/NfRMSAkgGq9jJ
         V00QNYvjA7WAnS0ormJ/U4VIx3ZQf+/+gA55tVZzyGJDkiMHoTtGfAOMaRNfei4ityeF
         l86w==
X-Gm-Message-State: ANoB5pl93znrU+MNhT/MDVFO096GQBdwFaDn1Rt3gLuPsAFfaxmp2GwI
        SQs9avBYLkwI67RDmMWoA2xpH1WP7g==
X-Google-Smtp-Source: AA0mqf7M9NWs/AP1+/NB1NNy5H44vkbvteepEMbJ1+gr4DpWhp1CvkedqtvGFv2cQop4Vmpov33/7Q==
X-Received: by 2002:a6b:6b07:0:b0:6dd:f70e:dda5 with SMTP id g7-20020a6b6b07000000b006ddf70edda5mr6778925ioc.100.1669238273216;
        Wed, 23 Nov 2022 13:17:53 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u12-20020a02c94c000000b003758390c97esm6813302jao.83.2022.11.23.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:17:52 -0800 (PST)
Received: (nullmailer pid 2511151 invoked by uid 1000);
        Wed, 23 Nov 2022 21:17:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org,
        Mike Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20221123142009.594781-3-abel.vesa@linaro.org>
References: <20221123142009.594781-1-abel.vesa@linaro.org>
 <20221123142009.594781-3-abel.vesa@linaro.org>
Message-Id: <166923784873.2501231.6595702811083404727.robh@kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: clock: Add SM8550 TCSR CC clocks
Date:   Wed, 23 Nov 2022 15:17:54 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 16:20:02 +0200, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * based on recent bindings, like Krzysztof asked
>  * used qcom,gcc.yaml and dropped redundant properties
>  * used additionalProperties instead unevaluatedProperties
>  * renamed qcom,tcsrcc-sm8550.h to qcom,sm8550-tcsrcc.h, to match
>    compatible
>  * added dual lincese to qcom,sm8550-tcsrcc.h
>  * moved patch to the beginning of patchset
>  * dropped redundant "bindings" from subject line
> 
>  .../bindings/clock/qcom,sm8550-tcsrcc.yaml    | 39 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    | 18 +++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml: allOf:0: '$ref qcom,gcc.yaml#' is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml: ignoring, error in schema: allOf: 0
Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.example.dtb:0:0: /example-0/clock-controller@1fc0000: failed to match any schema with compatible: ['qcom,sm8550-tcsrcc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221123142009.594781-3-abel.vesa@linaro.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

