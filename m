Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C1645E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLGQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLGQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:21:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9D63BA8;
        Wed,  7 Dec 2022 08:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E21A9CE1AFE;
        Wed,  7 Dec 2022 16:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD664C433D6;
        Wed,  7 Dec 2022 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670430093;
        bh=s4iNW1BXaJMNrUnKhvJnvr0PTKnv+uB2S+yk+zRRPVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDTYwUf0l8RUN5UsR6LWhgmgzQ+hN+5Etm0RYGxJBwwGMHKXnuyuzgEv46oWhIuUc
         ovk6GSFes0zuv8Su5yCFKhLrZexSErmFAORuSLo/YUJ7awkqaq/tBmu6KxZU/zasvR
         jhMBu8YFhYzlgTS/4bkIPgv3bKcBITKdlxibHMmU=
Date:   Wed, 7 Dec 2022 17:21:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix documentation for
 fwnode_get_next_parent()
Message-ID: <Y5C9ihcdY7ujcFzx@kroah.com>
References: <20221207112219.2652411-1-linmq006@gmail.com>
 <Y5CFVHL0xTeWbKfU@paasikivi.fi.intel.com>
 <CAJZ5v0hWhY5ZG+jYR8BfxTfwgwYKkOP33K4+Qc7FJeMheQQcEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWhY5ZG+jYR8BfxTfwgwYKkOP33K4+Qc7FJeMheQQcEA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:30:43PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 7, 2022 at 1:21 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > On Wed, Dec 07, 2022 at 03:22:18PM +0400, Miaoqian Lin wrote:
> > > Use fwnode_handle_put() on the node pointer to release the refcount.
> > > Change fwnode_handle_node() to fwnode_handle_put().
> > >
> > > Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
> > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >
> > Thanks!
> >
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> So I'm assuming that Greg will pick up this one or please let me know otherwise.

I'll grab it now, thanks.

greg k-h
