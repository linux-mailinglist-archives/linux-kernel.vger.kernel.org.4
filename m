Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B261A3B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKDVyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:54:48 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F3FC4;
        Fri,  4 Nov 2022 14:54:46 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13c2cfd1126so6947011fac.10;
        Fri, 04 Nov 2022 14:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHfKCAGS6K/fXRkNOQPnZhjCsBGVuOxndhGoDGUw/e0=;
        b=pfHURN5oyiCLPtKP24RNORwz3rx+Ik/IvnvSkYUjnwV7vMK+bg6TBYR39PQ8+98joc
         Dus2/gob8ZWrpHqQ4gQRDaxtmY/TznJCMvJatJBrZnMkDFCesE2jvGPtt2Xi+npuzl2C
         XBrn8BHlvCYm2Cso1M/RTd6NpBC7WPJs8Er+QhP3c5UhUVa7UHixTG8UNXTBs7xVe61G
         uedcvH02gC14ZExYtOJ1kiEMd6ZimLixwov34qVbTW+Ubk0MaIdp/mEV1vvep47Nibsl
         500UzPd7BhHQ6P0w+CqE34Sj4ZP8n0bVGYkpRqHDccFs8spH1Xmy5merXG23aOynKE/E
         tOLw==
X-Gm-Message-State: ACrzQf0UJ8nwzznSbwvcwHnh3Hzj9u9LaLCbP7xWvr0Hr+YrORgx/7IN
        X6VJhp53uTV0GnFThK3DMw==
X-Google-Smtp-Source: AMsMyM5C1qR5KE9rcVb0Gj4WDHhoHBRqKfAW8T0CfNQzgoMvjiluh8ynmhQwSTIfWSgV2S6n2eX69Q==
X-Received: by 2002:a05:6870:e88f:b0:13d:2a0b:b859 with SMTP id q15-20020a056870e88f00b0013d2a0bb859mr15070607oan.28.1667598885956;
        Fri, 04 Nov 2022 14:54:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g3-20020a544f83000000b0035a5b95bd38sm81191oiy.54.2022.11.04.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:54:45 -0700 (PDT)
Received: (nullmailer pid 2894320 invoked by uid 1000);
        Fri, 04 Nov 2022 21:54:46 -0000
Date:   Fri, 4 Nov 2022 16:54:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Zhang Qing <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Chris Zhong <zyw@rock-chips.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        devicetree@vger.kernel.org,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Sebastian Reichel <sre@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: supply: bq25890: allow
 power-supply fields
Message-ID: <166759888639.2894265.16300000999459794709.robh@kernel.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
 <20221102184501.109148-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184501.109148-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 14:45:00 -0400, Krzysztof Kozlowski wrote:
> The BQ25890 schema references common power-supply.yaml, so allow all its
> properties to fix warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: charger@6a: 'monitored-battery', 'power-supplies', ... do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/power/supply/bq25890.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
