Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AFD6D6E13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjDDUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDDUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:31:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CB4496
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:31:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z83so40269766ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680640271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdTsXK258IzXLXAvc6XiWI2mr2HmNvT/kYOEMCnlRUo=;
        b=nlYpHgIzmOXyMkBiUcEYWqFtVt4Zne0J5jKrBvGogT+bBiyiaLin/caXkB9yr92tM3
         2ZS+9a4KD8mt/5k4DU22GSU0mXS+jh6kX3/kl7rcnGeJslXp7+y/20wv7o5psjWRQBM4
         XqzGixTDBMnr6txgGi4lsol69DZQFYWjvjLWHv9fUFEgrii+L/YGaneGdmTa3CHOCnju
         cd46eTAqrD8yUSxTBIMhqc7cgw+uNCsdrM3mZ8DLvNma8aRUAkViYFXkyVJO/ZNcTYrJ
         qp64WDTHxFmUv8YT4QO7G9uJ7dX+prSWjVexeiHRXsNGxpmAIIEZZelU+yfpvXCl8Lly
         IBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdTsXK258IzXLXAvc6XiWI2mr2HmNvT/kYOEMCnlRUo=;
        b=z3R6mMR12YxA7pkqbuh/2b7Qe6fJjZ8jFyXkWABw9lWVEYlbUkNN47kMZAiz6kX5or
         O4mm3gC/d1cwBksH03nkXqK8JNG0Uu257hc/LkwIvU7waWdcD3beInLYcmBd9Y0B9rls
         3Cd3ONKyi9214F5r/yrJ3O8tu8CheYnCPHFWlEvkOh2+KTdoG4oV+Svd8LpYjnniSNDb
         8DOBSYs7ZufzkJJ6vb8KZ8o+RA2eCt+dB8dz1KUHvxUIk0pYdJ98wM1OcuLeJKTWODjZ
         +dcGDiMsgAK7+FQXkMbkYvFDRGDHKqjZfdgtNrzFM20xaT3lQR1HgQb4+yIr9wYST00k
         LOkA==
X-Gm-Message-State: AAQBX9cevmYkxqNz7gK1a14S7D1Iywd4+oyGGzLZ+dThRtvkxQ+SrK0j
        X+Jblnb/HzFz80m+qCdtOCaygUYZAuLGrpkiczVqyA==
X-Google-Smtp-Source: AKy350ZR4rq6mOtDfI46MVLmJmXiK+zn7TbwS88R47X330p26M7ez1pEy0wOOkmjRPNo3gQd948iyxlJSMMtNRqksYU=
X-Received: by 2002:a25:3083:0:b0:b23:4649:7ef3 with SMTP id
 w125-20020a253083000000b00b2346497ef3mr2716867ybw.4.1680640271402; Tue, 04
 Apr 2023 13:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230301142835.19614-1-m.zatovic1@gmail.com> <20230301142835.19614-3-m.zatovic1@gmail.com>
 <Y/98GqIPgMyPLRi3@smile.fi.intel.com> <ZCwifu6yxUikt42i@fedora>
In-Reply-To: <ZCwifu6yxUikt42i@fedora>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 22:30:59 +0200
Message-ID: <CACRpkdYyGjTMCJvAHWa=GE7i1qb98+7zDeK-28-Ko+1B2U8-mw@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
To:     =?UTF-8?B?TWFydGluIFphxaVvdmnEjQ==?= <m.zatovic1@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 3:13=E2=80=AFPM Martin Za=C5=A5ovi=C4=8D <m.zatovic1=
@gmail.com> wrote:
> On Wed, Mar 01, 2023 at 06:23:54PM +0200, Andy Shevchenko wrote:

> > > +/**
> > > + * of_register_wiegand_device - allocates and registers a new Wiegan=
d device based on devicetree
> >
> > NAK for OF only code. New, esp. bus, code must be agnostic. We have all=
 means
> > for that.
>
> In one of the previous versions of this patch series, there was also the =
possibility to instantiate
> the device from another driver. I have been told, that this is not the wa=
y to go anymore, unless
> there is a very specific reason for that. I did not find such reason, so =
I have removed this suport.

I don't know for sure but I think Andy simply means that you should take a =
look
in include/linux/property.h and replace every function named of_* with
the corresponding fwnode_* or device_* function from that file, and it
should all just magically work the same, but abstracted away from device
tree. It's not much more than a search/replace and rename operation
(unless there is a "hole" in the fwnode implementations... I hope not.)

In the end you can keep just <linux/property.h> and drop <linux/of.h>
and <linux/of_device.h> if this works.

Yours,
Linus Walleij
