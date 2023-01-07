Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0F660FAA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjAGO4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:56:53 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2D3AB36;
        Sat,  7 Jan 2023 06:56:51 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a64so4343994vsc.2;
        Sat, 07 Jan 2023 06:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3swf10ZLFW6qNCeoSiTN3mu6SiPLmmuQ4t5ZCg5wVZA=;
        b=QBFARmrXyHI5HZM3Q0ihwFQxWbcR6kBOXFFassyzG9LexAUhsmCax3azLn0lf3vdDw
         XMyngcRVcPPsTTtN2l8PbXRbZMiiWyn2geSUPcHzqkninsdMSMJwFRLhE1Pq7apbKSYW
         QOxzVWD58or5FB+ZiUHzxpDVWRR0psjq/ayYoJComGPHdiadelsckVVbigwc904xbluM
         RHpbG30eOb4PMBTrcVENkWjhtYHJw0XQ0JqHyMnxn1tPNNL8biRQ9piErW0g0MDnz3r9
         pc5RJfgMQ5UvUTAHEsiYoN/ARrYg5oXlmHv5lJODgtkTIHQuBgMotF8W3nL/bZL3TEpn
         FlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3swf10ZLFW6qNCeoSiTN3mu6SiPLmmuQ4t5ZCg5wVZA=;
        b=MAJmNH2OHaBvjgqTrN8Q5L5fHBQG8aRtD4k8xt2CI8p2eZMrkXQEsyP+O204nL3ieP
         9tEifXS6gccIYwPxkaftxqeb1bYzCWmDneP+e8HuYCodtKbztgjUb+pn4CBj8oM8UfVp
         gnat9bMbDCgEz+cYPmM8mZjqRly4d4f9TnNivU6L7CpLASueQvkq1VDC/RfiEYozwPnB
         bsFO5II8QjdsEybA0sBVHceWrwTM4L6LCa0bVqkKxzkocd9kXm+4xeciS3+V/d54cDgy
         /SP7QS/iDLPs4crifbwGJlxd63jfJuGYYXyd/ai8hU21e8sWUsJiyBN/7cT9FO8OOO2X
         PVzQ==
X-Gm-Message-State: AFqh2kr2LU9c7NxxF84tkx7tZphBNDot/leWwZSycoUeEICwJhwi+Ujw
        L0x3UvQ9WgPuhqfWivtbNOTymf/fZxaPjkUqDqE=
X-Google-Smtp-Source: AMrXdXvs9T8wmAXwlDyiXHkA86ONHle7RLbgEv6JwSPgfa031J28MbXvqQlbUJyjGi5C2k0Uc+4Gs3X0//SJWYY0fYE=
X-Received: by 2002:a05:6102:510e:b0:3b1:2b83:1861 with SMTP id
 bm14-20020a056102510e00b003b12b831861mr7199612vsb.10.1673103410149; Sat, 07
 Jan 2023 06:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-6-linux.amoon@gmail.com>
 <Y7XhYm0nvBsSS8MN@google.com> <Y7XnLYbHxfADz7gk@google.com>
In-Reply-To: <Y7XnLYbHxfADz7gk@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:26:34 +0530
Message-ID: <CANAwSgQbABi9QxO7eEZ5rKQY-2d5QZ+bUTOyv9sBWV8+4LGU8Q@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] usb: misc: onboard_usb_hub: add Genesys Logic
 GL852G-OHG hub support
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias

On Thu, 5 Jan 2023 at 02:23, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Jan 04, 2023 at 08:28:18PM +0000, Matthias Kaehlcke wrote:
> > On Wed, Dec 28, 2022 at 10:03:14AM +0000, Anand Moon wrote:
> > > Genesys Logic GL852G-OHG is a 4-port USB 2.0 STT hub that has a reset pin to
> > > toggle and a 5.0V core supply exported through an integrated LDO is
> > > available for powering it.
> > >
> > > Add the support for this hub, for controlling the reset pin and the core
> > > power supply.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >  drivers/usb/misc/onboard_usb_hub.c | 1 +
> > >  drivers/usb/misc/onboard_usb_hub.h | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > > index 94e7966e199d..c0e8e6f4ec0a 100644
> > > --- a/drivers/usb/misc/onboard_usb_hub.c
> > > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > > @@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> > >
> > >  static const struct usb_device_id onboard_hub_id_table[] = {
> > >     { USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
> > > +   { USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G-OHG USB 2.0 */
>
> Do you happen to know what '-OHG' stands for? The Genesys website only
> mentions a GL852G with different package types (none of them 'OHG').
> Unless there is an 'OHG' variant with a different product id I'd say
> let's drop the suffix.

Ok, done.


>
> > >     { USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
> > >     { USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
> > >     { USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> > > diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> > > index 62129a6a1ba5..2ee1b0032d23 100644
> > > --- a/drivers/usb/misc/onboard_usb_hub.h
> > > +++ b/drivers/usb/misc/onboard_usb_hub.h
> > > @@ -31,6 +31,7 @@ static const struct of_device_id onboard_hub_match[] = {
> > >     { .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
> > >     { .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
> > >     { .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
> > > +   { .compatible = "genesys,usb5e3,610", .data = &genesys_gl850g_data, },
> >
> > s/genesys,//
> >
> > >     { .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
> > >     { .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
> > >     { .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
> > > --
> > > 2.38.1
> > >
