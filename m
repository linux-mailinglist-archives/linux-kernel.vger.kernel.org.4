Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC49663FF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLBEK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiLBEKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:10:11 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32242D158C;
        Thu,  1 Dec 2022 20:10:08 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1322d768ba7so4438148fac.5;
        Thu, 01 Dec 2022 20:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tztRLB6mzSF4TXzBNH2EqTDisdRWShlDqP2hXZ6ZShA=;
        b=2NwjEXvvcP2IFAlqbC875JRCj/En3S1uBbpjqMXfHcSzRMBYpAwlknHgXrz04OnMYv
         A+ovHPZjYBpuE2uI1tIT0X99hMVW5Q9kWhUD68Z2iuJdfPAYWKtUf6N1IdcmqZh9n9U4
         lv9Rr2+sPOKFn5nMcvlOgZny1YIqpDL9/5z7+NQsR8DBB2AYUX2ws5Yh02p2IJCOHjhn
         MQMxsAdMSesL28QyCamjekh72azJjxA5qNQyzLSkDUe9CeAkVYMz1uA2skKTjO6qUY5W
         NkmoXQrp3WWAP+52rlJWYXCcS+x6IIQZLdy3+6PARqffxQp6LI6IcBOHJ/Ol5n9DOY2B
         0wXw==
X-Gm-Message-State: ANoB5pmMlaT97uvc63NSoKU3EIYkOG52hwYTm3yfVRMpT7tOP5wlRFSi
        MOZJfUP3Q4C4rbxz2WAW/Q==
X-Google-Smtp-Source: AA0mqf6gG6R8BWacHtluarpNJ8HkJUosCxyDgCp9hbhu6ftL/iTTIfVwtgs6UTN5W3nPfjPGq686bQ==
X-Received: by 2002:a05:6870:9a18:b0:142:efc1:1394 with SMTP id fo24-20020a0568709a1800b00142efc11394mr27456427oab.11.1669954207422;
        Thu, 01 Dec 2022 20:10:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o126-20020aca4184000000b003544822f725sm2605035oia.8.2022.12.01.20.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 20:10:06 -0800 (PST)
Received: (nullmailer pid 2118014 invoked by uid 1000);
        Fri, 02 Dec 2022 04:10:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, jbrunet@baylibre.com, mturquette@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        rockosov@gmail.com, kernel@sberdevices.ru,
        neil.armstrong@linaro.org, robh+dt@kernel.org, sboyd@kernel.org
In-Reply-To: <20221201225703.6507-4-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-4-ddrokosov@sberdevices.ru>
Message-Id: <166995398331.2089708.18189499743713568568.robh@kernel.org>
Subject: Re: [PATCH v8 03/11] dt-bindings: clock: meson: add A1 peripheral
 clock controller bindings
Date:   Thu, 01 Dec 2022 22:10:04 -0600
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


On Fri, 02 Dec 2022 01:56:55 +0300, Dmitry Rokosov wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Add the documentation to support Amlogic A1 peripheral clock driver,
> and add A1 peripheral clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       | 65 ++++++++++++
>  include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#
Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dts:18.48-30.11: Warning (unit_address_vs_reg): /example-0/periphs-clock-controller: node has a reg or ranges property, but no unit name
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dtb: periphs-clock-controller: reg: [[0, 2048], [0, 260]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-4-ddrokosov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

