Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F36C698F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjCWNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjCWNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:33:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4ED233C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:32:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z83so24797158ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679578377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmves1iun0LubRv/Ys4nZA2xeBzv8UQwNvC60f9TikY=;
        b=gqkCvl2kGvvcTFaJQcV+x+kJOcpeu9ZiQhIHPJC0OblCLfOis7YK/eGv26OVsFrtoz
         yF7QAL9IeR7Rl/5uP7zwJhv0/2wQ9lovpDLkPDqEoknhnuHKlupaLBiMsYcIMBjQN/ed
         eP+12pBn9LjvItcCaIc6NJaeVb0/CYZqx2OqluVyrt/SyExWWDSE5s4Hawf/NJFUuHbv
         yehmkzEfSAkzQpT3dy0bztCSWWIGWcO1inuFAzLwo2eWq626YjqVNy+F71C6YMb4kOTJ
         fAvYxsa0SAZhPy2sbgpYsINZoBew9fe47bzdP3TSHNh2fuNAf2deKx4v0EWeaStgK6Bg
         F+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679578377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xmves1iun0LubRv/Ys4nZA2xeBzv8UQwNvC60f9TikY=;
        b=ZOni52sucYuF+FmxqR8a8/2uecLZyLIbhDCsLPR8eiwIieaiQv2zAITI1snhm0NKE5
         cPCaIXfDG7uggLTEsh52qttdze03mQ0z5ZsO6v6Q5lGl//gAiRSS4kxLW1+IaRYH8WOz
         8Ij26EttTOMXSS6uutu0NhPxu8cphoU/O3CInguLM0EYNW6P5n+th1yLN5Moi/AmP701
         oLcjAaWgB5UUk/kVo9qB4ExCPzpwjwELp7D1tDJvnboypq+vsFjTXI0u+UxTPeIy6M22
         owrbDsg3xOyJC9n4+VdXwWwvL8yBo4lXuRabtfY4a9HoUHwi9KxNi2qptYe/ipX08Ca+
         dAdQ==
X-Gm-Message-State: AAQBX9fmrp+IFEtFM0glOPX1m0iPbyJhY2iEkLP32N9OT++HblMsSrFO
        rsBkDa1fkkS0Lx6kod5GrAY0cOuAWhPjpFBjG9Fvsc2j/7SVeljX
X-Google-Smtp-Source: AKy350YvJQnyVMRG28Mg7eTiOxvu2RSo5Ia+/3VnicOc+rmBAoLIdzonkW39U5RjqaDQaMKRmgLmwP/lEA4ZnbSOUxQ=
X-Received: by 2002:a05:6902:728:b0:a09:314f:a3ef with SMTP id
 l8-20020a056902072800b00a09314fa3efmr2229914ybt.12.1679578377145; Thu, 23 Mar
 2023 06:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230323122913.4f0410b8@canb.auug.org.au> <ZBtb6ML7FmMZ6uQ3@fedora>
In-Reply-To: <ZBtb6ML7FmMZ6uQ3@fedora>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 23 Mar 2023 14:32:46 +0100
Message-ID: <CACMJSev=ojX5j1qsMjTDev-cXxrKmT3o2rF=YpuuSbsVsuNzgw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 at 02:47, William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> On Thu, Mar 23, 2023 at 12:29:13PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/gpio/gpio-pci-idio-16.c:32:30: error: field 'state' has incomplete type
> >    32 |         struct idio_16_state state;
> >       |                              ^~~~~
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_direction':
> > drivers/gpio/gpio-pci-idio-16.c:39:13: error: implicit declaration of function 'idio_16_get_direction'; did you mean 'idio_16_gpio_get_direction'? [-Werror=implicit-function-declaration]
> >    39 |         if (idio_16_get_direction(offset))
> >       |             ^~~~~~~~~~~~~~~~~~~~~
> >       |             idio_16_gpio_get_direction
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
> > drivers/gpio/gpio-pci-idio-16.c:62:16: error: implicit declaration of function 'idio_16_get'; did you mean 'idio_16_gpio_get'? [-Werror=implicit-function-declaration]
> >    62 |         return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
> >       |                ^~~~~~~~~~~
> >       |                idio_16_gpio_get
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_multiple':
> > drivers/gpio/gpio-pci-idio-16.c:70:9: error: implicit declaration of function 'idio_16_get_multiple'; did you mean 'idio_16_gpio_get_multiple'? [-Werror=implicit-function-declaration]
> >    70 |         idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
> >       |         ^~~~~~~~~~~~~~~~~~~~
> >       |         idio_16_gpio_get_multiple
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set':
> > drivers/gpio/gpio-pci-idio-16.c:79:9: error: implicit declaration of function 'idio_16_set'; did you mean 'idio_16_gpio_set'? [-Werror=implicit-function-declaration]
> >    79 |         idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
> >       |         ^~~~~~~~~~~
> >       |         idio_16_gpio_set
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set_multiple':
> > drivers/gpio/gpio-pci-idio-16.c:87:9: error: implicit declaration of function 'idio_16_set_multiple'; did you mean 'idio_16_gpio_set_multiple'? [-Werror=implicit-function-declaration]
> >    87 |         idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
> >       |         ^~~~~~~~~~~~~~~~~~~~
> >       |         idio_16_gpio_set_multiple
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_mask':
> > drivers/gpio/gpio-pci-idio-16.c:106:45: error: invalid use of undefined type 'struct idio_16'
> >   106 |                 iowrite8(0, &idio16gpio->reg->irq_ctl);
> >       |                                             ^~
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_unmask':
> > drivers/gpio/gpio-pci-idio-16.c:129:41: error: invalid use of undefined type 'struct idio_16'
> >   129 |                 ioread8(&idio16gpio->reg->irq_ctl);
> >       |                                         ^~
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_handler':
> > drivers/gpio/gpio-pci-idio-16.c:164:46: error: invalid use of undefined type 'struct idio_16'
> >   164 |         irq_status = ioread8(&idio16gpio->reg->irq_status);
> >       |                                              ^~
> > drivers/gpio/gpio-pci-idio-16.c:178:37: error: invalid use of undefined type 'struct idio_16'
> >   178 |         iowrite8(0, &idio16gpio->reg->in0_7);
> >       |                                     ^~
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_init_hw':
> > drivers/gpio/gpio-pci-idio-16.c:198:37: error: invalid use of undefined type 'struct idio_16'
> >   198 |         iowrite8(0, &idio16gpio->reg->irq_ctl);
> >       |                                     ^~
> > drivers/gpio/gpio-pci-idio-16.c:199:37: error: invalid use of undefined type 'struct idio_16'
> >   199 |         iowrite8(0, &idio16gpio->reg->in0_7);
> >       |                                     ^~
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_probe':
> > drivers/gpio/gpio-pci-idio-16.c:232:37: error: invalid use of undefined type 'struct idio_16'
> >   232 |         iowrite8(0, &idio16gpio->reg->filter_ctl);
> >       |                                     ^~
> > drivers/gpio/gpio-pci-idio-16.c:248:9: error: implicit declaration of function 'idio_16_state_init'; did you mean 'file_ra_state_init'? [-Werror=implicit-function-declaration]
> >   248 |         idio_16_state_init(&idio16gpio->state);
> >       |         ^~~~~~~~~~~~~~~~~~
> >       |         file_ra_state_init
> > drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
> > drivers/gpio/gpio-pci-idio-16.c:63:1: error: control reaches end of non-void function [-Werror=return-type]
> >    63 | }
> >       | ^
> >
> > Caused by commit
> >
> >   473b79057bbd ("gpio: idio-16: Remove unused legacy interface")
> >
> > I have used the gpio-brgl tree from next-20230322 for today.
> >
> > --
> > Cheers,
> > Stephen Rothwell
>
> Commit 473b79057bbd shouldn't be merged until all of the IDIO-16 legacy
> interface is first removed.
>
> Bart, would you revert all of the "Migrate IDIO-16 GPIO drivers to
> regmap API" patches [0]? That patchset needs to be revised anyway to
> prevent conflicts with the handle_mask_sync() API change [1]; I'll
> submit a v3 later this week that resolves the incompatibilies and
> rebase on the latest gpio/for-next.
>
> William Breathitt Gray
>
> [0] https://lore.kernel.org/all/cover.1677515341.git.william.gray@linaro.org/
> [1] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/

Done, thanks!

Bart
