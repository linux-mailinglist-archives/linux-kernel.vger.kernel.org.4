Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B906093D3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJWONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:13:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8D4F68F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3D51B80BFF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F8C433D6;
        Sun, 23 Oct 2022 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666534402;
        bh=leqxc6BsGprbosIr/2xr3r85KNG1HLPmLbL6GeBiMEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+8TP2Qv59bHEpxTcuC2X8IglzZfbOJMIWrhcJXMvZgR5YKxPZUpB+W4UyYGyintv
         kB6eXIuY04N9Rqw6eHsinzC9FAPFxbeZacV8oE98jD+wKfoqf+8MZehlVTtnHfDS01
         YhzJnq/bIZIuj2bAjAKfmdy0EBWQGXGN0OU33Pl4=
Date:   Sun, 23 Oct 2022 16:13:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Message-ID: <Y1VL/wITM64U6qLi@kroah.com>
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1VDM2kWIi1I5dqI@debian.me>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> >  		case WLAN_FSTYPE_ASSOCRESP:
> > -			/* printk("assocresp"); */
> >  			wlandev->rx.assocresp++;
> >  			break;
> >  		case WLAN_FSTYPE_REASSOCREQ:
> > -			/* printk("reassocreq"); */
> >  			wlandev->rx.reassocreq++;
> >  			break;
> >  		case WLAN_FSTYPE_REASSOCRESP:
> > -			/* printk("reassocresp"); */
> >  			wlandev->rx.reassocresp++;
> >  			break;
> >  		case WLAN_FSTYPE_PROBEREQ:
> > -			/* printk("probereq"); */
> >  			wlandev->rx.probereq++;
> >  			break;
> >  		case WLAN_FSTYPE_PROBERESP:
> > -			/* printk("proberesp"); */
> >  			wlandev->rx.proberesp++;
> >  			break;
> >  		case WLAN_FSTYPE_BEACON:
> > -			/* printk("beacon"); */
> >  			wlandev->rx.beacon++;
> >  			break;
> >  		case WLAN_FSTYPE_ATIM:
> > -			/* printk("atim"); */
> >  			wlandev->rx.atim++;
> >  			break;
> >  		case WLAN_FSTYPE_DISASSOC:
> > -			/* printk("disassoc"); */
> >  			wlandev->rx.disassoc++;
> >  			break;
> >  		case WLAN_FSTYPE_AUTHEN:
> > -			/* printk("authen"); */
> >  			wlandev->rx.authen++;
> >  			break;
> >  		case WLAN_FSTYPE_DEAUTHEN:
> > -			/* printk("deauthen"); */
> >  			wlandev->rx.deauthen++;
> >  			break;
> >  		default:
> > -			/* printk("unknown"); */
> >  			wlandev->rx.mgmt_unknown++;
> >  			break;
> >  		}
> > -		/* printk("\n"); */
> >  		drop = 2;
> >  		break;
> > 
> > @@ -943,35 +930,27 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
> >  		wlandev->rx.ctl++;
> >  		switch (fstype) {
> >  		case WLAN_FSTYPE_PSPOLL:
> > -			/* printk("pspoll"); */
> >  			wlandev->rx.pspoll++;
> >  			break;
> >  		case WLAN_FSTYPE_RTS:
> > -			/* printk("rts"); */
> >  			wlandev->rx.rts++;
> >  			break;
> >  		case WLAN_FSTYPE_CTS:
> > -			/* printk("cts"); */
> >  			wlandev->rx.cts++;
> >  			break;
> >  		case WLAN_FSTYPE_ACK:
> > -			/* printk("ack"); */
> >  			wlandev->rx.ack++;
> >  			break;
> >  		case WLAN_FSTYPE_CFEND:
> > -			/* printk("cfend"); */
> >  			wlandev->rx.cfend++;
> >  			break;
> >  		case WLAN_FSTYPE_CFENDCFACK:
> > -			/* printk("cfendcfack"); */
> >  			wlandev->rx.cfendcfack++;
> >  			break;
> >  		default:
> > -			/* printk("unknown"); */
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

No, they should just be removed as was done here.

thanks,

greg k-h
