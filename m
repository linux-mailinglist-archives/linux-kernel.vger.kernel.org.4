Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1A6ECE0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjDXN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjDXN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:28:44 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6661B8;
        Mon, 24 Apr 2023 06:28:30 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-18665c1776dso3429632fac.2;
        Mon, 24 Apr 2023 06:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682342899; x=1684934899;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1fifvOlhjvGQRsm6j4YqMXPrKDsFNdYCXL46lCn8YU=;
        b=ToILqyCuyxvKv8o2UEc2/BSqKu+empVWthhSOanIFg8odBdqJNaYmUpADGWK7Um9BI
         9H0Otn8yamLbpKyVh4+af25FLtx0lNF9kMg6uaHgtNTXu89MTtAH6rENwtJIvmD8biba
         noVDXDgmce2eap8OTyczxIT08BhSJkVOH4hiWoyfeRddDRG2nJmV0WAYydPLVLx52fNc
         sIP3ZagcsWOGBczUcMDGOeI5r8bdPVGdUM+I7HxkPl5FJ9yaGjBXEeQ3JUIZQs6GLHCt
         2tJqa5a69JO90MXdJ0GhEpff76hBUFu0dtcSXUmQ2hHafWrjtFA2nXVd2U2tyB3sg/YR
         KSRg==
X-Gm-Message-State: AAQBX9e4/Sw/aKKNjrVosG4qyQrybOUBQxAuDqDNS3lGJBrwGP0mqior
        3xn2PqXxNCO5xL3nzv7Bl2O/dUN+Tg==
X-Google-Smtp-Source: AKy350Z/KIM/MbuvqVhEgg+x+VUTScdkDFKPCUzehJ/arFPHhmjsjLY4NRJsXPO/Tp0B3D1Pm5Dr7Q==
X-Received: by 2002:a05:6871:707:b0:188:5:bc87 with SMTP id f7-20020a056871070700b001880005bc87mr9645448oap.6.1682342898797;
        Mon, 24 Apr 2023 06:28:18 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80e7:4387:ec9f:155:c2d2:6e82])
        by smtp.gmail.com with ESMTPSA id n17-20020a9d6f11000000b006a5d7d7f6c3sm4607867otq.7.2023.04.24.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:28:18 -0700 (PDT)
Received: (nullmailer pid 2494968 invoked by uid 1000);
        Mon, 24 Apr 2023 13:28:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linusw@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20230424123522.18302-12-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-12-nikita.shubin@maquefel.me>
Message-Id: <168234108008.2461298.8379802160390368703.robh@kernel.org>
Subject: Re: [PATCH 11/43] dt-bindings: clock: add DT bindings for Cirrus
 EP93xx
Date:   Mon, 24 Apr 2023 08:28:08 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 15:34:27 +0300, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/arm/ep93xx.yaml       | 102 ++++++++++++++++++
>  .../dt-bindings/clock/cirrus,ep93xx-clock.h   |  53 +++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ep93xx.yaml
>  create mode 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/ep93xx.example.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['technologic,ts7250', 'cirrus,ep9301'] is too short
	'liebherr,bk3' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/ep93xx.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230424123522.18302-12-nikita.shubin@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

