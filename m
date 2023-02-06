Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5468C70B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBFTtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBFTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:49:51 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4B2684B;
        Mon,  6 Feb 2023 11:49:45 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id dt8so10742174oib.0;
        Mon, 06 Feb 2023 11:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6lVgx9Ye+fXVcDPZBAErXqmuGkKzZYMKhQaRCupxvo=;
        b=xPZo0/tRbHOmmeNAe5W/jgFNLf1Fss6P4QznAeKQF2kM91a9mlG33E/EqflF1dd/7R
         oIpwDwxbGliq3mM9sg05mVTz+GlMur1gwc1K9b0U9xR0Y7xYkopd79AUzA6y9tXaaVxm
         PCr1kARdMGTYlEDbnQ+K5hWjL/XN61K5p19ulaaURB+Ug1ULrHGwy8r39PAdI55X3B64
         1H8RrDWghgWyUFPUL2KlsTlZdfBeOYjBbU1tzJ4RzYskj2ZufuaORuPQysfrgdzq8f69
         X28ZvmVtNDAYaS0SwY82QHx/zdCYuTewhg5YQm/pisnd0DpqO26X62707dVOK8/JhH7A
         9vsA==
X-Gm-Message-State: AO0yUKXifQMMEo/YMgXNd3Cc6PyskhXNCP7Gjhpc+RUX1N/1ufqRgDmP
        xrGTG5CW/hAboC4KYk0p4Q==
X-Google-Smtp-Source: AK7set8aa786WtgYsb0fgpCCASQHkwkCjX54JwJnRI/IbL+r96zPJmsJPnE+9mqzFfAISnFuKDdNjw==
X-Received: by 2002:aca:5ec4:0:b0:378:90b7:b28 with SMTP id s187-20020aca5ec4000000b0037890b70b28mr10237783oib.3.1675712985174;
        Mon, 06 Feb 2023 11:49:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r184-20020aca44c1000000b003786e78f2b5sm4615151oia.9.2023.02.06.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:49:44 -0800 (PST)
Received: (nullmailer pid 1206434 invoked by uid 1000);
        Mon, 06 Feb 2023 19:49:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vijaya Anand <sunrockers8@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230206153325.43692-1-sunrockers8@gmail.com>
References: <20230206153325.43692-1-sunrockers8@gmail.com>
Message-Id: <167571291763.1202238.8557252319537323407.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller
 : convert the binding document to yaml
Date:   Mon, 06 Feb 2023 13:49:44 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 21:03:09 +0530, Vijaya Anand wrote:
>     Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
>     from txt to yaml so one could validate dt-entries correctly and any future additions can go
>     into yaml format. The options for compatability described according to the example given.
> ---
>  .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
>  .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/aspeed,cvic.yaml:23:111: [warning] line too long (123 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206153325.43692-1-sunrockers8@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

