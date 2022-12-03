Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F41641735
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLCOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLCOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:09:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785F14D01;
        Sat,  3 Dec 2022 06:09:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2241F60112;
        Sat,  3 Dec 2022 14:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E4EC433D6;
        Sat,  3 Dec 2022 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670076541;
        bh=0VjQfJ8AN1aBvqsDjcLVCbujnXCj2Mj5QWA7ZQ9yXWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03iJOT54xq1m9enm9dg/Uw+L9jPXrvyS9Nrl5uDjfNk7x8YJhDoae2K3oHAPHgGiq
         OzU27Q+z+TovR0z74z0nBDdBH4yjIAVQb+0aXQb8YmKZhGqPka2j5AiuccU9fh9tgw
         d65BA66cUDatzhoZeywvSgS0YLtpRrN6a+x7lLvo=
Date:   Sat, 3 Dec 2022 15:08:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>,
        Peter Osterlund <petero2@telia.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y4tYesUPvx1XX/jR@kroah.com>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <167000975630.934246.12888337558390915330.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167000975630.934246.12888337558390915330.b4-ty@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:35:56PM -0700, Jens Axboe wrote:
> 
> On Fri, 02 Dec 2022 19:27:58 +0100, Greg Kroah-Hartman wrote:
> > Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> > and deprecated") this driver was marked as "will be removed soon".  5
> > years seems long enough to have it stick around after that, so finally
> > remove the thing now.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] pktcdvd: remove driver.
>       commit: f40eb99897af665f11858dd7b56edcb62c3f3c67

Thanks!  I've sent a follow-on to remove the block_device_operations
callback that this driver was the last to use as well.

greg k-h
