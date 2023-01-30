Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1368187C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3SQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjA3SQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:16:14 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AA44BF8;
        Mon, 30 Jan 2023 10:16:09 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so1713796otj.4;
        Mon, 30 Jan 2023 10:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7bb455SP8TO1b2p4o1VPwtrIH2klzrLn8qwOehGPvI=;
        b=R9uzLqsGJ790Jdn1vUMi11/uarnRhHJ8F4Fxc+9SpFUrAf6E7BAwCfgiKcGq/Y5XWg
         NL6vAvV5/YvbTlwGHsu1nnqw1iBMQazJTKv6XSpfZuNF9zxoA8VG3S1QaTatQFN2jvHa
         OGzJrzqCIERTC9Kt+bGrzoHvP0GOzm5IBOJzv5I7Po3OCtKaGAC5gVKoXODpEmmtJvkH
         rzlKB6FXXht3NGsphzGi12ZkOTC8yanN8+Bnwj1qqFzDELCaJKStl5eNeKSSj3Q8VjLQ
         UBKx6P0P8OROJRQaSz/4S1iy3aeCumZS3gNSPUPFoNJjw51rddXPvsjZtlzZnq49yITu
         dcRQ==
X-Gm-Message-State: AO0yUKV14Mw0FQBX1e4z/G7CCI5S7WFBiVcGMMzb7B2FgcoQEOzSWXSk
        1zgbYC+3Xs9rOzSoetmO+Q==
X-Google-Smtp-Source: AK7set8FrVHMNoEHAdLjytXCeX5uEnWuM2t6vdS0Beh/CVdEt/BsnVh76wgyLd1X+eb1EX1hfyXuJw==
X-Received: by 2002:a9d:410a:0:b0:68b:d1c7:4eb4 with SMTP id o10-20020a9d410a000000b0068bd1c74eb4mr2404075ote.16.1675102568352;
        Mon, 30 Jan 2023 10:16:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h5-20020a056808014500b003785996ef36sm1111724oie.19.2023.01.30.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:16:07 -0800 (PST)
Received: (nullmailer pid 3060316 invoked by uid 1000);
        Mon, 30 Jan 2023 18:16:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        andersson@kernel.org, Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20230130153252.2310882-8-konrad.dybcio@linaro.org>
References: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
 <20230130153252.2310882-8-konrad.dybcio@linaro.org>
Message-Id: <167510252236.3059233.560325193993095939.robh@kernel.org>
Subject: Re: [PATCH v3 7/8] dt-bindings: clock: Add Qcom SM6115 GPUCC
Date:   Mon, 30 Jan 2023 12:16:07 -0600
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


On Mon, 30 Jan 2023 16:32:51 +0100, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for Qualcomm
> Technology Inc's SM6115 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v2 -> v3:
> 
> - Mention resets in description:
> - Use gcc.yaml
> 
>  .../bindings/clock/qcom,sm6115-gpucc.yaml     | 58 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm6115-gpucc.h | 36 ++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6115-gpucc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.example.dtb: clock-controller@5990000: '#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230130153252.2310882-8-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

