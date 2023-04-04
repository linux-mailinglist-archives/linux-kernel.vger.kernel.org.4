Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305326D60EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjDDMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjDDMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:38:00 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA840D7;
        Tue,  4 Apr 2023 05:37:36 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso1960586ott.4;
        Tue, 04 Apr 2023 05:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611794;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjG68dibK9/cWxjvku/lAc6j3Rz6IJnfcIxgAADMEtA=;
        b=HSwTdP9vZGFBn85pt0qo11fS6+xcXhsGdl9FSatpcLkzmlTg/b6Nafy+KAs6TqqHB9
         v8V2k7NOCYOPKitCvhgBjjI3X59AmmVNR4r+Nw3N9ivinBu4DmazSY570nengCY6R3zj
         gXVAUZa5Iw9nZkzKY7uD+VQKlZg0Wgys5Kw2yHQlLzQ2bQcMqD64rlD58P+1YRnMHGUs
         LpP8aG/YShurJcUsITc51hNIKaWniRlHit0/mcbzjO8111qb/Udc9gYmsm1+UiP8xnKh
         Kx6E4nLII61k2jE7RyGmzBbTPlHQSW+cOdttkowG2mG3zsZEnwot9w/ihxEK4AVfEcuT
         RLPg==
X-Gm-Message-State: AAQBX9cfC5k6P8D1KypLKpedBCZOHOfQ/UKGnXK+jQQ2vgoa3SaTJVnj
        geU9sVBmUTayqGe8yELmVNs3Y0vf3w==
X-Google-Smtp-Source: AKy350Y/UGYizDkd9w8AuBHG7Ho7zL2RA+5L2HIPoQs9B4tzgKhk490HQ1Uhx9IoP13r4X7M44oWYQ==
X-Received: by 2002:a9d:6a93:0:b0:6a1:7d40:f862 with SMTP id l19-20020a9d6a93000000b006a17d40f862mr1108755otq.35.1680611793988;
        Tue, 04 Apr 2023 05:36:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x5-20020a056830114500b006a2fd720f82sm4352384otq.7.2023.04.04.05.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:36:33 -0700 (PDT)
Received: (nullmailer pid 3710626 invoked by uid 1000);
        Tue, 04 Apr 2023 12:36:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230404054449.5665-1-otabeknazrullaev1998@gmail.com>
References: <20230404054449.5665-1-otabeknazrullaev1998@gmail.com>
Message-Id: <168061168969.3708419.4281966310027889475.robh@kernel.org>
Subject: Re: [PATCH] watchdog: dt-bindings: armada-37xx-wdt: convert text
 binding
Date:   Tue, 04 Apr 2023 07:36:32 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 14:44:08 +0900, Otabek Nazrullaev wrote:
> Convert Armada 37xx watchdog timer controller to YAML format
> 
> Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
> ---
>  .../bindings/watchdog/armada-37xx-wdt.txt     | 23 --------
>  .../bindings/watchdog/armada-37xx-wdt.yaml    | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.example.dtb: /example-0/system-controller@d000: failed to match any schema with compatible: ['marvell,armada-3700-cpu-misc', 'syscon']

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230404054449.5665-1-otabeknazrullaev1998@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

