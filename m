Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9163D858
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiK3OiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK3OiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:38:20 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48192D1EE;
        Wed, 30 Nov 2022 06:38:18 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322d768ba7so21199567fac.5;
        Wed, 30 Nov 2022 06:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=43xx9qXCrz3F8S6qKQa/eXVCPWGL75F49yrEq5R54q8=;
        b=IBhtpIFlLPo21J6/q9llYogJ04glnWB6B1UD02Csreifk9x6ZmQBk+Z6gk1NQwjBKp
         l2bD3FEK0ccKU4/sCS1huel+/ESHnb2ApfxOYopqWHZKZeqTuzk/kx1OLMZVNf5oSxTk
         I01/1LSEKjXeVX7M+FIJHMejAfbvdgSqsKV1R0tMyM1a9MXciBf8vN9YalgeqpChvVzN
         ov7zHy2Bmi5u0+ug4MlxywwCD+W8feuAFssfhlcropuOQ1lGhwSdY2Le/1lubrg0efLT
         BT6M3PeMZRIVYVrtCyQBeKY02YmkFwxRtLoHpqanywF+17DPL0xIH88hOArcIMt9lX41
         APAA==
X-Gm-Message-State: ANoB5plaxnq9UQ2PC1GiQFm7npXgilehkARiEftMQRJ5isw/gklyUkPe
        iZuY+RFez1Mq21bvUBhdOkjTadVQNQ==
X-Google-Smtp-Source: AA0mqf79hdNMKYx0txvg9ckRZy0JkGHEHBqBvnJbWTqho7minJHj6ftuvOmsKTTf6XvzSczucPaEfQ==
X-Received: by 2002:a05:6871:aa:b0:13b:ccc0:b292 with SMTP id u42-20020a05687100aa00b0013bccc0b292mr36788300oaa.258.1669819098028;
        Wed, 30 Nov 2022 06:38:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i6-20020a9d53c6000000b0066cacb8343bsm1005861oth.41.2022.11.30.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:38:17 -0800 (PST)
Received: (nullmailer pid 2122811 invoked by uid 1000);
        Wed, 30 Nov 2022 14:38:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221130132059.3145243-2-abel.vesa@linaro.org>
References: <20221130132059.3145243-1-abel.vesa@linaro.org>
 <20221130132059.3145243-2-abel.vesa@linaro.org>
Message-Id: <166981906152.2121820.815257956142894552.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Wed, 30 Nov 2022 08:38:16 -0600
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


On Wed, 30 Nov 2022 15:20:58 +0200, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v3:
>  * Dropped qcom,sm8550-rpmh.h and qcom,rpmh.h from examples
>  * Added the header for interconnect IDs to the top-level description
>  * Fixed examples indentation
> 
>  .../interconnect/qcom,sm8550-rpmh.yaml        | 139 +++++++++++++
>  .../interconnect/qcom,sm8550-rpmh.h           | 190 ++++++++++++++++++
>  2 files changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm8550-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,sm8550-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221130132059.3145243-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

