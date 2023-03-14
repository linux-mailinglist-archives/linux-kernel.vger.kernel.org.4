Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0526B8B41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCNGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:33:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F59ED2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:33:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso14108518pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678775619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWhc5GI6KxiqzBSNgylF0hu+tPDYSfgvHUxc/4hzpYk=;
        b=WZMLxYnO9qDcaaIsZ5nrDoWGNVvWDi3HDW/6rytnUzEHGwOP61EefD91KkRmH8LiZL
         vaIfbkwNIhj9vqgZdW5mnSWASh28uh632JY8/rbJDkDPup7CjGt3WsX5vnoJx2CyAVaO
         g9nzjuMgF3DEixBOT0/F0vLNz9JwSOWDwSpGZKdu6t7A7e+r0w7mbuTj1wt52q9KXSra
         iulVHi9lX+Mb8lEcM3vbFvszIMPfjcrQrq7CuKiz/YYnGszlD4eMSX17nHpmw57uJgTC
         40azU5JuwbT50om1OiQVnIhb/+hDxK2QnZ0x930YzPViFewwhrNvyj6jZct4SxNPIsI0
         l3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678775619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhc5GI6KxiqzBSNgylF0hu+tPDYSfgvHUxc/4hzpYk=;
        b=GaBcZ4dHFOPz5UMVY86aIzdCVrVGRNn80c3cSz46qxrjRMo2ww2Xkk1d1QMLgbGKeq
         EIkGt1qIpPK9g7uu6nMtP76+3a3UqUQZf+zNhVb6MFUqwpj5v2HS+4ALTdUzcveh8yzE
         9tYCNwtu011lHXXyOV+aRftdHN5ZuN5H1pEEKiG/5RCbMixybpb//f9Mag++/3kRe2j9
         826//ScNCMw09/WHdCB2G2v+mJGZqDa3hs728nBWth6wW3Xqr3+ylhwXCBOp8lgj2/LR
         v0cNAfWPvz3aMdQtntMWttuQWUwQNRhjhUwMnymQsO6sPy5Ig1ZGHDginR1qRZaWG+sQ
         Swzg==
X-Gm-Message-State: AO0yUKW6UjEfxSRYX+xqaiGTxxhm0E+hkCGEAWVYlBD/1Xb1K9fm45RV
        KFOP/VdsMNdh0oImWcrC7bo4681OR4rHag==
X-Google-Smtp-Source: AK7set9KQw3OEZASJWg5oP+D7flBYwBxNKRCMplbGTp8Mq535lr4GErZimI1rD4DC7SpEYRme2T4eA==
X-Received: by 2002:a17:90a:498b:b0:236:84a:8d9d with SMTP id d11-20020a17090a498b00b00236084a8d9dmr38144469pjh.39.1678775619182;
        Mon, 13 Mar 2023 23:33:39 -0700 (PDT)
Received: from vernon-pc ([49.67.2.142])
        by smtp.gmail.com with ESMTPSA id kj11-20020a17090306cb00b00198ac2769aesm893531plb.135.2023.03.13.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 23:33:38 -0700 (PDT)
Date:   Tue, 14 Mar 2023 14:33:34 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix help comment of SLUB_DEBUG[_ON]
Message-ID: <ZBAUrPq+Ic/VSzF5@vernon-pc>
References: <20230222232058.66971-1-vernon2gm@gmail.com>
 <Y/a7db7v9zJJnX30@localhost>
 <b0ceb6a5-5949-2e0b-0634-e9d991c43188@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ceb6a5-5949-2e0b-0634-e9d991c43188@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 05:26:19PM +0100, Vlastimil Babka wrote:
> On 2/23/23 02:03, Hyeonggon Yoo wrote:
> > On Thu, Feb 23, 2023 at 07:20:58AM +0800, Vernon Yang wrote:
> >> Since commit 081248de0a02 ("kset: move /sys/slab to /sys/kernel/slab"),
> >> the SYSFS path of slab was modified, so fix up the help comment of
> >> SLUB_DEBUG to use the correct one.
> >>
> >> And now the "slub_debug" parameter on boot that is support for more
> >> fine grained debug control, so fix up help comment of SLUB_DEBUG_ON
> >> for "no support" to "support".
> >>
> >> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> >> ---
> >>  mm/Kconfig.debug | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> >> index fca699ad1fb0..732043bf56c6 100644
> >> --- a/mm/Kconfig.debug
> >> +++ b/mm/Kconfig.debug
> >> @@ -61,8 +61,8 @@ config SLUB_DEBUG
> >>  	help
> >>  	  SLUB has extensive debug support features. Disabling these can
> >>  	  result in significant savings in code size. This also disables
> >> -	  SLUB sysfs support. /sys/slab will not exist and there will be
> >> -	  no support for cache validation etc.
> >> +	  SLUB sysfs support. /sys/kernel/slab will not exist and there
> >> +	  will be no support for cache validation etc.
> >
> > After commit ab4d5ed5eeda ("slub: Enable sysfs support for !CONFIG_SLUB_DEBUG"),
> > "Disabling SLUB_DEBUG also disables SLUB sysfs support" is not true anymore.

Yes, You are right. Thanks.

>
> Yeah we could say that /sys/kernel/slab will exist but will not provide e.g.
> cache validation.

OK.

>
> >>  config SLUB_DEBUG_ON
> >>  	bool "SLUB debugging on by default"
> >> @@ -73,10 +73,10 @@ config SLUB_DEBUG_ON
> >>  	  Boot with debugging on by default. SLUB boots by default with
> >>  	  the runtime debug capabilities switched off. Enabling this is
> >>  	  equivalent to specifying the "slub_debug" parameter on boot.
> >> -	  There is no support for more fine grained debug control like
> >> -	  possible with slub_debug=xxx. SLUB debugging may be switched
> >> -	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
> >> -	  "slub_debug=-".
> >> +	  There is support for more fine grained debug control like
> >> +	  possible with slub_debug=xxx, details in Documentation/mm/slub.rst.
> >> +	  SLUB debugging may be switched off in a kernel built with
> >> +	  CONFIG_SLUB_DEBUG_ON by specifying "slub_debug=-".
> >
> > I think this is a misunderstanding. SLUB_DEBUG_ON is equivalent to

Yeah, This is a misunderstanding. I remove this.

> > passing boot parameter slub_debug=FUPZ, and what the help text says is that
> >
> > "You can enable slub debugging by default using this config option but
> >  there is no support for fine-grained control like what slub_debug
> >  boot parameter provides."
> >
> >  IOW SLUB_DEBUG_ON cannot be used to have same effect as passing
> >  something like slub_debug=F.
>
> Agree with both comments. Vernon, will you send an updated patch?

Ok, I'll be sending a new patch shortly.

>
> >>
> >>  config PAGE_OWNER
> >>  	bool "Track page owner"
> >> --
> >> 2.34.1
> >>
> >>
>
