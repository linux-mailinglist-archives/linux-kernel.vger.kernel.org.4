Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D379E698D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBPGsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPGsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:48:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA79F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:48:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC32261E7B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A8C433D2;
        Thu, 16 Feb 2023 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676530090;
        bh=Y5D/nUl7e2/BDf0WOWGuemZZ+X+zv0TO1LnsgWDMiKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wuq5Hn/g45XpZ1WVKDlezEvWTc/CbfqACSKufUdcy973hBHB6uG7kyJgTjOEJ4TwP
         L59sZHCZg26034fDw0DPLCtDdmAPY7gzZCctQ9v3GTcWkRzLVKwbQgbby7l1Q5iIZ9
         z4ltTIqtoOku2r86HBhzhotqJwy1q3Teo40gFJHI=
Date:   Thu, 16 Feb 2023 07:48:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Michael Thalmeier <michael.thalmeier@hale.at>,
        Petr Mladek <pmladek@suse.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
Message-ID: <Y+3RpyiYLzU2Ocw4@kroah.com>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com>
 <Y+ztReOGJwAbpv52@alley>
 <1831554214.546921.1676479103702.JavaMail.zimbra@hale.at>
 <878rgy37f5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rgy37f5.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:17:58PM +0106, John Ogness wrote:
> On 2023-02-15, Michael Thalmeier <michael.thalmeier@hale.at> wrote:
> > You are right. I have encountered this problem with the RT-patchset.
> > We currently are using the latest v5.15-rt kernel which had this
> > problem.
> 
> The 5.15-rt kernel is based on an implementation of printk that has
> since been abandoned. I will provide a patch for 5.15-rt to fix this
> issue.

Ok, I'll drop this patch from my review queue as it's not needed in
mainline.

thanks,

greg k-h
