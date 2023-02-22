Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48E69F307
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjBVKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjBVKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:53:48 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14837B43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:53:47 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id x14so8062970vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1677063226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5MlTtZFsyGu8cOqniDY17GNpI9RMba/aT2wck0Oz68=;
        b=eJ4LjdJNRD6PN1K1sVfguMxeWrXtWS7OBCcokmQFCu8/CkDcydiAqlU4k0eTlk99sW
         ZTtcZN19rjm0MuZwFmyul1F1DvUu6S8mcc7/5kbctDYu9WR1OOrIsxqUtESZ2GoZwFDV
         q9wPhj+Ueth2+65PfSx0kXLJUZTITm7aQW/uJiHAteMq34ARmHTEn/ei5hFdciHYBkcT
         Ni7wEbzbupqPpXrYCi5Re//SQS5BELEbf/C1iEPRw3aI9upAUqFByqFpDrZ1kb/hNT8a
         DfszlFgL9rNXOB+zlAQrcxAqXW0o+3Nt57t9QTS0xOQ+L4jGWkkqawNBgAI4FkZ+pAv1
         iaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677063226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5MlTtZFsyGu8cOqniDY17GNpI9RMba/aT2wck0Oz68=;
        b=cMPVsups1/JE6L9rVWtdFhLhuLbhcY6lH/yELcWlC5b4CIpgu8AgqiCYeQw1VSGWuF
         yrGrRtZ/qHM1P7MNOoyQZf3hbbDV7Sz77NSM8y76+jsiZRdTvpJbga3j5xlXkTWCMB2N
         +YyZLtaMrf4oemyqxPbtyL1HGmDKpTD1qsak3cncwjdspzsOdwCft0jrj0OrqLcND4eU
         L+WZGRIBcf5KdLWeOcsz/UQeE2rj5m/2cXWNHRJWqT8k9CcbzVFKmzrgtwMhxVlIyroz
         Wm0NQS+cr65ESoh9GHYM2sd7ule9+6hMLltgWgzRqvJ6Q0EuwhLGIxeK2ao/EConYuOn
         GolQ==
X-Gm-Message-State: AO0yUKWv0OQNtVvsDVjGSMpo19MdqNB+WikIt/L+AtUmFxRYILubVGqk
        gpC6O8LQukyJBEKVFVmMhhkVt+0lJ6rDorwbp987fA==
X-Google-Smtp-Source: AK7set9nra+0DhCEZ5gj5gwhg4JhAvalntACrAyIMPOjTxAz0SwTUEO5HZy5DM7A3sNGO4RZakKK2xk0ww7hpZbswYE=
X-Received: by 2002:a1f:f284:0:b0:401:8b9a:d80e with SMTP id
 q126-20020a1ff284000000b004018b9ad80emr1422811vkh.21.1677063226136; Wed, 22
 Feb 2023 02:53:46 -0800 (PST)
MIME-Version: 1.0
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr> <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr> <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr> <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr> <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr> <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
In-Reply-To: <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Feb 2023 11:53:35 +0100
Message-ID: <CAMRc=MeFGMtjoq4fwfJ17pBPAstOAjBi3fcQQrjJJnawzx7W5A@mail.gmail.com>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 4:41 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 02:52:38PM +0100, Mirsad Goran Todorovac wrote:
> > On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
> > > On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
> > > > On 2/16/23 15:16, Bartosz Golaszewski wrote:
>
> ...
>
> > > > As Mr. McKenney once said, a bunch of monkeys with keyboard could
> > > > have done it in a considerable number of trials and errors ;-)
> > > >
> > > > But here I have something that could potentially leak as well. I could not devise a
> > > > reproducer due to the leak being lightly triggered only in extreme memory contention.
> > > >
> > > > See it for yourself:
> > > >
> > > > drivers/gpio/gpio-sim.c:
> > > >  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
> > > >  302 {
> > > >  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
> > > >  304         struct gpio_sim_attribute *val_attr, *pull_attr;
> > > >  305         unsigned int num_lines = chip->gc.ngpio;
> > > >  306         struct device *dev = chip->gc.parent;
> > > >  307         struct attribute_group *attr_group;
> > > >  308         struct attribute **attrs;
> > > >  309         int i, ret;
> > > >  310
> > > >  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
> > > >  312                                          num_lines + 1, GFP_KERNEL);
> > > >  313         if (!chip->attr_groups)
> > > >  314                 return -ENOMEM;
> > > >  315
> > > >  316         for (i = 0; i < num_lines; i++) {
> > > >  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
> > > >  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
> > > >  319                                      GFP_KERNEL);
> > > >  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
> > > >  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
> > > >  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
> > > >  323                         return -ENOMEM;
> > > >  324
> > > >  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
> > > >  326                                                   "sim_gpio%u", i);
> > > >  327                 if (!attr_group->name)
> > > >  328                         return -ENOMEM;
> > > >
> > > > Apparently, if the memory allocation only partially succeeds, in the theoretical case
> > > > that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
> > > > free the partially succeeded allocs, would it?
> > > >
> > > > To explain it better, I tried a version that is not yet full doing "all or nothing"
> > > > memory allocation for the gpio-sim driver, because I am not that familiar with the
> > > > driver internals.
> > >
> > > devm_*() mean that the resource allocation is made in a managed manner, so when
> > > it's done, it will be freed automatically.
> >
> > Didn't see that one coming ... :-/ "buzzing though the bush ..."
> >
> > > The question is: is the lifetime of the attr_groups should be lesser or the
> > > same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
> >
> > Bona fide said, I hope that automatic deallocation does things in the right order.
> > I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
> > a per driver list. But I am not sure how chip->gc was allocated?
> >
> > Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
> > as a part of
> >
> >       struct gpio_sim_chip *chip;
> >       struct gpio_chip *gc;
> >
> >       gc = &chip->gc;
> >
> > and gc->parent is set to
> >
> >       gc->parent = dev;
> >
> > in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.
> >
> > If I understood well, automatic deallocation on unloading the driver goes
> > in the reverse order, so lifetime of chip appears to be longer than attr_groups,
> > but I am really not that good at this ...
>
> So, the device is instantiated by platform_device_register_full().
>
> It should gone with the platform_device_unregister().
>
> In case of CONFIG_DEBUG_KOBJECT_RELEASE=y the ->release() can be called
> asynchronously.
>
> So, there are following questions:
> - is the put_device() is actually called?
> - is the above mentioned option is set to Y?
> - if it's in Y, does kmemleak take it into account?
> - if no, do you get anything new in `dmesg` when enable it?
>
> > > Or maybe the chip->gc.parent should be changed to something else (actual GPIO
> > > device, but then it's unclear how to provide the attributes in non-racy way
> > Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
> >
> > I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
> > device expert nor would be appropriate to try the craft not earned ;-)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Mirsad,

I think you fear that the memory allocated for sysfs attributes could
be accessed after the driver is detached from the simulated GPIO
device? This is not possible as sysfs handles that gracefully (by
removing all sysfs attributes with driver_sysfs_remove()) before
freeing devres resources. You can test that yourself by instantiating
a gpio-sim device, opening and holding a file descriptor to one of the
sysfs attributes, disabling the device and then trying to read from
said fd - it will return -ENODEV.

Let me know if you actually mean something else?

Bart
