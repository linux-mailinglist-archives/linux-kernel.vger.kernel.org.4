Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58195FDAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJMNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC110547;
        Thu, 13 Oct 2022 06:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A51C56179E;
        Thu, 13 Oct 2022 13:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6661FC433C1;
        Thu, 13 Oct 2022 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665668089;
        bh=XEEFgf7DOL5CNqeLhReMF2fRwLRqY88YOrKX4ca3Ths=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEZDjE6Nf7B+/uQ2fknfr3eBJUcf4x+nEAJxsqUMOsF33/VPjRvx4BIoPo3L3mSbC
         0qcU2UjnapSElBY9gxjAQb1DjZrMuMgczlvHWkXrSyKnDzYRG1HBYg1Rv5iQsAaMLW
         vA4Emqsb8nMlMhe15AUVCOiPpyOOGRL1nOwz7sVc=
Date:   Thu, 13 Oct 2022 15:35:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, guozihua@huawei.com, luto@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, zhongguohua1@huawei.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "random: restore O_NONBLOCK support" has been added to the
 5.4-stable tree
Message-ID: <Y0gUJNT6qLYMD2//@kroah.com>
References: <1665667389132166@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665667389132166@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:23:09PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     random: restore O_NONBLOCK support
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      random-restore-o_nonblock-support.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Oops, no, this breaks the build for 5.4.y and older so I'll go drop it
from all of those branches.

greg k-h
