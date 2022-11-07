Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8667161F0A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKGK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKGK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:29:48 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683B15FE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:29:47 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id g16so6293831vkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaNxkXQ1Y4JKbXCKNHnI42Q7eEAv3p2c5wJUZMq4jg0=;
        b=LALeX+CQc6yEAIT60ZcvX38eVOtEox1MCHJCm/0G+Q1qAGru2yWXLRd6QBRUqHcjVw
         +Icd2aOOOtpj6szG5Y5HbluYDK658QcJ1pC7e8Yd76bRz5goJZxaF4Dy6PNa2Svh5f8E
         oOZBYeOzAX5bfxbgR0QGPyj0veg25b8GvR/kKsAZ0/q+ymIBotnrmLIPD3Orvvvz1Md1
         DWjqcAKNoq39Rm810RCCfBBO0mq6UJR+p7uaer3mD+yBfN19cUYBACUqJoEmsbt5eOXf
         pe/jtmGnlJL+BV8gkhtpMcJ8sESAPxYe7PhFW0/zCI2oNLv2E3p4C+6atNREHuuZuooP
         lVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaNxkXQ1Y4JKbXCKNHnI42Q7eEAv3p2c5wJUZMq4jg0=;
        b=3VuXeuEzorVG29EjRNu+iH17zkpMyyqCEJjHgdgdiIQChey+auIUPwyiR7C3hJZqya
         B7MrtHEKE830LmsaxZkg4mV23s7bjBqywBuCXHEDBJhK7HQo391BwKcfLH/OVBl6BlAY
         o6PHRZDgdAPVOgyJICgUkx1XqxHn4Y4PDZJ3PBOuYBJ5HM3E/Bbth54wgAJT5QaAan2h
         6JJQeGiPF6AMBj6DgmrXSfGKJth7S/Qt6YWRUhQ2ojJkfk4yoYjn6H1wj1mojLT5erKN
         yN0v2OOjClIR/zKKaseCrVXGgQU6G8ejrl8Lpl3cfhk7qeom8u1+gh80fZQ6lcpW69Yi
         MUQw==
X-Gm-Message-State: ACrzQf0F7kxUTXHfJCR/qpvzFGTJb+A+uLb2gPpaW2HIN0gtnWhvAuGW
        mdZhGmrxAHrLQfgahygeTfNye+KxlCBai+10BcuMW/DkqGg=
X-Google-Smtp-Source: AMsMyM54Yr6hXkptY8k/m5E89W3bthkgvtDvkRDLzEyVct04WyInaLWAUG81rqK49HcbcfuEwdadpXGnAPKFDHFttEc=
X-Received: by 2002:a05:6122:2219:b0:3b8:7fbd:9554 with SMTP id
 bb25-20020a056122221900b003b87fbd9554mr5383200vkb.27.1667816986458; Mon, 07
 Nov 2022 02:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20221027130859.1444412-1-shenwei.wang@nxp.com> <PAXPR04MB9185E538798F83B3C03C70EA89389@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9185E538798F83B3C03C70EA89389@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Nov 2022 11:29:35 +0100
Message-ID: <CAMRc=McPXjixgSJNDfFLRzR=OM2Q9SuAuCumqEpjb_s2fdYa-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoCs
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 11:01 PM Shenwei Wang <shenwei.wang@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > Subject: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoC=
s
> >
> > On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source, =
the
> > GPIO block will be powered off when system enters into suspend state. T=
his can
> > greatly reduce the power consumption of suspend state because the whole
> > partition can be shutdown. This is called PAD wakeup feature on i.MX8x
> > platform.
> >
> > This series of patches enable this wakeup feature on i.MX8QM/QXP/DXL
> > platforms.
> >
> > Changes in v4:
> >  - fixed the format issues reported by Peng Fan.
> >  - change the return type of mxc_gpio_generic_config, and limit the
> >    suspend/resume behavior changes only on i.MX8QM/QXP/DXL platform.
> >
>
> A soft ping. =F0=9F=98=8A
>
> Regards,
> Shenwei
>
> > Changes in v3:
> >  - According to the feedback from Linus Walleij, the wakeup feature is
> >    moved to pinctrl driver, and the array of gpio-pin mapping is moved
> >    to gpio device node and initialized via gpio-ranges property.
> >
> > Shenwei Wang (5):
> >   arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
> >   arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
> >   arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property
> >   pinctrl: freescale: add pad wakeup config
> >   gpio: mxc: enable pad wakeup on i.MX8x platforms
> >
> >  .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 41 +++++++++
> >  .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 ++++++++
> >  .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   | 25 +++++
> >  drivers/gpio/gpio-mxc.c                       | 92 ++++++++++++++++++-
> >  drivers/pinctrl/freescale/pinctrl-scu.c       | 30 ++++++
> >  5 files changed, 225 insertions(+), 1 deletion(-)
> >
> > --
> > 2.34.1
>

GPIO part looks good to me.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
