Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23F60EA00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiJZULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiJZULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:11:14 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AB143A74;
        Wed, 26 Oct 2022 13:11:12 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so10703713otu.1;
        Wed, 26 Oct 2022 13:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxh7/bAaex3YOoW5fejtI6wP7XMx1Bm3idoLs8QD3D4=;
        b=xSPXhAZZw4fUWNguCX+FMaMAp33yOfzqNRkm3lIOOkaLIsZyhLQXVbXc9jGMVTT9ry
         HVAu0oQy6uCrJ6EMgRdBdd+KF/ejtQ1eOnRs7rpaq2I7nexcSvzhyUkOm5zJt8KxWwdY
         yUMMu6depuegT/pOqCQH0JqqnEhUOLeHXamT+N72grd6fsAVPv4lSBRyqAtWapmWzvkn
         wH6IkZir/FVVI7mEO11X8aHKJISO9vFqP9X5Ln9jqwtd53zKSqbkv6X4xcHNZFCpkY3/
         chv764CEsOBBdK7fwTMs57umNfUczJhvC/lV3B7MlGIcrUAY5ztvOVNk8S+8P1CwQqFj
         q5Qg==
X-Gm-Message-State: ACrzQf0zlVm5EjwYfNejihbWxRwbaXk6AYP6Bza2xu7Z/fYLwJ/pm5wc
        syOfwYkSU87uGf+sQ5Wm+A==
X-Google-Smtp-Source: AMsMyM4eINBgPpQ+uYOM1SjWMaqslOU61o8eyuDNV/lbKUULILrGgf1JXyrSpYeSTmLixyx9jsYo6g==
X-Received: by 2002:a05:6830:3102:b0:661:e1f9:ff75 with SMTP id b2-20020a056830310200b00661e1f9ff75mr22442086ots.207.1666815072153;
        Wed, 26 Oct 2022 13:11:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020a05683033ca00b00661a33883b8sm2525809ott.71.2022.10.26.13.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:11:11 -0700 (PDT)
Received: (nullmailer pid 1123772 invoked by uid 1000);
        Wed, 26 Oct 2022 20:11:12 -0000
Date:   Wed, 26 Oct 2022 15:11:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     f.fangjian@huawei.com, linus.walleij@linaro.org,
        yangyicong@hisilicon.com, xuwei5@huawei.com,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH next 2/2] dt-bindings: gpio: add entry for
 hisilicon,gpio-ascend910
Message-ID: <20221026201112.GA1104486-robh@kernel.org>
References: <20221026034219.172880-1-chenweilong@huawei.com>
 <20221026034219.172880-2-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026034219.172880-2-chenweilong@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:42:19AM +0800, Weilong Chen wrote:
> Add the new compatible for HiSilicon gpio controller driver.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
>  .../gpio/hisilicon,gpio-ascend910.yaml        | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
> new file mode 100644
> index 000000000000..912e4b808cae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hisilicon,gpio-ascend910.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon common GPIO controller Device Tree Bindings
> +
> +maintainers:
> +  - Jay Fang <f.fangjian@huawei.com>
> +
> +properties:
> +  compatible:
> +    const: hisilicon,gpio-ascend910

The normal convention is: vendor,soc-ipblock

> +    description:
> +      The HiSilicon common GPIO controller can be used for many different
> +      types of SoC such as Huawei Ascend AI series chips.
> +
> +  reg:
> +    description:
> +      Address and length of the register set for the device.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  ngpios:
> +    minimum: 1
> +    maximum: 32
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - reg
> +  - interrupts
> +  - ngpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    gpio@840d0000 {
> +      compatible = "hisilicon,gpio-ascend910";
> +      reg = <0x840d0000 0x1000>;
> +      ngpios = <0x20>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupts = <0x0 33 0x4>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 746becb5fe92..0ec86558cdce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9212,6 +9212,7 @@ HISILICON GPIO DRIVER
>  M:	Jay Fang <f.fangjian@huawei.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
>  F:	drivers/gpio/gpio-hisi.c
>  
>  HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
> -- 
> 2.31.GIT
> 
> 
