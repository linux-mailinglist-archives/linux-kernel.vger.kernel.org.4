Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE28603115
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJRQzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJRQzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:55:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61921AD992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:55:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so18734658ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SAC92zkDCoOb8Cpvbv0BcWkETu3jP+yy1JmC279Q2A=;
        b=Ra4wyabBIp8rt9azFlOFv7RAzTCWDvDKgJPw5swQEzTJq6MKRaWjqvOKB44/IJK3b5
         Fqe5fr5J5YyPnYY7au/ad5MSVNQfm968kRvremL2DDRzx3+TdnX5AtraZhZMS3neP4Op
         7fLWw75qb6CTQz/HU61J8Tjo8H0q7TRIir51cuKXvQYJrDVxUIQqyONLtpOYbToi4vIa
         /idIGQKogtLdsMLGCFUwe4RTHoDEPBUyWi/Yb+DvNgMj3N8sTOQSM67BE2eMjSYAGwBT
         7ZaPN6v9OOQjYAD1zZbb6TH9lGYW8xE2qXZ8pREFLnWRQXswbGCBMsDSwSjS7MQMQXZ5
         ObgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SAC92zkDCoOb8Cpvbv0BcWkETu3jP+yy1JmC279Q2A=;
        b=NRtRZGR7NyKAmZvwzguRNGk1XAecT24dB1ezajLoxvx98o1/S71uKQ/ptZ/9sbYHgP
         UeIkaK7ntHln2yvU+IQVWcj2H/+AL6jvFKxsbgXY8H4Glds5l2jcUpZm41wnHfN26GNs
         +yWHsqcQNrZ4dbMEapGNyuaLNiSwItvudYELCS/77CHEMT7Qv4DJLzABnXdBjCemUWXG
         HFhQMpHVPCrPPM15jllftXKc7IDYil8ySUHOlFAbkegim7yammdnSRGZN7azz0A6JpvD
         jfD52L0tDFOb2LeF8sN9SQdEHPUkt9seSMjN9oQNWCeqGbZm/QJv6VBWvKGpferRwvlO
         1MoA==
X-Gm-Message-State: ACrzQf2fnv4jZthV8eaJqTcp/PAh9Mv78hYGEHZaAChad1TBTwhPgja8
        qGO+qe5x0Wj09HCf6BxgJ+c=
X-Google-Smtp-Source: AMsMyM59JORIxeg6rOYkUZ+KB07JvYoNGW7Mv3gX1JuxcOd0SzDy/yYMNJ7CqWBTax8cH7uwpRuIaA==
X-Received: by 2002:a2e:8ecc:0:b0:26f:dd45:e50f with SMTP id e12-20020a2e8ecc000000b0026fdd45e50fmr1493871ljl.48.1666112115228;
        Tue, 18 Oct 2022 09:55:15 -0700 (PDT)
Received: from pc636 (host-90-235-12-21.mobileonline.telia.com. [90.235.12.21])
        by smtp.gmail.com with ESMTPSA id a13-20020a19f80d000000b004948b667d95sm1915582lff.265.2022.10.18.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:55:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Oct 2022 18:55:10 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
Message-ID: <Y07abvR1ugEBH0w+@pc636>
References: <20221017160233.16582-7-urezki@gmail.com>
 <202210180250.V8hzNH8X-lkp@intel.com>
 <Y07Rsz5R1ufZu6Od@pc636>
 <20221018124412.3beca846@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018124412.3beca846@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:44:12PM -0400, Steven Rostedt wrote:
> On Tue, 18 Oct 2022 18:17:55 +0200
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > Hello, Steven.
> > 
> > > 
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > [also build test ERROR on linus/master v6.1-rc1 next-20221017]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20221017160233.16582-7-urezki%40gmail.com
> > > patch subject: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
> > > config: um-i386_defconfig
> > > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://github.com/intel-lab-lkp/linux/commit/fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
> > >         git checkout fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    In file included from include/trace/events/vmap.h:123,
> > >                     from mm/vmalloc.c:47:  
> > > >> include/trace/define_trace.h:84:34: fatal error: trace/events/kernel_vmap.h: No such file or directory  
> > >       84 | # define __TRACE_INCLUDE(system) <trace/events/system.h>
> > >          |                                  ^
> > >    compilation terminated.
> > >  
> > I can reproduce it. It seems it happens so far only on the ARCH=um case.
> > For regular arm/x86 i do not see such build error.
> > 
> > If i rename the TRACE_SYSTEM macro to something different then "vmap"
> > it compiles fine. In case of:
> > 
> > #define TRACE_SYSTEM vmap
> > 
> > the prefix "kernel_" is added, thus the header name becomes as kernel_vmap.h
> > 
> > Steven can you give some indications? Or any thoughts about it?
> > 
> > Thank you in advance!
> 
> It comes from this:
> 
>    arch/um/Makefile:# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
>    arch/um/Makefile:       $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap      \
> 
> 
> It defines "vmap" to "kernel_vmap" which will change the above
> TRACE_SYSTEM Define to:
> 
>   #define TRACE_SYSTEM kernel_vmap
> 
> and that will confuse everything else.
> 
Hm... Right then it goes completely crazy. So there is only one option
it is to rename the trace header defined by the TRACE_SYSTEM.

Thank you for your help :)

--
Uladzislau Rezki
