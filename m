Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9F65988F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiL3NHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3NHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:07:45 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E5186CD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:07:43 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i188so21199390vsi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cD1BXfDtBVxLcOf4ZmyaQgx1rXbmgMgEvuAGP5dPHMY=;
        b=BiKf70pxBwv00QdFOssZW6OcQpVLksnJhhaQWAsQ9zQm3P1IDZf7BpM3T6WWOSzBGf
         y4l+eJKpSJqLqdOmLmtdwg2EQF0j+4fYuGvB0ylNNgzMQqK6SMu9/FWvCW9GeFLnwB0x
         zvnP1jjRRNUrcLiGkGlySKOjD9aivH+3+nr1HE4AlDJJ6ZQNYERJfWyR1NNp3DgzXWTe
         e6jo7CZTscEDLwRuHut4f+UYz00I/SHLJN5f0gUWjucpdrQOpGb5HlN6hllqWxnfSdn0
         4AJF8CnrDVozrCo8NELzFS01adTG2v8BUs7u4TCBomMAP2G2/kH+/HMjvZswwxxbcTvW
         G7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD1BXfDtBVxLcOf4ZmyaQgx1rXbmgMgEvuAGP5dPHMY=;
        b=0aUWMc7xqfbqK22xwZVEv/2EaHXn9eCw+S9yo4CLvgXpKUizOn9bNwmVgOx/HWrOW3
         yeWrbOKe/jNVue9oniGE14n0WtdTJYe4nBKHaKsaTXYj/ie0ONAYDwyQk6yTefQciKWN
         Yh8fNJl38fyq/wSFp0efm46yG4qP2cLeo1PaR5RBQ89wGvmcAG/hrr55/TB4lBWunfDR
         WWkPGIS5faFEg8AdIU021VnA+qAxHYoL7/fi1L5LHTkzaRuMF9Ze5J3QCdsht4pgHgAY
         TjKMRsONPLOqNR4FfigapyYJrxBnsHjetMlReyKUA1khqn5GRYICBn8EOwZhQ1K0mnyl
         yhMA==
X-Gm-Message-State: AFqh2krN8m9FZVtURjQoQEwTseulozHMtO6Vh6/GB7xsnBVPdKwE8gzk
        Ka1A2FaaCyjAfhP1uGLtKm01294YrBO30ZNwd/o96Q==
X-Google-Smtp-Source: AMrXdXuTK/xRoExGyM0EfLIR3lCsir3rCmp/aeu/DKKLpe+7/Kg32KnlL4f/vLb32N6E7iEKuNfl0xQaHrKkjEZeGnE=
X-Received: by 2002:a67:df8c:0:b0:3c5:1ac1:bf38 with SMTP id
 x12-20020a67df8c000000b003c51ac1bf38mr3005136vsk.78.1672405663040; Fri, 30
 Dec 2022 05:07:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672149007.git.william.gray@linaro.org>
In-Reply-To: <cover.1672149007.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Dec 2022 14:07:31 +0100
Message-ID: <CAMRc=MdgQUvjKxr7GTpbq0AzSmhiOHvRmCx7UbiqF__w8Y+P7Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Migrate i8255 GPIO drivers to regmap API
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 3:32 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Changes in v5:
>  - Add REGMAP_MMIO Kconfig selection for GPIO_104_DIO_48E,
>    GPIO_104_IDI_48, and GPIO_GPIO_MM
>  - Replace magic number 0x3 with GENMASK(1, 0) to make intent clear in
>    the dio48e_handle_mask_sync() function
>  - Write (instead of read) to clear interrupts on unmask; although the
>    datasheet lists the respective register as read/write, all other
>    references state that this should be a write operation to clear
>
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. The 104-dio-48e and gpio-mm modules depend on
> the i8255 library and are thus updated accordingly.
>
> The 104-IDI-48 is hardwired as an input-only device. Because the i8255
> control registers are not exposed on the 104-IDI-48, the i8255 library
> doesn't provide much benefit here. In this case it's simpler to utilize
> the gpio_regmap API directly, so this patch series does such and removes
> the i8255 library dependency from the 104-idi-48 module.
>
> The first patch in this series adjusts gpio_regmap to always set
> gpio_chip get_direction. This patch is mostly independent of the rest of
> the patches in the series and can be picked up separately if desired.
> I'm including it here because it allows the input-only 104-idi-48 driver
> to continue reporting offset directions after migrating to gpio_regmap.
>
> By leveraging the gpio_regmap API, the i8255 library is reduced to
> simply a devm_i8255_regmap_register() function, a configuration
> structure struct i8255_regmap_config, and a helper macro
> i8255_volatile_regmap_range() provided to simplify volatile PPI register
> hinting for the regmap.
>
> The regmap_irq API is leveraged by the 104-idi-48 and 104-dio-48e
> modules to support their IRQ functionality. Do their respective regmap
> configurations need use_hwlock set to true in this case, or is adequate
> locking already handled by the regmap_irq API?
>
> William Breathitt Gray (8):
>   gpio: regmap: Always set gpio_chip get_direction
>   gpio: 104-dio-48e: Migrate to the regmap-irq API
>   gpio: 104-idi-48: Migrate to the regmap-irq API
>   gpio: 104-idi-48: Migrate to gpio-regmap API
>   gpio: i8255: Migrate to gpio-regmap API
>   gpio: 104-dio-48e: Migrate to regmap API
>   gpio: gpio-mm: Migrate to regmap API
>   gpio: i8255: Remove unused legacy interface
>
>  drivers/gpio/Kconfig            |   8 +-
>  drivers/gpio/gpio-104-dio-48e.c | 398 +++++++++++---------------------
>  drivers/gpio/gpio-104-idi-48.c  | 336 +++++++++------------------
>  drivers/gpio/gpio-gpio-mm.c     | 154 +++---------
>  drivers/gpio/gpio-i8255.c       | 320 +++++++------------------
>  drivers/gpio/gpio-i8255.h       |  54 ++---
>  drivers/gpio/gpio-regmap.c      |   7 +-
>  7 files changed, 390 insertions(+), 887 deletions(-)
>
>
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> --
> 2.38.1
>

Series applied, thanks!

Bart
