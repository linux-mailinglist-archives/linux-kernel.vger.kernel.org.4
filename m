Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313663D717
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiK3Nrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK3Nrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:47:40 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8EC1101;
        Wed, 30 Nov 2022 05:47:38 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id t62so18728498oib.12;
        Wed, 30 Nov 2022 05:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gak/3RKX7XYoG4HonhN+fE0X+MnSoJz/FUAaVKDSypw=;
        b=DspuHJva8xCGOWNNyGrBt0tCvHOecmGce6tIWDMb68DIfgDd1V1xvRz7zm1LGakFub
         DDRNevXn8ONh4yJRyk1JzuLjuTmdPkQHmxcmhbS1ZnGfn8p9pr9uQXcM1AUPEtRzGgYB
         MisZiDnZcE4WTgn509ba5IjrMdgYHIxrf16PJRI7Degxk2f61PwHcP0RY/zPPRf72BpF
         b2nS2opap0tD5k/fDjPhYB1Y+V40ub0hKcl6fMCPhND8ToJfKWwcSHvuCRraUxDpJ05+
         Olj1YNTJsSBtSrz5HaV1rvoXTaz42LrxLYezFdYbU9OkWKh0W9UI9rTwFR/wJDmgqiAI
         7iLQ==
X-Gm-Message-State: ANoB5pn+VHPaw/wtRke9MA/Et0qnnOugW8r2Xn/EBhCZEMkP8/ptQWY5
        IlZt4OauO7P/db3cOgjXjw==
X-Google-Smtp-Source: AA0mqf6fMAoP/58oEsz3Wca9wUM11OobHl3sPwSCVzO8EB7MwtdlW8G2g9IbykGNOR0G2UCElHT3mw==
X-Received: by 2002:aca:1004:0:b0:350:d543:7554 with SMTP id 4-20020aca1004000000b00350d5437554mr31513963oiq.251.1669816057469;
        Wed, 30 Nov 2022 05:47:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cv31-20020a056870c69f00b00143cfb377b4sm1214314oab.6.2022.11.30.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:47:36 -0800 (PST)
Received: (nullmailer pid 1848613 invoked by uid 1000);
        Wed, 30 Nov 2022 13:47:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-2-12bc22255474@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v2-2-12bc22255474@linaro.org>
Message-Id: <166981596760.1846592.11317546499813728073.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: remoteproc: qcom: adsp: document
 sm8550 adsp, cdsp & mpss compatible
Date:   Wed, 30 Nov 2022 07:47:34 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Nov 2022 11:29:46 +0100, Neil Armstrong wrote:
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
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 195 +++++++++++++++++++++
>  1 file changed, 195 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221114-narmstrong-sm8550-upstream-remoteproc-v2-2-12bc22255474@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

