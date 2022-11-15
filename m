Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE862AF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKOXT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKOXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:19:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE46319;
        Tue, 15 Nov 2022 15:19:21 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v3so15003131pgh.4;
        Tue, 15 Nov 2022 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz56XkUie8CTZ7dnEHUH6pIADzDVI3YbYDDxtOkhxuE=;
        b=ZShIHfir/IpmOj3wxLNBiSKmw4lA73I6HtSJfOvQ5ndCi07b8wQ9tNMYXnaXyI79BV
         srliTEymVBTk48KSaGkAIykqqVWkpwYj4gIzPCR/7dK+bOaX+uy1qDtbFUHHrx2VqTvW
         K7+3N94zkUYFi7+EaLAeq8cCElnNH3y5jJzcCNrQOAJkxOGupmhCdKksNhYDLo4X6wlx
         kRlioTyKFYqPs4+IE3oCwZlp2+94I8ueyWIMWIPmTZzI4K28yR7GH6CJNLyEm3TnXvdY
         b/0PR+Y7aOKxNQVLDQDNBMZ+tqBLajmx0hJenDv4qiGC/gBB0hyP+WM9NDcy/TLN2Omj
         d1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz56XkUie8CTZ7dnEHUH6pIADzDVI3YbYDDxtOkhxuE=;
        b=Nuh5FM3/vOe6JELLi+86oqvGrE3eLNzEX+CI/cxFPvjyKV6KFOJDDxptCwCG/OaIzx
         MB30JYabFxn2eoMfSuqnllWRQWnX5t/yt4lVMG/xf0tp2nhu5SbuSh6EI1OF0Id96Hwc
         5QSEglIRK3SNY61OkICTHnqFAYwNZKYxJoYWzQqDwKfOgAjwp9wz3FgbUIRB7sXA4DoW
         w4y8e2trrn6g8sVfO73mb9VmLLadEp4aBQG5x9PZdd0vmoEmwqolqi6QAWGZn1xvYym3
         25OJb18BjdTFdacuHHLXCa+GB50ngkDGqAR7NXE5pBfZVRpaG+uMs0Scwl5nkYBTPAI4
         DJhw==
X-Gm-Message-State: ANoB5pniZXCX2r5+we1JsntBKrpNzp3fVwV1rPOXATcsxWx/XUcHWeDK
        T6/BMFCaVlVERSRs79JtBKc=
X-Google-Smtp-Source: AA0mqf5K1YA8mAOeu5fTKmA/mnWODA/nUqDxUPTwnORtbJEvmNGik7Vl8Q8Ij6bDGeIyLXvotf2p4A==
X-Received: by 2002:a65:58c7:0:b0:439:3c55:3df1 with SMTP id e7-20020a6558c7000000b004393c553df1mr17785447pgu.606.1668554360675;
        Tue, 15 Nov 2022 15:19:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a668600b0020d3662cc77sm92990pjj.48.2022.11.15.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:19:19 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:19:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add support for software nodes to gpiolib
Message-ID: <Y3QedBxErvjc+YHi@google.com>
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
 <CAMRc=Mf+FFyx7Mkw-nLMaoayJUjZbkEHDkVCsa_L+XkX6sEQDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf+FFyx7Mkw-nLMaoayJUjZbkEHDkVCsa_L+XkX6sEQDQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:28:17AM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 11, 2022 at 11:19 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > This series attempts to add support for software nodes to gpiolib, using
> > software node references. This allows us to convert more drivers to the
> > generic device properties and drop support for custom platform data.
> >
> > To describe a GPIO via software nodes we can create the following data
> > items:
> >
> > /* Node representing the GPIO controller/GPIO bank */
> > static const struct software_node gpio_bank_b_node = {
> >         .name = "B",
> > };
> >
> > /*
> >  * Properties that will be assigned to a software node assigned to
> >  * the device that used platform data.
> >  */
> > static const struct property_entry simone_key_enter_props[] = {
> >         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> >         PROPERTY_ENTRY_STRING("label", "enter"),
> >         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> >         { }
> > };
> >
> > The code in gpiolib handling software nodes uses the name in the
> > software node representing GPIO controller to locate the actual instance
> > of GPIO controller.
> >
> > To: Linus Walleij <linus.walleij@linaro.org>
> > To: Bartosz Golaszewski <brgl@bgdev.pl>
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: linux-gpio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-acpi@vger.kernel.org
> >
> > ---
> > Changes in v4:
> > - Rebased on top of next-20221111
> > - Added Andy's reviewed-by for patch #6
> > - Link to v3: https://lore.kernel.org/r/20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com
> >
> > Changes in v3:
> > - Addressed more Andy's comments
> > - Link to v2: https://lore.kernel.org/r/20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com
> >
> > Changes in v2:
> > - reworked the series to be independent of other in-flight patches.
> >   That meant keeping devm_gpiod_get_from_of_node() for now.
> > - removed handling of secondary nodes, it deserves a separate patch
> >   series
> > - fixed refcounting when handling swnodes (Andy)
> > - added include/linux/gpio/property.h with PROPERTY_ENTRY_GPIO (Andy)
> > - addressed most of the rest of Andy's comments
> > - collected reviewed-by and acked-by
> > - Link to v1: https://lore.kernel.org/r/20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com
> >
> > ---
> > Dmitry Torokhov (6):
> >       gpiolib: of: change of_find_gpio() to accept device node
> >       gpiolib: acpi: change acpi_find_gpio() to accept firmware node
> >       gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
> >       gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
> >       gpiolib: consolidate GPIO lookups
> >       gpiolib: add support for software nodes
> >
> >  drivers/gpio/Makefile         |   1 +
> >  drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++++-----------
> >  drivers/gpio/gpiolib-acpi.h   |  54 +----------
> >  drivers/gpio/gpiolib-of.c     |   7 +-
> >  drivers/gpio/gpiolib-of.h     |   4 +-
> >  drivers/gpio/gpiolib-swnode.c | 123 +++++++++++++++++++++++++
> >  drivers/gpio/gpiolib-swnode.h |  14 +++
> >  drivers/gpio/gpiolib.c        | 209 ++++++++++++++++--------------------------
> >  include/linux/gpio/property.h |  11 +++
> >  9 files changed, 315 insertions(+), 240 deletions(-)
> > ---
> > base-commit: f8f60f322f0640c8edda2942ca5f84b7a27c417a
> > change-id: 20221031-gpiolib-swnode-948203f49b23
> >
> > --
> > Dmitry
> >
> 
> I still had some fuzz when applying, can you for the future rebase on
> top of the GPIO for-next branch?

OK, I will, but I thought it is feeding into the next tree?

> 
> Anyway: series applied.

Thanks!

-- 
Dmitry
