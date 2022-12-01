Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979263FAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLAWxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiLAWw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:52:58 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39BD11A27
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:52:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 62so2892806pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u+GlEJaTRGydAzKEA1KTMHQ/xuICP4OQMpko1BA8XIg=;
        b=XPVXtTyHEysZOnnWvGQAaaVfsqyZR2ETSAYTP61Rdu8YxUZucOqj52A3xq1SGO+u0h
         ELLq+skCWfHle+15JIkPWxJErRpzj9WCSL1S4A6QewOFwiK+eN/WfiZFZ/5CUUHo5VQ4
         XRrFPAeV0J8wk9aCtu+ECfIFe7phYNlBFQz/JhuiUv8uRBe56t2AGDShjACnuDLqDxqy
         theaR0MNEA9WHGOVFbRmpRvrx0Hef33eevnPp4+LQCoMk1o653IQ37eIx1Q4mN/+lBuc
         r6jKawOWfgaQvW65kCH667JQ/pARSgdAg1c7lU9dGcxhGb5cs86w3X9p7vBJk8/+KsYi
         6Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+GlEJaTRGydAzKEA1KTMHQ/xuICP4OQMpko1BA8XIg=;
        b=2csG/egZIRLObc8DlYKkGdkYjdkof5Q5LG7iyJqIO5nhtUN1QWRNg+1UZ9HzLzaBs7
         NlheQyi92EmeWXar6RcPdSKvbCH/OkzvYU0i2/LYt4x3hQN86egKTcMJh++n6+k9Fk8E
         et1vs7HGLO2qCJd5BZOOzXmH0KJ1DM8qxV0rVmnMqKf5TqjzxmKYvTB/BO9q+tIIkbvT
         2qd9EycFWzUt9ocSUyy9dilnSnRuFJ7x5RgDup6SLuxn+n5amfXt9zYXxC7zXCBzt2Hk
         4yJ+I9U0upiEVDvP+7nefsT8fU2CevzxotdoRfHZBaK6kXisieswtq8Li7uXVUYrNvEa
         GkRQ==
X-Gm-Message-State: ANoB5plrTPKZRTWjbgU7QwNM4sIQZT3w36rxzlr9ggwcMr0lb03n0oX7
        EYxmFcunXxR91Ra/uQUlLk1SXeybI2TFERI0qTwz4Q==
X-Google-Smtp-Source: AA0mqf4/Rdlo9twsxywVaqCZLl1ql+AO14cGIHtfU9aOaBMox3gTH/JTcrnCLroC46cSvuayrVe2q2uGMrykuuA0Rh4=
X-Received: by 2002:a63:4087:0:b0:477:15c8:ff67 with SMTP id
 n129-20020a634087000000b0047715c8ff67mr46291956pga.275.1669935168163; Thu, 01
 Dec 2022 14:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20221130231936.1666390-1-wonchung@google.com> <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
 <CANLzEksD=dKgPuCUD74b3YQKCApbZKO_t7Q=tyNKONvAOQ89hw@mail.gmail.com> <CACeCKad7RGVPGdrd9WNpRhn3n99R5TG9zFJpCrMj7CDLK18rMA@mail.gmail.com>
In-Reply-To: <CACeCKad7RGVPGdrd9WNpRhn3n99R5TG9zFJpCrMj7CDLK18rMA@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Thu, 1 Dec 2022 14:52:36 -0800
Message-ID: <CAOvb9ygJ9afqLaeJRuCK+zFMH2vxjA4JGXAu2qZUvqqyUzhnmQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Create new USB driver for RGB keyboard
 in ChromeOS devices
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:36 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hey Benson,
>
> On Thu, Dec 1, 2022 at 1:00 PM Benson Leung <bleung@chromium.org> wrote:
> >
> > Hi Prashant,
> >
> >
> > On Thu, Dec 1, 2022 at 12:10 PM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > Hi Won,
> > >
> > > On Wed, Nov 30, 2022 at 3:19 PM Won Chung <wonchung@google.com> wrote:
> > > >
> > > > Without any driver bound to RGB keyboard, it may not be suspended
> > > > properly, preventing USB xHCI to be suspended and causing power drain.
> > > > Create new USB driver for RGB keyboard so that it can be suspended
> > > > properly.
> > >
> > > This seems like overkill. Can't you set this from USB's sysfs nodes
> > > like power/control [1] ?
> > >
> > > [1] https://www.kernel.org/doc/html/latest/driver-api/usb/power-management.html#the-user-interface-for-dynamic-pm
> > >
> > >
> > > Best regards,
> > >
> > > -Prashant
> >
> > We're seeing some behavior where a bound driver is needed in order for
> > this USB device to properly enter suspend state. Just manipulating the
> > power/control and other sysfs nodes for this usb device when there's
> > no driver in the kernel doesn't seem to affect the device's ability to
> > drop into a usb low power state.
>
> That seems like an issue with the device then, which should be debugged
> from the device side and/or its interaction with the USB subsystem.
>

Hi Prashant,

As Benson mentioned, I can check on my test Vell device that changing
power/control does not suspend the device.
Should it be controllable even without a driver bound?

The RGB keyboard seems to be able to enter sleep with a suspend signal.
Fyi, here are the related bugs for more context: b/242087721 and b/249173368

Thank you,
Won

> >
> > Also, I synced with Won about this offline, but the primary concern is
> > not this prism usb device runtime suspending, it's actually it's
> > ability to enter suspend state during system suspend. Right now, this
> > internal usb device is keeping the whole system from entering lower
> > S0iX states because it's not sleeping. This driver patch doesn't
> > address that yet, but I'd like Won to dig down and see if he can get
> > it suspending at suspend time too.
>
> Auto-suspend / dynamic PM should take care of that FWIU (but I may be mistaken).
