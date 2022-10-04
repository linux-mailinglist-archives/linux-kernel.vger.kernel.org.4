Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110285F4C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJDW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJDW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:56:45 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807C31373
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:56:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id g13so4830803ile.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21aF3xrHX47oLo0sMGUmu36P6Tlgyl21KoRQSXEdHrM=;
        b=cgGYJ6lfrnzD1l8DjimJ35xNcQVig2WjI0sX/wZA1Kt2WrOVb7v6+bBWv8xUTuhKRc
         di2GHl5ueLHpvrFq901ROpowMwn0iakdZinN8bDTO6vM4+Uq/+aic91q2TACJX78KaPn
         JRL+Naq6gR+1vG8IvtcuhQTcQPPGUDXF+2MdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21aF3xrHX47oLo0sMGUmu36P6Tlgyl21KoRQSXEdHrM=;
        b=FYubEIYtnfVJPYuZpyclIKuboOdRW3ISV7BILB5z0D2y4MoXi7wVtYZngsNpTqUlHM
         mM1sJu/DaH9mJt1SVbbLaJLGzf5xeu53LpotSEZHRf4HwesSa0HcfWR3G8W40T92loQT
         p3DYfObthdygpwmfvBe0bvnrWjgy4Rmrjc5NiKkCohF0NKwBI7CHfcKY8jY2gS/uOmHM
         4FnMxki105zMJz7Ae6RYebqwoyHaFHo/w0E43Royz+jFGc1KT1IJWIW5Zz1Q30pNxrKf
         R9H7xqwoanbFpL6zPLS/J32GguRtElXbOiid9mIu2WnJcbACxFCJ8Gwgy2926SOvWSNA
         pInw==
X-Gm-Message-State: ACrzQf0hgT2t2hujmD0J+B9aic6ZihbMJmc/uafvFqXhlnun/88VUcbk
        bC6ymV3Tyn8wgp1gLSvCWHCeYQ==
X-Google-Smtp-Source: AMsMyM4WTtHSi0Zw5vBdW0BqBDQ7WVxaWnQlFtOUczTGMe69fRh7AxEax+ShD8gBI6Bvp1v50CbEhA==
X-Received: by 2002:a05:6e02:154f:b0:2f9:f2ed:b661 with SMTP id j15-20020a056e02154f00b002f9f2edb661mr4732417ilu.134.1664924202749;
        Tue, 04 Oct 2022 15:56:42 -0700 (PDT)
Received: from chromium.org (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id k42-20020a056638372a00b0035a9b0050easm5720499jav.18.2022.10.04.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:56:42 -0700 (PDT)
Date:   Tue, 4 Oct 2022 16:56:40 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Yzy6KNUHFqxWZb9U@chromium.org>
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com>
 <Yzxl2oczTtwEvIqt@chromium.org>
 <Yzxsu2Ms43eTfOYR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzxsu2Ms43eTfOYR@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 at 19:26 +0200, Greg KH wrote:
> On Tue, Oct 04, 2022 at 10:56:58AM -0600, Jack Rosenthal wrote:
> > On 2022-10-04 at 10:51 +0200, Greg KH wrote:
> > > > +		A list of ids known to Coreboot can be found in the coreboot
> > > > +		source tree at
> > > > +		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
> > > 
> > > That will not age well, why not point to the reference in the kernel
> > > tree instead?
> > 
> > There is no copy in the kernel tree.
> 
> Then how does the kernel know what to print out?  Why not add such a
> reference somewhere?

The kernel really doesn't need to know the list of possible ids: it
simply reads what coreboot gives it from the coreboot tables and proxies
that on up to sysfs nodes.

In an earlier version of this patch
(https://lore.kernel.org/chrome-platform/CAODwPW-JzXXsEANaS+6n695YqriAQ0j0LXm31R2u1OP3MhX9Uw@mail.gmail.com/T/#u),
I actually had this list so that the directory names were human-readable
instead of using the 32-bit CBMEM id, but Julius didn't like it citing
that we'd have to keep the kernel tree and the coreboot tree in sync.

I'm fine with either solution ... just want to make all parties happy
here =)

> 
> > > >  config GOOGLE_COREBOOT_TABLE
> > > >  	tristate "Coreboot Table Access"
> > > >  	depends on HAS_IOMEM && (ACPI || OF)
> > > > diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> > > > index d17caded5d88..8151e323cc43 100644
> > > > --- a/drivers/firmware/google/Makefile
> > > > +++ b/drivers/firmware/google/Makefile
> > > > @@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
> > > >  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
> > > >  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
> > > >  
> > > > +# Must come after coreboot_table.o, as this driver depends on that bus type.
> > > 
> > > Doesn't the linker handle this for us?
> > 
> > Not in the case of compiling as a built-in module: I observed in this
> > scenario the order in the Makefile deterimined the module initialization
> > order, and, if this were to be listed alphabetically, the coreboot_table
> > module would not have been loaded before the cbmem module.
> 
> So is this a runtime dependancy or a symbol/link dependancy?
> 
> link one is easy, we always go off of the Makefile order, and if you
> move it and it breaks, well obviously move it back.  If it's a runtime
> order, then how will you handle one being a module and the other not?

link/symbol dependency ... it's just the cbmem driver depends on the
coreboot bus.  Existing EXPORT_SYMBOL facilities should have this
figured out for the module case, but the Makefile just needs to be in
the right order for the built-in module case.
