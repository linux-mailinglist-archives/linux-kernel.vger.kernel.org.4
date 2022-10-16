Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762E5FFDCD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJPHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJPHUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 03:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5692BB15;
        Sun, 16 Oct 2022 00:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D71460A78;
        Sun, 16 Oct 2022 07:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F67C4347C;
        Sun, 16 Oct 2022 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665904811;
        bh=4jWCuodgB9EVSe0rzJE6Be4AUKitddRxsZijdzxPvMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0elg5866PwIqS4W31SO964BpruEat98MGI7ZLVdemfbGcqQ0YTy1WS66BRP6gFpVI
         ElGA5//I//ZkxLVYue4NbbMPHnGrNgfvmRT2TpTRW2/XYGMeUDpN4+R81eL/tWZvOU
         SzFy+59qxfotCN4EJw6M3pGemoyjwzIDcyZpy69w=
Date:   Sun, 16 Oct 2022 09:20:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, axboe@kernel.dk,
        stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring/net: don't lose partial send_zc on fail" has
 been added to the 6.0-stable tree
Message-ID: <Y0uw2u16BqV93l0i@kroah.com>
References: <166590420820366@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166590420820366@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:10:08AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring/net: don't lose partial send_zc on fail
> 
> to the 6.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-net-don-t-lose-partial-send_zc-on-fail.patch
> and it can be found in the queue-6.0 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Oops, no, it breaks the build on 6.0.y, now dropped.
