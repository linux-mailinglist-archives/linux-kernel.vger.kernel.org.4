Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F35F2CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJCJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJCJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:05:17 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545712D2E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:59:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3253124010B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1664787556; bh=Z0qKp5DtnIGEVjLEnp/3kaZaVLp5zxIKuf7TnsVnxY4=;
        h=Date:From:To:Cc:Subject:From;
        b=nWfY2ysBkmNKfp09dEyK33vpUQ8cwgE6suWC6NtIQsVYsSe/x+lD9NQYTp69Nrywa
         33DCgRldja7/U4OLWJuVjn6fZ84noEQkQXV+6iMW7KDxNOklDdquzC4JZza79plP24
         hU5Qtf18ZRKhp/ZFLIrQs9kGh/eWwfMceprp97VWEA2XyssE61EsynX/xAYQ11NDO0
         0rRnl7Cmx+xcLmQKVaDN+pZeSpRAj6kyBhCkOnyVufpU9ijefY2xNlmTKk88E52Ozq
         xRCdzfXJwojpjuv+NXGe81Vh1eWKcgnxwd60krXXt+PanTYfV/coyRDEfHDCF/wDGw
         6Ak8XbjYAQ9DQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MgvsG6BDKz9rxM;
        Mon,  3 Oct 2022 10:59:14 +0200 (CEST)
Date:   Mon,  3 Oct 2022 08:59:13 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Jonas Malaco <jonas@protocubo.io>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add USB id of new revision of the
 HX1000i psu
Message-ID: <20221003105913.0a176e87@posteo.net>
In-Reply-To: <CANS_-EOai0-4=oDvNgHCUjhnNz_AmAtKx_sOPxF9Z88TsJv7FA@mail.gmail.com>
References: <YznOUQ7Pijedu0NW@monster.localdomain>
        <CANS_-EOai0-4=oDvNgHCUjhnNz_AmAtKx_sOPxF9Z88TsJv7FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 05:13:27 -0300
Jonas Malaco <jonas@protocubo.io> wrote:

> On Sun, Oct 2, 2022 at 2:46 PM Wilken Gottwalt
> <wilken.gottwalt@posteo.net> wrote:
> >
> > Also updates the documentation accordingly.
> >
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> >  Documentation/hwmon/corsair-psu.rst | 2 +-
> >  drivers/hwmon/corsair-psu.c         | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> > index c3a76305c587..3c1b164eb3c0 100644
> > --- a/Documentation/hwmon/corsair-psu.rst
> > +++ b/Documentation/hwmon/corsair-psu.rst
> > @@ -15,7 +15,7 @@ Supported devices:
> >
> >    Corsair HX850i
> >
> > -  Corsair HX1000i
> > +  Corsair HX1000i (revision 1 and 2)
> >
> >    Corsair HX1200i
> >
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index c99e4c6afc2d..345d883ab044 100644
> > --- a/drivers/hwmon/corsair-psu.c
> > +++ b/drivers/hwmon/corsair-psu.c
> > @@ -813,13 +813,14 @@ static const struct hid_device_id corsairpsu_idtable[] = {
> >         { HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> > -       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> > +       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i revision 1 */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> >         { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> > +       { HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsaur HX1000i revision 2 */
> 
> Wilken,
> 
> A small typo has creeped in: s/Corsaur/Corsair/.
> 
> P.S. Sorry if this reply arrives somewhat mangled, I'm away from my
> regular setup.

Oh, looks like I hit one key next to it. Thx for spotting this.

greetings,
Will
