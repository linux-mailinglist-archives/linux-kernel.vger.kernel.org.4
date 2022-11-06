Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5661E2A7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKFOpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Nov 2022 09:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKFOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:45:06 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C97DFCA;
        Sun,  6 Nov 2022 06:45:05 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id b21so8944799plc.9;
        Sun, 06 Nov 2022 06:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icqXyZ4B4azw337unBaACUMXUL9WUhY10PdOPOBKlKU=;
        b=qWlciOLIuSL6CQl49Ct873igziS5rReQMYsobKCfEwkFhpyH6c+hyAihaawzJAfsvJ
         R1pnVOvJzhy1IU926FGgaMGFvrdt2PvUIHO6BoVPCefWdjni1PHEyW04njrdutpyAoa9
         GmzmwKTIM/45Ermq8TD0iEtFqRGAX9UjdenyijTmEa9bes5xw2fBPxW1R/7qMg5IK7c7
         RL36ZfPhJB7OknDik+y0mFKxI/tRX6sYJ/jnSSkl3Coz6wYOeL/fHhaweGPwK2oNa4aL
         y4rMWGkcjSuZZcQgNhMSb4b5xUtcJnROdhYHXmlvcMNFHb7nOPIktSrXCknSCdyfJQl9
         KGWQ==
X-Gm-Message-State: ACrzQf0/8oRO+30+Aevh69XVjgPYfreOV1nXfVZHaxtGDcgNWvQfyvlY
        8HmiPnkjD4P9vNCnxN+2BhYYVRWL8aNYVui1BOU=
X-Google-Smtp-Source: AMsMyM6S/UUx42PiJBcgsKlkQ7VbAuE+AF8HixEy3mvGvjOA27PXUPhxo4mPrfhmqRUhu7NWzmrpp83OXjgOxLonB8w=
X-Received: by 2002:a17:90b:4ac3:b0:213:3918:f276 with SMTP id
 mh3-20020a17090b4ac300b002133918f276mr62009901pjb.19.1667745904778; Sun, 06
 Nov 2022 06:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr> <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com> <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com> <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
 <Y2eYw9Kna712mzR8@kroah.com> <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
 <Y2fDG9AsuFZh0Dkr@kroah.com>
In-Reply-To: <Y2fDG9AsuFZh0Dkr@kroah.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 6 Nov 2022 23:44:52 +0900
Message-ID: <CAMZ6RqLwebh6VuwXdyyxpcdyJjYg3fUt9Opx+dPQRzqZ-2976w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim. 6 nov. 2022 à 23:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> a écrit :
>
> On Sun, Nov 06, 2022 at 09:47:05PM +0900, Vincent MAILHOL wrote:
> > On Sun. 6 Nov. 2022 at 20:25, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sat, Nov 05, 2022 at 08:45:10PM -0400, Alan Stern wrote:
> > > > On Sat, Nov 05, 2022 at 06:38:35PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Sun, Nov 06, 2022 at 02:21:11AM +0900, Vincent MAILHOL wrote:
> > > > > > On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
> > > > > > <mailhol.vincent@wanadoo.fr> wrote:
> > > > > > > On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > It's late right now, and I can't remember the whole USB spec, but I
> > > > > think the device provides a list of the string ids that are valid for
> > > > > it.  If so, we can add that to sysfs for any USB device out there, no
> > > > > matter the string descriptor number.
> > > >
> > > > No, there is no such list.
> > >
> > > Yeah, my fault, nevermind about that, sorry.
> > >
> > > > > If not, maybe we can just iterate the 255 values and populate sysfs
> > > > > files if they are present?  I'll dig up the USB spec tomorrow...
> > > >
> > > > Yes, we could do that.  But the filename would have to be the string
> > > > id, which is not meaningful.  We wouldn't be able to have labels like
> > > > "product-info" unless somehow a driver could provide the label.
> > >
> > > We could have a directory of strings/ with the individual descriptors in
> > > there as files with the name being the string id.
> > >
> > > But that might take a long time to populate, as it can take a few tries
> > > to get the string from a device, and to do that 256 times might be
> > > noticable at device insertion time.
> > >
> > > > Also, there's the matter of language.  Devices can have string
> > > > descriptors in multiple languages; which one should we show in sysfs?
> > > > All of them?  Right now we use just the default language for the strings
> > > > that we put in sysfs.
> > > >
> > > > > I say do this at the USB core level, that way it works for any USB
> > > > > device, and you don't have a device-specific sysfs file and custom
> > > > > userspace code just for this.
> > > >
> > > > This is unavoidable to some extent.  Without device-specific information
> > > > or userspace code, there is no way to know which string descriptor
> > > > contains the data you want.
> > >
> > > Agreed.
> > >
> > > Ok, for this specific instance, adding the "we know this string id
> > > should be here" as a device-specific sysfs file seems to be the easiest
> > > way forward.
> > >
> > > Vincent, want to try that instead?
> >
> > OK for me. Will do that and remove the kernel log spam and replace it
> > by a sysfs entry.
> >
> > I have two questions:
> >
> > 1/ Can I still export and use usb_cache_string()? In other terms, does
> > the first patch of this series still apply? This looks like the most
> > convenient function to retrieve that custom string to me.
>
> Everyone seems to just use the usb_string() function, will that not work
> for you?

It is just that I would have to write two or three lines of code less.
But if you prefer I can use usb_string(), no problem on that.

> > 2/ Is it a no-go to also populate ethtool_drvinfo::fw_version? Some
> > users might look for the value in sysfs, while some might use ethtool.
> > If the info is not available in ethtool, people might simply assume it
> > is not available at all. So, I would like to provide both.
>
> That's up to the network developers/maintainers.  I don't know if that's
> a required or common api for network devices to have.

My question was more to know if you had any objection if I did so.
From the documentation, there is no indication that this is required.
But I don't like to leave a field empty when I have the information to
fill it.


Yours sincerely,
Vincent Mailhol
