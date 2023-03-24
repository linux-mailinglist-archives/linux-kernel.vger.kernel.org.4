Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876E6C86A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjCXURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCXURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:17:43 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E11A486;
        Fri, 24 Mar 2023 13:17:43 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id b19so2125817oib.7;
        Fri, 24 Mar 2023 13:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689062;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hjo6T06AhgrOxDlWz+2G2Zgc5NeJaNtNcNVYDLu3Z6E=;
        b=2JWRXrSz7YYmceDbTOfUwUqzTSmkWF55UTopg3rQRL50jhD2xcveMSu7kOvHRDKtar
         e1rn2uE0pyQscjP1tqk/II2gWeqFjDF3pPYPeKvmR10EG/z2TDaPd1nWhWFznKLd9O1p
         ZMxOz+A3TAAfu3o3vHlVB9Ixi03atqUoNXwmn/dF/KFi/Aov9DiOkCbWtj2M9eeM6L72
         UGE5ebt58v38VggFdeAJ8gOd+QlpZNEeo5rY+cUasHu5B4wLhnwZocpZk+YGjdmJX+LT
         vkg8N8ij04/CtGxxz5LI9tebEbEnIm34eSl10WXoUz0SetfQQO2o3detFmC5Xi262UwR
         4v5A==
X-Gm-Message-State: AO0yUKXLtl9yKbkWItMm6zvyywfwtJIw7d8NebVkvQ5v1t2ZoE3HJ/1I
        YgvinMYKkrYyhtnpxIgqXP7Wyxc2pg==
X-Google-Smtp-Source: AK7set83s82uaUJRj3dzo4SvDlSjN2K84Zt++hVAUhsWxmrL3xduYCYWVxI9pwtd5f8gJw4OKYZ90g==
X-Received: by 2002:aca:a913:0:b0:386:a30c:f16a with SMTP id s19-20020acaa913000000b00386a30cf16amr1668100oie.50.1679689062413;
        Fri, 24 Mar 2023 13:17:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l4-20020acabb04000000b00387852ef095sm918996oif.25.2023.03.24.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:17:42 -0700 (PDT)
Received: (nullmailer pid 2436315 invoked by uid 1000);
        Fri, 24 Mar 2023 20:17:41 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org
In-Reply-To: <20230324145652.19221-1-bbhushan2@marvell.com>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
Message-Id: <167968860240.2423272.17528725519300805146.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 GTI
 watchdog driver
Date:   Fri, 24 Mar 2023 15:17:41 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 20:26:51 +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell octeonTX2
> GTI watchdog driver.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  .../watchdog/marvel-octeontx2-wdt.yaml        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml:28:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.example.dtb: watch-dog@802000040000: $nodename:0: 'watch-dog@802000040000' does not match '^(timer|watchdog)(@.*|-[0-9a-f])?$'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230324145652.19221-1-bbhushan2@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

