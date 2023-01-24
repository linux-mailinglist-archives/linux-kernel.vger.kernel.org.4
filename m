Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B667A25E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjAXTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAXTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:06:39 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956C4DCD7;
        Tue, 24 Jan 2023 11:06:18 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id h3-20020a4ac443000000b004fb2954e7c3so2785486ooq.10;
        Tue, 24 Jan 2023 11:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zOsAeVeoSP5y0PXnd29TY9147nVFljKF4SWYsX6McA=;
        b=fxpJeJTiJDzTzcq7fxq9eiC1CF70mNAdbMiNcP/NIGmufjliMa0xYxzPJiZv/HzJmi
         RH3nz8Fvb86lujl8o/hh+st2cCgnNpcmCmvyk2tdkX5Y7w/+YFlUoD8aUpbefuG/U8OT
         933qUkTnHBdSmQ9ZeTSlFS3LFPbZ09rrwWPpjMDYaPa++L2Ireawhhp1z5yQ9BhSLfB0
         Hg/Qxq1La7e2a1DzkRIdNsfntQ7WVtJoYbCBXBINcndlU4jM3VfD4H3C0yk3xkfKi7x2
         cKFkMXnYWIMYVXADmiLy+yXMONcm2GCCuRzHXkCL2oZwrbUe2/gLPU+FFW5RbiMpQZSD
         RM5Q==
X-Gm-Message-State: AFqh2kpugfzH+OF1xw1MG0bypBmM5dc/fRK6NNbpKXWYdAsmR0Zb7xdi
        C0vb/p3fn3d+wwT9RyiH3A==
X-Google-Smtp-Source: AMrXdXt9DHpIlN+z/n8VyspGsPRK6b/qCM28zV8M13m6W05TnvExavuHduH/MfvUfPEIoF6iKsfeSA==
X-Received: by 2002:a4a:d757:0:b0:502:5eae:e506 with SMTP id h23-20020a4ad757000000b005025eaee506mr6904642oot.2.1674587177167;
        Tue, 24 Jan 2023 11:06:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a4ae40e000000b004f29c6fb6besm1054913oov.31.2023.01.24.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:06:16 -0800 (PST)
Received: (nullmailer pid 1261082 invoked by uid 1000);
        Tue, 24 Jan 2023 19:06:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manuel Traut <manuel.traut@mt.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <Y9AJ07zT1lpBLhPk@mt.com>
References: <Y9AJ07zT1lpBLhPk@mt.com>
Message-Id: <167458712310.1259438.16687606512438665063.robh@kernel.org>
Subject: Re: [PATCH 1/5 v7] dt-bindings: input: pwm-beeper: Convert txt
 bindings to yaml
Date:   Tue, 24 Jan 2023 13:06:15 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 17:39:47 +0100, Manuel Traut wrote:
> Converts txt binding to new YAML format.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/pwm-beeper.yaml:10:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/input/pwm-beeper.example.dts'
Documentation/devicetree/bindings/input/pwm-beeper.yaml:10:1: found character '\t' that cannot start any token
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/input/pwm-beeper.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/input/pwm-beeper.yaml:10:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/pwm-beeper.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Y9AJ07zT1lpBLhPk@mt.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

