Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6E5FD6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJMJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJMJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:23:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFDFA002;
        Thu, 13 Oct 2022 02:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AB4FB81D42;
        Thu, 13 Oct 2022 09:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C09C433D6;
        Thu, 13 Oct 2022 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665653002;
        bh=Jb1NtzIh2PpVxI3wpSmpifBpkZW7FOPoL1NsPPY0jmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bv+X4DMFK5RBEC1hBSveaV7TJ3UnjK3ZtQQi1dcH6PUOxvM5VtPmmaEW7E8v+EeSe
         60DD3RTsMPacao+9nLWZDAyEVSEcOWz2UoTx1LlVfxKNCAMkGr5LsQX7/8GclmyUDG
         0L3CkQlAvuovtnaUIEpGtxYWIraZV0mIrc7j9G4c=
Date:   Thu, 13 Oct 2022 11:24:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     chao@kernel.org, hj514.kim@samsung.com, jaegeuk@kernel.org,
        lvgaofei@oppo.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: invalidate META_MAPPING before IPU/DIO write" has
 been added to the 5.15-stable tree
Message-ID: <Y0fZNkHS8uH15To1@kroah.com>
References: <166565256518214@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166565256518214@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:16:05AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: invalidate META_MAPPING before IPU/DIO write
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Nope, nevermind, this is broken for these trees, all now dropped.

greg k-h
