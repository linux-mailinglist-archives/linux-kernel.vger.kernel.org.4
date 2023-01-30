Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35075681501
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjA3P3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjA3P3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:29:05 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F50710AB2;
        Mon, 30 Jan 2023 07:29:04 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1636eae256cso11135494fac.0;
        Mon, 30 Jan 2023 07:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Re9Y3gSh85iYxes8p1OPwaScIdLGuvtyxLSCyhs+8AE=;
        b=T7kF+PVNcG0+OkPJyaABEuEeHZ3hBQ+Y3i1Jd4FGn0+izWCnoVgpqFNUiaDeIa9aFr
         PZVjtA770IxhHrIAgal8KqA9BeRJdNmliY+WUgS3gQKMyzYdAjhxOqtcAdl1MzSneDxS
         y/G0jwJ18MLjUHg7BNkKhzoc3TYano8ReJjGstq2VprKo7SLmk3aibdCpcKs5UjTcNcL
         0qZ2uPeOHwPVjOiasj81gIZOykhbVFe4t1g9hzg0ZctSkOE2X+w+0Qv45xb7bgosz4IZ
         Fvmf53whuWPbykLByemhoBtJi2/CDe+hyUoAO8+cgq0GJR/rXFTcGX8uR8XJetOJbNo9
         RzsQ==
X-Gm-Message-State: AO0yUKVmjnEaO9eKEH75ne3xl8KYqEIbPImSI1kpzda6PShhHkDFW7pC
        ++2NxNzVBTmES29hSs54ew==
X-Google-Smtp-Source: AK7set/xg8UFthw46wt095CQ6iVpdLuhS9p0HATUnXyif8qxQF14khdjCq5Cy9p7wXHtQxbvoZDcHA==
X-Received: by 2002:a05:6870:5704:b0:163:1fa1:7be5 with SMTP id k4-20020a056870570400b001631fa17be5mr13198940oap.38.1675092544165;
        Mon, 30 Jan 2023 07:29:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 14-20020a9d048e000000b006864c8043e0sm5464585otm.61.2023.01.30.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:29:03 -0800 (PST)
Received: (nullmailer pid 2679071 invoked by uid 1000);
        Mon, 30 Jan 2023 15:29:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manuel Traut <manuel.traut@mt.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20230130135650.1407156-4-manuel.traut@mt.com>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
 <20230130135650.1407156-4-manuel.traut@mt.com>
Message-Id: <167509249482.2676771.1698495294796937190.robh@kernel.org>
Subject: Re: [PATCH v9 3/4] dt-bindings: input: pwm-beeper: add volume
Date:   Mon, 30 Jan 2023 09:29:03 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 14:56:49 +0100, Manuel Traut wrote:
> Adds an array of supported volume levels and a default volume level.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/pwm-beeper.example.dtb: beeper: 'default-volume-level', 'volume-levels' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/pwm-beeper.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230130135650.1407156-4-manuel.traut@mt.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

