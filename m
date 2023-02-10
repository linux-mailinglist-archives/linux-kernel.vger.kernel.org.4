Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1446919E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjBJIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjBJIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F71C59C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2115B61CD5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65ACC433EF;
        Fri, 10 Feb 2023 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676017037;
        bh=8yPM7GWJFYlcg5K9R6mPqdIszHdf2NmhyZnXIpG6Lv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd3BoVhMxEz0LdIUYpU+V9YWb58eezBYmFr21nDZPPdiZvJPTkk+D/29ibgsbIGoS
         towt82Q9HyvnRNzjy97z7P9HBhD7tfGcii5zAwbdELVS5OFokHPP3wl7uqyNZj9T4G
         TWuA3I/GNoAtuRbHs+sKLpyrK39H+6spn/dJ4+Mc=
Date:   Fri, 10 Feb 2023 09:17:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     chenwandun@huawei.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next 0/3] cleanup of devtmpfs_*_node()
Message-ID: <Y+X9irDpjtowQEZr@kroah.com>
References: <Y9t0pqN/1PaUlKoT@kroah.com>
 <20230210073309.4050841-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210073309.4050841-1-xialonglong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 07:33:06AM +0000, Longlong Xia wrote:
> The test steps:
> 1. Set the SElinux label of /dev to user_home_t 
> 2. modprobe zram num_devices=1000
> 
> The above test result is that there is no zram device was found in the 
> /dev. And don't see any errors printed in jouranls/dmesg. Of course, 
> it is rare to create 1000 zram devices, use dev_err may be better.
> 
> Longlong Xia (3):
>   devtmpfs: add debug info to handle()
>   driver core: add error handling for devtmpfs_create_node()
>   devtmpfs: remove return value of devtmpfs_delete_node()
> 
>  drivers/base/base.h     |  4 ++--
>  drivers/base/core.c     |  8 ++++++--
>  drivers/base/devtmpfs.c | 20 ++++++++++++++------
>  3 files changed, 22 insertions(+), 10 deletions(-)
> 
> Best Regards,
> Longlong Xia

This is a v2 series, please mark them as such, saying what changed from
the previous submission.  Otherwise our tools get totally confused and I
can not apply them.

Also just send it as a new thread, don't reply to the old one, there's
no need for making it that complex.

thanks,

greg k-h
