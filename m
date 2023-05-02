Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE66F3E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjEBHFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:05:32 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF53A86
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:05:31 -0700 (PDT)
Date:   Tue, 2 May 2023 09:05:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683011130; bh=OmQ34Rt6+vUMv4eAB/iwE7zXiWGswmkgDUkuNsvIZFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lkguk+wfk7eKJE3WMxtM7C+8ukUtebYNhHjLVlPyNyRgpA6sXnv4oxCPRyczl9XnA
         I8IvOu6dSAd3ngOiMQg277j3anBOxTq4Lm+JlTVKmuhSZjkregtrJJp4XJ4iZEq2Lx
         J4i4LdpCQlrAHrB8sxG6uJS9oZ1CQ/Qp4HdDDUFo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
Message-ID: <781b8ce2-bc3e-4eef-b466-fc0e26f64bb5@t-8ch.de>
References: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
 <ZFCubzgPxBSDiTwq@1wt.eu>
 <c967837e-39c7-48e4-9ee7-65892f13d126@t-8ch.de>
 <ZFC0z8dh+DmVSYyk@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFC0z8dh+DmVSYyk@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-02 08:59:27+0200, Willy Tarreau wrote:

<snip>

> > The following trivial fix on top of my patch would fix the problem:
> > 
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 5d624dc63a42..9d27131c224e 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -21,6 +21,7 @@
> >  #include <linux/auxvec.h>
> >  #include <linux/fcntl.h> // for O_* and AT_*
> >  #include <linux/stat.h>  // for statx()
> > +#include <linux/reboot.h> // for LINUX_REBOOT_*
> >  
> >  #include "arch.h"
> >  #include "errno.h"
> 
> Indeed it works for me as well.
> 
> > Want me to send a v2 or will you fix it up on your side?
> 
> It depends. If for you it's a fix and needed for 6.4 (or maybe older),
> then that one is needed with the "//" comment, and it will later
> conflict with your previous cleanup patch that's already queued. If
> you're fine with having it queued for 6.5 only however, then I'll just
> edit your patch and add that above. I tend to think the second solution
> is sufficient given that nobody complained till now ;-)

This is absolutely not urgent. 6.5 is fine.

Thomas
