Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9880647097
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLHNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiLHNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:15:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427198E5B2;
        Thu,  8 Dec 2022 05:15:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEDB9B823C9;
        Thu,  8 Dec 2022 13:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C58C433C1;
        Thu,  8 Dec 2022 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670505297;
        bh=glSCtV+QzoCCztEb8hKzqZvn/Kmi//N93WanQimJ3rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAwqHfgMtkZyHyvjY/V2PP92GiVHFAxUQ7AfeBuSj2egHNczQ63uPStxjudUu/19G
         iUO41j6S9tvKd6wB2+l2kEQOY1mH8qlOHgmC+MPr8+X0+cdrOKq94DDdWV4lGraL3p
         LX4/TT3k/jY5ZPbxpqpUXk0oy6EdKm9cVysL2+dM=
Date:   Thu, 8 Dec 2022 14:14:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v5 1/4] i915: Move list_count() to list.h as
 list_count_nodes() for broader use
Message-ID: <Y5HjTpzmgZWft+nF@kroah.com>
References: <20221130134838.23805-1-andriy.shevchenko@linux.intel.com>
 <Y5HelZhkxnPf6hIs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5HelZhkxnPf6hIs@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 02:54:45PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 30, 2022 at 03:48:35PM +0200, Andy Shevchenko wrote:
> > Some of the existing users, and definitely will be new ones, want to
> > count existing nodes in the list. Provide a generic API for that by
> > moving code from i915 to list.h.
> 
> Greg, I believe this one is ready to be taken. Or please tell me what I need
> to do.

Wait for me to get through the current backlog of patches that I have in
my review queue.  Odds are, it will have to wait until after 6.2-rc1 is
out based on when 6.1 is going to be released.

Don't worry, it's not lost.

thanks,

greg k-h
