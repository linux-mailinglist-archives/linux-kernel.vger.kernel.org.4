Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00769A993
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBQLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQLBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:01:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D145E58C;
        Fri, 17 Feb 2023 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676631704; x=1708167704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IK0jg8/ege2d89PKUbnoI/GAsL+o8k7CQysLNqinG18=;
  b=hhSkQJvOMgDU81KH+rx7LGZck6hfboMJqU4gsiRaYE0YJwfB3ASbtYyf
   iUe78iliRam6fqbI5xqz7FliNJkcig1YeuR+XaiPgcsTCzZLRvwZTg8aU
   J9146+Pe96EXO3fwPBy+hkaL1t3UKNtDYgFjic2rlOllXX06gYxxN1pW9
   wdnuYRrtAv0nKn+t43A1RuNGMvxQ5jmpSB7+AjLVBzVUmJwVajW6WwTO+
   6a6g2p6rOmZsv/OM0HgVPi0kyFdyeIqca0zA2JOKQvupg4+NNdOhur1RD
   kqefJ61v9SADoBcpEOi53Mto+IF+7GT09JeESV4zr8siMrDyg/ZijNUdD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320068679"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320068679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="648040359"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="648040359"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2023 03:01:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSyUm-008AiW-07;
        Fri, 17 Feb 2023 13:01:40 +0200
Date:   Fri, 17 Feb 2023 13:01:39 +0200
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
Message-ID: <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:

...

> >   * fwnode_get_next_child_node - Return the next child node handle for a node
> >   * @fwnode: Firmware node to find the next child node for.
> >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > + *
> > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > + * pointer.
> 
> The loop itself will also put the child node, so this is only relevant
> outside the loop.

Yes and this is exactly what people stumbled over. Hence this note.
This call per se doesn't loop, so I didn't get how your comment can
be transformed to anything here. Care to elaborate a bit more on
what I have to add here or reword?

...

> > + * Among other cases this has to be used when terminating device_for_each_child_node()
> 
> I don't think device_for_each_child_node() should be mentioned here. This
> isn't really related to that in particular.

Okay, I will drop this change. It's anyway out of the scope of this patch.

> With these:
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks, but due to above I can't apply it right away.

-- 
With Best Regards,
Andy Shevchenko


