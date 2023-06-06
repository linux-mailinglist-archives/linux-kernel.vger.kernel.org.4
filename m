Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43524724E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbjFFVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjFFVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:15:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E241701;
        Tue,  6 Jun 2023 14:15:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75da00a1eddso348002885a.3;
        Tue, 06 Jun 2023 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686086146; x=1688678146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvN8OXRancFtDGRge34JRr569bxdYS/BXS1NWvHf0Bs=;
        b=YUUpd8gLS3To8QU1u1zdbIw1zlkrBlUMc/EHB53Lo2uc+CgdWuQpdJYvbp7cjiXZpr
         FTW6dAieePNc01wOwzFoUuFfo2zO0hUeurUc8osXV+1jGZkWcTcN/63/MLAoWCifjqTg
         9LS/206mmmQC3kUhCUGWlxNAgr74ica3OXLXRu8kuF/AuppPvhgJZ5ikOZSIGyyFV7Go
         xa5s8QlSSaWVRtYbuKnpc8fXLHSOyaFR6zJyiBjOQdh+LuuGgxN7mPcJOAPICL/RnBmf
         eqJbL+G59q8tXf3WLBpG8e0Pet5H7K72Wc/BMT+y5mx9pKhfJlRilr+yLghSQwL5oLIJ
         fPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086146; x=1688678146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvN8OXRancFtDGRge34JRr569bxdYS/BXS1NWvHf0Bs=;
        b=efTfBrN7++7tRqYz5/49sPBuJa6iZ5d3uK4TSclt/hrptEYPr5fYuL+XpWDwZE2n+u
         FnIIOKt+HlV3okSFfxv49T1vnqATi3LkrfDax6l0y3w2RUKcpjgMdbeUDtny+inT0p/H
         LaJjvr7RPE5N3GYjN2gYjjUqEX+KK5oFNZkYgAc4BHpi0Svd1SlOuiSqycTKh5MuiUnx
         VBwiKgPKdFUlTr/MdgnDtayXkgHsln2uCHyUARxiEK4dW9PffbHRmRRz72OvLsNBpKwc
         J2HesFue29pmbhRgI4NiVX/fNgMr2XU3ba3RnG8785/xv9SpIDamid3ibDg0LXMCh7OH
         d8iA==
X-Gm-Message-State: AC+VfDwRnx0hihdL68HUtRTKHajuKPHOgor8IXLjaeRNZyF6v7r6eodF
        Iu4kovg6zKIFgehHavosAVRVPCT7RXTvxJjfKCHaPJz9ToLH9g==
X-Google-Smtp-Source: ACHHUZ7Fqe8U97GhrXgtHItqlviHzhpysCDXWWNuk+HDSM/2vKEgTAn2+WZvDgejJMHv+Z8q+/smlqdCuT1UII3dbro=
X-Received: by 2002:a05:6214:4017:b0:623:4ca9:5b24 with SMTP id
 kd23-20020a056214401700b006234ca95b24mr1079958qvb.12.1686086146475; Tue, 06
 Jun 2023 14:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230606014234.29491-1-nick.hawkins@hpe.com> <20230606014234.29491-3-nick.hawkins@hpe.com>
 <ZH76x6E9cbfrJHeu@surfacebook> <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jun 2023 00:15:09 +0300
Message-ID: <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 9:51=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.com>=
 wrote:

...

> > Why are you not using gpio-regmap?
>
> Is there are good example or previous commit you would recommend
> looking at that shows how to convert from regmap to gpio-regmap?
> Later in the code I am using regmap_read and regmap_update_bits
> with large differences in offset registers, and not so much a
> contiguous block.

I don't know how good these are, but that's what we have currently as
most prominent use of gpio-regmap

1) (ongoing) https://lore.kernel.org/linux-gpio/20230606092107.764621-6-jia=
wenwu@trustnetic.com/
2) (in the repo)
https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpio-i8255.c
3) (in the repo)
https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpio-104-idi-=
48.c

2) & 3) were converted, so you may see by executing respective `git
log -p -- drivers/gpio/...`.

--
With Best Regards,
Andy Shevchenko
