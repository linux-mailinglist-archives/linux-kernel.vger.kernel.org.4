Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3E600BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiJQJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiJQJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:58:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC185D115
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:58:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ot12so23716534ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/Byge+Vue4J7Z80ANz5rsyrsoG83IPzp3UARO7F6/s=;
        b=MUHWuYJag6UdIGNJWiJWxn8WAAZ42CXEFTnECn+6skOIqg/uauJYEVg974vMd9sMEk
         zE6zI7z18arTxzgN6sTudVQN0HH06/PzZJ+4X18m75Vy/bF7X3X+fEqiRAyn7cwpLeMe
         1S3Gkx8o3vO463r4qBmru/5P+HeV+QtYD7XFaMKTFQkBKEINKik6GSXOIGd4TakIzo/y
         22NV5ZvkVpf1kqoQWmMXugwEs+G3K/F00qz0J2gsZD0tyQrxzJVUb1Rv0OE2tl8BfDdT
         1Thx86QUb3Eo9BPHEOAqRcLadLrkm9xIrIOP9q0Nx+T+iVZxfi/eZSxmcD7GZQwM5l3C
         f6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/Byge+Vue4J7Z80ANz5rsyrsoG83IPzp3UARO7F6/s=;
        b=x5aIVUzbQY5pDlZLWCCq11rjDSMudBLQbmZ4v3hLPE6lLE1wAlCb24CvgwoMzQzBB8
         H4EB0lO4MlTYoWLuORTbhF4UJya89VSZ4Uay78pxafRXasWeW4WUGI8j3v6WjmNYtOgW
         hkxB9b0G8M55tT1mYXYuLpngGlwqu5G9k16LIfIK8vLPP//RciI0GsENLsGK5ssT98FZ
         2oqItqC64cSDTF3CT5ldqfbTslxk3Qt6UTjtOEcO7ClEYLfwdCj0lvXg6JSW4scbWI/h
         QZ4EaICSmZk4xA6a+WgbO02rLDSq2mVcsHO8w83VVMSJo7LhsBdLXUhEupXmG3c/uEHD
         G1hw==
X-Gm-Message-State: ACrzQf1KGdDNx6jWAITwsiqJ2qKWr9/ht6LB9A+J+iMzbdqLWRqmgtpE
        CWyALOSRh6g5KGn7BLlwHTzuqLgDnev087VQ1P8MXQ==
X-Google-Smtp-Source: AMsMyM4L0M6bcj2Wvh4KRdD8EKd7M4z6+eLVjZHPl1MFPGYp6JqekMO0KaAEpqZ8kDbWIS4EMUIR8qxcTy8qHdB2D/8=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr7556783ejc.690.1666000695069; Mon, 17
 Oct 2022 02:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ1M3ckw+jFgvMqG4jvR-t_44GPoZ6ZDXszwZCJr-cDpg@mail.gmail.com> <Y00f5exY2fM6IwZ+@smile.fi.intel.com>
In-Reply-To: <Y00f5exY2fM6IwZ+@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 11:58:03 +0200
Message-ID: <CACRpkdYmSOGtFz8W_RRkDqMXRRBOSB9jqSn65Sah90bf3Gm59g@mail.gmail.com>
Subject: Re: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:27 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 17, 2022 at 11:02:09AM +0200, Linus Walleij wrote:
> > On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > > than logical. This series is basically out of two parts:
> > > - add missed headers to the pin control drivers / users
> > > - clean up the headers of pin control subsystem
> > >
> > > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > > pin control subsystems, so all new drivers will utilize cleaned up headers
> > > of the pin control.
> >
> > Aha I see you want to send a pull request so I backed out the applied patches
> > from the series for now.
>
> Can I consider all that you answered to as Rb tag?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I haven't reviewed in detail but I fully trust you to do the right thing
and fix any fallout so will happily pull this.

Yours,
Linus Walleij
