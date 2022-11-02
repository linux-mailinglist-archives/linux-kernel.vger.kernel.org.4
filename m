Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B0616147
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKBKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKBKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:55:15 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66123BD8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667386501; bh=4H2YZFcQCuh1V5EtkYNJDyoz6e2tddNTkXLefVjinf4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=MyrR87fQ4sUtSoTF4ZQdrqKXQE7wszWdOK7Wm6fpMJl0j+CGsvF88XEYH/VD5Nn0n
         HRyu+k+ep+IgZuj4+rUsiAeT6l4nVaaTKpypfOFMmDtJ6vY5bl9B3RgBB8E3EvKMz+
         mLQf0bqLd2Kc9sghvRPtlabDmNp2ipKXKo39Hi+A=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Wed,  2 Nov 2022 11:55:01 +0100 (CET)
X-EA-Auth: 7JRskj5N/SPhHbQd4gvDUdxv6rhPeoIA2ZLYHn2/h8Hk/nOOlvQw6py10lNwy4gm+6nxuzA8tqmOyhR6qAIbcjU9K2T7X7HR
Date:   Wed, 2 Nov 2022 16:24:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: rtl8192u: unused code cleanup
Message-ID: <Y2JMgdAzOS25qQuA@lion2204>
References: <cover.1667237959.git.drv@mailo.com>
 <Y2Ib7FjwfqbcZ77h@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Ib7FjwfqbcZ77h@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:27:40AM +0100, Greg KH wrote:
> On Mon, Oct 31, 2022 at 11:25:14PM +0530, Deepak R Varma wrote:
> > Remove unnecessary or unused code.
> >
> > Changes in v2:
> >    Patch1:
> >       1. Revise patch log to explain impact of the patch
> >          Suggested by gregkh@linuxfoundation.org
> >    Patch2:
> >       1. Review other similar macro defines and clean those up as well.
> >          Suggested by gregkh@linuxfoundation.org
> >       2. Revise patch log to explain impact of the patch
> >          Suggested by julia.lawall@inria.fr
> >
> > Deepak R Varma (2):
> >   staging: rtl8192u: remove unnecessary function implementation
> >   staging: rtl8192u: remove redundant macro definition
> >
> >  .../staging/rtl8192u/ieee80211/ieee80211.h    | 67 -------------------
> >  .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  6 --
> >  .../rtl8192u/ieee80211/ieee80211_module.c     |  3 -
> >  3 files changed, 76 deletions(-)
>
> This series causes a build breakage:
>
>   MODPOST Module.symvers
> ../ERROR: modpost: net/mac80211/mac80211: 'ieee80211_wake_queue' exported twice. Previous export was in drivers/staging/rtl8192u/r8192u_usb.ko
> ERROR: modpost: net/mac80211/mac80211: 'ieee80211_stop_queue' exported twice. Previous export was in drivers/staging/rtl8192u/r8192u_usb.ko
> make[1]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
> make: *** [Makefile:1944: modpost] Error 2
>
> Always test build your changes.

My apologies. I did a limited driver specific build but did not run a full make.
I understand that the EXPORT_SYMBOL is across the kernel and I should have run a
full build.

I have made the corrections and now running a full build. I will send a revision
shortly.

Sorry for the trouble.

./drv



>
> greg k-h
>


