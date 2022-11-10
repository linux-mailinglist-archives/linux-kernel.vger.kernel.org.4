Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1011623F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiKJKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiKJKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:02:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769B6B3B2;
        Thu, 10 Nov 2022 02:02:27 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id hh9so628975qtb.13;
        Thu, 10 Nov 2022 02:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FttHOwm7yc9wMfWVriclkQhHjfh2wdlqWSk7Onvpq8=;
        b=CpYG5wHpFAWfwMEJkJ0eHYbZ9DL6XwV2Z/moVEO9AM4ClREtISOeFFzcR0rcxMVz9V
         g2OxzAjvczR/8MOr1r1UBRKzsiVqV3b6O2ydSAvqXsVQPgcX7L7bW6F/lSzpePH8OJ02
         8mIGf6EyfxQEo2Zyr1eLGPMFf+tmiZZNje+1FjEBU59ZRLBAxJ6JJVGszx8X7NTncvGv
         UJVEyGc+3kDwaI7RaqpcSt8wJzU4SgGI8rBR5tS7qLUo966pmdZI4ZZ3LSG5DkuQ07ZC
         R8ILr3qVPKxVyQfZPNKlATCvpJruYwCrJ2XgU9EFq+Vsj8e2h2kZ3+MfnfNKY2264vaP
         nSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FttHOwm7yc9wMfWVriclkQhHjfh2wdlqWSk7Onvpq8=;
        b=hXDDvhum5A258L+bQQh/SsHTkeoPk/tNTNmb7qdKrDUukKqQoue8grdeG1Tbte8lmQ
         E3vT3CUfSRCkMfCYIIRyfnXwqhD23PVKWJ/K+Dc2U1W4jl3U+A2F3FHko+YfRjzXYVBx
         OY1eclQ5CokuxGnRfjPJ3hfhMJJ0Oo/nF6TCInNQAB6vfbgmEisQMgRRCv6HZFw4Y1vR
         e2XqutUb7/Wl7HBJakCXo6XpZBcAwi6v8GBlMb894HqW2dXoU73NNWDAcw7YbQxJoO4G
         Y0KqS/k8xhFKtZ/LNS2Ttq7BWhiJMRV6Aubdq1lkHcWafuaRdT6wZmRQC8qtIekUmPLc
         GKsw==
X-Gm-Message-State: ACrzQf1Ahc63nRwnJDkgiwt80NbPumRacz0+KYODxylUFyxW2llUklSZ
        Nh658KHie8FEqyEyuJISFIvuFP7GLGgXp6utpd4=
X-Google-Smtp-Source: AMsMyM5zyKKFkF0k+jBAxhQa09hMD/ILNPqt1IUoUwv+CYksYwl4z51Pjj8Y6qF5FNIYquzMCn/iEQzmc6JmyK82jgE=
X-Received: by 2002:ac8:7152:0:b0:3a5:2fa2:cd1a with SMTP id
 h18-20020ac87152000000b003a52fa2cd1amr40448801qtp.195.1668074546324; Thu, 10
 Nov 2022 02:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-6-andriy.shevchenko@linux.intel.com> <20221110073831.ggudvgl6jzgbo2vb@pengutronix.de>
In-Reply-To: <20221110073831.ggudvgl6jzgbo2vb@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 12:01:50 +0200
Message-ID: <CAHp75Ve837d_2UEQRMJEcmOdPVdqSAKv+dJje057uJouCPAe9Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] pwm: lpss: Add pwm_lpss_probe() stub
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

On Thu, Nov 10, 2022 at 9:38 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 08, 2022 at 04:22:25PM +0200, Andy Shevchenko wrote:
> > In case the PWM LPSS module is not provided, allow users to be
> > compiled with a help of a pwm_lpss_probe() stub.

...

> > +static inline
> > +struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem =
*base,
> > +                                  const struct pwm_lpss_boardinfo *inf=
o)
> > +{
> > +     return ERR_PTR(-ENODEV);
>
> Would it be more consistent to return the same value as the pwmchip_add
> stub does?

Then I will lose the ability to distinguish between absent driver (or
device) and actual error during the probing of it. Any suggestions on
how to do that better?

--=20
With Best Regards,
Andy Shevchenko
