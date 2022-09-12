Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FA5B5D61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiILPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiILPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:38:24 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954A38693;
        Mon, 12 Sep 2022 08:38:17 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id p15-20020a056830130f00b006544f5228e3so6137872otq.2;
        Mon, 12 Sep 2022 08:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=a25yavm4T3/wy75F/lXl3Zv2sYUZapqJNpfJrj3sw9M=;
        b=NIlmTwCdmCuBzJ/pL2V1vmkf0e+xiwJrYuBBh9kpTvfavz0YPA8e3EcWW0VVN/qJ+r
         sqEOc6HY//2G7Gke8ZBoO7RwKA/S6OHK0xhdwcdUIton3IuRRBoDHk8TofRIS+JvYZRj
         kaefILYYStYOHlAx5CGvQJX1GZkxUuu7YpYyBGdBKRna/9++kbF20WyxaS34kn2pss9e
         e2ZSqQis30ClHl85mV2Ci065s77OmwqYLbHqxLqIjYBmzYC9r0Ha7n2tW4EQR8D58rDI
         XZ1OFV1rVNkmV3XpO4ZEvDKKvLylipSu8LvCYYEZDJsUE4XAvnVwuV9LrBJETu3Xm9rS
         vRfw==
X-Gm-Message-State: ACgBeo2T2SaBWJly2VRCFIJ69bGH0Mj3EldYxQ8+feRvLxK+m+GYuTaX
        HS7QJ65ZDnQJFXXqcCsLCw==
X-Google-Smtp-Source: AA6agR40YLfHysBKsNn0RPEoPnwyWujca3ESVSwkwCC/stqY2qeM4q+R36/DqLyx+1UAXTU09JpIwQ==
X-Received: by 2002:a05:6830:2644:b0:638:9e31:89d2 with SMTP id f4-20020a056830264400b006389e3189d2mr10907859otu.117.1662997096476;
        Mon, 12 Sep 2022 08:38:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b9-20020a4aba09000000b0044b125e5dabsm4217474oop.35.2022.09.12.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:38:16 -0700 (PDT)
Received: (nullmailer pid 1345585 invoked by uid 1000);
        Mon, 12 Sep 2022 15:38:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, andersson@kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, rafael@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org> <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH 3/4] dt-bindings: thermal: Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings
Date:   Mon, 12 Sep 2022 10:38:15 -0500
Message-Id: <1662997095.474707.1345584.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 14:20:48 +0530, Bhupesh Sharma wrote:
> Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings.
> 
> Qualcomm QMI based TMD cooling device(s) are used for various
> mitigations for remote subsystem(s) including remote processor
> mitigation, rail voltage restriction etc.
> 
> Each child node represents one remote subsystem and each child
> of this subsystem in-turn represents separate TMD cooling device.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: rafael@kernel.org
> Cc: andersson@kernel.org
> Cc: robh@kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/thermal/qcom,qmi-tmd-device.yaml |  78 +++++++++++
>  .../bindings/thermal/qcom,tmd-device.yaml     | 122 ++++++++++++++++++
>  include/dt-bindings/thermal/qcom,tmd.h        |  14 ++
>  3 files changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
>  create mode 100644 include/dt-bindings/thermal/qcom,tmd.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,adsp.example.dtb: adsp: 'qcom,instance-id' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,adsp.example.dtb: adsp: 'clock-names', 'clocks', 'compatible', 'cx-supply', 'interrupt-names', 'interrupts-extended', 'memory-region', 'qcom,smem-state-names', 'qcom,smem-states', 'smd-edge' do not match any of the regexes: '^tmd-device[0-9]?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

