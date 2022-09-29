Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12975EFEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiI2VHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiI2VHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:07:20 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FAF1B2607;
        Thu, 29 Sep 2022 14:07:16 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id m81so2883794oia.1;
        Thu, 29 Sep 2022 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u3B4AXMno9nb8iZf5zQNwk767aQTUKKU1v3oIRo2uIY=;
        b=bFSuxmoBni6zPKmbPNAr8JQg/XOh5y1svc96TOhCV1YgIDGoRuPeNH9sHOqcI7l3u7
         82RMBTVkp/+7CLWxdV9vPKQgo3O/alvcTda3v6Geos5+pSGze+YE8CDwaNGVe3N14Swt
         gjTH+b+tblItj+SZ1WllgizS57COtmzc86D+IQihK7hMh0LnT1ERPdPlvRJQTvNticsW
         fp3Jwu23Cv11aNFHUWYsjEKWSQE40RYSod3OB33Qr/SCB3ymyexI1eSyEpX1V9yELHIb
         EPyahXp+jW6FmVB0FiDfnMQKtX9QvZNXUz9vA1FsnTNjlCdsAekXP8Cm1vGP4nO6atCN
         K7eA==
X-Gm-Message-State: ACrzQf0pMaqdI4VmkPwG2JnT/paori/A4nf5RHu+eZLYBXjhdPyA81c/
        GBgzbYVOO18K0MZ8DhjhTg==
X-Google-Smtp-Source: AMsMyM6TwJd0hAEFLH56WIO6Yzur03lHZly+x+08QITWC4ObpNv661/Odx7T56khaPygTvhv1Bdp5w==
X-Received: by 2002:a05:6808:bd3:b0:350:e312:9abf with SMTP id o19-20020a0568080bd300b00350e3129abfmr8019360oik.78.1664485635979;
        Thu, 29 Sep 2022 14:07:15 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx21-20020a056830601500b0065689e13f52sm165192otb.71.2022.09.29.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:07:15 -0700 (PDT)
Received: (nullmailer pid 2721310 invoked by uid 1000);
        Thu, 29 Sep 2022 21:07:14 -0000
Date:   Thu, 29 Sep 2022 16:07:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output binding
Message-ID: <20220929210714.GA2684335-robh@kernel.org>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925220319.12572-3-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 03:03:18PM -0700, Zev Weiss wrote:
> This describes a power output supplied by a regulator, such as a
> power outlet on a power distribution unit (PDU).
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> new file mode 100644
> index 000000000000..40953ec48e9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/regulator/regulator-output.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator output connector
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +description: |
> +  This describes a power output connector supplied by a regulator,
> +  such as a power outlet on a power distribution unit (PDU).  The
> +  connector may be standalone or merely one channel or set of pins
> +  within a ganged physical connector carrying multiple independent
> +  power outputs.
> +
> +properties:
> +  compatible:
> +    const: regulator-output
> +
> +  vout-supply:
> +    description:
> +      Phandle of the regulator supplying the output.
> +
> +  regulator-leave-on:
> +    description: |
> +      If the regulator is enabled when software relinquishes control
> +      of it (such as when shutting down) it should be left enabled
> +      instead of being turned off.
> +    type: boolean

I'm not too sure about this one as there could be various times when 
control is relinquished. It is userspace closing its access? 
driver unbind? module unload? Does a bootloader pay attention to this?

Rob
