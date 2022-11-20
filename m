Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175306314CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKTPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKTPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:09:29 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D22D1D4;
        Sun, 20 Nov 2022 07:09:27 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id q83so10253030oib.10;
        Sun, 20 Nov 2022 07:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVGUqFNK7QHl7oagdZ7ol1T74KslFgB97zBDrmW7P5U=;
        b=DhtdZTZvnc13mbldQktvKE2Rf4zivIzrnBizCC1JLUy2ZIKOytW98NHfH/GYM9L8OP
         PM8HgV2MRe2QtiPX/sGud7cEupxBSSQhNML/Iit4jHN1BLRNX2bpRMbgwkFv6rOH6Nos
         VmhJhflqcJN2zFHSdBfIR5Pn1QqEnZ3qESJYjwDNooCMGJ5rNQq4JMDPb92y/g6tjR8a
         gPYZigOON7qLGBgOWLYNTJ9h8VUcDFswbmk3HQNn1Jx3LZDY/lnsRppR2IqaIBRsu0CY
         fDw1WuqU4Wfa+z/gw75ZsFhDRNfNkoq102QpQjdwt/PH3KcOnsZ1cs4AfpksjQ+mn/5J
         WMRg==
X-Gm-Message-State: ANoB5pkq/wiv9RGnKlfCSZMiqMX8CC7Qg8NVP73rhljZtdTGz1+N8oOU
        VSX3aqDcqCh41BNcE2rcoWXYLfYJng==
X-Google-Smtp-Source: AA0mqf5t9jVGZnwDJIFnAQp0beLeBUk4w470fj8UcMal8bLIZI7yowIDLhhJ0BpHZYRywhVfdYjFUw==
X-Received: by 2002:a54:4611:0:b0:35a:1d79:181b with SMTP id p17-20020a544611000000b0035a1d79181bmr10190286oip.8.1668956966705;
        Sun, 20 Nov 2022 07:09:26 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f6:1a48:29f6:113d:266f:a78e])
        by smtp.gmail.com with ESMTPSA id l21-20020a056870f15500b001226d2100f2sm4838243oac.33.2022.11.20.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:09:26 -0800 (PST)
Received: (nullmailer pid 3068618 invoked by uid 1000);
        Sun, 20 Nov 2022 15:09:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Loic Poulain <loic.poulain@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        phone-devel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Wang <wangborong@cdjrlc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephen Boyd <swboyd@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Skladowski <a_skl39@protonmail.com>
In-Reply-To: <20221120133744.24808-2-a39.skl@gmail.com>
References: <20221120133744.24808-1-a39.skl@gmail.com>
 <20221120133744.24808-2-a39.skl@gmail.com>
Message-Id: <166895687938.3066844.689710891045782245.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: add support for the display
Date:   Sun, 20 Nov 2022 09:09:23 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 Nov 2022 14:37:36 +0100, Adam Skladowski wrote:
> Add DPU and MDSS schemas to describe MDSS and DPU blocks on the Qualcomm
> SM6115 platform.
> Configuration for DSI/PHY is shared with QCM2290 so compatibles are reused.
> Lack of dsi phy supply in example is intended
> due to fact on qcm2290, sm6115 and sm6125
> this phy is supplied via power domain, not regulator.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/display/msm/qcom,sm6115-dpu.yaml |  87 ++++++++
>  .../display/msm/qcom,sm6115-mdss.yaml         | 187 ++++++++++++++++++
>  2 files changed, 274 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/display/msm/dpu-common.yaml
./Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/display/msm/mdss-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.example.dtb: display-controller@5e01000: False schema does not allow {'compatible': ['qcom,sm6115-dpu'], 'reg': [[98570240, 585728], [99287040, 8200]], 'reg-names': ['mdp', 'vbif'], 'clocks': [[4294967295, 63], [4294967295, 2], [4294967295, 10], [4294967295, 12], [4294967295, 16], [4294967295, 18]], 'clock-names': ['bus', 'iface', 'core', 'lut', 'rot', 'vsync'], 'operating-points-v2': [[4294967295]], 'power-domains': [[4294967295, 0]], 'interrupts': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['display-controller@5e01000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.example.dtb: display-controller@5e01000: Unevaluated properties are not allowed ('interrupts', 'operating-points-v2', 'ports', 'power-domains' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: mdss@5e00000: False schema does not allow {'#address-cells': [[1]], '#size-cells': [[1]], 'compatible': ['qcom,sm6115-mdss'], 'reg': [[98566144, 4096]], 'reg-names': ['mdss'], 'power-domains': [[4294967295, 0]], 'clocks': [[4294967295, 61], [4294967295, 63], [4294967295, 10]], 'clock-names': ['iface', 'bus', 'core'], 'interrupts': [[0, 186, 4]], 'interrupt-controller': True, '#interrupt-cells': [[1]], 'iommus': [[4294967295, 1056, 2], [4294967295, 1057, 0]], 'ranges': True, 'display-controller@5e01000': {'compatible': ['qcom,sm6115-dpu'], 'reg': [[98570240, 585728], [99287040, 8200]], 'reg-names': ['mdp', 'vbif'], 'clocks': [[4294967295, 63], [4294967295, 2], [4294967295, 10], [4294967295, 12], [4294967295, 16], [4294967295, 18]], 'clock-names': ['bus', 'iface', 'core', 'lut', 'rot', 'vsync'], 'operating-points-v2': [[4294967295]], 'power-domains': [[4294967295, 0]], 'int
 errupts': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[1]], 'phandle': [[3]]}}}}, 'dsi@5e94000': {'compatible': ['qcom,dsi-ctrl-6g-qcm2290'], 'reg': [[99172352, 1024]], 'reg-names': ['dsi_ctrl'], 'interrupts': [[4]], 'clocks': [[4294967295, 4], [4294967295, 7], [4294967295, 14], [4294967295, 8], [4294967295, 2], [4294967295, 63]], 'clock-names': ['byte', 'byte_intf', 'pixel', 'core', 'iface', 'bus'], 'assigned-clocks': [[4294967295, 5], [4294967295, 15]], 'assigned-clock-parents': [[2, 0], [2, 1]], 'operating-points-v2': [[4294967295]], 'power-domains': [[4294967295, 0]], 'phys': [[2]], 'phy-names': ['dsi'], '#address-cells': [[1]], '#size-cells': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[3]], 'phandle': [[1]]}}, 'port@1': {'reg': [[1]], 'endpoint': {}}}}, 'phy@5e94400': {'compatible': ['qcom,dsi-phy-14nm-2290'], 'reg': [[9917
 3376, 256], [99173632, 768], [99174400, 392]], 'reg-names': ['dsi_phy', 'dsi_phy_lane', 'dsi_pll'], '#clock-cells': [[1]], '#phy-cells': [[0]], 'clocks': [[4294967295, 2], [4294967295, 0]], 'clock-names': ['iface', 'ref'], 'phandle': [[2]]}, '$nodename': ['mdss@5e00000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: mdss@5e00000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'interrupt-controller', 'interrupts', 'power-domains', 'ranges', 'reg', 'reg-names' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: display-controller@5e01000: False schema does not allow {'compatible': ['qcom,sm6115-dpu'], 'reg': [[98570240, 585728], [99287040, 8200]], 'reg-names': ['mdp', 'vbif'], 'clocks': [[4294967295, 63], [4294967295, 2], [4294967295, 10], [4294967295, 12], [4294967295, 16], [4294967295, 18]], 'clock-names': ['bus', 'iface', 'core', 'lut', 'rot', 'vsync'], 'operating-points-v2': [[4294967295]], 'power-domains': [[4294967295, 0]], 'interrupts': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[1]], 'phandle': [[3]]}}}, '$nodename': ['display-controller@5e01000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: display-controller@5e01000: Unevaluated properties are not allowed ('interrupts', 'operating-points-v2', 'ports', 'power-domains' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221120133744.24808-2-a39.skl@gmail.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

