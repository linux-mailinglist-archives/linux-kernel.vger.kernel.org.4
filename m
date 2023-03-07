Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3846AF706
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCGU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCGU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:56:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48784ABB31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:56:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id fa28so8897132pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678222600;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hUNTaLzZDvNotIxhn6MyoQhiZFZ3+VH2QjfGOxPnRw=;
        b=h5Djc3etli6VJDb5WfFqu+J2bU6QolErLBRchPWvNYlgFyKIigoOvNjEGzW8hoT5Mq
         DdYOTKaPB7qSQClyzh6t+sVx1I0WsyUYarEgpsb+HNQITvkwMCULmQQBkMbuyMq09vMb
         Q6fxuwvliWWw0DzSeWKxjYIgwrUV+0CJ5zDDKvxZd0QfZj8/QvvIb8Y5XHIsA5oG/qXN
         3OIvXRMIKo4DmsxaSyKZ6AnP+vkS6Lq5bQDneP7NxLZmgdS7WvjKwJfh5KRTH6vECpVC
         InIae/TEHa7FK/32zXKvk0aTVnyenJeh7k/NX1nbl8/15yECB4yE0MbJ/nUaiNPjaWlO
         GmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222600;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hUNTaLzZDvNotIxhn6MyoQhiZFZ3+VH2QjfGOxPnRw=;
        b=XrMnDAPE4bDt0MkSVEEDTMCEaohyS5sVloUxKYJUh7nHDYflZzMyIngAic9dewEnC9
         FlyecXBj+sALCVkeosJ7z4zMAuqyOkVOppc0TFicujmF8xysaBFf5lTTh11qQt7skRZy
         pIFBxRzRT7bIvvMXZ7+4TxegDgOrk1pKHPbTSuPpOfZqLwEQ4yJY6R49yLeCZdOQMZ+b
         eA5iC399uZVJR4wUyx6xLcMfP3vKJCI1ulWqr7KN5J6Zhqk3FHOIH9yL2RrlbxJBcD5H
         qdQtTKT7/0MABJm7jr3WxB0kf8Gg1qRk4ssulVGD4i9OlChXj67SiqqFQTO4Faopzme6
         tBhQ==
X-Gm-Message-State: AO0yUKXTI9CzrpQjlPAINkskUJr2pGJnuUFqCswtfpQtyI/yEH2SH+dl
        lyrL1AEYfLlUHcSuAFvHZ58eaA==
X-Google-Smtp-Source: AK7set8aj9SpSp3tb9b2XdQj4tmRkNceu/cxunxMGoS5gBVk6iL/KAt4T5ZqaeDF7AdwY3g5oAGtIQ==
X-Received: by 2002:aa7:9af5:0:b0:5aa:4df7:7eef with SMTP id y21-20020aa79af5000000b005aa4df77eefmr15492706pfp.6.1678222599563;
        Tue, 07 Mar 2023 12:56:39 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m21-20020aa78a15000000b00571cdbd0771sm8343415pfa.102.2023.03.07.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:56:39 -0800 (PST)
Date:   Tue, 07 Mar 2023 12:56:39 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 12:55:49 PST (-0800)
Subject:     Re: [RESEND PATCH v7 0/5] leds: Allwinner A100 LED controller support
In-Reply-To: <20221231235541.13568-1-samuel@sholland.org>
CC:     lee@kernel.org, pavel@ucw.cz, linux-leds@vger.kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>,
        guoren@kernel.org, heiko.stuebner@vrull.eu, heiko@sntech.de,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-93c6925c-9c65-40dc-ac0a-221dbdbbc492@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 15:55:35 PST (-0800), samuel@sholland.org wrote:
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

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
