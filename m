Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB7623FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKJKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKJKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:24:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBDD663FA;
        Thu, 10 Nov 2022 02:24:51 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id a27so656751qtw.10;
        Thu, 10 Nov 2022 02:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7OQDRdg/PBKb75GJhg597BiFzGJdloU/76dILAYuhQ=;
        b=GVEyzN1eEbMQyQBN2auzyQXHH73BcHa5Fyfr5jepcgR2gPq6KEYPE5FR9JhvJmElyb
         3FjOFTFg+RfCtXet32H7kvn8eSW+WZa2yFGHIkYKKjeCJgTjQDMOGWTvPguPuAwMtfDD
         XAALI6jGkEC91xwDh04WLsnQkHoARIXhcSDQak3FygTVJ7nku8lXvq1Z2r68W3BR6GZ6
         Nu4xI/mGAKSLe0WG19qR/03vYvuLVaSwIjzOR858paVaD2Vgle0dQUv86jCrIbt2VTns
         T62p3Z+mslNJJ2bAYJRH3OHcKyZjulKCmKq4mCo9jlIbKHxdqu1P11OisilaDagcuvkd
         Tk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7OQDRdg/PBKb75GJhg597BiFzGJdloU/76dILAYuhQ=;
        b=s5Dcao/YK76j7uzFi1FoWjH9gPf2jOUMfT3QdhKMIZmBIYzkF5XjA6fHQ8fAuHJbkf
         JJC7spVEWC2KYThU5vu95kIoURvUUomQZpX5vASlvP0xKSFQxpfeE2zUBUj5pdNFSxrR
         s8o0Kq9VDsHFZhkihehnvQQGeF1xhyeGjxoKfUo1f9CiT5Z0A1avc2fGiEtE/e/20d11
         IY2ULaGm7b88sv3qMCbbAo6ioIDxQXSM2gdShhk7nZGOv2rkGkIuEcigoKBz+rFhkNuB
         VileK/8pcttEA4uNFn+/5+fZweK/7ina6vuYrXi4n4c+1SzgsNv7JHdwIiE6wWChm5nH
         WeNw==
X-Gm-Message-State: ACrzQf1eN8DVDKPA+u0ML2C4zE3qIJtByKysrrHDZOMgstdCsr/GuoEF
        PPMXcYfXTIoYClQjObJ7rI22jftGlkHITtXNT7M=
X-Google-Smtp-Source: AMsMyM717gn40X0LG0YAQOaEOSHzvkaHpEdAOnw0/rGnjLJcED5HZEScxpx7nTTlIhPrLJDUqkSH6Cz5vW2SKA6KO1s=
X-Received: by 2002:ac8:7152:0:b0:3a5:2fa2:cd1a with SMTP id
 h18-20020ac87152000000b003a52fa2cd1amr40497653qtp.195.1668075890956; Thu, 10
 Nov 2022 02:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-4-andriy.shevchenko@linux.intel.com>
 <20221110072144.2s37r52qcpi6utgh@pengutronix.de> <CAHp75VenLc-QfuD3rHPh=5nu_SqWvEnsePbNMsBA4R-Zs+nvrw@mail.gmail.com>
 <20221110102025.2tqdb3v6ndg6vyqk@pengutronix.de>
In-Reply-To: <20221110102025.2tqdb3v6ndg6vyqk@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 12:24:14 +0200
Message-ID: <CAHp75Vdmr8X1iWqtCZ3b1G+GE0KQFJDVr=f26v_2Y5G1AhRZMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] pwm: lpss: Include headers we are direct user of
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:20 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Nov 10, 2022 at 11:53:59AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 9:22 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Nov 08, 2022 at 04:22:23PM +0200, Andy Shevchenko wrote:

...

> > > > Replace device.h with a forward declaration in order to improve
> > > > the compilation time due to reducing overhead of device.h parsing
> > > > with entire train of dependencies.
> > >
> > > Together with "For the sake of integrity, include headers we are dire=
ct
> > > user of." this makes an a bit schizophrenic impression on me. You add
> > > <linux/types.h> because the file is a direct user of it, but you drop
> > > <linux/device.h> despite being a direct user.
> >
> > But we don't use device.h.
>
> What is the canonical header to provide struct device?

But we don't use the struct device here. We use _pointer_ to a struct devic=
e.


--=20
With Best Regards,
Andy Shevchenko
