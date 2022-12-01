Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901063F1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLANgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiLANgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:36:36 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A329C7722;
        Thu,  1 Dec 2022 05:36:31 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id s186so1917265oia.5;
        Thu, 01 Dec 2022 05:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Klj16cU1mtrWiiQAip05GLt5Hnkht/EiPyy1Xk8o6Y=;
        b=jkC418wUUN9rbZ6BfqY45pD2x4sSIUFloajeSEtz847z99/8/drVw9Uc0aO167C+J7
         /roBgy7QLy+ea3eZ4HDEax0WOdwyVzIIDHsXt6reEz/JWTyM5WQ+QiV0XFMNFSyYeyfe
         cuN8bgXBk97DsYqtUSj0FuoTY8n2vGX1O763YUjSrPxsPK+ApFXjZ6/5qYtoPYD//wyV
         pNBE5Vu/4g3ln81jCbsxIQoeJppuaFZlCPJl1Hu/SHUvTd4xhdlk4lZJPtPSwq+e3Yci
         MA7nijPRzbRbmaCpj6ws/0HjK0jvvpOJmZ9ZMTkO/vHc8kw4yIz/0CX97Ek6/jDkjVZ2
         cdIg==
X-Gm-Message-State: ANoB5pm5x+8cBCnvz/W4MPTwL06eViHMn9pEySFrveJURhEm+rtK3xt0
        misiGHQ1bjf/p652tVgdRaYfWio4XQ==
X-Google-Smtp-Source: AA0mqf4eI/tqppRx6qJ7bUdnKLs1yb66LbrRb7kME/EKcEm+rpS9k2Et0w/CkRsOU/ILU0PizVQkSw==
X-Received: by 2002:a05:6808:1392:b0:359:a4de:1d3a with SMTP id c18-20020a056808139200b00359a4de1d3amr33834535oiw.138.1669901790559;
        Thu, 01 Dec 2022 05:36:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j14-20020a9d7f0e000000b0066bb73cce68sm2070309otq.69.2022.12.01.05.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:36:30 -0800 (PST)
Received: (nullmailer pid 486289 invoked by uid 1000);
        Thu, 01 Dec 2022 13:36:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, marten.lindahl@axis.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20221201044643.1150870-3-saravanan@linumiz.com>
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
Message-Id: <166990139199.476214.11896276603520678291.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Date:   Thu, 01 Dec 2022 07:36:29 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 05:46:41 +0100, Saravanan Sekar wrote:
> Document mpq7932 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/hwmon/pmbus/mps,mpq7932.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.example.dtb: pmic@3: regulators: Additional properties are not allowed ('buck1' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201044643.1150870-3-saravanan@linumiz.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

