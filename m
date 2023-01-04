Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4E165DC38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjADSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbjADSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:34:30 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB81C437
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:34:09 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p66so18472128iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=og5W/pf+GC35o306sZo7M+U9bRheLryDvrZbfbaDyxs=;
        b=O7auC2m9bx6mUqQqnZN9CUlfJT6TP4fWluRnhPbjmVgetTy7ua6wNbYEv2jxIHZS8X
         vbuWRV96tsVSNPAWDrOwL1ngFzWeHYpkwnspdSJxHEgcxBJoAx3m06b5T1Dkp0/X0sNh
         DBVjEWBJYOLF+63tkogSgZuHnoW378XoyyxPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=og5W/pf+GC35o306sZo7M+U9bRheLryDvrZbfbaDyxs=;
        b=G1ngAElCK3SW8KQ5KDvlCOA99svtMG55h5FOqlfqq2LTED3F79qzKW9zba83ELVu55
         iX+KLJ7xgkBpfwlWzy32NfD7tPK93Rp933jwjCI7/UUBHPZMLxUnb8vaLMQ5mH5i/WnI
         wgW/hGGNk7CeDWtEAdJMyWZ1lDKHWf/vG41i4zRQH8uUo8xbf4PwC/V3LJsMDouPsFww
         PZxh1jPiL2pB+PuD0NLDG4twc8ymvHbePdHXgPOm4Se3dGjPFjmgmBxrCsKtcHyDOqDb
         L8u7pVQwdTlGAXCpiDUK4uqCZh+rk3IzDFxSF8eK5KeAqJyj3MDZIHcRIpYmRnstU7Ft
         MNzg==
X-Gm-Message-State: AFqh2krP1jzWxaGXfOzLOhQCKUcTAM0ozlL49o0qkw0VygPQfjRuKlUq
        tVDxpnBsdra9l8yMfSlBIx9elgWrm42nT6Z+TqTlkA==
X-Google-Smtp-Source: AMrXdXv7d2HqnjPOksgFTlUuTo3bNaY6y2c16rjCrih6M9+5a1aCxEFZtLPXVz2wEdreVgMmwVc19HaSqSkP3yNnFBk=
X-Received: by 2002:a6b:b2c5:0:b0:6e0:34aa:4548 with SMTP id
 b188-20020a6bb2c5000000b006e034aa4548mr2844680iof.72.1672857248764; Wed, 04
 Jan 2023 10:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20221212213857.3636830-1-grundler@chromium.org>
 <CABXOdTd34M1fCEdYfT7F7RAMDmvEj=Ak_Wcg+HgcU83nOFor8w@mail.gmail.com>
 <CANEJEGtOE8HYDPJi80=TQ==4bwLh2=c7Dn3450Girxm5Uhgz9A@mail.gmail.com> <20230102221907.i474olwdaxjfbyns@mercury.elektranox.org>
In-Reply-To: <20230102221907.i474olwdaxjfbyns@mercury.elektranox.org>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 4 Jan 2023 10:33:57 -0800
Message-ID: <CANEJEGvY01tSVB=LyEcrWk+s07cS7Upk+LOa9T0nLHy1adZ5Vg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: cros_usbpd: reclassify "default case!" as debug
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[plain text this time]

On Mon, Jan 2, 2023 at 2:19 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> Thanks, queued to power-supply's fixes branch.

Awesome - thanks Sebastian!

I'll pull from that branch when backporting to  the Chrome OS kernels.
   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=bb6bbf5df16201ece2dacabeb489fc2180c7cfcd

cheers,
grant

>
> -- Sebastian
>
> On Thu, Dec 29, 2022 at 11:53:55PM -0800, Grant Grundler wrote:
> > Hi Sebastian, linux-pm folks, Benson,
> > Can I get feedback on this patch please?
> >
> > I was just told another user feedback report had 70% of the dmesg buffer
> > filled with the cros-usbpd-charger output.
> >
> > cheers,
> > grant
> >
> >
> > On Mon, Dec 12, 2022 at 1:49 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > > On Mon, Dec 12, 2022 at 1:39 PM Grant Grundler <grundler@chromium.org>
> > > wrote:
> > > >
> > > > This doesn't need to be printed every second as an error:
> > > > ...
> > > > <3>[17438.628385] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1:
> > > default case!
> > > > <3>[17439.634176] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1:
> > > default case!
> > > > <3>[17440.640298] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1:
> > > default case!
> > > > ...
> > > >
> > > > Reduce priority from ERROR to DEBUG.
> > > >
> > > > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > >
> > > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > >
> > > >
> > > > ---
> > > >  drivers/power/supply/cros_usbpd-charger.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/power/supply/cros_usbpd-charger.c
> > > b/drivers/power/supply/cros_usbpd-charger.c
> > > > index cadb6a0c2cc7..b6c96376776a 100644
> > > > --- a/drivers/power/supply/cros_usbpd-charger.c
> > > > +++ b/drivers/power/supply/cros_usbpd-charger.c
> > > > @@ -276,7 +276,7 @@ static int cros_usbpd_charger_get_power_info(struct
> > > port_data *port)
> > > >                 port->psy_current_max = 0;
> > > >                 break;
> > > >         default:
> > > > -               dev_err(dev, "Port %d: default case!\n",
> > > port->port_number);
> > > > +               dev_dbg(dev, "Port %d: default case!\n",
> > > port->port_number);
> > > >                 port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
> > > >         }
> > > >
> > > > --
> > > > 2.39.0.rc1.256.g54fd8350bd-goog
> > > >
> > >
