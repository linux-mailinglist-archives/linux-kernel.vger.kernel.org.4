Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBF8658D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiL2NbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2NbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:31:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155515FCB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:31:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 124so12662487pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJyXOHIJy199WKQmrcss/MftC0S714TuH1DdiOZFBe8=;
        b=CHkKg4pKUiD5Odl/DCpWFAuhudcLG+uwXgtoD/ao8t24YBoeFQPtIFtL9iYoyjJmf2
         rVO+pZK2HGEfrsDMGUp0bvwU2p1booGk3yA9BFxWkEWaccAcgolHwYxR3P3KjxpXi6IT
         uN11cTNyqmdLPzm+fuXJluv/X/McnSBpD8S230Gs83bUxt761lP7AmIM6XgPGDiScq0V
         Qs9MShVIMhVCdo6U8RuouVFr62htSbaIbXJfOfxS+1BLA+bUQDsJgVMp5FS2KJIhGDXZ
         4zTmWEbHUJHSnGA3dZJknElLIqkHLw2fIDpFS2ZdrLtysAU3Te8AjFwOZLAXJGJRnUIm
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJyXOHIJy199WKQmrcss/MftC0S714TuH1DdiOZFBe8=;
        b=sJ4wlwkeZjI1Gn3vSzc/XL6igitr2z/ZrnObbiTdvXi16GCTtUU4wkfBF2J6lYCEH8
         80qELfqBy9UvkMW1ajfCWAEDsdQzCgtvOBvwEYefdc1BTX//plEbhgLUBf44p+bdEY6w
         7ghNQq98R4TYg76P7aZvZ9b2AGVwCFNz6xyKLZkYn2Puf4uM+qk/3oe4EvGMmWbgpTI+
         OmBbIWdYUoPytbqi+ygYeHTLOuy3dwRDC3uz+HrRcQYyeY8ki1sODlmIHoS+q2h5sjNf
         a/P7lwJa1AmvvpmjFjf38TF+NOWTKb2HMp68bOZYzqqCx/cWyaM4p7UVq0ruyUKvHujX
         2/cw==
X-Gm-Message-State: AFqh2koYY3yIvIpHSYwcZBQFWFt5s7MdSZUDH2bIEnk8tm8iYtbioivJ
        1HvO753lXcJloybV+MF+BHE=
X-Google-Smtp-Source: AMrXdXtJuDlA/aYufo+aCodeU7FfCubBFPa1GVtVH7kHMYxHgSbLUUfM78MOv1CAUv7d4IwfQwkw6w==
X-Received: by 2002:a62:b412:0:b0:581:3557:f75b with SMTP id h18-20020a62b412000000b005813557f75bmr12396832pfn.5.1672320665523;
        Thu, 29 Dec 2022 05:31:05 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 12-20020a62170c000000b005769436a23dsm12089673pfx.218.2022.12.29.05.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:31:04 -0800 (PST)
Date:   Thu, 29 Dec 2022 22:30:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y62WkiG3dSWOKL1i@hyeyoo>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
 <Y6HSutM8pmoKxQWp@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HSutM8pmoKxQWp@alley>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 04:20:26PM +0100, Petr Mladek wrote:
> On Sun 2022-12-18 19:19:00, Hyeonggon Yoo wrote:
> > %pGp format is used to print 'flags' field of struct page.
> > As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> > are set in page_type field, introduce %pGt format which provides
> > human readable output of page_type.
> > 
> > Note that the sense of bits are different in page_type. if page_type is
> > 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> > page_type is 0xffefffff. Clearing a bit means we set the bit.
> > 
> > Bits in page_type are inverted when printing page type names.
> > 
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -575,12 +575,13 @@ The field width is passed by value, the bitmap is passed by reference.
> >  Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
> >  printing cpumask and nodemask.
> >  
> > -Flags bitfields such as page flags, gfp_flags
> > +Flags bitfields such as page flags, page_type, gfp_flags
> >  ---------------------------------------------
> 
> Please, underline the entire title. Otherwise, "make htmldoc"
> complains ;-)
> 
>     /prace/kernel/linux/Documentation/core-api/printk-formats.rst:579: WARNING: Title underline too short.
>     Flags bitfields such as page flags, page_type, gfp_flags

Still not getting used to rst format ;)
Will fix, thanks!

> 
> 
> >  
> >  ::
> >  
> >  	%pGp	0x17ffffc0002036(referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff)
> > +	%pGt	0xffefffff(slab)
> >  	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
> >  	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
> >  
> 
> Please, explain this also in the paragraph below these examples.
> I would personally refactor it to an itemized list, something like:
> 
> <proposal>
> For printing flags bitfields as a collection of symbolic constants that
> would construct the value. The type of flags is given by the third
> character. Currently supported are:
> 
> 	- p - [p]age flags, expects value of type (``unsigned long *``)
> 	- t - page [t]ype, expects value of type (``unsigned int *``)
> 	- v - [v]ma_flags, expects value of type (``unsigned long *``)
> 	- g - [g]fp_flags, expects value of type (``gfp_t *``)
> 
> The flag names and print order depends on the particular type.
> </proposal>

The proposal sounds reasonable to me,
will adjust in next version.

> Rant:
> Sigh, it looks a bit error prone when similar pointer modifiers
> expects pointers to different types. I wish there was a way how
> to check the passed pointer type at compilation time. But it
> is generic problem with these %p* modifiers.

From my limited knowledge, it seems that there is no way to check
this :/

> 
> Otherwise the patch looks fine for the vsprinf side.

Thank you for looking at this!

> 
> Best Regards,
> Petr

-- 
Thanks,
Hyeonggon
