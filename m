Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418F67C424
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 06:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjAZFBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 00:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjAZFAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 00:00:53 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EFC162;
        Wed, 25 Jan 2023 21:00:00 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z9so521345qtv.5;
        Wed, 25 Jan 2023 21:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2S3RLfrNyQH49fsnFGoQQ0jF5nvWXPOvFK0VP3Scjo=;
        b=IWV/X5EtYYc53U1keZc6Iu7v0jyTbAY6l2uYNr2tB7WaZHXvEwhIXcw5VZBulQSL6A
         6Jvn59mMR6weRaRmLdZ8F/95n+NaBJ9dRVjOjQ19w5aWxL+R6I/zOQkl4hj19hbQKkcg
         XmaOWJvaFGorOGR6gKFoxWNZ42yq3JI5PBjwnFIMJq9VFbqd+i4rUMftB8vjBgxSsNEW
         8gniu1Yv79dBtc9rOZbpIC451t5eJqX4pgao5Ha7dYw38DOKNCO4jT0+eG5WUHdqooRu
         CkQgahq+Ky8sF3BbotZY5uEqwtIQM7xrxtVzCBDUeiEKNovMTvE8/M+lrLSGEv0r5Wgg
         UqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2S3RLfrNyQH49fsnFGoQQ0jF5nvWXPOvFK0VP3Scjo=;
        b=fMP5Ut3zw8rZOEixxDwwNw9zm2YQWsZ0OoltQIoJS3YZB7Zeq8RloNjSlSxCarNZ54
         6SaS7p7HmzrVGm9D/R/g623sMseaPAI/3OUSERm9g4sFUEmJB9dWn9pCkHrfMy21qyQ0
         Nvdl7DXHuz3IOugOLzeW1DGQELCFdKLW7Fe+WdsyEYmhUrDpVaM3FXoqn2Ogk4XxuQwX
         gJ+BQogLgsk5XDUvHSAUSBN6/L7BeR6lLTU8h7rrVh/4DmnW+nrzMaMle0JvOey8ltoq
         r3YFoyLeyq8MqaeRjFqIdnNrEaL3//7KLImdcAgriJOVFlFTZHq8/FjnnT8ZOcj+L6CS
         pE4g==
X-Gm-Message-State: AO0yUKVlxmzH5n4Ad63LECSNPQ3oLhc1pRwXFfROaJQ/c+89nN0Nd+NN
        b2/qMeqPd37FQ4ZFWRKmbMs=
X-Google-Smtp-Source: AK7set9uZfTD1W3z0cbHBVUg5SVE0mxBEXs/DXbPnm5/hifsR8XEBxaOH/w+lDF8YqDyrPMz+u2j0Q==
X-Received: by 2002:ac8:6794:0:b0:3b7:ec87:8154 with SMTP id b20-20020ac86794000000b003b7ec878154mr6565219qtp.44.1674709143369;
        Wed, 25 Jan 2023 20:59:03 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id j7-20020ac806c7000000b003b80a69d353sm120720qth.49.2023.01.25.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 20:59:02 -0800 (PST)
Date:   Wed, 25 Jan 2023 23:59:00 -0500
From:   Trevor Woerner <twoerner@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v7 0/5] leds: Allwinner A100 LED controller support
Message-ID: <20230126045900.GA7126@localhost>
References: <20221231235541.13568-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221231235541.13568-1-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-12-31 @ 05:55:35 PM, Samuel Holland wrote:
> [Resending because it has been a couple of months since v7 with no LED
> maintainer feedback, and LEDs now have an additional maintainer.]
> 
> This series adds bindings and a driver for the RGB LED controller found
> in some Allwinner SoCs, starting with A100. The hardware in the R329 and
> D1 SoCs appears to be identical.
> 
> Patches 4-5 depend on the D1 devicetree series[1], but the rest of this
> series can/should be merged without them.
> 
> This driver was tested on the D1 Nezha board.
> 
> [1]: https://lore.kernel.org/lkml/20221231233851.24923-1-samuel@sholland.org/
> 
> Changes in v7:
>  - Use DEFINE_SIMPLE_DEV_PM_OPS
> 
> Changes in v6:
>  - Drop the A100 DMA controller DT node patch, which was merged via a
>    different series
> 
> Changes in v5:
>  - A100 contains the original implementation, so use that as the base
>    compatible string, and rename the binding to match
>  - Add "unevaluatedProperties: false" to the child multi-led binding
>  - Rename the driver R329 -> A100, since that is the actual original
>    implementation
> 
> Changes in v4:
>  - Use "default" instead of "maxItems" for timing properties
>  - Depend on LEDS_CLASS_MULTICOLOR
> 
> Changes in v3:
>  - Removed quotes from enumeration values
>  - Added vendor prefix to timing/format properties
>  - Renamed "format" property to "pixel-format" for clarity
>  - Dropped "vled-supply" as it is unrelated to the controller hardware
>  - Added vendor prefix to timing/format properties
>  - Renamed "format" property to "pixel-format" for clarity
>  - Dropped "vled-supply" as it is unrelated to the controller hardware
>  - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa
> 
> Changes in v2:
>  - Fixed typo leading to duplicate t1h-ns property
>  - Removed "items" layer in definition of dmas/dma-names
>  - Replaced uint32 type reference with maxItems in timing properties
>  - Renamed from sunxi-ledc to sun50i-r329-ledc
>  - Added missing "static" to functions/globals as reported by 0day bot
> 
> Samuel Holland (5):
>   dt-bindings: leds: Add Allwinner A100 LED controller
>   leds: sun50i-a100: New driver for the A100 LED controller
>   arm64: dts: allwinner: a100: Add LED controller node
>   riscv: dts: allwinner: d1: Add LED controller node
>   riscv: dts: allwinner: d1: Add RGB LEDs to boards
> 
>  .../leds/allwinner,sun50i-a100-ledc.yaml      | 139 +++++
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  14 +
>  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  12 +
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    |  13 +
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |   6 +
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  15 +
>  drivers/leds/Kconfig                          |   9 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-sun50i-a100.c               | 555 ++++++++++++++++++
>  9 files changed, 764 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
>  create mode 100644 drivers/leds/leds-sun50i-a100.c

this whole series:
Tested-by: Trevor Woerner <twoerner@gmail.com>

from: https://github.com/smaeul/linux/tree/d1/all
test script: https://github.com/twoerner/rgb-led-test
