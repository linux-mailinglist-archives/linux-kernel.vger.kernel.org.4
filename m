Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E26093D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJWOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:11:26 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A374F68F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666534269; bh=7hNP8hjaYMyU1wlRxR/bmZkSyaJpg6Rh9kVXG2+maWg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=DN5ECJzoipAIenQhgM1PLM68MaUifE7b/CbqKfbpzSh5jP2JDZRWQsTGn24zInzVX
         ZD/Hntp+FOQjqa+MVNOWQZJypdjm0Pzy6DuMlF03l85ccG1fd9kwYOtNFnZj43DCnC
         qCGbK7HP4OupVBuEYeiHp9363qMXcK5XEvL38ixs=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Sun, 23 Oct 2022 16:11:08 +0200 (CEST)
X-EA-Auth: +uStNp8uuEi6lQ+O2XKDU8b2GFjw8xi10Fb5lzwXpxvQeG1WLshBQXUHAU37QsRnvAryg9P/YN0kAurcezJ3SHhi0+LYijhr
Date:   Sat, 22 Oct 2022 04:10:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Message-ID: <Y1Mf7IVccbst10iP@debian-BULLSEYE-live-builder-AMD64>
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1VDM2kWIi1I5dqI@debian.me>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 08:35:47PM +0700, Bagas Sanjaya wrote:
> On Sat, Oct 22, 2022 at 01:03:42AM +0530, Deepak R Varma wrote:
> > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > index e04fc666d218..6bef419e8ad0 100644
> > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > @@ -881,55 +881,42 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
> >  		wlandev->rx.mgmt++;
> >  		switch (fstype) {
> >  		case WLAN_FSTYPE_ASSOCREQ:
> > -			/* printk("assocreq"); */
> >  			wlandev->rx.assocreq++;
> >  			break;
> >  			wlandev->rx.ctl_unknown++;
> >  			break;
> >  		}
> > -		/* printk("\n"); */
> >  		drop = 2;
> >  		break;
> >
> > @@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
> >  			wlandev->rx.cfack_cfpoll++;
> >  			break;
> >  		default:
> > -			/* printk("unknown"); */
> >  			wlandev->rx.data_unknown++;
> >  			break;
> >  		}
>
> Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?

Hi Sanjaya,
Sure they can, but I think they are very basic tracing message and do not appear
to carry much of information useful the event of debugging. Do you have a
suggestion on what additional information may be added to make them more useful?

If you still think we should have then in the CONFIG_DEBUG_KERNEL guard, let me
know and I will attempt to improve these.

Thank you,
./drv

>
> --
> An old man doll... just what I always wanted! - Clara




