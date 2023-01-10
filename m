Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55CA6641D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjAJN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbjAJN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:29:39 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75094A469;
        Tue, 10 Jan 2023 05:29:34 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id o66so10002852oia.6;
        Tue, 10 Jan 2023 05:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylhyb07nBatqigygjs/qnbUzW1F5v2uWBB/vpftxr7Y=;
        b=fOL7T1IPZD6uNIME7YD7G5MBI/0zaflTOGRlbkP2MkZwPg9Xnu7MlCKmNdieOVkZXY
         Wjl6rsFgxoPhDWVRB5Pb8xmBZIDeMQr7DOBuTlYC2zy2rIt53+p8xAK6uOGRtUCTWlwg
         OOY6DDvQR+0Vz21lcPNZLBZDKQz7QSFo0oi8RqkSfntJNVq+iFMlxMGfgq5bTscg6U81
         dQ3wimX3NmR0uMLnbbuv+xuM9VhgRH27bIxh2dkG788PiXvDSIWVUdcSFCwMSoyuxs6Z
         Zrdq6YCeXRQgPKyUjgmsUdC710iFp/Mj5ts1UyDfyW3I0yhoA2Ztmu7zOARRGtkaF7VV
         2IgA==
X-Gm-Message-State: AFqh2kq42NO0UGGyRTZmN6P5veuwX7aQuRz/BucLbAaUoYKf1nInZyIt
        cGQczCzCACdbv2DeSFblTw==
X-Google-Smtp-Source: AMrXdXtwO/PhRlomM5A6dF6OoKCHg3+XXfeF06MGvncoUKF+PZZ9GgCaWBCAqc7Lt5F6ycb44BfNfg==
X-Received: by 2002:aca:e0d4:0:b0:363:b22c:4c7 with SMTP id x203-20020acae0d4000000b00363b22c04c7mr14883792oig.7.1673357373663;
        Tue, 10 Jan 2023 05:29:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u23-20020a056808001700b0035e7c48d08esm5257608oic.15.2023.01.10.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:29:32 -0800 (PST)
Received: (nullmailer pid 1984999 invoked by uid 1000);
        Tue, 10 Jan 2023 13:29:30 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     devi priya <quic_devipriy@quicinc.com>
Cc:     tdas@codeaurora.org, quic_kathirav@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_gokulsri@quicinc.com,
        nfraprado@collabora.com, linux-arm-msm@vger.kernel.org,
        quic_poovendh@quicinc.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, arnd@arndb.de, sboyd@kernel.org,
        broonie@kernel.org, will@kernel.org, quic_sjaganat@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, linux-gpio@vger.kernel.org,
        p.zabel@pengutronix.de, catalin.marinas@arm.com,
        marcel.ziswiler@toradex.com, linus.walleij@linaro.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        agross@kernel.org
In-Reply-To: <20230110121316.24892-2-quic_devipriy@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-2-quic_devipriy@quicinc.com>
Message-Id: <167335661700.1967953.6789968437095688240.robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: arm64: ipq9574: Add binding descriptions
 for clock and reset
Date:   Tue, 10 Jan 2023 07:29:30 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 17:43:10 +0530, devi priya wrote:
> Adding support for the global clock controller found on
> IPQ9574 based devices
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        |   4 +
>  .../devicetree/bindings/clock/qcom,gcc.yaml   |   9 +-
>  include/dt-bindings/clock/qcom,gcc-ipq9574.h  | 226 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,gcc-ipq9574.h  | 164 +++++++++++++
>  4 files changed, 402 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq9574.h
>  create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq9574.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295, 0], [4294967295, 1], [4294967295, 2], [4294967295]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295, 1], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk', 'pcie_0_pipe_clk', 'pcie_1_pipe_clk', 'ufs_phy_rx_symbol_0_clk', 'ufs_phy_rx_symbol_1_clk', 'ufs_phy_tx_symbol_0_clk', 'usb3_phy_wrapper_gcc_usb30_pipe_clk'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110121316.24892-2-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

