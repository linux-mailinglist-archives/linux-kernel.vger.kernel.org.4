Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20946D4554
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjDCNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjDCNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:10:36 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA32D45;
        Mon,  3 Apr 2023 06:10:35 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso15567113otb.12;
        Mon, 03 Apr 2023 06:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527434;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0c6y0klJZIlR38JQvtzWomooCiiJ+Ub0Wtb8gTfWb6E=;
        b=7OJ28S0ZttxpZ3nnFb/b2mMrrL95kH4W2T6149quOHu5ymCn94Q7aUHY6YQJ/ebczk
         5edsHPC0nchaqC9IsFJYIKELB8X7Rkg9MbArW69aX7ElrwftIfKbOkIPIpG1vccthC4s
         cypro/9//8Vpz6iSkvEgRJ7H37ykBm8LOR2fQgrVnm9k38sterJmo0VeZlQoRQ7FpfT5
         te7fXoTXOE0fiFKNZpr2D0OEnx+wX8HKt4R1q5epH3aqzjECtaURHsL67+PBi4mOB6/u
         aHIqDjrfF4ginLMzSAGsEISVJUlX50LQfT6QwhB2BlrYIJSTdtBwIBDVgl14N61gphOg
         iVoQ==
X-Gm-Message-State: AO0yUKVZKcDi49kOC22tEJa4CQ5CxG5mbiiHaqM+NrCHkdrdYuVsqhNs
        Y9DLwNida47U4EMaEJzm5vxM+h7kqA==
X-Google-Smtp-Source: AK7set9uze4lqSyJ3xkKEcHa56jWK0pv1GNxAJixs2X/EkgOgvxyRgyidMAPmlj6kHkuggnQE4xfMw==
X-Received: by 2002:a05:6830:1bcf:b0:69b:7f5b:c657 with SMTP id v15-20020a0568301bcf00b0069b7f5bc657mr17464458ota.14.1680527434129;
        Mon, 03 Apr 2023 06:10:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x5-20020a056830114500b006a2fd720f82sm3067379otq.7.2023.04.03.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:33 -0700 (PDT)
Received: (nullmailer pid 522012 invoked by uid 1000);
        Mon, 03 Apr 2023 13:10:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
Message-Id: <168052514639.463695.9544022277060710805.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Date:   Mon, 03 Apr 2023 08:10:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 13:50:51 +0300, Cristian Ciocaltea wrote:
> Convert the PWM fan bindings to DT schema format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403105052.426135-2-cristian.ciocaltea@collabora.com


pwm-fan: 'cooling-max-state', 'cooling-min-state' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb

