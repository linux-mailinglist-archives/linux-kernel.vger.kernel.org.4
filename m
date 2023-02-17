Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEE69AAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBQLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:44:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238B5BD86;
        Fri, 17 Feb 2023 03:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676634270; x=1708170270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsporBvbvkhAN2zntnBXKCyzIPBXsJmRP2z5y0oC/HA=;
  b=N65OH9Gat4iDQ7HfdnljQo1PXQuTxRsS4hngdKauUUlF958XXUY8tjnU
   gYYKtXLsK73SjCehfaiHTO10S11fWvNw4QD850l0TkzyZkj58ovtrIHEX
   OEFf5j6L9RClEsJFyC/4BypPzCvSE8jtPlPnBltMeVZv3w4Wb4mYd0sQD
   iE7Bvy90Ij5LcXvB4f/qK/xKVl+mvpm/eK13HL6yxw8hNOvCBVYUEhx9N
   mFi1j0D8ZOCdkQE4le3RBAMW7ShQjHxMhMIKNxDVyjEBTmmh6CmOePPaa
   tGmy87Z9PPZaS7CoY0L3tY5ehLC7T2SnIZtwqw4o79jXCjaeyiGG3K06f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331971396"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331971396"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:44:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="844546742"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="844546742"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:44:27 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 44FB911FC11;
        Fri, 17 Feb 2023 13:44:25 +0200 (EET)
Date:   Fri, 17 Feb 2023 13:44:25 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description on returned
 value in some functions
Message-ID: <Y+9omTMIzAxWM2by@kekkonen.localdomain>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
 <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
 <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
 <Y+9k9wkRgE1JOsr0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9k9wkRgE1JOsr0@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:28:55PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 17, 2023 at 01:18:31PM +0200, Sakari Ailus wrote:
> > On Fri, Feb 17, 2023 at 01:01:39PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> > > > On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > >   * fwnode_get_next_child_node - Return the next child node handle for a node
> > > > >   * @fwnode: Firmware node to find the next child node for.
> > > > >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > > > > + *
> > > > > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > > > > + * pointer.
> > > > 
> > > > The loop itself will also put the child node, so this is only relevant
> > > > outside the loop.
> > > 
> > > Yes and this is exactly what people stumbled over. Hence this note.
> > > This call per se doesn't loop, so I didn't get how your comment can
> > > be transformed to anything here. Care to elaborate a bit more on
> > > what I have to add here or reword?
> > 
> > Ah, indeed. This is achieved by putting the previous child. Generally this
> > function is used via the loop helper macro and not called directly, hence
> > the documentation there matters the most. Those functions appear to be
> > without any documentation though.
> 
> So, what should I do?

Good question.

How about this text:

The caller is responsible for calling fwnode_handle_put() put on the
returned fwnode. Note that this function also puts a reference to @child
unconditionally.

This is actually done by the firmware specific implementation, namely on OF
and at least should be done on swnode.

A second patch to document the fwnode iterator macros would be nice.

-- 
Sakari Ailus
