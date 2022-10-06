Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43A45F634D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJFJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiJFJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:08:01 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB897ED4;
        Thu,  6 Oct 2022 02:08:00 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id i9so812408qvu.1;
        Thu, 06 Oct 2022 02:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L7WdsxThKx8DLY3HEg/N0eYOYTLtN7B9Ka7mZhp0NQU=;
        b=NqtUswe4HGsoycpMrf6/wsEGNt22ya3P2Lh7Z+CA1hnnT4T+YNwShbFOWakQqEoVhp
         yhYBNn57RuHd1D8nKgXQiEmwDApJ33wf+EuiqP2SnOzeh2C3RcOfcPVVw0NRXa2aJ2P6
         BdMnESYjIlHdmEg6c4hqT3Gu4j9zymXMmqB+xdDvD50pPN0UCBqHNDUEMD/E/xJCNbhK
         RmL6fKYxeU67xZccQ86DJE19sjKrXD1sjYxs1jxfSol2MkIIUA6P/RzONXDjv+xY0ZJ1
         jsb3CVcbk5yKMJGXbyUXSXlXb1Wqe5if2zxUxLvMZAEyiwGiEpRWBgrHugSXMIdqWESo
         3jhA==
X-Gm-Message-State: ACrzQf0J5REU9z2p4nyg8miPYF7XuTjcRnanrRuSqe4QJU02ebk4Y3pX
        jGi5M5htrssPZnHy7vPMnZr4Xp4MCm0tbg==
X-Google-Smtp-Source: AMsMyM5yhSUztWo2SZJX22LCh2nXmw4fPZhLzHAHdTDOZ5k4uGiUUXlcLm84ZafS013zmrU9oyuTkg==
X-Received: by 2002:a05:6214:2387:b0:497:15b3:f792 with SMTP id fw7-20020a056214238700b0049715b3f792mr2985316qvb.118.1665047279143;
        Thu, 06 Oct 2022 02:07:59 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006bbf85cad0fsm19798641qko.20.2022.10.06.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:07:58 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-35ad0584879so11875627b3.7;
        Thu, 06 Oct 2022 02:07:57 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:357:2422:13b4 with SMTP id
 135-20020a81098d000000b00357242213b4mr3519086ywj.316.1665047277420; Thu, 06
 Oct 2022 02:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930061404.5418-1-hal.feng@linux.starfivetech.com> <166457324093.1075476.18009315584754055366.robh@kernel.org>
 <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
In-Reply-To: <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Oct 2022 11:07:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUx9FCDAW4maJytd5H0=Mur9K4Teg99EOp6cVXF8ann8w@mail.gmail.com>
Message-ID: <CAMuHMdUx9FCDAW4maJytd5H0=Mur9K4Teg99EOp6cVXF8ann8w@mail.gmail.com>
Subject: Re: [PATCH v1 23/30] pinctrl: starfive: Rename "pinctrl-starfive" to "pinctrl-starfive-jh7100"
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Oct 4, 2022 at 10:50 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 30, 2022 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, 30 Sep 2022 14:14:04 +0800, Hal Feng wrote:
> > > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> > >
> > > Add the SoC name to make it more clear. Also the next generation StarFive
> > > SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
> > > No functional change.
> > >
> > > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > > ---
> > >  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
> > >  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
> > >  drivers/pinctrl/starfive/Kconfig                            | 2 +-
> > >  drivers/pinctrl/starfive/Makefile                           | 2 +-
> > >  .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
> > >  .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
> > >  6 files changed, 8 insertions(+), 8 deletions(-)
> > >  rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
> > >  rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Would be good to pull this out separately and apply for 6.1. It's kind
> > of messy with cross tree dependencies.
>
> OK I applied this for V6.1.

Isn't the name of the DT bindings header file part of the DT bindings,
i.e. it cannot be changed afterwards?
As of v5.17, it is in active use by
arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
