Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39D5FB4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJKOkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:40:03 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C813FB8;
        Tue, 11 Oct 2022 07:40:01 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id cj27so8340090qtb.7;
        Tue, 11 Oct 2022 07:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sKcP+GTT+SWbU28Mvg7qTSCnoQqhpg8QoNv8i57vas=;
        b=1aNMOHpvof8T12wTAyU55u7qVFoNhS1TB23r1CqXs3i1eZK+TM5HO59VOvt6M/E27R
         EA38S3n/l+OM2H2sSAdK/RugbSUkW0SR5K/icQ3Q1jzYLG5x4NpMuSx0ThSgbFRv2IK6
         7yUDy4NEgldJumzmi3qa+RobR1ce6xc63cez23NNNEBEC5YMA5jMvku0xy3BTQbLTLtX
         AfnpU0jDlsNRErk7JqdRLNmqaeb5fkPOYNg2h+pgKouGSh8exYETRNtek7P0gDUcd69D
         4bxucfkk+JDtgW0y8yBxvVlFPp0EZ4DBuF/lqh7uo6wUu+EyQW9xIK2ZadmP9hfbvyQX
         O1fg==
X-Gm-Message-State: ACrzQf1SCNwAc5AdJHKXDqN3KCAbnw9ZsWfgLowXcIs+kRXuz8atLkb2
        4a9rw6P7hoQGpjXE/a70EFcW5vWbkGb1NQ==
X-Google-Smtp-Source: AMsMyM4YpuJRtELUxBQ47QR4BZqAaZNk2NdfGebfSuG/kCUVyPn3dFtBV9xGHo8vAZs7LWsqk/l0hA==
X-Received: by 2002:ac8:7c4c:0:b0:35c:fa89:5a30 with SMTP id o12-20020ac87c4c000000b0035cfa895a30mr19674630qtv.359.1665499200606;
        Tue, 11 Oct 2022 07:40:00 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006ce9e880c6fsm13030433qkb.111.2022.10.11.07.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:39:58 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id b145so16775121yba.0;
        Tue, 11 Oct 2022 07:39:58 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr21857240ybb.604.1665499197788; Tue, 11
 Oct 2022 07:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol> <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
 <Y0V0IXF3sASTGdMU@smile.fi.intel.com> <Y0V57gI75ik4ki3A@sol> <Y0V9eJX7a0fe6EfX@smile.fi.intel.com>
In-Reply-To: <Y0V9eJX7a0fe6EfX@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 16:39:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhSKuJ3N5zf_+ad_dFu6kSmVTqRpgFUWtd54S9ryw=ew@mail.gmail.com>
Message-ID: <CAMuHMdUhSKuJ3N5zf_+ad_dFu6kSmVTqRpgFUWtd54S9ryw=ew@mail.gmail.com>
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Oct 11, 2022 at 4:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 11, 2022 at 10:13:02PM +0800, Kent Gibson wrote:
> > On Tue, Oct 11, 2022 at 04:48:17PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 11, 2022 at 11:05:42AM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 11, 2022 at 3:02 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:
>
> ...
>
> > > > > > -#include <linux/gpio.h>
> > > > > >  #include <linux/gpio/driver.h>
> > > > > > +#include <linux/gpio.h>
> > > > > > +#include <linux/hte.h>
> > > > >
> > > > > Ok with the hte re-order.
> > > > >
> > > > > But moving the gpio subsystem header after the gpio/driver is not
> > > > > alphabetical ('.' precedes '/') and it read better and made more sense
> > > > > to me the way it was.
> > > >
> > > > I see, I guess this is vim sort vs shell sort. Strange, they should
> > > > follow the locale settings...
> > >
> > > I have checked, the shell and vim sort gave the same result as in this patch.
> > >
> >
> > The original order (sans hte.h) was done by VSCode Sort Lines Ascending,
> > and that still returns the same result.  That matches what I would
> > expect to see given the content of the text.
> >
> > And for me vim also gives the original order.
> >
> > Just to confirm - is '.' 0x2e and '/' 0x2f in your universe?
>
> $ LC_COLLATE=C sort test1.txt
> #include <linux/gpio.h>
> #include <linux/gpio/driver.h>
>
> $ LC_COLLATE= sort test1.txt
> #include <linux/gpio/driver.h>
> #include <linux/gpio.h>
>
> I guess this explains the difference. Currently I have en_US.UTF-8.

Throwing my can of paint into the mix...

I think it is more logical to first include the general <linux/gpio.h>,
followed by whatever <linux/gpio-foo.h> and <linux/gpio/bar.h>,
irrespective of (language-specific or phonebook) sort order.

Yeah, it sucks that this requires some manual work after running sort...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
