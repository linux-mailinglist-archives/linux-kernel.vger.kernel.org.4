Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078D629B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKOOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKOOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:17 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE7656D;
        Tue, 15 Nov 2022 06:11:16 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso2225683otl.13;
        Tue, 15 Nov 2022 06:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EqWqP263F0VBi+wp6NIdMw44Os0nhYFuBkjSSobCBrM=;
        b=1bop19wabKm90YAFbXXGpFoIrDJnznYli72qMUE1a50/2+aSF8ho7Vi3Asl6Fk4zJo
         besrXKmEZ1yK5Eh7G8RVzFb/kR1F2Ht3MoZnOKZIUng3dFVAOCAECXqrGixFBfwJsIq9
         qDSDocxxPubBfMfONI7zJ2Yey04boZfkGxCIXwDX2EHsJMZz5nh+KUPl6e8Bi31GezPF
         JUM/LIDmcbimSS2QYIEAGaf4bKbkoQAc0mX/Syq0H3Y5IizsPifLq9y0MLLScZ8vpzJr
         1smzsQrDHzzBAL1B6Z2DGketq9trVroxttBAmdtnOl08fVuJswRCdDENvv/PcUf6S2vb
         625g==
X-Gm-Message-State: ANoB5plK46P09v5UB00pf5cwCOQGIyVHGUQUAe7spfK8360m0rrVoS1u
        6tPTtwzZMj9ptxTY8PmC2Q==
X-Google-Smtp-Source: AA0mqf79qA6Fs+UZ4mUVQEbyhd/P9Pj/81uhRm470TyNwj7sRxVAqBNhJBdEn+OuAqL6o613cSb4XA==
X-Received: by 2002:a05:6830:20ca:b0:66c:4f87:fd14 with SMTP id z10-20020a05683020ca00b0066c4f87fd14mr8909225otq.159.1668521475440;
        Tue, 15 Nov 2022 06:11:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 185-20020aca06c2000000b0035a5b95bd38sm4915712oig.54.2022.11.15.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:11:14 -0800 (PST)
Received: (nullmailer pid 908582 invoked by uid 1000);
        Tue, 15 Nov 2022 14:11:14 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     quic_vpolimer@quicinc.com, agross@kernel.org,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        quic_jesszhan@quicinc.com, Jonathan Marek <jonathan@marek.ca>,
        quic_kalyant@quicinc.com, airlied@linux.ie,
        konrad.dybcio@somainline.org, freedreno@lists.freedesktop.org,
        robdclark@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        loic.poulain@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, daniel@ffwll.ch, vinod.koul@linaro.org,
        angelogioacchino.delregno@somainline.org,
        devicetree@vger.kernel.org, sean@poorly.run,
        quic_abhinavk@quicinc.com
In-Reply-To: <20221115111721.891404-2-robert.foss@linaro.org>
References: <20221115111721.891404-1-robert.foss@linaro.org>
 <20221115111721.891404-2-robert.foss@linaro.org>
Message-Id: <166851961813.867662.5795540352280640159.robh@kernel.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: display: msm: Add qcom,sm8350-dpu binding
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


On Tue, 15 Nov 2022 12:17:10 +0100, Robert Foss wrote:
> Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI etc. Add YAML schema for DPU device
> tree bindings
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8350-dpu.yaml | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/display/msm/dpu-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.example.dtb: display-controller@ae01000: False schema does not allow {'compatible': ['qcom,sm8350-dpu'], 'reg': [[182456320, 585728], [183173120, 8200]], 'reg-names': ['mdp', 'vbif'], 'clocks': [[4294967295, 27], [4294967295, 28], [4294967295, 0], [4294967295, 34], [4294967295, 32], [4294967295, 44]], 'clock-names': ['bus', 'nrt_bus', 'iface', 'lut', 'core', 'vsync'], 'assigned-clocks': [[4294967295, 44]], 'assigned-clock-rates': [[19200000]], 'operating-points-v2': [[1]], 'power-domains': [[4294967295, 6]], 'interrupts': [[0]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, 'opp-table': {'compatible': ['operating-points-v2'], 'phandle': [[1]], 'opp-200000000': {'opp-hz': [[0], [200000000]], 'required-opps': [[4294967295]]}, 'opp-300000000': {'opp-hz': [[0], [300000000]], 'required-opps': [[4294967295
 ]]}, 'opp-345000000': {'opp-hz': [[0], [345000000]], 'required-opps': [[4294967295]]}, 'opp-460000000': {'opp-hz': [[0], [460000000]], 'required-opps': [[4294967295]]}}, '$nodename': ['display-controller@ae01000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.example.dtb: display-controller@ae01000: Unevaluated properties are not allowed ('interrupts', 'operating-points-v2', 'opp-table', 'ports', 'power-domains' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

