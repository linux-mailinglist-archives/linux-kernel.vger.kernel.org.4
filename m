Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695F6968F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBNQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjBNQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:13:08 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F020543;
        Tue, 14 Feb 2023 08:12:46 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id f10so6437281ilc.7;
        Tue, 14 Feb 2023 08:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOvrwglmfiziR7GpHogrkS3U+q64rSn22USfXubW88k=;
        b=Bjp339WSHdL+AkmdChLS6Nm5WhaR3AVgV9aJjLEFzaYqb4gvyxFh6EfCyPb9lBbB+h
         dvbHvT5NIXR8Ds8uvZaN5DPuCVaPZSEp4SnuIitKABk2V7habX8h65LMZteopeEOY8L1
         ZjGT1CuijpN9BAzBxhXADmnEhxmwV4f6YAfubLo4JGjIrfdcognqIxIQ8ubb7p17Hrt3
         qIhiaYQqhjjWgNdZ1p0ec4LQwSHMBrILOBW7vXR+/Ts2/71u/2q7hNu4HopXfSQq5US1
         vO/irbM/ZdTvJRQUI93QFPglJFojcC8GMlO6Chu0cZDbiVcLsbJfg9WXVYQxRkKHsfJq
         cNYA==
X-Gm-Message-State: AO0yUKV4UYM1eyitP7K8RDjXS4A/2wsWm24eK/WNPV2NTvjs9aUsPwQn
        KbNiZYl2/ECjea6RPkwY1g==
X-Google-Smtp-Source: AK7set/1RjGkMZEjYQt+pgvNdOtTX6Ck9XeM1kK01k0MLbfojEYgbSZ8+acxpFVCLsWy9ptdlxsOYQ==
X-Received: by 2002:a05:6e02:1ba4:b0:313:904d:abda with SMTP id n4-20020a056e021ba400b00313904dabdamr2858079ili.28.1676391165536;
        Tue, 14 Feb 2023 08:12:45 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id r15-20020a02c6cf000000b0039e68e9988csm4797305jan.56.2023.02.14.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:12:45 -0800 (PST)
Received: (nullmailer pid 76710 invoked by uid 1000);
        Tue, 14 Feb 2023 16:12:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bastian Germann <bage@debian.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-sunxi@lists.linux.dev,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230213231931.6546-2-bage@debian.org>
References: <20230213231931.6546-1-bage@debian.org>
 <20230213231931.6546-2-bage@debian.org>
Message-Id: <167638944701.3666.5425414440419322569.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: hwlock: sun6i: Add missing
 #hwlock-cells
Date:   Tue, 14 Feb 2023 10:12:34 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2023 00:19:28 +0100, Bastian Germann wrote:
> The allwinner,sun6i-a31-hwspinlock.yaml binding needs #hwlock-cells
> which is required by the hwlock type.
> 
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dtb: hwlock@1c18000: '#hwlock-cells' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230213231931.6546-2-bage@debian.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

