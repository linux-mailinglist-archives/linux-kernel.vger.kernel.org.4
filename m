Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D416CCA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC1Swp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjC1Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:52:42 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A9212F;
        Tue, 28 Mar 2023 11:52:36 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17e140619fdso13739287fac.11;
        Tue, 28 Mar 2023 11:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029555;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVacYwtIgbggoek+dBPxXXdcI8rj+hjbnNGphnrVryw=;
        b=PHYnUl/us+vIvcYUJJSCsYidhHG65JC54WH05LgJ4hXp/UYYifAk1XYVeHnjOVL97Z
         VI0h3xM0By3tN73kRWj66geNXMvqvW1OWqf1c91yRqpSMXD5UUKSN9SMpefJXmNYT9Qx
         XwvxArldLsy/bPZKyJbbC4riUTqttza2y1XXZhAG/lt6pMzh5tqyzS5BgdBhLUWdZ/9K
         +64TCQ265VkiSmNQNzu6A6Pv6oAE2rwrX8rfVsDfeMZtfwzeH5SIJ5J+0Gd7ShBMdUaq
         mVLxO8sJaTtUAxZgfQCBySGNBaHXit/nWczbdNHXSHu8vOgz7j5/8tdvTG1ExciwoqGh
         XC4Q==
X-Gm-Message-State: AAQBX9c2JCW8myyc1ZXT8VaqtxCenxCwi/KCFhYX9kVF6DRO3u95WjGW
        nl200h+anB/0bj4mi/KgiFXpMLAOgg==
X-Google-Smtp-Source: AK7set9V4wMT/dvNBxiMGYy/dpIfIa134L1J5NBLbOKdIZ8kqPNG6hURwnrb1wYJ4sLR17gmRVvpyQ==
X-Received: by 2002:a05:6870:524f:b0:177:9b62:6b7c with SMTP id o15-20020a056870524f00b001779b626b7cmr11183813oai.19.1680029555319;
        Tue, 28 Mar 2023 11:52:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ug21-20020a0568714d1500b0017af6149e61sm11121279oab.21.2023.03.28.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:52:35 -0700 (PDT)
Received: (nullmailer pid 3766572 invoked by uid 1000);
        Tue, 28 Mar 2023 18:52:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20230328120506.375864-3-keguang.zhang@gmail.com>
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
 <20230328120506.375864-3-keguang.zhang@gmail.com>
Message-Id: <168002881746.3753096.11245437677389006840.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Tue, 28 Mar 2023 13:52:34 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 20:05:05 +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 clocksource.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../timer/loongson,ls1x-pwmtimer.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.example.dts:21:18: fatal error: dt-bindings/clock/loongson,ls1x-clk.h: No such file or directory
   21 |         #include <dt-bindings/clock/loongson,ls1x-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328120506.375864-3-keguang.zhang@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

