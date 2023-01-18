Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A27672A50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjARVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjARVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:21:17 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56389303E6;
        Wed, 18 Jan 2023 13:21:16 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so67265ooa.6;
        Wed, 18 Jan 2023 13:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HE+LNeQ0cLDl8QRW2H/1UEvxinXqttcsmYeJEyRWQyE=;
        b=TYeteF2u+gHYdhjSg//1HlRvHuT6146CTGkQbqbw239oqMfPvlnTjwdjKX/vxcEaiI
         FtXu5ZUKB20LXzH5tgbdGkrl5RiCfOzDj3nP5IjHm3vWVq9uMxv63MjsyOXJIld8UAjj
         ubDymExCrw6uU1na/qDDIKNXxZBe+sBHXbzCXZ/dU9kGMwY1866JzmYZUeQva6X4TdMc
         V03HJIaBzUUzN9Z1EAkx7IQ5Ngg48tqfKRwPFJiSVAvB4eXh441EzzzvqedqWkk3RoO0
         8b7l0pxgw/KM2xN6zxfH27ElVhjw8jth3NhOk/N/RnVdQkO/Hy9aqUFDF4coApe3iKl0
         itZA==
X-Gm-Message-State: AFqh2kq0F+VD+jSaWATAkj3Sg28X8zHXHh8l0d8F1erAhiP05SrsT1Zl
        zWRlOelg3OXljHeODeQwOA==
X-Google-Smtp-Source: AMrXdXvubcxEn8wrt2Zaj7/ykTRTSravLh1ahoCM+6vzmSxcJ4qw956Y2VRfxfuq6IAQxbMTBNZrcA==
X-Received: by 2002:a4a:e910:0:b0:4f7:bce6:4e06 with SMTP id bx16-20020a4ae910000000b004f7bce64e06mr4181387oob.1.1674076875480;
        Wed, 18 Jan 2023 13:21:15 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id q76-20020a4a334f000000b004f21af81e0csm8653454ooq.46.2023.01.18.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:21:15 -0800 (PST)
Received: (nullmailer pid 876135 invoked by uid 1000);
        Wed, 18 Jan 2023 21:21:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-2-54154c08c0b7@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v4-2-54154c08c0b7@linaro.org>
Message-Id: <167407681596.873892.9837637729592866883.robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: remoteproc: qcom: adsp: document
 sm8550 adsp, cdsp & mpss compatible
Date:   Wed, 18 Jan 2023 15:21:14 -0600
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


On Wed, 18 Jan 2023 17:22:40 +0100, Neil Armstrong wrote:
> This documents the compatible for the component used to boot the
> aDSP, cDSP and MPSS on the SM8550 SoC.
> 
> The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
> firmware to be passed along the main Firmware, and the cDSP a new power
> domain named "NSP".
> 
> A third memory domain for the DSM memory zone is also needed for the MPSS
> PAS bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.example.dtb: remoteproc@30000000: False schema does not allow {'compatible': ['qcom,sm8550-adsp-pas'], 'reg': [[805306368, 256]], 'clocks': [[4294967295, 0]], 'clock-names': ['xo'], 'interrupts-extended': [[4294967295, 6, 1], [4294967295, 0, 1], [4294967295, 1, 1], [4294967295, 2, 1], [4294967295, 3, 1]], 'interrupt-names': ['wdog', 'fatal', 'ready', 'handover', 'stop-ack'], 'memory-region': [[4294967295], [4294967295]], 'firmware-name': ['qcom/sm8550/adsp.mbn', 'qcom/sm8550/adsp_dtb.mbn'], 'power-domains': [[4294967295], [4294967295]], 'power-domain-names': ['lcx', 'lmx'], 'qcom,qmp': [[4294967295]], 'qcom,smem-states': [[4294967295, 0]], 'qcom,smem-state-names': ['stop'], 'glink-edge': {'interrupts-extended': [[4294967295, 3, 0, 1]], 'mboxes': [[4294967295, 3, 0]], 'label': ['lpass'], 'qcom,remote-pid': [[2]]}, '$nodename': ['remoteproc@30000000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.example.dtb: remoteproc@30000000: Unevaluated properties are not allowed ('glink-edge', 'qcom,smem-state-names', 'qcom,smem-states' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221114-narmstrong-sm8550-upstream-remoteproc-v4-2-54154c08c0b7@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

