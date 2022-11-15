Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFF629BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiKOOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiKOOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:25 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D7010541;
        Tue, 15 Nov 2022 06:11:21 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13b23e29e36so16316147fac.8;
        Tue, 15 Nov 2022 06:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ko/Jm2Crg/0IdcHGiNY7XpYLJ5KYFoRqG/YZh7PVLyY=;
        b=FhWMyJsA3vsxjdc9rv6A/uAcrw9ZhihR+NxIiv6FSWvpqzIGcBPx79WwC7UNYllooT
         lNX1e3xO6EW9xslIEtL3VRMAC+t1Ts1L3rJy3t560HgQ1q5aD5FoMM+RfYn4I2sZtLYS
         CFuN/JoOTRWXk7LtZXHS1v8o/RL3ZPbafuqWHgXTsFuS/RX4KfEoiYfddXqV/akWaxHA
         XfoP8XiJ7VIh1ubuSalIzB0pc+EwUmYjAEjD+6TpF8aj2YDNMJX3UOMJOGIBIVDx6zUZ
         yDamXChlKRWV3ogSPEMS6Cbs6nx4758xzt490+yzRltn/tNkKI2oQfYFYw6jXChGA5gm
         qyXA==
X-Gm-Message-State: ANoB5plzWjaJDgWDmZRDCMB76Mp86Lej4mIS0fFTifhWMaWJghGxXlS5
        dlG89Vh/L0GoBIa9YMZ3Zg==
X-Google-Smtp-Source: AA0mqf4uFfNYExut1Ar/priZ+hCGhKrNBdRZ8B91gwC+ZnuPQ2gqm3VuCjdMAE7iq3CCnmQj84NR9g==
X-Received: by 2002:a05:6870:5246:b0:13b:d7c0:d66b with SMTP id o6-20020a056870524600b0013bd7c0d66bmr472834oai.36.1668521480911;
        Tue, 15 Nov 2022 06:11:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q204-20020acaf2d5000000b0035418324b78sm4937480oih.11.2022.11.15.06.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:11:20 -0800 (PST)
Received: (nullmailer pid 908580 invoked by uid 1000);
        Tue, 15 Nov 2022 14:11:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v4-2-463523919c19@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v4-2-463523919c19@linaro.org>
Message-Id: <166851961723.867617.14976811191392756271.robh@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Date:   Tue, 15 Nov 2022 08:11:14 -0600
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


On Tue, 15 Nov 2022 11:12:36 +0100, Neil Armstrong wrote:
> Convert the non-SMD RPM node bindings to dt-schema, the old txt bindings
> are now removed since all bindings were converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
>  .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 101 ++++++++
>  2 files changed, 101 insertions(+), 283 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml
./Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/soc/qcom/qcom,rpm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb: rpm@108000: regulators: False schema does not allow {'compatible': ['qcom,rpm-pm8921-regulators'], 'vdd_l1_l2_l12_l18-supply': [[1]], 's1': {'regulator-min-microvolt': [[1225000]], 'regulator-max-microvolt': [[1225000]], 'bias-pull-down': True, 'qcom,switch-mode-frequency': [[3200000]]}, 's4': {'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 'qcom,switch-mode-frequency': [[1600000]], 'bias-pull-down': True, 'qcom,force-mode': [[3]], 'phandle': [[1]]}}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb: rpm@108000: regulators: Unevaluated properties are not allowed ('compatible', 's1', 's4', 'vdd_l1_l2_l12_l18-supply' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb:0:0: /example-0/rpm@108000/regulators: failed to match any schema with compatible: ['qcom,rpm-pm8921-regulators']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

