Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF836B2631
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCIOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCIOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:01:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC2DFB61;
        Thu,  9 Mar 2023 06:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370404; x=1709906404;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q6QptM2lZW/mxcCZq+pcmryzCogJvA7ubRMFrbpXJxU=;
  b=cv7WB/aOA0fe++1MMGqoxRo0dVCMf3lyex8FdKnxqMDhwPfG7Nq1MTSY
   1Q9+wr7kdHA541eolwzVPHGumulQGkEQBDkToWwTktOs5YJlune7VIsIu
   uvjU4BTYE+upXBN2hjwCXd8Z3BGbToFQ6WjZyOWlot4KFHLHJPQsPkI/p
   y6G471heb9C3r7O/ihYHGWvXK6h6g+ietlHzqWVUIIcitGeP+4Sk62sdc
   /LM5OY0JHM5dNqw+abNjwJQV5eMe7gokoGKQjGJpufvVcXN6LuX0ot7lK
   LJknz0uUE4UC2LM8K1n3XYfMJSw/k2RNZIMmpUJtPoERm6QcyYfld/ZgQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="337975544"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="337975544"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="677376938"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="677376938"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:00:01 -0800
Date:   Thu, 9 Mar 2023 15:59:55 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] n_tty: Reindent if condition
In-Reply-To: <b7e72552-d4ec-46f2-4f45-d8baec914ff1@kernel.org>
Message-ID: <ec97f7c5-b9fb-aefb-2249-9bfadc7eee7d@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com> <20230309082035.14880-8-ilpo.jarvinen@linux.intel.com> <b7e72552-d4ec-46f2-4f45-d8baec914ff1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1754519233-1678370403=:21633"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1754519233-1678370403=:21633
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 9 Mar 2023, Jiri Slaby wrote:

> On 09. 03. 23, 9:20, Ilpo Järvinen wrote:
> > Align if condition to make it easier to read.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >   drivers/tty/n_tty.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index 0481e57077f1..1c9e5d2ea7de 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -1176,7 +1176,7 @@ static void n_tty_receive_overrun(struct tty_struct
> > *tty)
> >     	ldata->num_overrun++;
> >   	if (time_after(jiffies, ldata->overrun_time + HZ) ||
> > -			time_after(ldata->overrun_time, jiffies)) {
> > +	    time_after(ldata->overrun_time, jiffies)) {
> 
> Staring at this, what the second time_after() does in the first place?
> 
> >   		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
> >   		ldata->overrun_time = jiffies;
> >   		ldata->num_overrun = 0;

That's a very good question ... I first thought it was checking whether 
the jiffies is between two times but obviously that was wrong intuition 
now when taking a closer look.

But then, looking more into it, this whole thing looks an opencoded 
*_ratelimited print. So perhaps overrun_time could be removed 
completely... ? I can see it kinda changes priority of which messages 
would get filtered out but I don't know if that's a problem or not.

-- 
 i.

--8323329-1754519233-1678370403=:21633--
