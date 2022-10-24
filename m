Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB18609911
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJXEH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJXEHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:07:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674B258162
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 21:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AFC5B80BA4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316E3C433C1;
        Mon, 24 Oct 2022 04:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666584471;
        bh=wqPgP+8gYHmK9GoieUKkAx4Z5kQUK7bHl56fCslFrUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIxX1ej7uZtoW4nLSZBV5AQuSiOEwB1kMAgXMr95mJ3/m6kmXDSQOu0jyxLkKPAAi
         onH2jWPn/F8urOxwynMLOsn1WG9sQgVAHDa3d/C/MDaMbU8xt0dTMvafILGDRa1scs
         VTGKvaYlcOIXAtgIor7q4CBvmrMdXWxV3V+hti9E=
Date:   Mon, 24 Oct 2022 06:08:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Message-ID: <Y1YPypVbN5v18uni@kroah.com>
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me>
 <Y1VL/wITM64U6qLi@kroah.com>
 <4863c6d7-ffdd-1304-981b-9b0644a87f4e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4863c6d7-ffdd-1304-981b-9b0644a87f4e@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:08:00AM +0700, Bagas Sanjaya wrote:
> On 10/23/22 21:13, Greg KH wrote:
> >>> @@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
> >>>  			wlandev->rx.cfack_cfpoll++;
> >>>  			break;
> >>>  		default:
> >>> -			/* printk("unknown"); */
> >>>  			wlandev->rx.data_unknown++;
> >>>  			break;
> >>>  		}
> >>
> >> Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?
> > 
> > No, they should just be removed as was done here.
> > 
> 
> What if in case of debugging without these printks?

I can not parse this line, sorry.
