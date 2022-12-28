Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F38658538
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiL1RQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiL1RQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:16:52 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AEB87E;
        Wed, 28 Dec 2022 09:16:51 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id v2so8552010ioe.4;
        Wed, 28 Dec 2022 09:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHfMwaOAV9fi7ueWL2mqIc1grouYvmeBq3yswelgrso=;
        b=bjhChm3Hfmb2xSRTSgswj/nT2k3MBDyOXQUlneX/zlDG4PFn3dpoqWK6JFYi9vUGXw
         XR5slAJmQNuezfr4Qjt9d60BfAvKnhLNbdp9trw7JDlT7ilP0Yggo6m81fc+7RLtkBLp
         YY1oi0+bMDca2czkSAKsWHDI0TYoLzVXiAluEg/+55jzhrxuVE9ELgy8FTkA/J6zm5MS
         UgO+zASxZ53D8v/G0xKjUDgynM4z/ZfDiUxaMF3SBlotRvKg8KdoKL5vwDryTPxut0p+
         h+95Zf6PqWD7MUd64buHkk4macl/EDQUvzmBHyXpBR/42CkJ5jtueWZsJok85Z26OeG+
         09mw==
X-Gm-Message-State: AFqh2krTQGbT5SYO/zMcKr7Ydg46gxElHRO6EpruafY5Li9VkEhXq6HK
        WRhowxD7rEgKkuh7AyzO1Q==
X-Google-Smtp-Source: AMrXdXuqOhuydqoQh6LM+Q1TGzx6ph5WP1cYnBRmcVnCotV8vYKiaASi4zDljOx5xBH5l20Bxr6vNQ==
X-Received: by 2002:a6b:4114:0:b0:6df:dc79:a205 with SMTP id n20-20020a6b4114000000b006dfdc79a205mr15104766ioa.20.1672247811344;
        Wed, 28 Dec 2022 09:16:51 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v1-20020a056602058100b006bb57cfcb88sm6057433iox.44.2022.12.28.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:16:51 -0800 (PST)
Received: (nullmailer pid 1928461 invoked by uid 1000);
        Wed, 28 Dec 2022 17:16:44 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     andersson@kernel.org, p.zabel@pengutronix.de, j-luthra@ti.com,
        robh+dt@kernel.org, praneeth@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, nm@ti.com, devarsht@ti.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20221228123655.15384-2-hnagalla@ti.com>
References: <20221228123655.15384-1-hnagalla@ti.com>
 <20221228123655.15384-2-hnagalla@ti.com>
Message-Id: <167224753896.1921532.11791738136486951543.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: k3-dsp: update bindings for
 AM62A SoCs
Date:   Wed, 28 Dec 2022 11:16:44 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Dec 2022 06:36:54 -0600, Hari Nagalla wrote:
> The TI AM62A SoCs have a C7xv DSP and Analytics engine for deep
> learning purposes. The DSP part is similar to the C71x DSP found on
> K3 J7 SoCs, but additional hardware accelerators and IP are added to
> the subsystem for deep learning.
> 
> Compatible info is updated to match AM62A SoCs.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml:116:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts'
Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml:116:1: found character '\t' that cannot start any token
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml:116:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221228123655.15384-2-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

