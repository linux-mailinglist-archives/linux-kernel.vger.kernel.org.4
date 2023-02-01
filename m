Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE811685E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBAEsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjBAEsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:48:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DAD15CB6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A016098A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E90C4339C;
        Wed,  1 Feb 2023 04:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675226888;
        bh=sTFC2ZLtv3eoBLzmMQaU6y38LRDLS1xPck1j1IfGfMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wr7Qivg9yZ5XKBgml4ynB9HEtrxB9l7DVmpCVO/uIVp8g7I/EO6rGPh3BinbgYrYn
         a1dIjfkjHSbwLbhuJ4GVXS8cWWYnM9aK//kcWBLtJJR4UJdhe4L5sRXFgYMlvTvkb4
         uR4foF7Mldgw1+PxRGg+5QUMUH1Ba3XuZz4suTzQ=
Date:   Wed, 1 Feb 2023 05:48:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] Remove a number of duplicate includes
Message-ID: <Y9nvBbGcwZkQbOGN@kroah.com>
References: <52d6ec2f-417c-8bc5-ed35-72229fc8d7a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d6ec2f-417c-8bc5-ed35-72229fc8d7a0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:27:23PM +0100, Jesper Juhl wrote:
> > From 09d653f07a8bbb2aea52b735a731ca781f5f401c Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Thu, 26 Jan 2023 02:16:59 +0100
> Subject: [PATCH] Remove a number of duplicate includes

Why is this in the body of the changelog?


> 
> Including the same header multiple times when there's no functional reason
> to do so is just pointless clutter and potentially slows down builds.
> 
> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
> ---
>  drivers/base/node.c                     | 1 -
>  drivers/bus/bt1-apb.c                   | 1 -
>  drivers/char/hw_random/core.c           | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
>  drivers/gpu/drm/drm_gem_shmem_helper.c  | 1 -
>  fs/fscache/io.c                         | 1 -
>  fs/overlayfs/inode.c                    | 1 -
>  kernel/sched/build_utility.c            | 1 -
>  kernel/sched/core.c                     | 3 ---
>  kernel/sched/fair.c                     | 2 --
>  10 files changed, 13 deletions(-)

Please properly split this up into subsystem-related patches and send
them that way.

thanks,

greg k-h
