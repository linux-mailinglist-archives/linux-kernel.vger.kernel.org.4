Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B456F3E57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjEBHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:20:39 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2957273A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:20:37 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3427KaNZ028037;
        Tue, 2 May 2023 09:20:36 +0200
Date:   Tue, 2 May 2023 09:20:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
Message-ID: <ZFC5xHVNEfyXtbLS@1wt.eu>
References: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
 <ZFCubzgPxBSDiTwq@1wt.eu>
 <c967837e-39c7-48e4-9ee7-65892f13d126@t-8ch.de>
 <ZFC0z8dh+DmVSYyk@1wt.eu>
 <781b8ce2-bc3e-4eef-b466-fc0e26f64bb5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <781b8ce2-bc3e-4eef-b466-fc0e26f64bb5@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 09:05:29AM +0200, Thomas Weißschuh wrote:
> On 2023-05-02 08:59:27+0200, Willy Tarreau wrote:
> 
> <snip>
> 
> > > The following trivial fix on top of my patch would fix the problem:
> > > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index 5d624dc63a42..9d27131c224e 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/auxvec.h>
> > >  #include <linux/fcntl.h> // for O_* and AT_*
> > >  #include <linux/stat.h>  // for statx()
> > > +#include <linux/reboot.h> // for LINUX_REBOOT_*
> > >  
> > >  #include "arch.h"
> > >  #include "errno.h"
> > 
> > Indeed it works for me as well.
> > 
> > > Want me to send a v2 or will you fix it up on your side?
> > 
> > It depends. If for you it's a fix and needed for 6.4 (or maybe older),
> > then that one is needed with the "//" comment, and it will later
> > conflict with your previous cleanup patch that's already queued. If
> > you're fine with having it queued for 6.5 only however, then I'll just
> > edit your patch and add that above. I tend to think the second solution
> > is sufficient given that nobody complained till now ;-)
> 
> This is absolutely not urgent. 6.5 is fine.

OK, now queued on top of my 20230415-nolibc-updates-4a branch that
I'll soon send to Paul.

Thank you!
Willy
