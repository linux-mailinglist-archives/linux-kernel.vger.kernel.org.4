Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA669AA2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBQLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBQLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:18:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7126860;
        Fri, 17 Feb 2023 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676632717; x=1708168717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v/lw1+bQmMiA1mwRVjY2gf0AYcjp0L2FgQopU0DgmDs=;
  b=THztKsvNl5kAvV8ZNrdVRo8IEZpnHB3bpmdNXZfADYWOOTHpuOyhyXuW
   okG4sT/Y4ZNbHEwZPTe9chuITByBL3C6VZe+j2nR833Rp0FDCGHULxVeT
   IpUrHIpO7sWIwXAksNk7ujMVn3pJhirPJb6GHTKFHj6pKveEknsMd6012
   dLcESZaTXrQNlOlLM1mrvwP2KgVqs0CB1xw/3NOmmMPyTVyNd+3NdWpmQ
   u5hAYcEIdf5Lgyi7i/M8rXOcZ/3UYbbsn4lkhiELe4Z9+y4lY7/2nk/3x
   Z1241jv+P7804EHZsx8wdg3R/Sb3Y3ZeyyMU1P120j5xafFlyU0nf4bDw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312331249"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="312331249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:18:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="702944819"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="702944819"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:18:34 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 43E1011FC11;
        Fri, 17 Feb 2023 13:18:31 +0200 (EET)
Date:   Fri, 17 Feb 2023 13:18:31 +0200
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
Message-ID: <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
 <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Feb 17, 2023 at 01:01:39PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> > On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > >   * fwnode_get_next_child_node - Return the next child node handle for a node
> > >   * @fwnode: Firmware node to find the next child node for.
> > >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > > + *
> > > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > > + * pointer.
> > 
> > The loop itself will also put the child node, so this is only relevant
> > outside the loop.
> 
> Yes and this is exactly what people stumbled over. Hence this note.
> This call per se doesn't loop, so I didn't get how your comment can
> be transformed to anything here. Care to elaborate a bit more on
> what I have to add here or reword?

Ah, indeed. This is achieved by putting the previous child. Generally this
function is used via the loop helper macro and not called directly, hence
the documentation there matters the most. Those functions appear to be
without any documentation though.

-- 
Regards,

Sakari Ailus
