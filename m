Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC82677D03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAWNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjAWNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:49:06 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA51701;
        Mon, 23 Jan 2023 05:49:05 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id o66so10384322oia.6;
        Mon, 23 Jan 2023 05:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lqOumL3KduCMWlmYCLOi0nP7JGRGPZs09Nu01ylX9A=;
        b=3ZPeKcC+6v8a1V9Kib7RnCetH4VswQy4i/4cCqY/J+OFwe51mRxnJCkdH+rfCBkV2S
         WoiXP8f0yshy6acJMOjMB5IaF2YFf3Kj50PZjd2T4Q+EjQdxlyxv0Lr1XXW+MVe+ayBS
         u+xkPBK0UYc/aG9IBncrmyJ3og0ahHxErnYuIS4iMH9ajUS0N2lXTA/3ZS3dpk4fkCLZ
         jcJZl1hMuU8Ifo618tdfhnhYw2xYkkbo70liIBI5lGQUmvLzWV63nUa8sSDniOaXOC8f
         BFSaob3+clmsxR+sPqEt63zvzNq0JmYWrfI3EEaYMA7r3Tukn0ZUB5F5yD+ZR1J7BrxE
         AywA==
X-Gm-Message-State: AFqh2kqv7SfT/Yo0Ww8jZPH9z764kkONKm8eIKOMNetak21Fcj3719DQ
        xeJPGjYbI2De0CwQaZvK8Aw6gqwCqw==
X-Google-Smtp-Source: AMrXdXtjPmZ6lmAoz1wBbGbSlXRK6GaMUbNV13wEmtGrhMWbVHH+1FceJFCUKleTNQKt2TEvf0A8ew==
X-Received: by 2002:aca:ea05:0:b0:35a:74f9:4f46 with SMTP id i5-20020acaea05000000b0035a74f94f46mr18867465oih.30.1674481744756;
        Mon, 23 Jan 2023 05:49:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v63-20020acaac42000000b003670342726fsm10662621oie.12.2023.01.23.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:49:04 -0800 (PST)
Received: (nullmailer pid 1354420 invoked by uid 1000);
        Mon, 23 Jan 2023 13:49:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, stephan@gerhold.net,
        agross@kernel.org, djakov@kernel.org, shawn.guo@linaro.org,
        fabien.parent@linaro.org, dmitry.baryshkov@linaro.org,
        leo.yan@linaro.org, andersson@kernel.org
In-Reply-To: <20230123023127.1186619-2-bryan.odonoghue@linaro.org>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-2-bryan.odonoghue@linaro.org>
Message-Id: <167448142490.1341243.15159926410174126977.robh@kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: msm8939: Move msm8939 to a
 distinct yaml file
Date:   Mon, 23 Jan 2023 07:49:02 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Jan 2023 02:31:22 +0000, Bryan O'Donoghue wrote:
> The MSM8939 has two DSI controllers as opposed to the MSM8916 which has
> one. As a consequence we need to document some additional clocks provided
> by the MSM8939 GCC which are not provided by MSM8916.
> 
> Move the declaration of the MSM8939 super-set of clocks to an MSM8939
> specific yaml file.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-msm8916.yaml      |  7 +-
>  .../bindings/clock/qcom,gcc-msm8939.yaml      | 87 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.example.dts:18:18: fatal error: dt-bindings/clock/qcom,rpm.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,rpm.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230123023127.1186619-2-bryan.odonoghue@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

