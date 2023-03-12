Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1886B6744
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCLOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:43:28 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D84FF3E;
        Sun, 12 Mar 2023 07:42:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4C688DFE6B;
        Sun, 12 Mar 2023 07:41:49 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0u-FZJ_QCjOM; Sun, 12 Mar 2023 07:41:48 -0700 (PDT)
Message-ID: <cd70891320aab38f5c085c67c4651e0f4f6d8ed8.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678632108; bh=sMSRCt3IKf55EZOCLKJArkH1HgCz/B/V5Tz2XnYwseI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P6HHQgY1jhlLYwQFbXzhK9ou4sa3CCsRggqO0GdqwcHgue6mt8SMK+E96DdTP9+l1
         Y4MAllg5mOe7Qv5CJ2hGArhuUg6AyS14b+xWJVDjadJmVK6WXxv1eX7K+MwlLvkWiQ
         lZL9tXwrKyE16gYU0CVVPxhu8yLWmc6lt0C5WYzt6CNmRza8G1avgYQUH9b4JmInOx
         EjQOvaAmYoEHU0oF7/Qo9u3bmgYf7gNGjW3oY2GWe7R2SfwxPdUO2b7CkDBOWANvK3
         CCn5/cSaUDOX0LNX5qHAyDHVO76l4mYiYFD2k92WKJyOxlfiP3htsAxWaxKk5x1bYh
         MaXkU9PvNT67A==
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Sun, 12 Mar 2023 15:41:43 +0100
In-Reply-To: <CAGETcx_CDBf3eTgTkUCwYoyvXk4L7hJBDKj6rwow6k=EdbZpqA@mail.gmail.com>
References: <20230301214952.2190757-1-saravanak@google.com>
         <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm>
         <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
         <CAGETcx93K1VjAosX9NDEyLVLPK2utPSUV6dwzdAT-Dc5BfmhzQ@mail.gmail.com>
         <4e8d00617de0c25dcf84847c3d3ad3f2d76ee5b9.camel@puri.sm>
         <CAGETcx_CDBf3eTgTkUCwYoyvXk4L7hJBDKj6rwow6k=EdbZpqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 10.03.2023 um 14:18 -0800 schrieb Saravana Kannan:
> On Fri, Mar 10, 2023 at 2:07 AM Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > Am Donnerstag, dem 09.03.2023 um 16:24 -0800 schrieb Saravana
> > Kannan:
> > > On Thu, Mar 2, 2023 at 1:41 AM Martin Kepplinger
> > > <martin.kepplinger@puri.sm> wrote:
> > > > 
> > > > Am Donnerstag, dem 02.03.2023 um 10:12 +0100 schrieb Martin
> > > > Kepplinger:
> > > > > Am Mittwoch, dem 01.03.2023 um 13:49 -0800 schrieb Saravana
> > > > > Kannan:
> > > > > > Yongqin, Martin, Amelie,
> > > > > > 
> > > > > > We recent refactor of fw_devlink that ends with commit
> > > > > > fb42378dcc7f
> > > > > > ("mtd: mtdpart: Don't create platform device that'll never
> > > > > > probe"),
> > > > > > fw_devlink is smarter and doesn't depend on compatible
> > > > > > property.
> > > > > > So,
> > > > > > I
> > > > > > don't think these calls are needed anymore. But I don't
> > > > > > have
> > > > > > these
> > > > > > devices to test on and be sure and the hardware I use to
> > > > > > test
> > > > > > changes
> > > > > > doesn't have this issue either.
> > > > > > 
> > > > > > Can you please test these changes on the hardware where you
> > > > > > hit
> > > > > > the
> > > > > > issue to make sure things work as expected?
> > > > > > 
> > > > > > Yongqin, If you didn't have the context, this affected
> > > > > > hikey960.
> > > > > > 
> > > > > > Greg,
> > > > > > 
> > > > > > Let's wait for some tests before we land these.
> > > > > > 
> > > > > > Thanks,
> > > > > > Saravana
> > > > > 
> > > > > hi Sravana,
> > > > > 
> > > > > I picked the 12 commits leading up to commit fb42378dcc7f
> > > > > ("mtd:
> > > > > mtdpart: Don't create platform device that'll never probe") (
> > > > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink
> > > > > ) and included the tipd patch below to test it.
> > > > > 
> > > > > With that, I get the following errors:
> > > > > 
> > > > > [    0.237931] imx-uart 30890000.serial: Failed to create
> > > > > device
> > > > > link
> > > > > with regulator-gnss
> > > > > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create
> > > > > device
> > > > > link
> > > > > with regulator-lcd-1v8
> > > > > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create
> > > > > device
> > > > > link
> > > > > with backlight-dsi
> > > > > 
> > > > > but they are independent of this final tipd patch below. I'll
> > > > > test a
> > > > > real linux-next tree soon, for completeness, maybe I missed
> > > > > something?
> > > > > 
> > > > > Anyways, on that tree, your tipd removal patch breaks type-c
> > > > > still
> > > > > for
> > > > > me, imx8mq-librem5.dtsi
> > > > > 
> > > > > just to give a first reply quickly... thanks,
> > > > > 
> > > > >                              martin
> > > > > 
> > > > 
> > > > just confirming: it's the same as above on next-20230302 + this
> > > > patch (
> > > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink_next-20230302
> > > > ) with the errors already independent from the patch. I should
> > > > have
> > > > tested earlier patches -.-
> > > 
> > > Thanks a lot for testing Martin!
> > > 
> > > Your email is a little ambiguous to me. With the 12 refactor
> > > commits
> > > +
> > > the 4 patches in this series, things are breaking for you. But if
> > > you
> > > drop the 4 patches in this series, things work again. Is that
> > > right?
> > 
> > no. Sorry if I wasn't clear. I can't justify to block these 4
> > patches.
> > they *themselves* don't break anything.
> > 
> > Something broke *earlier* than these 4 patches in one of the other
> > 12.
> 
> If you find out it's one of the other 12 patches in the refactor that
> broke things for you, can you please reply to the right email in that
> series[1] and let me know which patch broke things for you and
> provide
> the debug details there? I don't want to mix issues with unrelated
> threads -- I want them to be easy to find in the future.
> 
> [1] -  
> https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@google.com/
> 
> For all my questions below, you don't need to reply here. Just reply
> to the right thread.

Thanks. I'll have to reply here though - I'm puzzled how, but I got it
wrong - I must have seen the "Failed to create device link" messages
without checking broken drivers: The 12 patches you linked above are
fine. (In a way that's good as I saw them in a stable kernel already).

commit ("usb: typec: tipd: Remove use of
fw_devlink_purge_absent_suppliers()") breaks things for me. That is
patch 2 of this series. That's for sure now.

> 
> > As to *what* broke: The error messages during boot,
> 
> The error messages, is it anything other than the "Failed to create
> device link"?
> 
> > and the charger and
> > fuel gauge don't work anymore, I see:
> > 
> > # cat /sys/kernel/debug/devices_deferred
> > 3-0036  max17042: failed: power supply register
> > 0-003f
> 
> This seems to be the main culprit. That 0-003f isn't probing. It's
> surprising that the reason is empty too. IIRC that means it didn't do
> deferred probing, but rather failed with an error. Wild guess ....
> Try
> increasing the deferred_probe_timeout to see if it helps?
> 
> > 38100000.usb    platform: wait for supplier endpoint
> > 32c00000.hdmi   platform: supplier 0-003f not ready
> > 3-006a  bq25890-charger: registering power supply
> > 
> > 
> > I haven't had time to track it down and see where the issue is.
> > Could
> > be one of the 12 patches, could be a wrong description for my
> > board:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> > or something else (an i2c issue?).
> > 
> > (for completeness, the exact tree I ran:
> > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink
> > )
> > 
> > > 
> > > Let's ignore the "Failed to create device link" errors for now --
> > > it's
> > > not related to this usb-c-connector series. It's basically
> > > pointing
> > > out issues that we ignored silently in the past -- it's basically
> > > pointing out holes in fw_devlink's visibility of devices. I'll
> > > get to
> > > them later.
> > 
> > ok. good to know. please do.
> 
> Here's a fix for the Failed to create device link issues.
> https://lore.kernel.org/lkml/20230310063910.2474472-1-saravanak@google.com/
> 
> > And since I'm the only one seeing an issue, please move the patches
> > forward. I'll need to fix this after the fact and hope to have time
> > for
> > it next week.
> 
> I'd rather wait for you than rush these patches in. The patches are
> just removing what I expect to be cruft. I'd rather confirm that
> first
> than break anything.
> 
> -Saravana


