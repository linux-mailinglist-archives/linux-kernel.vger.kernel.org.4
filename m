Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309D361A3B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKDVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKDVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:54:32 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FCE15;
        Fri,  4 Nov 2022 14:54:31 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v81so6535835oie.5;
        Fri, 04 Nov 2022 14:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGaVAwUn8c2ti1bCfTH5Q6nfCxHujNBUhBWckDN3Rw=;
        b=JKX8q9oxOJtcxSN709DptWHfd5g3fm0BoYPouQ3px3IrTT7G8i6cPIaVuwhPy2igI8
         jxHrX3eI4IHcduW5rJOVM7vrGZpEYb5Z23SxwPmlXwP6KcYCbDvSFzqu1C4WSo6Jwbs9
         D0O2cjWdxolel4YDal0y22HAW7g+yaA3mLA1emKFVvzAUiHgUL4fP8HaGauX6XgT+hwr
         T0R60KdmK6KwgL3+9zqrMfhcgw06rIxGi4qVd8bn2/oWiVuYcI31+LxvzyBGAXnNPs98
         7V+b710mHI9K1Sici3mQjlYmMsICwTSQABB15EzxmVvR6sduwN9vyE7YFKm0r0aAmsmQ
         HEAA==
X-Gm-Message-State: ACrzQf3D+ZVr30oqYd2OkHUWlTWpwXjHLsOgNzFniJ6fkJuh6B7gTarh
        O0slx7AbDQ7uLQ7hY1VBhw==
X-Google-Smtp-Source: AMsMyM4quzX/kOKQolKqucQ/vJpGWoaG3f+zw89mXBu3/+4PZouFb7sbgETZqEgzLf3rmj2Lbw17BA==
X-Received: by 2002:a05:6808:f93:b0:355:4d84:c802 with SMTP id o19-20020a0568080f9300b003554d84c802mr20407096oiw.187.1667598870615;
        Fri, 04 Nov 2022 14:54:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870348300b0012d6f3d370bsm60379oah.55.2022.11.04.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:54:30 -0700 (PDT)
Received: (nullmailer pid 2893922 invoked by uid 1000);
        Fri, 04 Nov 2022 21:54:31 -0000
Date:   Fri, 4 Nov 2022 16:54:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Chris Zhong <zyw@rock-chips.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-kernel@vger.kernel.org,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: define
 monitored-battery in common place
Message-ID: <166759887101.2893866.8476609318769745646.robh@kernel.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 14:44:59 -0400, Krzysztof Kozlowski wrote:
> Define the type of monitored-battery in power-supply.yaml common schema.
> Reference the schema where applicable to enforce the above in bindings
> which have monitored-battery property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Re-work the patch - define the type in power-supply.yaml.
> ---
>  Documentation/devicetree/bindings/mfd/ene-kb930.yaml        | 6 +++---
>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml   | 2 ++
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 --
>  .../devicetree/bindings/power/supply/ingenic,battery.yaml   | 4 ++--
>  .../devicetree/bindings/power/supply/power-supply.yaml      | 6 ++++++
>  .../devicetree/bindings/power/supply/rohm,bd99954.yaml      | 1 +
>  .../devicetree/bindings/power/supply/sc2731-charger.yaml    | 1 -
>  7 files changed, 14 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
