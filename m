Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAABB60E2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiJZNz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiJZNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:54:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BD103243
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4571CB82257
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3D9C433C1;
        Wed, 26 Oct 2022 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666792449;
        bh=qtJhkpBNI09xyN+fRFiz2dyg8X03xHEV6Ai99KiJV2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnfwyRUSZErm+pvgMwTNddfTWovLzhr1Oh8B35+Dabsp1Yg4o6DX7PCJYh1l5DQ7p
         0GwS/I8io1kir1Cnlkrf01C/fG/tl6Kz1X/6Gv/uVUj47oHrB95v7JUqX89LKHfcTx
         lDUpBN+JKgKfi4Vy5O+ssXCkdX76BkNKoiqzUtwQ=
Date:   Wed, 26 Oct 2022 15:55:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192u: remove unused macro definition
Message-ID: <Y1k8NWuTxOf6z5zL@kroah.com>
References: <cover.1666754500.git.drv@mailo.com>
 <b7053d8737c048d6a878609f0ec24d66b18c5abd.1666754500.git.drv@mailo.com>
 <Y1kyr/hWqbKCzaaR@kroah.com>
 <Y1k5y5PVT6t0+OIS@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1k5y5PVT6t0+OIS@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:14:43PM +0530, Deepak R Varma wrote:
> On Wed, Oct 26, 2022 at 03:14:23PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 26, 2022 at 08:58:44AM +0530, Deepak R Varma wrote:
> > > Pre-processor macros that are defined but are never used should be
> > > cleaned up to avoid unexpected usage.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > index 00c07455cbb3..0b3dda59d7c0 100644
> > > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > @@ -230,8 +230,6 @@ struct cb_desc {
> > >  #define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
> > >  #define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl
> > >
> > > -#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
> > > -
> > >  #define free_ieee80211			free_ieee80211_rsl
> > >  #define alloc_ieee80211			alloc_ieee80211_rsl
> >
> > These #defines are a mess, please look into unwinding them as they
> > should not be needed at all.
> 
> Hello Greg,
> I would like to know what you mean by "unwind them". Is there a documentation or past
> commit that I can review to understand the expectations better?

Look at them and try to figure out why they are there, and then work to
remove them entirely.  A define like this is very odd in the kernel, it
should not be needed at all, right?

thanks,

greg k-h
