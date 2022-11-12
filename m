Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDF626A48
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiKLPkq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Nov 2022 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:40:45 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E65B1ADAC;
        Sat, 12 Nov 2022 07:40:44 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 136so6687276pga.1;
        Sat, 12 Nov 2022 07:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFmEovQuih3sC0ACkx1NqUHQ6cWP4h8cIyeW3MWuhGY=;
        b=GziSfrdP4WDbfkR4yrd9a3/FbqVd11+6faQmdncSQvQsGWMoa+Gehd2LJTPNbpF6/d
         KqC/qR1ELHj06ue5Vgd2i3z1siVAwAX0gWwWOFP2CkccpvpzwnnW76vyW9A0o/TDKJi5
         Dvun6PfBq9lN66ePWLM64NsZnXVKevEmGNb8DynGs4BqfnWrIoA/Jhjam6k35GbqdN79
         gSwp2nncIzbQggLsPgzj2CixrWUiRyi8pPblkU8GhEtVK9rae8H25MtgmlMyznrcvuaf
         Do6dD/T7BNUXtsaMwKHQVDxXc10lHLwljWQQBlDkOU6bAsUzexCV+fAFFW8QRqR9Pd7T
         5Z7g==
X-Gm-Message-State: ANoB5pmTRQHPaZYueJxtKJJ/AyoDpe7C9yDyqkcW1rmQyrZr5ATcVZDA
        THSWn0yzo1v2c60llBxU+5orbLwkZYtxZ3b79W0fKt9VqLA=
X-Google-Smtp-Source: AA0mqf45ci/2udy38PrCir2ebdsKsLN4JFAx8FeKjFhrpyNi9bASzqETpUJxdcijsb0IYwuBi/qSs4D6d2xNIgk8O38=
X-Received: by 2002:a63:4e53:0:b0:473:f7fb:d2c7 with SMTP id
 o19-20020a634e53000000b00473f7fbd2c7mr5730598pgl.535.1668267643484; Sat, 12
 Nov 2022 07:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com> <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com> <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
 <Y2eYw9Kna712mzR8@kroah.com> <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
 <Y2fDG9AsuFZh0Dkr@kroah.com> <CAMZ6RqLwebh6VuwXdyyxpcdyJjYg3fUt9Opx+dPQRzqZ-2976w@mail.gmail.com>
 <Y2faf++qaSq92qmZ@kroah.com>
In-Reply-To: <Y2faf++qaSq92qmZ@kroah.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 13 Nov 2022 00:40:31 +0900
Message-ID: <CAMZ6Rq+N7Dbs7AENU12PJu-M2coBeoEF-YLpvQp79cSChAR6hg@mail.gmail.com>
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

On Mon. 7 nov. 2022 at 01:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Nov 06, 2022 at 11:44:52PM +0900, Vincent MAILHOL wrote:
> > On Sun. 6 Nov. 2022 à 23:22, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > On Sun, Nov 06, 2022 at 09:47:05PM +0900, Vincent MAILHOL wrote:
> > > > On Sun. 6 Nov. 2022 at 20:25, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > 1/ Can I still export and use usb_cache_string()? In other terms, does
> > > > the first patch of this series still apply? This looks like the most
> > > > convenient function to retrieve that custom string to me.
> > >
> > > Everyone seems to just use the usb_string() function, will that not work
> > > for you?
> >
> > It is just that I would have to write two or three lines of code less.
>
> Odd, should it be used instead where others are calling usb_string()?
>
> > But if you prefer I can use usb_string(), no problem on that.
>
> Try it both ways.  If it's easier with usb_cache_string(), then we can
> export it.  It's just odd that it hasn't been exported yet.

I tried both. Not counting the line breaks, the empty lines and the
comments, the usb_string() version needs 6 more lines. Not a huge
difference but the usb_cache_string() remains easier (at least in my
eyes).

For reference, here is the diff before and after using usb_cache_string():

diff --git a/drivers/net/can/usb/etas_es58x/es58x_sysfs.c
b/drivers/net/can/usb/etas_es58x/es58x_sysfs.c
index 4ff0332f6f50..c1d220d0d35f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_sysfs.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_sysfs.c
@@ -178,17 +178,10 @@ void es58x_create_file(struct device *dev)
 {
        struct es58x_device *es58x_dev = dev_get_drvdata(dev);
        char *prod_info;
-       int ret;

-       prod_info = kmalloc(ES58X_PROD_INFO_SIZE, GFP_KERNEL);
-       if (!prod_info)
-               return;
-
-        ret = usb_string(es58x_dev->udev, ES58X_PROD_INFO_IDX,
-                        prod_info, ES58X_PROD_INFO_SIZE);
-        if (ret < 0) {
+       prod_info = usb_cache_string(es58x_dev->udev, ES58X_PROD_INFO_IDX);
+       if (!prod_info) {
                dev_warn(dev, "could not retrieve the product info string\n");
-               kfree(prod_info);
                return;
        }

diff --git a/drivers/net/can/usb/etas_es58x/es58x_sysfs.h
b/drivers/net/can/usb/etas_es58x/es58x_sysfs.h
index 62347ffa0214..a204aa5344a8 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_sysfs.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_sysfs.h
@@ -14,13 +14,6 @@
 /* USB descriptor index containing the product information string. */
 #define ES58X_PROD_INFO_IDX 6

-/* Maximum size for the USB information custom string. USB strings are
- * at most 127 characters and es58x devices only use ASCII (i.e. one
- * byte). Also, empirical observations show a maximum length of 83
- * bytes for the product information.
- */
-#define ES58X_PROD_INFO_SIZE (127 + 1)
-
 void es58x_create_file(struct device *dev);
 void es58x_remove_file(struct device *dev);
