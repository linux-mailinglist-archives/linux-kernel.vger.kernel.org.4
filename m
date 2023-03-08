Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108EA6B06B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCHMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCHMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:13:39 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB93900B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:13:38 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v101so14395997ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678277617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oca9dY8hWUO5/h8xtr438Tcso20TDnzGLmg2ddoHe4M=;
        b=mG+VNc7/+ZVH4peD5IzNTeOjeDEtz2/QDLrQseyt1w5jR60Vf3vwhV/UiECtfojG1d
         placMWBg9SZ3uNn9KmQCqQyQKL+3dbLOvATLA2d7k4wzQeMx7iD1t8Ej0dykdODGuchw
         ZIC5gVhPTsdlc+vgfY7DP/ICTAy1rHAyN0BtycPUV2Td9bWfnWKPQAR41CdVEPVcLgjE
         +amCcxZzViJs5TgPv/+zaeIZbAkHw0Gr3djUm2UlDD9P1vRU2cWC0xMDVSvcDMuZv6Ij
         EZN20pCM7mLDwQNRN/EbnHrQycWZHZ6Zqd7umnQU+0SOlaK2Kpr6Cuz2EZN4okjiyEw/
         ID7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678277617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oca9dY8hWUO5/h8xtr438Tcso20TDnzGLmg2ddoHe4M=;
        b=mI6KuuOy5kV+HbVs6phYNX4EbAdTWxLUeH2IgLLEhWrzChQBNJPfAfrY+yzTxqGEu2
         3C92xtROYtVlq5z615gVfVmpLL3gaEQKFWehKs/1asLEhC75SN2e46vGoxFcQOuVAt+p
         yA5MHvikHi8Sosdez6EsmKYiZOkVLtPLlkhw4SX3Oyov1mDcwmJL+seJgFP0yBYDnSPH
         SoHwnY1alXho4qKsLDXYYTPByuc/FbT19XgqVf8myoWzX4qkU0QIJuh23OSqpSOlWTGy
         /GWkjKKa+lxXBzRfrv+06EbjS3VO3DDRouuQU6gQSCNxF2XjWtT/DvfcDBCnLuWfxeHQ
         YS+g==
X-Gm-Message-State: AO0yUKXNG83HOdnttB4IwHIVJGnmjfOVufyP44OWlPHL8PRtKttovSXs
        oJT9zh+DOEB8r2saXwwS+wRdjm+r2Nbg/oOLmCKbFA==
X-Google-Smtp-Source: AK7set+ggNypJdI+7ULj7vVNY+A7k42rbSaDWPMWE5mmu2065wVDPTzRD/vMNWcCbvtu842b/ja6rElDW3gnsY5CIcg=
X-Received: by 2002:a5b:209:0:b0:aa9:bd2e:3746 with SMTP id
 z9-20020a5b0209000000b00aa9bd2e3746mr6164422ybl.4.1678277617418; Wed, 08 Mar
 2023 04:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
 <20230215-immutable-chips-v2-3-d6b0e3f2d991@linaro.org> <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
In-Reply-To: <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Mar 2023 13:13:25 +0100
Message-ID: <CACRpkdZmemtVHkdo7f8G4wTHEayk1moHSMHEyvomebPV_h8AHA@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] gpio: aspeed: Convert to immutable irq_chip
To:     Joel Stanley <joel@jms.id.au>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:22 AM Joel Stanley <joel@jms.id.au> wrote:
> On Tue, 7 Mar 2023 at 13:04, Linus Walleij <linus.walleij@linaro.org> wrote:

> > +static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
> > +{
> > +       const struct aspeed_gpio_bank *bank;
> > +       struct aspeed_gpio *gpio;
> > +       u32 bit;
> > +       int rc, offset;
> > +
> > +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
>
> Why do we call this instead of using irq_data_get_irq_chip_data?

Because this is what the other irqchip callbacks do and I do not
dare to do anything inventive or different as I can't really test
the patches.

> Actually, the callback appears to do the same as the default
> implementation, so we could just drop it?

So is chip->name always set to dev_name(dev) if we don't define
it? I had no idea.

I can respon with this change, the optional IRQ should be a separate
patch I think?

Yours,
Linus Walleij
