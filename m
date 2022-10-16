Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC75FFDD9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJPH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJPH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 03:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C433ED51;
        Sun, 16 Oct 2022 00:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AF060ABA;
        Sun, 16 Oct 2022 07:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39864C433D6;
        Sun, 16 Oct 2022 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665905191;
        bh=YCdlx6AiUm0pIpFrg26HyxiJH+NARVtCCkOPp3vrGzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGCK4e7PAjvO3prkLwiPFfZzacIeLuXF8Zl7imVOsOm7LL3oMZmKzpN1KTqUKZiKd
         a7d0h05uvDUPzDJBAOZltSxQg7gYMfGJiQOQ5RUbqemMaf/YzuSXj+QfMeqskPcJat
         +9ABdYFai0SljIWFkvgMsPdywxAC+HuL5Q7UxcIY=
Date:   Sun, 16 Oct 2022 09:27:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, axboe@kernel.dk, beldzhang@gmail.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring/rw: fix unexpected link breakage" has been added
 to the 5.15-stable tree
Message-ID: <Y0uyVhuymJsCcUHe@kroah.com>
References: <166590419616064@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166590419616064@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:09:56AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring/rw: fix unexpected link breakage
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-rw-fix-unexpected-link-breakage.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, nope, breaks the 5.15, 5.10, and 5.4 builds, dropped from there
now.

greg k-h
