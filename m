Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B865657E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiLZWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiLZWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:21 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126483883;
        Mon, 26 Dec 2022 14:36:12 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142b72a728fso13796511fac.9;
        Mon, 26 Dec 2022 14:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJO/06FIXq3z13IvQMxlap0KdKJ66fHNDyyYEzUFilU=;
        b=DzZ2+v5IHxERIyZiA4uwfv0oEO3PrwbOwj1rM1wrTv9WPrjU9zmHwhCB2E9oPRx7f2
         5huA1D7v1AM6n5whUbYWASPcQlL3zFP8BxE0Aj22mziW5sMlXh3ZjysiYtnJaPYsecZJ
         whbYWWuwXCbzqcVXOYcGPfJF752WJnKkUyVW+hrhL5isS52V/wKor2MsCf/ESmVDJQBR
         VUVTfg/cHF9/fAdhvtrtAj3UE30gUhAneNtOVHeeyru2OSPGT9829TYYnwGByswCD09O
         KU2kQduDsqzJfqVlgnaIm9E+Uf83MlWNXGo/kCQuQFGIG6aNcjFVNu1vTb7hTm9SLWk9
         62gg==
X-Gm-Message-State: AFqh2kqQdHX28tMR8kxO5VUwBImesyvKYWxin1kr7Hk5D1QIFcUEIhtg
        n1rbvr35Mnv/Ye2cFR9Q2A==
X-Google-Smtp-Source: AMrXdXt09iYhbv33u4BcUku+5pEdyzFCX27esXJ8xccdE2njuScXZBm6SKkDo+jeXGaaHeCxqlFdcA==
X-Received: by 2002:a05:6871:b20:b0:14f:d036:fdb with SMTP id fq32-20020a0568710b2000b0014fd0360fdbmr6070687oab.41.1672094171253;
        Mon, 26 Dec 2022 14:36:11 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id k14-20020a05687015ce00b0014fd7e7c3fesm2342757oad.27.2022.12.26.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:36:10 -0800 (PST)
Received: (nullmailer pid 8259 invoked by uid 1000);
        Mon, 26 Dec 2022 18:23:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kamil =?utf-8?q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ondrej Jirman <megi@xff.cz>,
        Robert Mader <robert.mader@posteo.de>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221226134909.2822179-3-javierm@redhat.com>
References: <20221226134909.2822179-1-javierm@redhat.com>
 <20221226134909.2822179-3-javierm@redhat.com>
Message-Id: <167207881578.4286.1861963771638185276.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: display: Add Himax HX8394 panel controller
Date:   Mon, 26 Dec 2022 12:23:46 -0600
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Dec 2022 14:49:06 +0100, Javier Martinez Canillas wrote:
> Add device tree bindings for panels based on the Himax HX8394 controller,
> such as the HannStar HSD060BHW4 720x1440 TFT LCD panel that is connected
> through a MIPI-DSI video interface.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v2:
> - Drop redundant "bindings" in subject (Krzysztof Kozlowski).
> - Drop "device tree bindings" in title (Krzysztof Kozlowski).
> - Put port next to other "true" properties (Krzysztof Kozlowski).
> - Add Krzysztof Kozlowski's Reviewed-by tag.
> 
>  .../bindings/display/panel/himax,hx8394.yaml  | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx8394.example.dtb: panel@0: 'port' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx8394.example.dtb: panel@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml

doc reference errors (make refcheckdocs):


See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221226134909.2822179-3-javierm@redhat.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

