Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583665FFDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJPHW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJPHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 03:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588C2FC0E;
        Sun, 16 Oct 2022 00:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 393BEB803F1;
        Sun, 16 Oct 2022 07:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C91C433D6;
        Sun, 16 Oct 2022 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665904970;
        bh=qiPtOO2f2gQmiHa0lBO6NlfdSz+qVnU9j5M32L75XxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glFq0qzMqu2P6AmI/8zX8qwAGxIgQoM3oRtRqQZcYiJM1c3QJHSX04cOI1mZqJS0y
         Ha45r1pCeqk81y8AKvf4cydGlLw7X8eTBxItQfAL+eom35zXI2kvmfoyoxCMEMhqmh
         1GlbYrbcsdmr/4U37jxmu8NXMbzSakuRNLEpOUX4=
Date:   Sun, 16 Oct 2022 09:23:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     aidansun05@gmail.com, axboe@kernel.dk,
        stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring/net: handle -EINPROGRESS correct for
 IORING_OP_CONNECT" has been added to the 5.19-stable tree
Message-ID: <Y0uxeGcXYv5gjY7k@kroah.com>
References: <1665904202128147@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665904202128147@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:10:02AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring/net: handle -EINPROGRESS correct for IORING_OP_CONNECT
> 
> to the 5.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-net-handle-einprogress-correct-for-ioring_op_connect.patch
> and it can be found in the queue-5.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nope, breaks the build in 5.19.y, now dropped.
