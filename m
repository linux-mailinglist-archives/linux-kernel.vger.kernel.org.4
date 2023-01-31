Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EA682633
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjAaIOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:14:29 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4A2F7B8;
        Tue, 31 Jan 2023 00:14:27 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id cr22so454087qtb.10;
        Tue, 31 Jan 2023 00:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0ccHC8reNWYQgpAYbVr9s42CKygVFy7/fkfStrl4kw=;
        b=xVL0rmSqmFG8Fy/wiT3oZvwoIe1JjlG5hQIkwCmocnAhSNXKWtHa3N2wtLDwc/qMRR
         JpEOl5nzatGLY5cAnJs7NzmFXgNbvn/ZH7/TNg2nYZq98JiFZF9yqc5VfBEFzyQfKc1Z
         NUL/3j/Jgem7tIbgLm+35L2tLbb6tWFZfQEsZAmH7K1vUurfSk79rY8OaoJUtjSk6TLC
         FOlDkGZDTm4W2yIHy5/BxPny8vNkrYyaS0eqwWB+5rXYFtwPBFT6yCdrLVnf7uXPQv8R
         8nwevTn/qW1IZH1Wkitv8haab7IQ2G+3r10Q855z9pYiN8xqnFb4ofrhbdBfKK+dAP7G
         hGOA==
X-Gm-Message-State: AO0yUKX6VwooeJCof0ImhvQRmE5KWjXm7kNo4Zz39j0TighdQb8hn8N/
        qpZUD1FAaAqR0n1KMhlJs3rnnSw3qUgCQA==
X-Google-Smtp-Source: AK7set8cehzt6XtCtfsggb0kK7lrgGwoHmuqS4400CGzLNf17X1rKn1ag4jN14d+y444+9cn1Jtosw==
X-Received: by 2002:ac8:5956:0:b0:3b8:4144:fe72 with SMTP id 22-20020ac85956000000b003b84144fe72mr18462380qtz.9.1675152866404;
        Tue, 31 Jan 2023 00:14:26 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id f8-20020ac840c8000000b003b84b92052asm5396355qtm.57.2023.01.31.00.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:14:26 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id b1so17081658ybn.11;
        Tue, 31 Jan 2023 00:14:26 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr4679605ybo.380.1675152855693; Tue, 31
 Jan 2023 00:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
 <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
 <CAGETcx9EXkbAfEX6pBL84DBr3SEwiJe7N4xh91TspLn8CwZ+LQ@mail.gmail.com>
 <CAMuHMdUFeSim2gvmiBuPbAajbK6ybh67gBmbLLqRhG1T5+v0JA@mail.gmail.com> <CAGETcx-TSrjFnmxV02TMaGN6Au4f9SuLgzjMPOqAOTqx_bqLhA@mail.gmail.com>
In-Reply-To: <CAGETcx-TSrjFnmxV02TMaGN6Au4f9SuLgzjMPOqAOTqx_bqLhA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Jan 2023 09:14:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=F5zPfVQLihWRBt0EN-nNW=x4v_XFpp4aY9WrhkwmJw@mail.gmail.com>
Message-ID: <CAMuHMdX=F5zPfVQLihWRBt0EN-nNW=x4v_XFpp4aY9WrhkwmJw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
 for fw_devlink
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

Hi Saravana,

On Mon, Jan 30, 2023 at 9:00 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Jan 30, 2023 at 12:43 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Sat, Jan 28, 2023 at 8:19 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Fri, Jan 27, 2023 at 12:11 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Fri, Jan 27, 2023 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > The OF_POPULATED flag was set to let fw_devlink know that the device
> > > > > tree node will not have a struct device created for it. This information
> > > > > is used by fw_devlink to avoid deferring the probe of consumers of this
> > > > > device tree node.
> > > > >
> > > > > Let's use fwnode_dev_initialized() instead because it achieves the same
> > > > > effect without using OF specific flags. This allows more generic code to
> > > > > be written in driver core.
> > > > >
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/drivers/soc/renesas/rcar-sysc.c
> > > > > +++ b/drivers/soc/renesas/rcar-sysc.c
> > > > > @@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
> > > > >
> > > > >         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> > > > >         if (!error)
> > > > > -               of_node_set_flag(np, OF_POPULATED);
> > > > > +               fwnode_dev_initialized(&np->fwnode, true);
> > > >
> > > > As drivers/soc/renesas/rmobile-sysc.c is already using this method,
> > > > it should work fine.
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > i.e. will queue in renesas-devel for v6.4.
>
> I hope you meant queue it up for 6.3 and not 6.4?

V6.4.
The deadline for submitting pull requests for the soc tree is rc6.
Sorry, your series was posted too late to make that.

> > > Thanks! Does that mean I should drop this from this series? If two
> > > maintainers pick the same patch up, will it cause problems? I'm
> > > eventually expecting this series to be picked up by Greg into
> > > driver-core-next.
> >
> > Indeed. Patches for drivers/soc/renesas/ are supposed to go upstream
> > through the renesas-devel and soc trees. This patch has no dependencies
> > on anything else in the series (or vice versa), so there is no reason
> > to deviate from that, and possibly cause conflicts later.
>
> This series is supposed to fix a bunch of issues and I vaguely think
> the series depends on this patch to work correctly on some Renesas
> systems. You are my main renesas person, so it's probably some issue
> you hit. Is you pick it up outside of this series I need to keep
> asking folks to pick up two different patch threads. I don't have a
> strong opinion, just a FYI. If you can take this patch soon, I don't
> have any concerns.

Oh right, you do remove OF_POPULATED handling in
"[PATCH v2 09/11] of: property: Simplify of_link_to_phandle()".
It might be wise to postpone that removal, as after your series,
there are stillseveral users left, some of them might be impacted.

I do plan to test your full series on all my boards, but probably that
won't happen this week.

> > BTW, I will convert to of_node_to_fwnode() while applying.
>
> Sounds good.

If you still want this to land in v6,3 (with the of_node_to_fwnode()
conversion):
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
