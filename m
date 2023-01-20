Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCE674E18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjATH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:27:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A085359;
        Thu, 19 Jan 2023 23:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4A8B81FBA;
        Fri, 20 Jan 2023 07:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB496C433D2;
        Fri, 20 Jan 2023 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199625;
        bh=SXvVC1TWuqjHbriWiGDYFys5n1XX5jAMZePJarDSq6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDUOiPBAVreLpJxY8MFVQkL3ZVg1PJbjQg+MVeIc54t543eJVKrntwqG+25UVFsHz
         riUE4HwZabNWtMYX1P+sqmigrdK/tN+MQ8nqYoLQV8+/kRiQOJlbV8oAnO+1IdoT7k
         uOHodS41X/2b57iJWowXG7PWe/VlMMpJ8Dw2CSfw=
Date:   Fri, 20 Jan 2023 08:27:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] pktcdvd: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y8pCRv7MYrdrmr3j@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:03AM +0200, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/pktcdvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
