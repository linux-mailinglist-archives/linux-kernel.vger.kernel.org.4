Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C969AAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBQMEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:04:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810C644D2;
        Fri, 17 Feb 2023 04:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676635469; x=1708171469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cI/EMqPKZ8zG8WS5rHmQT19as03smKMEfuOMAQ1Y+oQ=;
  b=lxa7FA7btSFwLXqe2SrhIQWJOniQSvfUTzJyjrE/8ptFnzyY2UlVtbda
   JM2/haQALFMmeRrnhy5wpx46efV1UPJXKssGDNCwckV2xW0+FAcLK2xAB
   hE/NMQOc52jOAq7uGmGruRTybJQs17zbnP/aS1ROEFFNZ5qL7fDxxbeHu
   Nvor5EWH9faOSiXr5guZ6kI/q4e7xbbIA/i1pGihNVECbOs6MMgxmMKRg
   Iz3Hu9mOzGfyAuGuCuQBleQo1inFs6hENHR+yqTeB8NiWFot00r4rxP/l
   ZEwWwLobIY9kYWhAuwXP+/7fN6Z8B02gR9LKe3VjUYey97LHeoCuN5ebU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="315686635"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="315686635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 04:04:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672561304"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="672561304"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 04:04:24 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 632A811FC11;
        Fri, 17 Feb 2023 14:04:22 +0200 (EET)
Date:   Fri, 17 Feb 2023 14:04:22 +0200
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
Message-ID: <Y+9tRoXCp4+oZ45l@kekkonen.localdomain>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
 <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
 <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
 <Y+9k9wkRgE1JOsr0@smile.fi.intel.com>
 <Y+9omTMIzAxWM2by@kekkonen.localdomain>
 <Y+9rPzw9orlqYkIx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9rPzw9orlqYkIx@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:55:43PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 17, 2023 at 01:44:25PM +0200, Sakari Ailus wrote:
> > On Fri, Feb 17, 2023 at 01:28:55PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 17, 2023 at 01:18:31PM +0200, Sakari Ailus wrote:
> > > > On Fri, Feb 17, 2023 at 01:01:39PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> > > > > > On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > >   * fwnode_get_next_child_node - Return the next child node handle for a node
> > > > > > >   * @fwnode: Firmware node to find the next child node for.
> > > > > > >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > > > > > > + *
> > > > > > > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > > > > > > + * pointer.
> > > > > > 
> > > > > > The loop itself will also put the child node, so this is only relevant
> > > > > > outside the loop.
> > > > > 
> > > > > Yes and this is exactly what people stumbled over. Hence this note.
> > > > > This call per se doesn't loop, so I didn't get how your comment can
> > > > > be transformed to anything here. Care to elaborate a bit more on
> > > > > what I have to add here or reword?
> > > > 
> > > > Ah, indeed. This is achieved by putting the previous child. Generally this
> > > > function is used via the loop helper macro and not called directly, hence
> > > > the documentation there matters the most. Those functions appear to be
> > > > without any documentation though.
> > > 
> > > So, what should I do?
> > 
> > Good question.
> > 
> > How about this text:
> > 
> > The caller is responsible for calling fwnode_handle_put() put on the
> > returned fwnode. Note that this function also puts a reference to @child
> > unconditionally.
> 
> Fine. Does it mean I have to change existing wording of the first sentence
> everywhere?

Up to you.

> 
> > This is actually done by the firmware specific implementation, namely on OF
> > and at least should be done on swnode.
> 
> Yes, that's. But it's not needed to be added.
> 
> > A second patch to document the fwnode iterator macros would be nice.
> 
> Not the reported problem. Maybe someone else can do the job?

It's perhaps not the most pressing issue at the moment. Let's see.

-- 
Sakari Ailus
