Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC90701BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjENGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF91FE6;
        Sat, 13 May 2023 23:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBBB61470;
        Sun, 14 May 2023 06:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C435C433EF;
        Sun, 14 May 2023 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684045980;
        bh=1dZ7d937g3cEehK4Bk2L/HX89vq34GtVVpU+t+w4bes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YR+Cf42wmgwUAKpVoPu7zi/HZsELdI7vnMIwpriO5yuT2WZb0z8wbgLyNfDEu7Xqf
         8Yabcdp8jdKn4jvlVbZggOodgMhjV2nFOzalYBcvgbfhh38YMKt8KEzh0wUKzMjzn8
         an+gOaOOS9yOngVUTSsyoY/GIUOMV/UmprUY7Z74=
Date:   Sun, 14 May 2023 00:07:28 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Fontana <rfontana@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Watchdog Devices <linux-watchdog@vger.kernel.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ray Lehtiniemi <rayl@mail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrey Panin <pazke@donpac.ru>, Oleg Drokin <green@crimea.edu>,
        Marc Zyngier <maz@kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Sylver Bruneau <sylver.bruneau@googlemail.com>,
        Andrew Sharp <andy.sharp@lsi.com>,
        Denis Turischev <denis@compulab.co.il>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 08/10] drivers: watchdog: Replace GPL license notice
 with SPDX identifier
Message-ID: <2023051414-headroom-maimed-553c@gregkh>
References: <20230512100620.36807-1-bagasdotme@gmail.com>
 <20230512100620.36807-9-bagasdotme@gmail.com>
 <CAC1cPGy=78yo2XcJPNZVvdjBr2-XzSq76JrAinSe42=sNdGv3w@mail.gmail.com>
 <ef31b33f-8e66-4194-37e3-916b53cf7088@gmail.com>
 <CAC1cPGzznK8zoLaT1gBjpHP1eKFvTKKi+SW6xuXF3B8aHN27=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1cPGzznK8zoLaT1gBjpHP1eKFvTKKi+SW6xuXF3B8aHN27=g@mail.gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 09:43:39AM -0400, Richard Fontana wrote:
> On Sat, May 13, 2023 at 6:53 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On 5/12/23 19:46, Richard Fontana wrote:
> > > On Fri, May 12, 2023 at 6:07 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > >
> > >
> > >> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> > >> index 504be461f992a9..822bf8905bf3ce 100644
> > >> --- a/drivers/watchdog/sb_wdog.c
> > >> +++ b/drivers/watchdog/sb_wdog.c
> > >> @@ -1,3 +1,4 @@
> > >> +// SPDX-License-Identifier: GPL-1.0+
> > >>  /*
> > >>   * Watchdog driver for SiByte SB1 SoCs
> > >>   *
> > >> @@ -38,10 +39,6 @@
> > >>   *     (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
> > >>   *                                             All Rights Reserved.
> > >>   *
> > >> - *     This program is free software; you can redistribute it and/or
> > >> - *     modify it under the terms of the GNU General Public License
> > >> - *     version 1 or 2 as published by the Free Software Foundation.
> > >
> > > Shouldn't this be
> > > // SPDX-License-Identifier: GPL-1.0 OR GPL-2.0
> > > (or in current SPDX notation GPL-1.0-only OR GPL-2.0-only) ?
> > >
> >
> > Nope, as it will fail spdxcheck.py. Also, SPDX specification [1]
> > doesn't have negation operator (NOT), thus the licensing requirement
> > on the above notice can't be expressed reliably in SPDX here.
> >
> > [1]: https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/
> 
> The GPL identifiers in recent versions of SPDX include an `-only` and
> an `-or-later` variant.

But Linux does not use the newer versions of SPDX given that we started
the conversion before the "-only" variant came out.  Let's stick with
the original one please before worrying about converting to a newer
version of SPDX and mixing things up.

thanks,

greg k-h
