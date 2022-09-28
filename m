Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5442F5ED472
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiI1GDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1GDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6B8A1E9;
        Tue, 27 Sep 2022 23:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB44361D0F;
        Wed, 28 Sep 2022 06:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C60C433C1;
        Wed, 28 Sep 2022 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664344988;
        bh=j4kB7olgilPfVNlMOTcYqlCkkxFG3t3S85ulNHUvZP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn7ZWTGY7fOq6xb+VeCBijrCoFESpcFclyxcRUwLygW8gm9mVj2nXppPWFn2Exmbn
         /pd8DOZIoxFFuNBYOZMcRZLwG0bRdKCE1JZfGppbUAneJ/Hl5VTJznT3G9j2Zw9FIL
         hJZXEyABqtjCm5anV6lJwaTtyEawOosGxzs0DQk0=
Date:   Wed, 28 Sep 2022 08:03:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add wake on connect/disconnect on USB4 ports
Message-ID: <YzPjvo8pkAmO2rra@kroah.com>
References: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
 <YzMpaa1V492X52/J@kroah.com>
 <YzPVDzI4K4cbG7Mk@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPVDzI4K4cbG7Mk@black.fi.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:01:03AM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> On Tue, Sep 27, 2022 at 06:48:41PM +0200, Greg KH wrote:
> > On Wed, Sep 28, 2022 at 06:30:05PM +0530, Rajat Khandelwal wrote:
> > > Wake on connect/disconnect is only supported while runtime suspend
> > > for now, which is obviously necessary. Its also not inherently
> > > desired for the system to wakeup on thunderbolt hot events.
> > > However, we can still make user in control of waking up the system
> > > in the events of hot plug/unplug.
> > > This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> > > attribute and only enables wakes on connect/disconnect to the
> > > respective port when 'wakeup' is set to 'enabled'. The attribute
> > > is set to 'disabled' by default.
> > > 
> > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> > 
> > Including the issue pointed out below by my bot, Intel has a "special"
> > requirement that you are not meeting here in order to send out patches
> > for review on a public mailing list in a subsystem like this (i.e. one
> > that I and others review patches on.)
> > 
> > Please meet that requirement first before sending any future kernel
> > patches out.
> 
> I asked Khandelwal to send this patch upstream after we did an internal
> review for it (I think I also asked him to send this out after v6.1-rc1
> is released but whatever).

So the correct rules were not followed, please fix that :(

> I think the bot noticed the v4 he sent earlier that was the same we
> reviewed internally.

Again, yes, this was sent incorrectly.

> I was planning to pick this up after the merge window closes if there
> are no objections.

I'm objecting :)

thanks,

greg k-h
