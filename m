Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0045C64F97F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLQOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLQOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:47:07 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A812ABC;
        Sat, 17 Dec 2022 06:47:06 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id i127so3233424oif.8;
        Sat, 17 Dec 2022 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H5syX+qSmHurj2XiBG1knkx8RD2uoui+as7dCzawJEg=;
        b=IYpm8LPvbEYY36/+O7lWYBuM2Nfkbcz/wOtQV/GNoSlRjOf4UHPTw+lnY8CXrnNnB8
         vAqr2cXYcA8EsJX4zd7KiYHVcC3zBhJEpTEorscnbfoSMI1oYO0lD/DIuOcrdSDtbAzp
         r63msSYmtOSHZzWGSPVDaSOhNIZ87Enm5rfAcBUVEKZ1+UDxTtUgI3oVAvFY12yiZ+yR
         fHQVzpI3529aAv+i0W0TyU7dWdek2idO+piYlVE9P8M0qxq6VL6xzpuM1t36FP0xnHxp
         L6xkdpcJFKtXI/mc0Xr9JikmLSCxkP4FAiF5VSRlnkOd7ADagaPiGwSpLIEpJcysHrfB
         G2Ww==
X-Gm-Message-State: ANoB5pkLtssYSnDyMj7IeY+k+6v/GBqYlgXc9KCUWygZDbgquysBKCan
        b5umxNVAq10GlS3q03ByTAKuAENS1w==
X-Google-Smtp-Source: AA0mqf6LezE/1MlnqkahESlqzHzfohkqG8yMKqud0ueew2YZanl1DRlhpQjWaCSA8oCg2Voujzfjew==
X-Received: by 2002:a05:6808:d5:b0:35e:b805:e34b with SMTP id t21-20020a05680800d500b0035eb805e34bmr6927835oic.15.1671288425769;
        Sat, 17 Dec 2022 06:47:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020aca1709000000b0035ec1384c9esm2102728oii.23.2022.12.17.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 06:47:05 -0800 (PST)
Received: (nullmailer pid 1510847 invoked by uid 1000);
        Sat, 17 Dec 2022 14:47:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216230722.21404-2-quic_molvera@quicinc.com>
References: <20221216230722.21404-1-quic_molvera@quicinc.com>
 <20221216230722.21404-2-quic_molvera@quicinc.com>
Message-Id: <167124498396.424274.14851039167580060223.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks
Date:   Sat, 17 Dec 2022 08:47:04 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Dec 2022 15:07:21 -0800, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,qdu1000-gcc.yaml      |  51 +++++
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h  | 175 ++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qdu1000-gcc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.example.dtb: clock-controller@100000: '#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221216230722.21404-2-quic_molvera@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

