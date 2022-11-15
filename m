Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57564629BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKOOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKOOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:19 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC13FD10;
        Tue, 15 Nov 2022 06:11:18 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so5512619otl.7;
        Tue, 15 Nov 2022 06:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TacVoOO9NDNFIMt31qzCtRgln1ccwtifAk7PyC4xZ0s=;
        b=Yc81WYSMHcoQCFkUjglHBXlPO3FslTCzFdfDy8+cbx6s9/JRQVnGlBYJWBcXwsWVcK
         Vqne5MyMZlxsNE/ziQbazFAE45WlMdVJQposhQHNxU3mNbNh0tD+NtwxQVhrUv2mYdc2
         7YCwIWAEHfdzHVEztGWxFlHadSwdmu51xi4VrO1LGopkVNUovMrZn7mLHgpWyhqIQl75
         dH/Z0wdHuWWwZi6xGklO24vv8TKwFE1tOh2u4x0ZLhJS38olUMBYhcvGbmwSiFzBWEoq
         AhdFdhjAgbr+asQIhomOSa2a3+iZ0QUVsh27yJef8F3Ho4+QLv5g/cmqZ/THyrNgHqEN
         1U2w==
X-Gm-Message-State: ANoB5pnFTlq+kR+snLRiNr+BaMQLrxcbesrJ+CDvGdD1WFz0Njj+mEwo
        N5+6yrvbt3ln+9SN2bdd+g==
X-Google-Smtp-Source: AA0mqf41qwNznHD4daQ+Mhz0sumypTqDXe1dh5cjhOzl/ybpdXvQQEyrHv+3a+htI5DwxWlPOz3B+g==
X-Received: by 2002:a05:6830:153:b0:66c:a3a8:3870 with SMTP id j19-20020a056830015300b0066ca3a83870mr8901401otp.54.1668521477402;
        Tue, 15 Nov 2022 06:11:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s5-20020a4adb85000000b00499527def25sm4840834oou.47.2022.11.15.06.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:11:16 -0800 (PST)
Received: (nullmailer pid 908584 invoked by uid 1000);
        Tue, 15 Nov 2022 14:11:14 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, devicetree@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, dianders@chromium.org,
        bjorn.andersson@linaro.org, quic_kalyant@quicinc.com,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        loic.poulain@linaro.org, dmitry.baryshkov@linaro.org,
        daniel@ffwll.ch, angelogioacchino.delregno@somainline.org,
        andersson@kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, sean@poorly.run
In-Reply-To: <20221115111721.891404-3-robert.foss@linaro.org>
References: <20221115111721.891404-1-robert.foss@linaro.org>
 <20221115111721.891404-3-robert.foss@linaro.org>
Message-Id: <166851961892.867704.17058917320073105789.robh@kernel.org>
Subject: Re: [PATCH v2 02/12] dt-bindings: display: msm: Add qcom,sm8350-mdss binding
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


On Tue, 15 Nov 2022 12:17:11 +0100, Robert Foss wrote:
> Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI etc. Add YAML schema for MDSS device
> tree bindings
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../display/msm/qcom,sm8350-mdss.yaml         | 240 ++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/display/msm/mdss-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: display-subsystem@ae00000: False schema does not allow {'compatible': ['qcom,sm8350-mdss'], 'reg': [[182452224, 4096]], 'reg-names': ['mdss'], 'interconnects': [[4294967295, 7, 0, 4294967295, 1, 0], [4294967295, 8, 0, 4294967295, 1, 0]], 'interconnect-names': ['mdp0-mem', 'mdp1-mem'], 'power-domains': [[4294967295, 0]], 'resets': [[4294967295, 0]], 'clocks': [[4294967295, 0], [4294967295, 27], [4294967295, 28], [4294967295, 32]], 'clock-names': ['iface', 'bus', 'nrt_bus', 'core'], 'iommus': [[4294967295, 2080, 1026]], 'interrupts': [[0, 83, 4]], 'interrupt-controller': True, '#interrupt-cells': [[1]], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': True, 'display-controller@ae01000': {'compatible': ['qcom,sm8350-dpu'], 'reg': [[182456320, 585728], [183173120, 8200]], 'reg-names': ['mdp', 'vbif'], 'clocks': [[4294967295, 27], [4294967295, 28], [4294967295, 0], [42
 94967295, 34], [4294967295, 32], [4294967295, 44]], 'clock-names': ['bus', 'nrt_bus', 'iface', 'lut', 'core', 'vsync'], 'assigned-clocks': [[4294967295, 44]], 'assigned-clock-rates': [[19200000]], 'operating-points-v2': [[1]], 'power-domains': [[4294967295, 6]], 'interrupts': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[2]], 'phandle': [[4]]}}}, 'opp-table': {'compatible': ['operating-points-v2'], 'phandle': [[1]], 'opp-200000000': {'opp-hz': [[0], [200000000]], 'required-opps': [[4294967295]]}, 'opp-300000000': {'opp-hz': [[0], [300000000]], 'required-opps': [[4294967295]]}, 'opp-345000000': {'opp-hz': [[0], [345000000]], 'required-opps': [[4294967295]]}, 'opp-460000000': {'opp-hz': [[0], [460000000]], 'required-opps': [[4294967295]]}}}, 'dsi@ae94000': {'compatible': ['qcom,mdss-dsi-ctrl'], 'reg': [[183058432, 1024]], 'reg-names': ['dsi_ctrl'], 'interrupts': [[4]], 'clocks': [[4294967295, 2], [4294967295,
  5], [4294967295, 36], [4294967295, 28], [4294967295, 0], [4294967295, 27]], 'clock-names': ['byte', 'byte_intf', 'pixel', 'core', 'iface', 'bus'], 'assigned-clocks': [[4294967295, 3], [4294967295, 37]], 'assigned-clock-parents': [[3, 0], [3, 1]], 'operating-points-v2': [[4294967295]], 'power-domains': [[4294967295, 6]], 'phys': [[3]], 'phy-names': ['dsi'], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4]], 'phandle': [[2]]}}, 'port@1': {'reg': [[1]], 'endpoint': {}}}}, 'phy@ae94400': {'compatible': ['qcom,dsi-phy-5nm-8350'], 'reg': [[183059456, 512], [183059968, 640], [183060736, 608]], 'reg-names': ['dsi_phy', 'dsi_phy_lane', 'dsi_pll'], '#clock-cells': [[1]], '#phy-cells': [[0]], 'clocks': [[4294967295, 0], [4294967295, 0]], 'clock-names': ['iface', 'ref'], 'vdds-supply': [[4294967295]], 'phandle': [[3]]}, '$nodename': ['display-subsystem@ae00000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'interrupt-controller', 'interrupts', 'power-domains', 'ranges', 'reg', 'reg-names', 'resets' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

