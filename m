Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8C6B27B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCIOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjCIOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C6F4019;
        Thu,  9 Mar 2023 06:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68B98B81F6D;
        Thu,  9 Mar 2023 14:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE665C433EF;
        Thu,  9 Mar 2023 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678373169;
        bh=c1E4ThECUKxHP23yQsQHZm3CcpLsIFmHnS3tNZHvv7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZXa0Jn3FK2xYWQiRqUGKmF6SMvDqiQe6L1RMHrjdY85X9boTFeBXnEIO43UPIYoj
         MSIjuGHOQy2Zccg87zOWJ70PftYtEZaVxZq9nQr6XTsSeseLILflP0SSluctdls0uR
         UuZj2mqViBjdYW7xfQhPCYPjWcvLKP41kihJPopE=
Date:   Thu, 9 Mar 2023 15:46:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description of returned
 value in some functions
Message-ID: <ZAnxLj7I7RlWlLuC@kroah.com>
References: <20230217133344.79278-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jV_Z04zWGuKoiXR4cMovVW8DRyfdYbcwUV30M12Z0shQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jV_Z04zWGuKoiXR4cMovVW8DRyfdYbcwUV30M12Z0shQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 08:16:15PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 17, 2023 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Some of the functions do not provide Return: section on absence of which
> > kernel-doc complains. Besides that several functions return the fwnode
> > handle with incremented reference count. Add a respective note to make sure
> > that the caller decrements it when it's not needed anymore.
> >
> > While at it, unify the style of the Return: sections.
> >
> > Reported-by: Daniel Kaehn <kaehndan@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> or please let me know if I need to pick it up.

I can take it, thanks.

greg k-h
