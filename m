Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D273586C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjFSNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjFSNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:20:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65F1AC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:20:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5F3D218E6;
        Mon, 19 Jun 2023 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687180844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/SWAgI5HI5GKotedaHyXkoUm3dh7H6kmLw/xseZ1DY=;
        b=Ie5U9APgMNUrpdGe8gCGjCqqdjxijMm8mC7Jg+stWOZ4RJQ2y2YZR0JpNcWbyrYeg2nVlO
        +wmOA1LaSR8fv9KGy1lJuFah5Ye7K4lfmj8J1UhcPcHAwRYkZkDOBtc70sFlWgVkg2pUjr
        QqaXc/VcESKX0joJQ2fBzlWFE72BbUo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 00E252C141;
        Mon, 19 Jun 2023 13:20:43 +0000 (UTC)
Date:   Mon, 19 Jun 2023 15:20:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, hexingwei001@208suo.com,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <ZJBWK01h7xCO0olj@alley>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
 <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
 <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
 <20230614110640.57817123@gandalf.local.home>
 <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
 <ZI/5guHaSPrld+Cv@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZI/5guHaSPrld+Cv@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-06-19 08:45:22, Pavel Machek wrote:
> On Wed 2023-06-14 18:16:36, Andy Shevchenko wrote:
> > On Wed, Jun 14, 2023 at 11:06:40AM -0400, Steven Rostedt wrote:
> > > On Wed, 14 Jun 2023 15:32:30 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Jun 14, 2023 at 04:30:55PM +0800, hexingwei001@208suo.com wrote:
> > > > > Add missing spaces to clear checkpatch errors:
> > > > > 
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).  
> > > > 
> > > > Doesn't make any difference to the code, so let do this (unneeded) churn
> > > > to calm checkpatch down.
> > > > 
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > checkpatch is for patches (new code) and should not be run on existing code.
> > 
> > Why does it have -f option? What do you propose to prevent people from using it?
> 
> Brain needs to be used while using checkpatch.

I agree.

Also I agree with Sergey that these changes just complicate
backport.

I would prefer if people did not send these cosmetic "fixes".


> Plus, autosel is "great" trying to backport anything that mentions
> "error", so better don't do this.

Autosel is another tool which would deserve a human filter. Well, we have
it because of lack of resources...

I am surprised that checkpatch.po reports the missing space as an "ERROR"
in the first place.

Best Regards,
Petr
