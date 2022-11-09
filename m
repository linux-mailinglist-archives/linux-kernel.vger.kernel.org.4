Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234E622C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKINhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKINhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:37:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754E2B629;
        Wed,  9 Nov 2022 05:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D75CA61AA9;
        Wed,  9 Nov 2022 13:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD17DC433D6;
        Wed,  9 Nov 2022 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668001024;
        bh=f/xAPisSsdWyYC6XwiUc5ujSvIiCpdpduXCMm9nkl14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/smpQkObQOV0Ptab+55OvgyBT2RULz8sUW1x/rcNTUB8XtBpv8pBFkQJRNuQBRUA
         I+dy3R3Vd2oxHXvwQPIHS9bUGba4RA2URg5+FylAjk/RNkm8TIjEMsy9PJaHUu52+f
         qZew5XnElQ50T8as62KsfFda1u19X9M/VH99w8es=
Date:   Wed, 9 Nov 2022 14:37:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] resource: Replace printk(KERN_WARNING) by
 pr_warn()
Message-ID: <Y2us/RKHYLMTrje0@kroah.com>
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gxM80EKiiMJKkN6t1CVgf1=6yYA3D4=TfOHVh1chaJuw@mail.gmail.com>
 <Y2uOd+mCwmh4qdm8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2uOd+mCwmh4qdm8@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:26:47PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 09, 2022 at 12:12:03PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 9, 2022 at 11:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Replace printk(KERN_WARNING) by pr_warn().
> > >
> > > While at it, use %pa for the resource_size_t variables.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > This is Greg's stuff I think.
> 
> OK.
> 
> ...
> 
> > > +       resource_size_t end = addr + size - 1;
> > 
> > And this change could be mentioned in the changelog too.
> 
> And it's (indirectly). This is to have a variable to be consistent in the
> print. But I can add more explicit mention.

Please do.
