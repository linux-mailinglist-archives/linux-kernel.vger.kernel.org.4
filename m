Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC85F9852
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJJGZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJJGZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F824BCE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C48160E00
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209F6C433C1;
        Mon, 10 Oct 2022 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665383125;
        bh=Bq01zH3+U+EuA/w4xnrJi13JAnBK8qFa7KvKJB2s56Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fa68Hn5GBfEaHbXvSPK6tKJCl9Hl9C5f+21FGUXUcHO46MMTnkAk/czg0HfiaOAkG
         p3k9vJxjbDQH4TDtWvYisjH0rMdS94y1TsbWCqbjbpx3GoccQ4uu4KGF0fyqw1OvEF
         6SQ5CwXI2lj+1czzghCl85WLUZzIZCAXHYjz0UoQ=
Date:   Mon, 10 Oct 2022 08:26:08 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Daniel Scally' <djrscally@gmail.com>,
        'Heikki Krogerus' <heikki.krogerus@linux.intel.com>,
        'Sakari Ailus' <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Case-insensitive match_string and
 fwnode_is_compatible()
Message-ID: <Y0O7AOUgCbjPYOAt@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
 <Y0MRxgKhRVbyrTz2@kroah.com>
 <1BF643A9A697B323+1bc601d8dc55$65ae1cf0$310a56d0$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BF643A9A697B323+1bc601d8dc55$65ae1cf0$310a56d0$@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:07:13AM +0800, Soha Jin wrote:
> Hi Greg,
> 
> > 
> > On Mon, Oct 10, 2022 at 12:21:52AM +0800, Soha Jin wrote:
> > > I am introducing these patches for the patch for ethernet driver which
> > > I will send later.
> > 
> > We can't take functions that have no real users.  Please send these patches
> > as part of your driver submission so we can see how they are used and if they
> > are even needed at all.
> > 
> 
> This is the first time I submit patches to kernel, I am sorry for anything
> wrong I did.
> 
> I am just thinking these patches and the driver patches are in different
> trees, so I split the patches into different parts. The driver patch is at
> https://lore.kernel.org/all/20221009162247.1336-1-soha@lohu.info/.

As you can see, the kernel test robot reported that these changes are
broken as it does not know about this separate series you submitted.

Please make them all one series so we can properly review them together
and the testing infrastructure can correctly run.

thanks,

greg k-h
