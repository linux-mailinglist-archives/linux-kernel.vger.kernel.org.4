Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D066264173E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLCOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:19:56 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BF2018D;
        Sat,  3 Dec 2022 06:19:53 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id o5-20020a4aa805000000b004a020f841cbso1092461oom.3;
        Sat, 03 Dec 2022 06:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MTgd+n7LWusiGOC/Gub2PoyKrV2kI0pnTuI95oFDai0=;
        b=BDVneJCxIrMna9yC+EpEf1j1Hbqu3pcPoJi5CMWgTijdGMglsyuYUONh3qkwJQ+5jw
         VcoBTNQf1629Ds1Z/Hj/GCHPi2xJ6OjCT8d9Ol73ipsxN39ZLolMjFAFrW62/7P1reDb
         OGLb3pw/zJqS7dIvSSnQkMVaSjezbxRSpzruNUfQ25Q1N+X7U52WapD8lspytaiCKR6y
         NsIOv4fwCbwr29rM/7Kqje00KEPeQHjoqIqOTE1R/xYyIaZtey+876irAaYGPEyVUN0V
         CO3rZ/viqCelPJgNoo/5L6niZPMqpxwm7JhseYGszV6ixGKxfQkndcNwj2cmWWugnrTr
         qRjg==
X-Gm-Message-State: ANoB5pmzGw0meUQhbSYYkbQMxuATFK+TnwgF+LckpMkMiwEmWnv5eGQB
        SZNNsfrhG4fAyoe8yRzHdSQ+IY5/lw==
X-Google-Smtp-Source: AA0mqf6Ehf7v80eg1GhYvnEpyx8HUbLu9JP+5En8/00R6WxVWYs8KVfvWUUSlsVbZ3BaLed0gqqgNw==
X-Received: by 2002:a4a:b813:0:b0:49f:8d3:14f4 with SMTP id g19-20020a4ab813000000b0049f08d314f4mr32275886oop.80.1670077192169;
        Sat, 03 Dec 2022 06:19:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a4adbc4000000b0049f5ce88583sm4105243oou.7.2022.12.03.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 06:19:51 -0800 (PST)
Received: (nullmailer pid 1270254 invoked by uid 1000);
        Sat, 03 Dec 2022 14:19:51 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20221202232054.2666830-2-abel.vesa@linaro.org>
References: <20221202232054.2666830-1-abel.vesa@linaro.org>
 <20221202232054.2666830-2-abel.vesa@linaro.org>
Message-Id: <167007709608.1267842.9280978291039468846.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Sat, 03 Dec 2022 08:19:51 -0600
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


On Sat, 03 Dec 2022 01:20:53 +0200, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes since v4:
>  * Added Krzysztof's R-b tag
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221202232054.2666830-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

