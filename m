Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F516AAB30
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCDQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCDQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:42:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFC1D919;
        Sat,  4 Mar 2023 08:42:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A9E660018;
        Sat,  4 Mar 2023 16:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3A9C433D2;
        Sat,  4 Mar 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677948143;
        bh=66L7PzTaQz6dIJoLaz2yX5a8HHo/Cc+RT63gZVmaf0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U9DQXHVi2XGf6tN5S3RM+ebRUvU2uyzACywptj8hfp8+mrgY+3HfPoBntENiAAtxz
         WfDoD/zE1u9R03cLDB0+jj/WlDvCNIFk2M647KNmBINgIf1G1FS/gw7Yi/xqSirA5x
         OEyFgpcknxinnSVMfXdu7gWy8GG/fYFDLe5zRsttQoVN1Vc2kkt9hE8ZNLrUudLa0e
         IzBLWDGN4FKB0ZdVQjqLsHhI4A7qccleQx2ZqcuAa560vHBYkm/h35vU1dC6hnmJmt
         R6vjklRFpjOEqmtrx4pa6VxbPAtRVOVmO67/70yWncUO8yC0xDWYOPhYXg9kxtlUOo
         3i+uQEWTRq0LA==
Date:   Sat, 4 Mar 2023 16:42:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <20230304164219.2ee62070@jic23-huawei>
In-Reply-To: <ZADNexu/8SnwfI0B@smile.fi.intel.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
        <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
        <ZADGnRILByq1/1ch@smile.fi.intel.com>
        <ZADMRsDgxKZ/UfJj@carbian>
        <ZADNexu/8SnwfI0B@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 18:23:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 02, 2023 at 05:18:14PM +0100, Mehdi Djait wrote:
> > On Thu, Mar 02, 2023 at 05:54:05PM +0200, Andy Shevchenko wrote:  
> > > On Thu, Mar 02, 2023 at 02:04:35PM +0100, Mehdi Djait wrote:  
> > > > Move the kernel-doc of the function to industrialio-trigger.c
> > > > Add a note on the context where the function is expected to be called.  
> 
> ...
> 
> > > > v2:
> > > > - Changed the expected context of from interrupt to hard IRQ context  
> > > 
> > > Thank you for an update.
> > > 
> > > But it seems I messed up with this and my previous remark shouldn't be
> > > taken into consideration.
> > > 
> > > The "relevant hardware interrupt handler" may be hard and threaded IRQ context,
> > > which looks like your first version was correct.
> > > 
> > > Let's wait for Jonathan opinion on this as he is a native speaker.  
> > 
> > If I understood the function correctly I think you were right. It should
> > be hard IRQ context
> > 
> > The relevant functions calls:
> > iio_trigger_poll --> generic_handle_irq --> handle_irq_desc
> > 
> > handle_irq_desc: returns Operation not permitted if !in_hardirq() && handle_enforce_irqctx 
> > and it is the reason why the sysfs trigger uses the irq_framework to call iio_trigger_poll 
> > from hard IRQ context [1][2]  
> 
> Cool, thank you for elaboration!
> 
> In any case it's up to Jonathan now what to do. With your explanation it seems
> correct to phrase as you did in v2. Hence,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It is indeed hard interrupt context that matters here so I'm fine with this version.
Though I'm going to tweak it to drop the empty line at the end of the comment block
whilst applying it.

Thanks,

Jonathan

> 
> > [1] https://lwn.net/Articles/411605/ 
> > [2] https://lore.kernel.org/all/1346922337-17088-1-git-send-email-lars@metafoo.de/  
> 

