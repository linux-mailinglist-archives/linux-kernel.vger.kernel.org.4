Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BC673A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjASNg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjASNgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:36:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217867E6A8;
        Thu, 19 Jan 2023 05:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B125C614C1;
        Thu, 19 Jan 2023 13:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4319C433F2;
        Thu, 19 Jan 2023 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674135364;
        bh=r+aEF8tR83YHD0+G3KraGQL5njNYG4yonFW3TjF0EmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3FCCHLn9ZW7US6RqrnaN+l2IbrjHqzX0cccubFgQ1fzVlRcKE2dLS+kkR/whj/Kk
         f5tkSmFDwULnXe00cTJRMMvvkqgypmi5EKFV49HDcr6tQ/nnM0oz5Zq+BlqXqgM6go
         2oEG7nMFk/GXNer+HWL9+CZMlvKtwp9MnxIc4j2E=
Date:   Thu, 19 Jan 2023 14:36:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Make
 fwnode_graph_for_each_endpoint() consistent
Message-ID: <Y8lHQcrgyNLcXZIK@kroah.com>
References: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gdWWmAj9JMe--wUM+Z=MZLof65hbwHCGGgWknAnw61UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdWWmAj9JMe--wUM+Z=MZLof65hbwHCGGgWknAnw61UQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:55:19PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 17, 2023 at 4:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Make fwnode_graph_for_each_endpoint() consistent with the rest of
> > for_each_*() definitions in the file, i.e. use the form of
> >
> >         for (iter = func(NULL); iter; \
> >              iter = func(iter))
> >
> > as it's done in all the rest of the similar macro definitions.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I think that you need to resend it and CC Greg (who picks up
> device property patches nowadays).

I can grab it from here, thanks.

greg k-h
