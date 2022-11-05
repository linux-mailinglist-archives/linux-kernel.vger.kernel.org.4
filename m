Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3561DC59
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKERVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 13:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKERVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:21:24 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F91004E;
        Sat,  5 Nov 2022 10:21:23 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso10966427pjc.0;
        Sat, 05 Nov 2022 10:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD8FilkUBj9ngEYDZ1KCGWjlrUlUwcbQQEe0iyoadYo=;
        b=dDH/kf4Q5iI6ywTjdUFf2qv8iyrdHF97K5VOA3k+jiY4X9KAR3gDzIAQxNfOx/e/Oi
         3mExDEmpxPvS60ji4aP0es42Wt6nf16qDWio582WD5YaYx80Q+/U3lYwNhMcx+CmADx1
         IIvRJOuWb1At3y7Nz19Rnil8pRO2d14LTXlyjQGVOAij1kv/NncCJgZn0Mytfx+T+CBF
         4XHTpNF+bL5Kl4VHZH9ZctlyxqJkTZ3tZaBia+VDtwzozg1cqKLL0B1DUPC0jbnWAjPQ
         BEYK8qRX/adhY2vXDDXQdB1d5C6TzTSIZvzLeN5spMeN0gp49OwNv2grtDOQnDQaqc0r
         qXLg==
X-Gm-Message-State: ACrzQf1heVfOzh4sIVugL6e9TcK15JnkKtsgkh2PuNpe470SYS80jrz7
        cNVQiaW3Hbqh1AaG5D+sWcmRlFPA+6m07sWpb5dm5D6r4mSdaA==
X-Google-Smtp-Source: AMsMyM4LNeQqsBaWEqblbhExjVCprmk08vhjyAe5UUhyfmbAmaaOponjVbuyeA8/NVTW9skelDPEFSrIP0cj9rGzt4o=
X-Received: by 2002:a17:90b:4ac3:b0:213:3918:f276 with SMTP id
 mh3-20020a17090b4ac300b002133918f276mr57992592pjb.19.1667668882537; Sat, 05
 Nov 2022 10:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr> <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com> <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
In-Reply-To: <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 6 Nov 2022 02:21:11 +0900
Message-ID: <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Nov 05, 2022 at 02:16:04AM +0900, Vincent Mailhol wrote:
> > > ES58x devices report below information in their usb product info
> > > string:
> > >
> > >   * the firmware version
> > >   * the bootloader version
> > >   * the hardware revision
> > >
> > > Report the firmware version through ethtool_drvinfo::fw_version.
> > > Because struct ethtool_drvinfo has no fields to report the boatloader
> > > version nor the hardware revision, continue to print these in the
> > > kernel log (c.f. es58x_get_product_info()).
> > >
> > > While doing so, bump up copyright year of each modified files.
> >
> > Why not just stick to the normal USB interface here and not try to tie
> > it into ethtool?  These values are all availble today in sysfs or in
> > libusb, right?
>
> The simple answer is ignorance. I am more familiar with ethtool than
> libusb and I just did not think to explore that second option.
> Thanks for the review, comments taken. I will study sysfs and libusb
> and will rework that.

I double checked following options:
  * CONFIG_USB_ANNOUNCE_NEW_DEVICES
  * lsusb -v from usbutils
  * sysfs

None of those will return the firmware version. The only strings I am
getting are: the Product name, the Manufacturer and the SerialNumber.

I guess you were expecting some default behavior from the device, but
unfortunately, this is not the case.
On this device, the firmware version is stored at some arbitrary
descriptor index (if you ask me: 6). Unless you query that magic
number, the information will not pot up.

So as far as I can see, this does not duplicate existing mechanisms.
With this patch, the firmware version becomes available using:
  $ ethtool -i canX

> > What workflow wants this added to ethtool?
>
> No workflow. My work is not bound to any company and this driver
> maintenance and anything else I am doing on the mailing list at this
> time is pure hobby.
>
> Yours sincerely,
> Vincent Mailhol
