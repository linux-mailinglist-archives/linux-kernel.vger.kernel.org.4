Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12855EC9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiI0QtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiI0Qsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37E33A12;
        Tue, 27 Sep 2022 09:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA72F6126D;
        Tue, 27 Sep 2022 16:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C955BC433D6;
        Tue, 27 Sep 2022 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664297324;
        bh=IOZcbjA9Lg63FB6UEPbdUOWfb/1T2ALWEz6B3RQsLe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObHVf+50D//o8xHkysOWtvykIZDiBU5zkzbdJHrNJAncaP9lJWia6AafdmwZVH8vQ
         9VZRSQCd1wKHDv9w02lWOSp+ZDaJmUOlCXonLNm47RRLBVHgmTB8GJIyX9Mcr0itEJ
         T3XFAr7ldvxWhyPmLuiq3hdhglnP8tMpRNYrJXmA=
Date:   Tue, 27 Sep 2022 18:48:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add wake on connect/disconnect on USB4 ports
Message-ID: <YzMpaa1V492X52/J@kroah.com>
References: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:30:05PM +0530, Rajat Khandelwal wrote:
> Wake on connect/disconnect is only supported while runtime suspend
> for now, which is obviously necessary. Its also not inherently
> desired for the system to wakeup on thunderbolt hot events.
> However, we can still make user in control of waking up the system
> in the events of hot plug/unplug.
> This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> attribute and only enables wakes on connect/disconnect to the
> respective port when 'wakeup' is set to 'enabled'. The attribute
> is set to 'disabled' by default.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>

Including the issue pointed out below by my bot, Intel has a "special"
requirement that you are not meeting here in order to send out patches
for review on a public mailing list in a subsystem like this (i.e. one
that I and others review patches on.)

Please meet that requirement first before sending any future kernel
patches out.

> ---
> 
>  drivers/thunderbolt/tb_regs.h   |  2 ++
>  drivers/thunderbolt/usb4.c      | 33 +++++++++++++++++++++++++--------
>  drivers/thunderbolt/usb4_port.c |  3 +++
>  3 files changed, 30 insertions(+), 8 deletions(-)

> 
Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
