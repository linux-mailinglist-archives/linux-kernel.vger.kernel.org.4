Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D668B5F6DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiJFTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiJFTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:06:40 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E49606AF;
        Thu,  6 Oct 2022 12:06:39 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w70so3119019oie.2;
        Thu, 06 Oct 2022 12:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPEVQe4YSet3buvo/uAwKM5bGj7XGV+aFDBmZihtmho=;
        b=XjtctX6K32Hjrxi03GpXQtImHK92qTO6acosSISOWlVdVrrnIQ1gEkrbPvPbovY91q
         /Htrmcx5vohXbaHGgkIGvHLILnQJs5FBmwiI3mL/t/YzazjhRuDzxm+OmTps6GAVeYfd
         8OwBAEjoikINADTa7sZWG7qfCuyq/1zlXOdQi5inA+TRC9IpDohgMs7nrUYWBGCYNGJF
         TJLHFXAo2oa3pT4R1S/dWRYGci5NVNoLjp1EJ/AYuJ3HuCNsP5zFuc+pctLvNNT3gzlb
         NMLhsu3nGwnLgtOo2ID/RvBZYi0mGTGRVIsPk0LSPeXcJGI9MjSjPhnvPbrlLSda/xSV
         jqTg==
X-Gm-Message-State: ACrzQf2AcJEbl9YhaUJTuX7fFVe2uWQMmra5BssGVtXHUPX4KgQAiYRg
        bdvFLrFFB+Q/RNHQmeeMah9e1r8aug==
X-Google-Smtp-Source: AMsMyM6ACos8BQtyl2t2Tf0o2DJYhk75Lx64cxxwnaWI2x6YAJ1AcQ2zl4PUxF66xgJ8jcarfQEwEg==
X-Received: by 2002:a05:6808:201a:b0:34f:c23e:ef28 with SMTP id q26-20020a056808201a00b0034fc23eef28mr5718022oiw.6.1665083198937;
        Thu, 06 Oct 2022 12:06:38 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id a48-20020a4a98b3000000b0044884c40c8asm4651443ooj.30.2022.10.06.12.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:06:38 -0700 (PDT)
Received: (nullmailer pid 39209 invoked by uid 1000);
        Thu, 06 Oct 2022 19:06:37 -0000
Date:   Thu, 6 Oct 2022 14:06:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: convert semtech,sx150xq bindings
 to dt-schema
Message-ID: <20221006190637.GA30963-robh@kernel.org>
References: <20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 02:35:36PM +0000, Neil Armstrong wrote:
> This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
> bindings documentation to cover all differences between HW variants
> and current bindings usage.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-sx150x.txt |  72 -------
>  .../bindings/pinctrl/semtech,sx1501q.yaml          | 207 +++++++++++++++++++++
>  2 files changed, 207 insertions(+), 72 deletions(-)

[...]

> diff --git a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
> new file mode 100644
> index 000000000000..5c21f54b0e2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/semtech,sx1501q.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech SX150x GPIO expander
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - semtech,sx1501q
> +      - semtech,sx1502q
> +      - semtech,sx1503q
> +      - semtech,sx1504q
> +      - semtech,sx1505q
> +      - semtech,sx1506q
> +      - semtech,sx1507q
> +      - semtech,sx1508q
> +      - semtech,sx1509q
> +
> +  reg: true

maxItems: 1

Some I2C devices have multiple addresses.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  semtech,probe-reset:
> +    description: Will trigger a reset of the GPIO expander on probe
> +    type: boolean
> +
> +patternProperties:
> +  '-cfg$':
> +    type: object
> +    properties:
> +      pins: true
> +
> +      bias-disable: true
> +      bias-pull-up: true
> +      bias-pull-down: true
> +      bias-pull-pin-default: true
> +      drive-push-pull: true
> +      output-low: true
> +      output-high: true
> +      drive-open-drain: true
> +
> +    required:
> +      - pins
> +
> +    allOf:
> +      - $ref: "pincfg-node.yaml#"
> +      - $ref: "pinmux-node.yaml#"
> +      - if:
> +          properties:
> +            pins:
> +              contains:
> +                const: "oscio"

Don't need quotes

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
