Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA103687793
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBBIe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjBBIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:34:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199986EA9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:33:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DB8619B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ABFC433D2;
        Thu,  2 Feb 2023 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675326838;
        bh=xBMp1O9N/F7RyeQsYOUc+GkIYLasNOIQKN7ooKC5xX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsO9wa/d7H6GTZdQ/QqgP/MYd1IQCoxVSRHI1+XogRpFzO2iWVSDPWhK0zixZQPZh
         fir+Sk23YjYw/3khTPhqZLEMYvYVFjDM+9+CtFe50X3jGadiAcSJxAjDZv6QmCEKKA
         3p0Nq7JjVmtWw5PzU/w+AoIHmEKRRer1/SWDfzg8=
Date:   Thu, 2 Feb 2023 09:33:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH -next 1/3] devtmpfs: convert to pr_fmt
Message-ID: <Y9t1c7v+bq80lhl9@kroah.com>
References: <20230202033203.1239239-1-xialonglong1@huawei.com>
 <20230202033203.1239239-2-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202033203.1239239-2-xialonglong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:32:01AM +0000, Longlong Xia wrote:
> Use the pr_fmt() macro to prefix all the output with "devtmpfs: ".
> while at it, convert printk(<LEVEL>) to pr_<level>().
> 
> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> ---
>  drivers/base/devtmpfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Nice!

I'll take this one now, the other two I've sent review comments on
already.  Please fix them up and resend them and I'll be glad to
consider taking them.

thanks,

greg k-h
