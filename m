Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFD626423
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKWG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiKKWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:06:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2643248E7;
        Fri, 11 Nov 2022 14:06:26 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y203so5986661pfb.4;
        Fri, 11 Nov 2022 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rR11mzRH9PaWWeTd1C49W1RDX3i29Xb0we9+01jaFz0=;
        b=MsWhqYCsmEbWKuZIg5WrpR2JkjHFBm6PEGWpgmvFCRNWsKYvYIm3bXDJHJBaNyL6tN
         7egYC95mB13C7g7c1S+P5hth69P3+2unEWoZ6ISBNZ2wqbTunJfXtWp1ftcJl4ULx6U2
         jOp+ENQgkEHRi4Ss4Dc8A4paKE0YM3Iln+4NFqjSiT8ykztbdiRqJT68yqmYsZYPlL4L
         2H1DuHbj/n4v1J9Dc/Hes08qVe1SLB2NTHIoStRWf247E8xioxTa8Fpc3wbIK4rq0t7W
         Pb6lLRF2+QczY37uwPPYLTvOblfLxWRL0ta+HbB40edvBpAbGS47FeRqH54K33gSvUHr
         cLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR11mzRH9PaWWeTd1C49W1RDX3i29Xb0we9+01jaFz0=;
        b=o5kTpcbeUWBTK5RWUX+J/ilxmgJT6v4dAMPFdlkeNaS4FVLX9W+CuACLGfKVgMfTG3
         0pL1zQU2WSQJKoBccrfPo65wh9tkgeLcI1N0r2MvX0l0WAk6GjQZov6XG5cE810Ckc+d
         nMgm0vK60Uy/M+d2QvNOLuOG4scgdKzm5piKK4NS0U7+6newpRL3u4WdyWgznZvKgHfQ
         2AkL2LWZ4IWWfp3+P4IiRokZT8k1joheP51S3E7nVdT98awCG+Vq5NgppB/7pkaDiY0X
         Pt1wkpfpgyYaP7kgeUG6CPNm/nbK5tlC6SQxcScqfDgkM8knG3rqAUgRuDvn6ltP3qEm
         QtYg==
X-Gm-Message-State: ANoB5pn0Q5S/6/J8EP+dIAz/kQqCSIux81YgeP/3ATj6GfDj7jAjwonW
        lDxsu9S+vTn34uJ4szIsr3Q=
X-Google-Smtp-Source: AA0mqf42DGvwTD/3UdIWQd2VSTGw/aX2JgpqJJcsRb+Sc6XC6UP1KqWpPrvzoDNjxZx+f098TUO8Yw==
X-Received: by 2002:a05:6a00:1c84:b0:569:92fa:cbbc with SMTP id y4-20020a056a001c8400b0056992facbbcmr4575624pfw.77.1668204386104;
        Fri, 11 Nov 2022 14:06:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id d9-20020a62f809000000b0056bfebfa6e4sm2022709pfh.190.2022.11.11.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:06:25 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:06:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add support for software nodes to gpiolib
Message-ID: <Y27HXmqoaWPEiyeQ@google.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
 <CAMRc=Mc-obd_8HiZamirE2YP+VruALFQ5Rp1f4YNVsRqZUC-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc-obd_8HiZamirE2YP+VruALFQ5Rp1f4YNVsRqZUC-tw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:49:32PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 9, 2022 at 8:30 PM Dmitry Torokhov
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
> > base-commit: b6fc3fddade7a194bd141a49f2689e50f796ef46
> > change-id: 20221031-gpiolib-swnode-948203f49b23
> >
> > --
> > Dmitry
> >
> 
> Hi Dmitry,
> 
> What are the prerequisites of this series as it doesn't apply to my
> gpio/for-next branch?

Hi Bart,

No prereqs, must be just a small context changes now that you merged
leds changes and the patch removing devm_fwnode_get_[index_]gpiod_from_child().

Let me rebase it on top of latest next tree and resend.

-- 
Dmitry
