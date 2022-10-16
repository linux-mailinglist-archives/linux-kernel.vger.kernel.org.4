Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D059E600412
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJPW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJPW6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:58:24 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE832B9B;
        Sun, 16 Oct 2022 15:58:23 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n130so10472865oia.6;
        Sun, 16 Oct 2022 15:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A22Jauy7LNRDNuhvPuiWffS/7WEdlZGpv0lUu6wktOU=;
        b=tjl0DNXyZXseuxcBezm7x0qbft7x1v7zGCfP5jvbJ/lYrZdhqMQwtpCWOWXHrs4hwf
         XFhYmmSKNkdQu9xUW+7yJ06MO3w4BnrFhjGQyC/RGhQsvgNo7xlMyv9YaawfWfg6CHeJ
         asUxyrSAeWjZX1VR8yMVgakolNRXFJ+F7dliLzddsVB6yfGAkMkMTvjacphBpqOD7tup
         Py5zCfiTj2bwUWwIMMLODEMpjwnqr7YZH6nhFVL31WzGunr0HfNxmMbueGvc0aljSJDe
         V+1CXs6RgZQlp/hDdNv20gMbT9CvAIsWLln6MqO3KEtWDuiorKz01V626/iy5EuKZJ+9
         A6Bw==
X-Gm-Message-State: ACrzQf3s0UgsLhZC7dK0zLqfGFX9iC1t9raBsxPd4mBgxjUZ8uBlgPhr
        mEdLR7Z3TdA5Dx5Pa/HMSQ==
X-Google-Smtp-Source: AMsMyM7/JNd+JtwlZy7i5d/Z+UtIZM/Wkab6jBp3h69lrLIVsSh+Oi/U3tK6BY8sFZHjRxSU8yW+LA==
X-Received: by 2002:a05:6808:219a:b0:354:daec:53cb with SMTP id be26-20020a056808219a00b00354daec53cbmr3503273oib.2.1665961102216;
        Sun, 16 Oct 2022 15:58:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 64-20020a9d04c6000000b00661cc94f035sm4165401otm.41.2022.10.16.15.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 15:58:21 -0700 (PDT)
Received: (nullmailer pid 3904626 invoked by uid 1000);
        Sun, 16 Oct 2022 22:58:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221014221138.7552-2-quic_molvera@quicinc.com>
References: <20221014221138.7552-1-quic_molvera@quicinc.com> <20221014221138.7552-2-quic_molvera@quicinc.com>
Message-Id: <166596080339.3896245.9931514726714981073.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
Date:   Sun, 16 Oct 2022 17:58:18 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 15:11:36 -0700, Melody Olvera wrote:
> Document the QDU1000 and QRU1000 SoC bindings and the boards that use
> them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/qcom.yaml:496:18: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/qcom.example.dts'
Documentation/devicetree/bindings/arm/qcom.yaml:496:18: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/arm/qcom.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/qcom.yaml:496:18: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom.yaml: ignoring, error parsing file
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

