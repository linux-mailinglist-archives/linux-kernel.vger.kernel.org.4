Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA90169AAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBQLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBQLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:55:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374565368;
        Fri, 17 Feb 2023 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676634948; x=1708170948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvKLjPw57vtYaQ5DHnkEkh8qut8RHFj2SAOHnL8By7Q=;
  b=HKdi28nL7UEFgHwszxKz98pMAR/UD3A9PJj3y3JqaJEPQXmt5xVeCDz7
   xqlor/T3zAS/esD8chX71AH1DuoR5wuDNvoqZivPLp99a0HK4SNiNRR+g
   w+8a3MN3/sYibvSdvPPTuVt28UfpzwDnza/vum1kD989Jrj4y8YQK190u
   PNUTLv6cI9HQ3+JuPkRr8M/6AeWY5BC3m6d2Ls5keX54DPwvnmWjW1F5N
   oZpzixp4/HNhK46Zm5CUjjZz0OpHnGU8VOzN6OCzElCfIi4rqq5F9kX+C
   hOORocyEtVkd6+fNDAcxqKEccSdfTe0zG1mEnJRex8EGI7UbqoXplhhrs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396645451"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="396645451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="739239446"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="739239446"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2023 03:55:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSzL5-008BpC-1Q;
        Fri, 17 Feb 2023 13:55:43 +0200
Date:   Fri, 17 Feb 2023 13:55:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description on returned
 value in some functions
Message-ID: <Y+9rPzw9orlqYkIx@smile.fi.intel.com>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
 <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
 <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
 <Y+9k9wkRgE1JOsr0@smile.fi.intel.com>
 <Y+9omTMIzAxWM2by@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9omTMIzAxWM2by@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:44:25PM +0200, Sakari Ailus wrote:
> On Fri, Feb 17, 2023 at 01:28:55PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 17, 2023 at 01:18:31PM +0200, Sakari Ailus wrote:
> > > On Fri, Feb 17, 2023 at 01:01:39PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> > > > > On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:

...

> > > > > >   * fwnode_get_next_child_node - Return the next child node handle for a node
> > > > > >   * @fwnode: Firmware node to find the next child node for.
> > > > > >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > > > > > + *
> > > > > > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > > > > > + * pointer.
> > > > > 
> > > > > The loop itself will also put the child node, so this is only relevant
> > > > > outside the loop.
> > > > 
> > > > Yes and this is exactly what people stumbled over. Hence this note.
> > > > This call per se doesn't loop, so I didn't get how your comment can
> > > > be transformed to anything here. Care to elaborate a bit more on
> > > > what I have to add here or reword?
> > > 
> > > Ah, indeed. This is achieved by putting the previous child. Generally this
> > > function is used via the loop helper macro and not called directly, hence
> > > the documentation there matters the most. Those functions appear to be
> > > without any documentation though.
> > 
> > So, what should I do?
> 
> Good question.
> 
> How about this text:
> 
> The caller is responsible for calling fwnode_handle_put() put on the
> returned fwnode. Note that this function also puts a reference to @child
> unconditionally.

Fine. Does it mean I have to change existing wording of the first sentence
everywhere?

> This is actually done by the firmware specific implementation, namely on OF
> and at least should be done on swnode.

Yes, that's. But it's not needed to be added.

> A second patch to document the fwnode iterator macros would be nice.

Not the reported problem. Maybe someone else can do the job?

-- 
With Best Regards,
Andy Shevchenko


