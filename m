Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910695BEC79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiITSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:02:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AC481F3;
        Tue, 20 Sep 2022 11:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DABA1B80B43;
        Tue, 20 Sep 2022 18:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427BDC433D6;
        Tue, 20 Sep 2022 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663696940;
        bh=xcqNefFPU+MnGuvyj1R3YpL88Z7VQcYAWD2sPQ5jKFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBi8F0GsFhEjy3+m0qbXzHfknDixP5l4wLemltqJOJztTCZJvOMtXNTyl0kCQ0M+O
         AH27UcQc+NDDVkknVIdxH/Wxi854oqoivSj2VGRP5PQey0DinZu0eGy4PlYkP2GGSO
         ps5E7T3q4EJKxT6pt3A8BNp9MOIdOiiMFYRY6X8k=
Date:   Tue, 20 Sep 2022 20:02:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, stern@rowland.harvard.edu,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: Patch "USB: gadget: Fix use-after-free Read in usb_udc_uevent()"
 has been added to the 5.15-stable tree
Message-ID: <YyoAKjEF5axLtGaW@kroah.com>
References: <20220918232130.6926-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918232130.6926-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 07:21:29PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     USB: gadget: Fix use-after-free Read in usb_udc_uevent()
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      usb-gadget-fix-use-after-free-read-in-usb_udc_uevent.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

As mentioned many times in the past, this does not belong in any kernels
older than 5.19, so I have dropped it again.

thanks,

greg k-h
