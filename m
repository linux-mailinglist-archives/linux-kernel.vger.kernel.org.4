Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C87675303
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjATLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjATLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AEB4E1F;
        Fri, 20 Jan 2023 03:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB6461EF6;
        Fri, 20 Jan 2023 11:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99727C4339B;
        Fri, 20 Jan 2023 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674212816;
        bh=tVbn5JTds4p/qo8OX0AbDwPKZh0p5F1FTdIi8kiCORU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8cX2WzMxlEiCDtXKxnN12H8MDcaO/Jr+QZle8Vd0pv46SWWV8BYOfEdjeEZaP1mv
         rpfjm2gPDnIUG48112bjER7jAdRjKDYVVFKNy9J9glWVjuYzjJLD804deNDh+74mOL
         nbGEW4GQOIwmEdxu/oB6AtusbzOcFIGv6Vd4VBdc=
Date:   Fri, 20 Jan 2023 12:06:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH v10 3/3] crypto: hisilicon/qm - define the device
 isolation strategy
Message-ID: <Y8p1zdHjYZ+Gqeh0@kroah.com>
References: <20221119074817.12063-1-yekai13@huawei.com>
 <20221119074817.12063-4-yekai13@huawei.com>
 <Y5V1zaurC8TuuA6l@gondor.apana.org.au>
 <e1bb7612-2763-5a00-0e53-bad22fa167cf@huawei.com>
 <9e3aa5d6-951c-afcd-5544-2056d63a087a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3aa5d6-951c-afcd-5544-2056d63a087a@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:13:50AM +0800, yekai (A) wrote:
> 
> 
> On 2023/1/12 17:26, yekai (A) wrote:
> >
> >
> >
> > On 2022/12/11 14:16, Herbert Xu wrote:
> >> On Sat, Nov 19, 2022 at 07:48:17AM +0000, Kai Ye wrote:
> >>> Define the device isolation strategy by the device driver. The
> >>> user configures a hardware error threshold value by uacce interface.
> >>> If the number of hardware errors exceeds the value of setting error
> >>> threshold in one hour. The device will not be available in user space.
> >>> The VF device use the PF device isolation strategy. All the hardware
> >>> errors are processed by PF driver.
> >>>
> >>> Signed-off-by: Kai Ye <yekai13@huawei.com>
> >>> ---
> >>>  drivers/crypto/hisilicon/qm.c | 169 +++++++++++++++++++++++++++++++---
> >>>  include/linux/hisi_acc_qm.h   |  15 +++
> >>>  2 files changed, 169 insertions(+), 15 deletions(-)
> >> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> > Hi Greg KH
> >
> >  
> >
> > Could you help me to apply this patchset v10?
> >
> >  
> >
> > thanks
> >
> > Kai
> >
> >
> Hi Greg KH
> 
> Just a friendly ping. 
> Could you help me to apply this patchset v10?  Your prompt reply is much appreciated.

Sorry for the delay, I missed the crypto maintainer's review.  now
queued up.

greg k-h
