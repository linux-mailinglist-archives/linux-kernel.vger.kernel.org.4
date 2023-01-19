Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC38B674C68
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjATFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjATF2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA76F30F;
        Thu, 19 Jan 2023 21:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 694C1B8253F;
        Thu, 19 Jan 2023 15:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C25C433F0;
        Thu, 19 Jan 2023 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674141266;
        bh=KByIy1N1vj4CdqmgezrljbyOU02A64Fc2TZq8HcGIZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfRYYOLTiNZsG4JqSKVVaQTf8dHEsTYGASqmmiTHEw6jG+5IFhBclAYcP5LpjB/3M
         lA5xpV3SHIquMIrAgg5hNdxDvLVgVo68+SnIcK5DP7RZoH5Lp2M7PR2F4u69Kmw343
         tKh501dxrNf29DOQqAR8W7qx3cNzNVc7oIGH4Q68=
Date:   Thu, 19 Jan 2023 16:14:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <Y8leT6LXyy20eyyh@kroah.com>
References: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
 <Y8lBczJAXR4Hjl93@kroah.com>
 <Y8lVmOL5T2EUVkgr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lVmOL5T2EUVkgr@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:37:12PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 02:11:15PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 18, 2023 at 10:04:19AM +0200, Andy Shevchenko wrote:
> > > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > > object evaluated by _DSM call. Use it instead of open coded variant.
> 
> ...
> 
> > Fails to apply to my tree :(
> 
> It seems it's against usb-linus as Mathias' original patch is there.

Ah, then that can wait until it merges into my usb-next branch.  Can you
resend it in a week or so when that happens?

thanks,

greg k-h
