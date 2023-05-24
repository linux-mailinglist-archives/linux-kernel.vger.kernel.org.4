Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5170F2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEXJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEXJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:34:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3492611D;
        Wed, 24 May 2023 02:34:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA44A1042;
        Wed, 24 May 2023 02:35:22 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC91B3F67D;
        Wed, 24 May 2023 02:34:33 -0700 (PDT)
Date:   Wed, 24 May 2023 10:34:31 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/4] Add support for Allwinner GPADC on
 D1/T113s/R329 SoCs
Message-ID: <20230524103431.50c6a2fd@donnerap.cambridge.arm.com>
In-Reply-To: <20230524082744.3215427-1-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 11:27:29 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maxim,

many thanks for your work on this and for posting it!

> This series adds support for general purpose ADC (GPADC) on new
> Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> provides basic functionality for getting ADC channels data.
> 
> All of the listed SoCs have the same IP. The only difference is the number
> of available channels:
>      T113 - 1 channel
>      D1   - 2 channels
>      R329 - 4 channels

This may sound kind of obvious, but wouldn't it be easier to model this
with one compatible string, and have the number of channels as a DT
property?
Or, alternatively, using iio/multiplexer/io-channel-mux.yaml, since it's
only one ADC anyway?

And btw: it seems that the T507 (the H616 die with a different pinout) has
the same IP, with four channels:
http://dl.linux-sunxi.org/T507/

Cheers,
Andre

> This series is just an RFC and I would be glad to see any comments
> about it.
> 
> 
> Maxim Kiselev (4):
>   iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
>   dt-bindings: iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
>   ARM: dts: sun8i: t113s: Add GPADC node
>   riscv: dts: allwinner: d1: Add GPADC node
> 
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  52 ++++
>  arch/arm/boot/dts/sun8i-t113s.dtsi            |  12 +
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  10 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c            | 275 ++++++++++++++++++
>  6 files changed, 360 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 

