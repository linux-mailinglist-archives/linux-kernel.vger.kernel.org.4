Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99E62E9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKQXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiKQXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:49:17 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F21532F7;
        Thu, 17 Nov 2022 15:49:15 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso2103110otr.9;
        Thu, 17 Nov 2022 15:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qMcsFmOL/2GypqX63+TgzuiSSfzo6QHW3VYHiQ5eWyQ=;
        b=DSzrLDk8NFHkI2fEypEFc0b+PIPx3YitXFvr8DGZN7RBpfqdoauZMQE/Bn8xWWiXiy
         4jNyBcZqZwOoOgNTtpfn7S7y4ARUeI36zPjovOAyGmIO5y7QrUa1EPfl72yFTSagqDzL
         dMxwAGnQujKlFxmRlWc6bWw4beM7N2rxzyMCcVDSNfVrqEeDMtQhSy7Bio7O+ZRXIzdG
         F7EbEP4Q9wCa7SodxGZ39ndOKsxXROw2CLnT8VMMsjkuGBcuX5HtYrJ2nyzzti/1aM94
         YIvgLHAEW6sgE9rHkyZWVEgWtsE24MsjmZxadKoncxK3SxLWQv1PKJolevroOfw+Fu//
         /sQg==
X-Gm-Message-State: ANoB5plE5eVnYKDqPZdx+f0q5ArMOqlbLs5WG9eHYtoFLKUrsLMZt/g5
        L1OhdK4qZDzK5xqELpmLTQ==
X-Google-Smtp-Source: AA0mqf70HF0fYopJdR01uFy+Fw0KQgN9VuaGnVLTj/Bb72eE55NhcI4+NXbQu1RE6+w84xfmZ8cONg==
X-Received: by 2002:a9d:28d:0:b0:66c:cedd:8d0 with SMTP id 13-20020a9d028d000000b0066ccedd08d0mr2629224otl.131.1668728954597;
        Thu, 17 Nov 2022 15:49:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a056870d61200b0012b298699dbsm1161400oaq.1.2022.11.17.15.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:49:14 -0800 (PST)
Received: (nullmailer pid 13384 invoked by uid 1000);
        Thu, 17 Nov 2022 23:49:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
Message-Id: <166872874092.6463.6032366215221969012.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Date:   Thu, 17 Nov 2022 17:49:15 -0600
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


On Thu, 17 Nov 2022 18:04:58 +0100, Neil Armstrong wrote:
> Convert the non-SMD Regulators bindings to dt-schema, the old text based
> bindings will be deleted later since the RPM bindings are not yet converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml: Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

