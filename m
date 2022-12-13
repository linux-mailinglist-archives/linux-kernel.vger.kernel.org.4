Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BF64B299
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiLMJqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiLMJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:45:57 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1A164BE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:45:56 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3cbdd6c00adso184257807b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iPtLftr9mLTiDAptPz9mvrZVG8hTqgqEvX9Avo9sl1g=;
        b=hKzXso9eZlsyOVFQUJDMuaKvlCYfZTlVdb6U8r74Fs35C7eVjSGT3Vkb/R5Mfy1xkU
         P/CF6pRg0fmWckEmcLfH8V5KvD8T9TojXNwpF63EKIicT5yAu+kYbbjx5rKWDemGf4VF
         UxSG6NeaM1rHYnlaN+4K9Mea/3hEf3+Uhd++yPx5AJfRwxGDngXAfpyX3lF47CjJuVa3
         p+VoyxfRz0LALyDmpZruXOj+MD28bDJnDJPPny3greWOjMnMGdMDE36d4ZVrDwEQoBdp
         Y46WZSZXo4KSrwnBBUFZ80g7pTpy4HSE4SMlSXz2jshf4Ilr2QoUHiX6xwUed84OZuVg
         BDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPtLftr9mLTiDAptPz9mvrZVG8hTqgqEvX9Avo9sl1g=;
        b=K3HuKojtfkg9XiTgoMWigYTY1TNfTPQsQX/ZVJnR3ExPm3CGGhauc0A8Y32hG7tmD9
         lcRFDVWqeamVgzOKXEIVKuzuTy8KjCuMHuhISQUQypuKhAsHdDatuCcZtUEllV5qBDbh
         iWcy3aKBltUmvY94ub8n2CdggS5IH2ngexj1NcU0FKbBnCyjQfFDCWMz/3lvszO+70wW
         DXzWszJTlTzkfla6rW0qmmfbmv+DwM3M/7NffnHmTqlxH1K3qFOaudbbLv3XT0kfDMD9
         C319CtblrgqgeR74BuIMfzxyi2rM1I2iogEL14i/VyFKg7C7tBXA9n6OYumCm7jduVMT
         32PQ==
X-Gm-Message-State: ANoB5pniywH3khQjDhQmrX5te1+kRNEycmdQOALAP39gI06ByPvcCQ+Q
        FZhWZoXDzuBX+dVZLe9UzigxbVtOxFBppKyRsdOMBQ==
X-Google-Smtp-Source: AA0mqf5KB4LYFTpAQUpghbjTaGUJ19gRvoZw0sTgHBYe53MAcw9jcGLIhvF3gdN62YzKc6H5k3qDSar0IR2TxwYnNPo=
X-Received: by 2002:a81:5d8:0:b0:3f5:b69c:387 with SMTP id 207-20020a8105d8000000b003f5b69c0387mr12925219ywf.359.1670924755634;
 Tue, 13 Dec 2022 01:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20221121123803.3786-1-zhuyinbo@loongson.cn> <20221121123803.3786-2-zhuyinbo@loongson.cn>
 <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
 <8a7abd77-9540-efa8-6f67-908530e85399@loongson.cn> <CACRpkdb=wdydOYCcrpjLSyvfVO--_ezXsFQ46qwfVCiiTd5fNw@mail.gmail.com>
 <b78f02f4-4329-602e-ca8d-adbe911c2a54@loongson.cn>
In-Reply-To: <b78f02f4-4329-602e-ca8d-adbe911c2a54@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Dec 2022 10:45:43 +0100
Message-ID: <CACRpkdbrY2hV=JM3NJVdFyJbpXARKEhGMVpwrN9U=cP6LzyPQA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 9:34 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> > Don't do that because the GPIO maintainers love the
> > dynamic base and hate hardcoded bases. Set the base to -1
> > If you wonder why, read drivers/gpio/TODO.
>
> Hi Linus,
>
> I recenly verfied other peripheral on upstream, some peripheral driver
> need use gpio number,

What do you mean by upstream? If it is your own derivate kernel
(what we call *downstream) then it should be fixed, not
accommodated for.

If it is the mainline (Torvalds) kernel you are looking at legacy code
(such as boardfiles) which should be fixed or deleted. Beware that
the kernel contains much old code and bad examples which should
not be followed.

> but if use dynamic base that gpio number will be
> meaningless.  in additon I notice that many gpio driver don't use
> dynamic base, although bgpio_int was called.

Two wrongs does not make one right.
It is always possible to find bad examples in the kernel, because we
maintain lots of legacy code.
When in doubt, do what the maintainers say.
This maintainer says this: use a dynamic base.

> so I think the gpio number should be keep consistent with datasheet for
> some platform that need use gpio number.

So someone wrote a datasheet for a derivative, home-cooked kernel
that they had not bothered to synchronize with the community and
now the community should accommodate this mistake?

Sorry that is not how we work.

That datasheet is probably recommending old and bad practices, such
as using global GPIO numbers in drivers or using GPIO sysfs. The
GPIO maintainers do not approve of such stuff.

What about fixing the datasheet to say:
- We use dynamic GPIO number allocation
- Assign GPIOs to devices in the device tree with only HW GPIO number
  references = <&gpio HW_NUM GPIO_ACTIVE_HIGH>; etc
- For userspace access use libgpiod and /dev/gpiochipN, do not
  enable the legacy GPIO sysfs.

Yours,
Linus Walleij
