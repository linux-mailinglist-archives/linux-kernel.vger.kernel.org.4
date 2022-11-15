Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82403629BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKOOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiKOOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:20 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549665B8;
        Tue, 15 Nov 2022 06:11:19 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13bd19c3b68so16323775fac.7;
        Tue, 15 Nov 2022 06:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c5N91/KhOasWYPhexzTdP8VafBqdlF1gEW+N65BWXt8=;
        b=Az6WiAjntBLV9RU/3XUaxbAbZa5qoTldktEJaROJCQRrydR8trledzSZxK9CWepld2
         BNcqC+kw5J9qFawXw85DJ2geVnVDkm1pd/YbFdTX+w5BWkfdU1+K4bjj15qNmIiDqBHt
         qsuGJy0p9wlK9ZrxgKqoTqzG+kq9QbUer+xMlEBD/1uAibULTWLF0NH7//nFisLp4qwi
         FBa323XaTk85ddWyBNDV+93pfz0MfHxEs6nnA08a3FS2i6LB2a9biCgRgIZp1t6IAbmc
         ieQ0tCPUXtUpYKLqNGJuJz8BuqT6uTBg9dkcL6XYZhCopGS0UhvzYVcwVXBOCLjdHEey
         XpyA==
X-Gm-Message-State: ANoB5pl3Nc0us2GqExUizm0qzWgHS9aj275xUpkmx1SZqIswtDBPQB3a
        5Qe9zbHQaer/Uj9KzZXiTA2dFEi9JQ==
X-Google-Smtp-Source: AA0mqf6nYfASooBBF6z9v/cD7taFztOAnQfXgMwa2knN6vvGmeETBJghAeI6PSSUhC1CWCqvEuuVUg==
X-Received: by 2002:a05:6870:781b:b0:132:68d8:703e with SMTP id hb27-20020a056870781b00b0013268d8703emr406826oab.174.1668521478957;
        Tue, 15 Nov 2022 06:11:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a9d450d000000b00661948e6119sm5504101ote.47.2022.11.15.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:11:18 -0800 (PST)
Received: (nullmailer pid 908578 invoked by uid 1000);
        Tue, 15 Nov 2022 14:11:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v4-1-463523919c19@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v4-1-463523919c19@linaro.org>
Message-Id: <166851961643.867594.12105329661363857830.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Date:   Tue, 15 Nov 2022 08:11:14 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 11:12:35 +0100, Neil Armstrong wrote:
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
./Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/regulator/qcom,rpm-regulator.yaml#

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml: Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

