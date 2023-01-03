Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEF65CA97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjACX6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjACX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:57:59 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9D13D59;
        Tue,  3 Jan 2023 15:57:58 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id y4so17428083iof.0;
        Tue, 03 Jan 2023 15:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCBM6izNbuTn4BbZDCMu2fZHONyHP+YTrXpo1NPkZzM=;
        b=8Pf+KIBnNTgobxEQsRLgG8+RoAcWex9yUxwl8W7sgLA+tas56xaksPhiXbt3o681IJ
         tix0eTzJvXgTt1S5bEGB64UIbVIO5QrvvaZS3vTW9cWegMQdi3CqHNFxm0vpCtJvIYKq
         QI6Y1Z3Ve9jNKt2ZXwaT/JSxq5T+q6rAYWpTC9wjeDwI72krsPDLtupuiXoiNslnSAfl
         zg5e8lTCyUZclpnRgslmetfsD9Alft7mMbMMpHZ8GMYwKSFket/hagNOAg7t03r/wHOp
         tZ78kCWIhErBRKP7MZkxKw0KR+/s1ga5noY2uQelJd568f1Hp/V1nMo2vS4FZy0xpjHg
         lEpg==
X-Gm-Message-State: AFqh2koEF7H22RfUMq5jHt1eNtEAvIiZBLTlOkoCW4mWo1fi+TBonyfW
        tBIZL24dqw5BaC88374fOMrLDRh7CA==
X-Google-Smtp-Source: AMrXdXv0r9ni148+UL/DzqY7hvwzjYZzGtxk347OR1XVsUMtSMZalr+iOfUguy5QsabosSFgEXvx2g==
X-Received: by 2002:a6b:7d0d:0:b0:6e6:726a:bd80 with SMTP id c13-20020a6b7d0d000000b006e6726abd80mr35977379ioq.6.1672790277508;
        Tue, 03 Jan 2023 15:57:57 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d84ce000000b006e2f2369d3csm11486637ior.50.2023.01.03.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:57:57 -0800 (PST)
Received: (nullmailer pid 96022 invoked by uid 1000);
        Tue, 03 Jan 2023 23:57:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230103192158.1155197-2-abel.vesa@linaro.org>
References: <20230103192158.1155197-1-abel.vesa@linaro.org>
 <20230103192158.1155197-2-abel.vesa@linaro.org>
Message-Id: <167278476359.4159651.9551364831180681931.robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: clock: Add SM8550 TCSR CC clocks
Date:   Tue, 03 Jan 2023 17:57:55 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Jan 2023 21:21:55 +0200, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8550-tcsr.yaml      | 55 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8550-tcsr.h  | 18 ++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.example.dts:23.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230103192158.1155197-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

