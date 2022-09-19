Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D55BD127
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiISPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiISPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:36:52 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFB25C56
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:36:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id m16so1643882iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TJtbFKRoGiqIeIUx0M4B9tZ4pfPeod5mEoLdwUysHys=;
        b=BiwYyDqhE0F49clj/AW/ikyBuNMX6gxBY/CFZUt//iTCGt3exdRQT1Ti9iiBoR6F5j
         Jc4qylZx+Rd7Dpdy0TTaQ3n5h9JmOwwQ+svZmMhhg5mePMSv3fc8+mKFTe6kpZJ4o/eg
         /por1H5C9hfLDxwNQkX6Xc1/KEzOprlv4yV1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TJtbFKRoGiqIeIUx0M4B9tZ4pfPeod5mEoLdwUysHys=;
        b=NJoHWpLJvY8+K7YLZh/hciCdCd6+LvwfCWjNQQKNzOLcF5pZ+/pGTkK4zWOWYjYie1
         A5SifN3xYYXsymbzzc1IRdifhTad5y7ieUMa8RyDfkpOGo/0cVXEEKGuRc4t4vz7usLX
         XUK8YNXwjykiSgpEDps6RCRYSdezhTI3Mb6xB6RoG9C1PK7hzCF91P4KUzuzBVh8UvcM
         z1ITBugD42BrsXJvPlLcn/HwbGFz3HVRCw1YgOcDhE17/5bd/i+ezfJgW/FND23vTbr2
         BgX2HInL/GA0WSulOYgkN42r0CtsvBbBSPucoZixzRwdrmh2PQ9wq8255NoF8/uqB/m1
         o5Cw==
X-Gm-Message-State: ACrzQf0g7TNn8664WHu3oYG437aDqrAzu/ZIapHDIsjSwy5Bbp1aC5B3
        OJRVTIc/y14E4y/EUoR9YVmQ4aPNDl7vdw==
X-Google-Smtp-Source: AMsMyM5wj6itY6xEiM9M0qhg0Y3+wLKaYWz7xrXZVr1+tbBzQSuxqw2Zj41K81sWuLHW8JQEWwGZVQ==
X-Received: by 2002:a05:6e02:1489:b0:2f1:a985:853 with SMTP id n9-20020a056e02148900b002f1a9850853mr7602614ilk.68.1663601810149;
        Mon, 19 Sep 2022 08:36:50 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id e8-20020a056602044800b006849ee78e1bsm14950412iov.34.2022.09.19.08.36.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:36:49 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id m16so1643859iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:36:49 -0700 (PDT)
X-Received: by 2002:a05:6e02:2189:b0:2f1:92d4:6b22 with SMTP id
 j9-20020a056e02218900b002f192d46b22mr6968781ila.210.1663601464513; Mon, 19
 Sep 2022 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220914235801.1731478-1-rrangel@chromium.org>
 <20220914155914.v3.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid> <Yyg8UGRItbO4Abvb@smile.fi.intel.com>
In-Reply-To: <Yyg8UGRItbO4Abvb@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 19 Sep 2022 09:30:53 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Axy2epgvB4oHAEmEiU14mQn5Q9FUa1NBiEVvMe4ZSwMw@mail.gmail.com>
Message-ID: <CAHQZ30Axy2epgvB4oHAEmEiU14mQn5Q9FUa1NBiEVvMe4ZSwMw@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tim Van Patten <timvp@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 3:54 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 14, 2022 at 05:57:54PM -0600, Raul E Rangel wrote:
> > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > interrupt should wake the system. This change exposes that bit via
> > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> > before arming an IRQ to wake the system.
>

> From code perspective it's straightforward, so
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> (take a look into nit-picks, though)

I went ahead and re-ran clang-format with a 96 char limit, then I
manually applied the rest of the nits.
Thanks!

>
> From the functional perspective AFAIU it's appreciated, but I'm not
> a guru in this domain to tell.
>
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Fixed bad indent
> >
> > Changes in v2:
> > - Added ability to extract wake bit from Interrupt/IRQ resources
> >
> >  drivers/acpi/irq.c             | 11 ++++++++---
> >  drivers/acpi/resource.c        | 24 +++++++++++++++++-------
> >  drivers/pnp/pnpacpi/rsparser.c |  9 ++++++---
> >  include/linux/acpi.h           |  3 ++-
> >  include/linux/ioport.h         |  3 ++-
> >  5 files changed, 35 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > index dabe45eba055d1..5483cf9a28e3a0 100644
> > --- a/drivers/acpi/irq.c
> > +++ b/drivers/acpi/irq.c
> > @@ -147,6 +147,7 @@ struct acpi_irq_parse_one_ctx {
> >   * @polarity: polarity attributes of hwirq
> >   * @polarity: polarity attributes of hwirq
> >   * @shareable: shareable attributes of hwirq
> > + * @wake_capable: wake capable attribute of hwirq
> >   * @ctx: acpi_irq_parse_one_ctx updated by this function
> >   *
> >   * Description:
> > @@ -156,12 +157,14 @@ struct acpi_irq_parse_one_ctx {
> >  static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
> >                                           u32 hwirq, u8 triggering,
> >                                           u8 polarity, u8 shareable,
> > +                                         u8 wake_capable,
> >                                           struct acpi_irq_parse_one_ctx *ctx)
> >  {
> >       if (!fwnode)
> >               return;
> >       ctx->rc = 0;
> > -     *ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> > +     *ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable,
> > +                                          wake_capable);
>
> Can be on one line.
>
> >       ctx->fwspec->fwnode = fwnode;
> >       ctx->fwspec->param[0] = hwirq;
> >       ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
> > @@ -204,7 +207,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
> >               fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
> >               acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
> >                                        irq->triggering, irq->polarity,
> > -                                      irq->shareable, ctx);
> > +                                      irq->shareable, irq->wake_capable,
> > +                                      ctx);
>
> Ditto.
>
> >               return AE_CTRL_TERMINATE;
> >       case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> >               eirq = &ares->data.extended_irq;
> > @@ -218,7 +222,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
> >                                                     eirq->interrupts[ctx->index]);
> >               acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
> >                                        eirq->triggering, eirq->polarity,
> > -                                      eirq->shareable, ctx);
> > +                                      eirq->shareable, eirq->wake_capable,
> > +                                      ctx);
>
> Ditto.
>
> >               return AE_CTRL_TERMINATE;
> >       }
> >
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index 510cdec375c4d8..6a1c008a348902 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -336,8 +336,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
> >   * @triggering: Triggering type as provided by ACPI.
> >   * @polarity: Interrupt polarity as provided by ACPI.
> >   * @shareable: Whether or not the interrupt is shareable.
> > + * @wake_capable: Wake capability as provided by ACPI.
> >   */
> > -unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
> > +unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
> > +                              u8 wake_capable)
>
> Ditto.
>
> >  {
> >       unsigned long flags;
> >
> > @@ -351,6 +353,9 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
> >       if (shareable == ACPI_SHARED)
> >               flags |= IORESOURCE_IRQ_SHAREABLE;
> >
> > +     if (wake_capable == ACPI_WAKE_CAPABLE)
> > +             flags |= IORESOURCE_IRQ_WAKECAPABLE;
> > +
> >       return flags | IORESOURCE_IRQ;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
> > @@ -442,7 +447,7 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> >
> >  static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> >                                    u8 triggering, u8 polarity, u8 shareable,
> > -                                  bool check_override)
> > +                                  u8 wake_capable, bool check_override)
> >  {
> >       int irq, p, t;
> >
> > @@ -475,7 +480,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> >               }
> >       }
> >
> > -     res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> > +     res->flags = acpi_dev_irq_flags(triggering, polarity, shareable,
> > +                                     wake_capable);
>
> Ditto.
>
> >       irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
> >       if (irq >= 0) {
> >               res->start = irq;
> > @@ -523,7 +529,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >               }
> >               acpi_dev_get_irqresource(res, irq->interrupts[index],
> >                                        irq->triggering, irq->polarity,
> > -                                      irq->shareable, true);
> > +                                      irq->shareable, irq->wake_capable,
> > +                                      true);
> >               break;
> >       case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> >               ext_irq = &ares->data.extended_irq;
> > @@ -532,9 +539,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >                       return false;
> >               }
> >               if (is_gsi(ext_irq))
> > -                     acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> > -                                      ext_irq->triggering, ext_irq->polarity,
> > -                                      ext_irq->shareable, false);
> > +                     acpi_dev_get_irqresource(res,
> > +                                              ext_irq->interrupts[index],
> > +                                              ext_irq->triggering,
> > +                                              ext_irq->polarity,
> > +                                              ext_irq->shareable,
> > +                                              ext_irq->wake_capable, false);
>
> Maybe false on the next line to split FW parameters from pure software ones?
>
> >               else
> >                       irqresource_disabled(res, 0);
> >               break;
> > diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
> > index da78dc77aed32e..55b28fc0a94042 100644
> > --- a/drivers/pnp/pnpacpi/rsparser.c
> > +++ b/drivers/pnp/pnpacpi/rsparser.c
> > @@ -206,7 +206,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
> >               if (i >= 0) {
> >                       flags = acpi_dev_irq_flags(gpio->triggering,
> >                                                  gpio->polarity,
> > -                                                gpio->shareable);
> > +                                                gpio->shareable,
> > +                                                gpio->wake_capable);
> >               } else {
> >                       flags = IORESOURCE_DISABLED;
> >               }
> > @@ -315,7 +316,8 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
> >               if (p->interrupts[i])
> >                       __set_bit(p->interrupts[i], map.bits);
> >
> > -     flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
> > +     flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
> > +                                p->wake_capable);
> >       pnp_register_irq_resource(dev, option_flags, &map, flags);
> >  }
> >
> > @@ -339,7 +341,8 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
> >               }
> >       }
> >
> > -     flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
> > +     flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
> > +                                p->wake_capable);
>
> One line?
>
> >       pnp_register_irq_resource(dev, option_flags, &map, flags);
> >  }
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index d3121cef6cc3bc..9f7947ee1b006f 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -495,7 +495,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
> >                                    struct resource_win *win);
> >  bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
> >                                        struct resource_win *win);
> > -unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
> > +unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
> > +                              u8 wake_capable);
>
> One line?
>
> >  unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
> >  bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >                                struct resource *res);
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 616b683563a970..3baeea4d903bfd 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -79,7 +79,8 @@ struct resource {
> >  #define IORESOURCE_IRQ_HIGHLEVEL     (1<<2)
> >  #define IORESOURCE_IRQ_LOWLEVEL              (1<<3)
> >  #define IORESOURCE_IRQ_SHAREABLE     (1<<4)
> > -#define IORESOURCE_IRQ_OPTIONAL      (1<<5)
> > +#define IORESOURCE_IRQ_OPTIONAL              (1<<5)
> > +#define IORESOURCE_IRQ_WAKECAPABLE   (1<<6)
> >
> >  /* PnP DMA specific bits (IORESOURCE_BITS) */
> >  #define IORESOURCE_DMA_TYPE_MASK     (3<<0)
> > --
> > 2.37.3.968.ga6b4b080e4-goog
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
