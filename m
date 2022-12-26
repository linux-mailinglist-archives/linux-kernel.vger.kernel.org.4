Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7107A656559
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiLZWfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:35:43 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112810BD;
        Mon, 26 Dec 2022 14:35:40 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1433ef3b61fso13785707fac.10;
        Mon, 26 Dec 2022 14:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oX0WsRscSfuA8tilkGcRacZc6TjlOCBKjDCVU7/5xVM=;
        b=0lsEdUoq47wPNaghQpiYt6YMUXlot95qy5xyST70IKe2NtR2XkZI2mgUu7ibiW6dDC
         GCGR6vI4KmtcGmmFWZDiuRbO9VIhZ3+YJd6KGbEd8YX3Zl9F1MEuuXa0iAwJ+tz7Rac0
         Io0zPZym//jyiggqOWjf8THhMhWXMFglPKlbD+Bi8Yn1W0fmCb2IniaCAbizyKr7LKfe
         bwWsrJ52rqqlIGTJDu6tKuRFJADJcfVZSbtJFYn5ggHqR9iGwwtpv8aHAJqfSu5MqzCQ
         +tPLEwmjSPTbnom9kMb3wSBhd1FG4OmUXaHM2R10PEC0hzV8b4+zCIzQPecOc3VwdGk2
         jXkw==
X-Gm-Message-State: AFqh2kq4dHPRt4dY09D9+yEqea/gwkcx8Qrt2OPMvCVmcE/E5RQUDQy7
        mLUdE1qVZMHD9VmZ/6SJ+w==
X-Google-Smtp-Source: AMrXdXsybzoZuet6EB4T+tyDmOkKAdx2023rooVqt3vrMjr9yKXc5usiZeYhUM6FkQ9IxABWewqi0w==
X-Received: by 2002:a05:6870:7387:b0:14b:bdda:7754 with SMTP id z7-20020a056870738700b0014bbdda7754mr13891966oam.37.1672094139839;
        Mon, 26 Dec 2022 14:35:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id y15-20020a056870418f00b00144e18d8525sm5401533oac.25.2022.12.26.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:39 -0800 (PST)
Received: (nullmailer pid 8256 invoked by uid 1000);
        Mon, 26 Dec 2022 18:23:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221226114513.4569-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
Message-Id: <167207881373.4211.1128001945440113741.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Mon, 26 Dec 2022 12:23:46 -0600
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Dec 2022 12:45:11 +0100, Pali Rohár wrote:
> This new optional priority property allows to specify custom priority level
> of reset device. Prior this change priority level was hardcoded to 192 and
> not possible to specify or change. Specifying other value is needed for
> some boards. Default level when not specified stays at 192 as before.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v4:
> * Use restart-handler.yaml
> 
> Changes in v3:
> * Add explanation into commit message
> 
> Changes in v2:
> * Change sint32 to int32
> * Add default
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:57:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/power/reset/syscon-reboot.example.dts'
Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:57:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/power/reset/syscon-reboot.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml
./Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:57:1: found duplicate key "allOf" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/cdrom/packet-writing.rst: Documentation/ABI/testing/sysfs-class-pktcdvd
Documentation/cdrom/packet-writing.rst: Documentation/ABI/testing/debugfs-pktcdvd
tools/power/cpupower/man/cpupower-powercap-info.1: Documentation/power/powercap/powercap.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221226114513.4569-1-pali@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

