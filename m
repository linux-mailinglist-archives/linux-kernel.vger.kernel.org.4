Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCB641698
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLCMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:15:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3332B255;
        Sat,  3 Dec 2022 04:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A262B81BEA;
        Sat,  3 Dec 2022 12:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAA2C433C1;
        Sat,  3 Dec 2022 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670069747;
        bh=FA/FXwkV3yMNIZNWRRooladDMk/8jvBZ9yNQ26r2y30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9qtJzyMeu6TWO8GaBUDPEkOkSfuyFWWUtes5iPKfxsr2PcVT7UuAdNac6PQV3OFg
         A6ZEwYnUzPKTdRjceF3dr8ODjJW3FLDxAx557Yx46L0cgcC7e8zxb3GvX1ZDACnQkk
         yMnfAGGQqdRwmsY3Pfa1sVoUjeA3LTu8MBNgxcNg=
Date:   Sat, 3 Dec 2022 13:15:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     arun.r.murthy@intel.com, tvrtko.ursulin@intel.com,
        ville.syrjala@linux.intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "drm/i915: Remove non-existent pipes from bigjoiner pipe
 mask" has been added to the 6.0-stable tree
Message-ID: <Y4s98APBEmpaAKZd@kroah.com>
References: <1670066627221113@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670066627221113@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:23:47PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     drm/i915: Remove non-existent pipes from bigjoiner pipe mask
> 
> to the 6.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-i915-remove-non-existent-pipes-from-bigjoiner-pipe-mask.patch
> and it can be found in the queue-6.0 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nope, this breaks the build, now dropped.
