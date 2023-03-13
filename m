Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090B6B7215
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCMJIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCMJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:08:02 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E010EB;
        Mon, 13 Mar 2023 02:06:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3B852E0FCB;
        Mon, 13 Mar 2023 02:06:01 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KqaR6nthGCF3; Mon, 13 Mar 2023 02:06:00 -0700 (PDT)
Message-ID: <2f84f3196c426a3957d479d8fe0d1440a82932af.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678698360; bh=9qC4noDrLpgjlr1iZhfPnQ3ESFPoh887kUgfzjHtjxE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HSS91jrM3hyPc+Dl5XjezZ167iBV5U/CnKzyOub10LefaW7CBFRP0A9++3fOmgskh
         xr0KnhKRm/fzPio0y7XuxPSQaYV+95RKhwYJmUZhZlcqC4/1o+Xj0xmFnRDyOyeKA0
         Igih7K/LQWX0d3CdCHB1GIib6GpAOsFY6USTrrv/z1Kt9IpFD5eZ7nH/KFbOZCWUEe
         GnzSEvzxUVf6jMLbsYUE5Xf0tQaQ9qU3rBvtPB2s0TfL9nNcDL2GwfOuXlZGjcYvnT
         U36GM3BD16QeTKBh9sANnlBA2aaE/nyeTnhMO8+OMdoACv5dn9Q/SUPjIFlIp75K04
         IldTTgL8gOu3g==
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
Date:   Mon, 13 Mar 2023 10:05:52 +0100
In-Reply-To: <cd70891320aab38f5c085c67c4651e0f4f6d8ed8.camel@puri.sm>
References: <20230301214952.2190757-1-saravanak@google.com>
         <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm>
         <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
         <CAGETcx93K1VjAosX9NDEyLVLPK2utPSUV6dwzdAT-Dc5BfmhzQ@mail.gmail.com>
         <4e8d00617de0c25dcf84847c3d3ad3f2d76ee5b9.camel@puri.sm>
         <CAGETcx_CDBf3eTgTkUCwYoyvXk4L7hJBDKj6rwow6k=EdbZpqA@mail.gmail.com>
         <cd70891320aab38f5c085c67c4651e0f4f6d8ed8.camel@puri.sm>
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

Am Sonntag, dem 12.03.2023 um 15:41 +0100 schrieb Martin Kepplinger:
> Am Freitag, dem 10.03.2023 um 14:18 -0800 schrieb Saravana Kannan:
> > On Fri, Mar 10, 2023 at 2:07 AM Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > > 
> > > Am Donnerstag, dem 09.03.2023 um 16:24 -0800 schrieb Saravana
> > > Kannan:
> > > > On Thu, Mar 2, 2023 at 1:41 AM Martin Kepplinger
> > > > <martin.kepplinger@puri.sm> wrote:
> > > > > 
> > > > > Am Donnerstag, dem 02.03.2023 um 10:12 +0100 schrieb Martin
> > > > > Kepplinger:
> > > > > > Am Mittwoch, dem 01.03.2023 um 13:49 -0800 schrieb Saravana
> > > > > > Kannan:
> > > > > > > Yongqin, Martin, Amelie,
> > > > > > > 
> > > > > > > We recent refactor of fw_devlink that ends with commit
> > > > > > > fb42378dcc7f
> > > > > > > ("mtd: mtdpart: Don't create platform device that'll
> > > > > > > never
> > > > > > > probe"),
> > > > > > > fw_devlink is smarter and doesn't depend on compatible
> > > > > > > property.
> > > > > > > So,
> > > > > > > I
> > > > > > > don't think these calls are needed anymore. But I don't
> > > > > > > have
> > > > > > > these
> > > > > > > devices to test on and be sure and the hardware I use to
> > > > > > > test
> > > > > > > changes
> > > > > > > doesn't have this issue either.
> > > > > > > 
> > > > > > > Can you please test these changes on the hardware where
> > > > > > > you
> > > > > > > hit
> > > > > > > the
> > > > > > > issue to make sure things work as expected?
> > > > > > > 
> > > > > > > Yongqin, If you didn't have the context, this affected
> > > > > > > hikey960.
> > > > > > > 
> > > > > > > Greg,
> > > > > > > 
> > > > > > > Let's wait for some tests before we land these.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Saravana
> > > > > > 
> > > > > > hi Sravana,
> > > > > > 
> > > > > > I picked the 12 commits leading up to commit fb42378dcc7f
> > > > > > ("mtd:
> > > > > > mtdpart: Don't create platform device that'll never probe")
> > > > > > (
> > > > > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink
> > > > > > ) and included the tipd patch below to test it.
> > > > > > 
> > > > > > With that, I get the following errors:
> > > > > > 
> > > > > > [    0.237931] imx-uart 30890000.serial: Failed to create
> > > > > > device
> > > > > > link
> > > > > > with regulator-gnss
> > > > > > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create
> > > > > > device
> > > > > > link
> > > > > > with regulator-lcd-1v8
> > > > > > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create
> > > > > > device
> > > > > > link
> > > > > > with backlight-dsi
> > > > > > 
> > > > > > but they are independent of this final tipd patch below.
> > > > > > I'll
> > > > > > test a
> > > > > > real linux-next tree soon, for completeness, maybe I missed
> > > > > > something?
> > > > > > 
> > > > > > Anyways, on that tree, your tipd removal patch breaks type-
> > > > > > c
> > > > > > still
> > > > > > for
> > > > > > me, imx8mq-librem5.dtsi
> > > > > > 
> > > > > > just to give a first reply quickly... thanks,
> > > > > > 
> > > > > >                              martin
> > > > > > 
> > > > > 
> > > > > just confirming: it's the same as above on next-20230302 +
> > > > > this
> > > > > patch (
> > > > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink_next-20230302
> > > > > ) with the errors already independent from the patch. I
> > > > > should
> > > > > have
> > > > > tested earlier patches -.-
> > > > 
> > > > Thanks a lot for testing Martin!
> > > > 
> > > > Your email is a little ambiguous to me. With the 12 refactor
> > > > commits
> > > > +
> > > > the 4 patches in this series, things are breaking for you. But
> > > > if
> > > > you
> > > > drop the 4 patches in this series, things work again. Is that
> > > > right?
> > > 
> > > no. Sorry if I wasn't clear. I can't justify to block these 4
> > > patches.
> > > they *themselves* don't break anything.
> > > 
> > > Something broke *earlier* than these 4 patches in one of the
> > > other
> > > 12.
> > 
> > If you find out it's one of the other 12 patches in the refactor
> > that
> > broke things for you, can you please reply to the right email in
> > that
> > series[1] and let me know which patch broke things for you and
> > provide
> > the debug details there? I don't want to mix issues with unrelated
> > threads -- I want them to be easy to find in the future.
> > 
> > [1] -  
> > https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@google.com/
> > 
> > For all my questions below, you don't need to reply here. Just
> > reply
> > to the right thread.
> 
> Thanks. I'll have to reply here though - I'm puzzled how, but I got
> it
> wrong - I must have seen the "Failed to create device link" messages
> without checking broken drivers: The 12 patches you linked above are
> fine. (In a way that's good as I saw them in a stable kernel
> already).
> 
> commit ("usb: typec: tipd: Remove use of
> fw_devlink_purge_absent_suppliers()") breaks things for me. That is
> patch 2 of this series. That's for sure now.


this thing is this: I have downstream patches against tipd, among
others. And I don't know yet but we might very well do something wrong
in our downstream tree that is now not compatible anymore with this
removal...

I switched to a tree without any downstream stuff: For the 12 earlier
patches, I there see the follwing which is NOT your fault and we need
to fix upstream (we fix that in our downstream tree):

root@pureos:/home/purism# cat /sys/kernel/debug/devices_deferred 
3-0036

And then I add patch 2 of this series (removing the call from tipd), it
becomes:

root@pureos:/home/purism# cat /sys/kernel/debug/devices_deferred 
0-003f	
38100000.usb	platform: wait for supplier endpoint
3-0036	


