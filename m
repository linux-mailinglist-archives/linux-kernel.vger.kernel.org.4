Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0365FC78F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJLOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:38:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFDE03B;
        Wed, 12 Oct 2022 07:38:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x13so8017476qkg.11;
        Wed, 12 Oct 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKPVsd3W7uhNdx8AxGe9ZGmFEXcX2gtbcARjTMPwtE0=;
        b=jGgCcVxw9aYw+7+X6FUgRTvWP9wT47kEmtOZr477HoPkmQAsPEA5JGobOI6Qze1oP6
         HPXB6t9x0H25ecRAwTY0BEXhlzAMg/o6RTruu8USuaYPuJvTdljw3u9oSPXN4yGstANA
         aLxFp546AW+Ay1L/fgx7sRfkKlIGSymtayWFQ4DwNZ0T9qB9Trv5DUmuBtdlKrU41ESi
         cgyR3kfuwNlBTsq3NS01dpqfazFNVgF1b6Wr8aOSTkmeMAqBxjpEU6+Tq60kBrey2PpH
         x8y0MTNGT2fsR1ECqiiwD2wXi6jMN9JWReiWyiVOUMbL075hz+qaAOCf93KVgCINHefo
         b7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKPVsd3W7uhNdx8AxGe9ZGmFEXcX2gtbcARjTMPwtE0=;
        b=JAug/8IoJHJJn6bghM1xUQKV5YAvspMCnZcVzxAJIPMDjFB+IJM/vZUWYkvKAN3C7U
         gwSR4zgmBJEeY9SIncRHIw9YZvgXcQ+J2un8EQdUZuJFA81S+8PfRb38RwE9KU5yK+lx
         zOEmdmumrnIlbjelwz+nV2qlknY+viJk1E0opGo4omfoSZ4m5NaqxIfwbD4/hCD6vHQB
         mvHqvD4IdVIQ3Z8r6fNViPRpGyvWKc4wNbmk2YlpJ+1Aus87k8kzVKDl9ZXX/UlJ+HGM
         ZCPYItpYl1r4RBEoxAdFyndNv6JhyLtV891t/kddmMpcxNGAEe/w+6KdoGZG+NYuW/p7
         8G3g==
X-Gm-Message-State: ACrzQf3SmyVMIv2CfsX+vslzee9Fae7pvcVOLRGxa3zBERqsqbYGIgnX
        k8b8y9ZcOsRN47eXc6jImMYmZD9H3WSRP5zIoGA=
X-Google-Smtp-Source: AMsMyM7b7eFUYW469t9gBAUzXjB/1SiBsX+TjGi2DrbbBdSxt9U56YHR1FbMXNHgZ43uuhcXFE2IKeNMDRcE++1W0/Y=
X-Received: by 2002:a05:620a:2552:b0:6ca:bf8f:4d27 with SMTP id
 s18-20020a05620a255200b006cabf8f4d27mr20286297qko.383.1665585512923; Wed, 12
 Oct 2022 07:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
In-Reply-To: <20221012142205.13041-1-olivier.moysan@foss.st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Oct 2022 17:37:56 +0300
Message-ID: <CAHp75VeUXwqeb+kZE7HshMwjRRrd0=85=qxEGmLDkiyoEEuKrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iio: stm32-adc: add support of adc for stm32mp13
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 5:23 PM Olivier Moysan
<olivier.moysan@foss.st.com> wrote:
>
> On STM32MP13 SoCs, each ADC peripheral has a single ADC block.
> These ADC peripherals, ADC1 and ADC2, are fully independent.
> The STM32MP131 SoC provides only ADC2, while other STM32MP13x
> SoCs provide both ADC1 and ADC2.
>
> The STM32MP13 ADC features and characteristics are slightly
> different from STM32MP15 ADC ones, requiring a specific support
> in the driver.
>
> This patchset enables the ADC peripheral on STM32MP135F-DK board.
>
> On STM32MP135F-DK board the ADC is connected to VDDA voltage
> provided by the PMIC LOD1 supply, which has to be enabled through
> SCMI regulator framework.
> This serie introduces a fixed regulator to allow ADC probing,
> while SCMI regulators support is not available. This does
> not ensure ADC regulator enabling however.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for patches 1,3, and 4.

> Changes in v4:
> - reformat patch 1 commit message
> - reorder adc1 node
>
> v3:
> - Remove blank line in tag block
> - Use HZ_PER_MHZ unit for max frequency definition
> - Coding style updates
>
> v2:
> - Rework commit message length
> - Add missing spaces
> - Remove useless defines
>
> Olivier Moysan (8):
>   iio: adc: stm32-adc: fix channel sampling time init
>   dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
>   iio: adc: stm32-adc: add stm32mp13 support
>   iio: adc: stm32: manage min sampling time on all internal channels
>   ARM: dts: stm32: add adc support to stm32mp13
>   ARM: dts: stm32: add adc pins muxing on stm32mp135f-dk
>   ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
>   ARM: dts: stm32: add adc support on stm32mp135f-dk
>
>  .../bindings/iio/adc/st,stm32-adc.yaml        |  68 ++++-
>  arch/arm/boot/dts/stm32mp13-pinctrl.dtsi      |   7 +
>  arch/arm/boot/dts/stm32mp131.dtsi             |  43 +++
>  arch/arm/boot/dts/stm32mp133.dtsi             |  31 +++
>  arch/arm/boot/dts/stm32mp135f-dk.dts          |  33 +++
>  drivers/iio/adc/stm32-adc-core.c              |  30 ++-
>  drivers/iio/adc/stm32-adc-core.h              |  30 +++
>  drivers/iio/adc/stm32-adc.c                   | 247 +++++++++++++++---
>  8 files changed, 443 insertions(+), 46 deletions(-)
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
