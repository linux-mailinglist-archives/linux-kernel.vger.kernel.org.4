Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C15ED4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiI1GZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiI1GZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:25:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A54FE659;
        Tue, 27 Sep 2022 23:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EE54B81F0F;
        Wed, 28 Sep 2022 06:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7FDC433C1;
        Wed, 28 Sep 2022 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664346301;
        bh=FyzOc4GlUkTlszaDDdOzvuwTgevArpofgPZCukzh4bc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C2XQ0xmE8JFHmAuhBQJXBlcVJumzM4oV7Nw02D03pgTin3yb3TaEcoJXbEzBk7YCL
         Ydi1t2naxg3oLD6DWIAH8JWuZ2cVYQELynQ7+AnpQc4jdDx97EnAQu3MAIN++6CTWO
         j3KWayG93Z28b2EAuheLPtf+ddR4VT5Qy2nQVoWaA0K+0NJ7+eSW320m6X5CxtZUrL
         58j6Jf7sXyaI0/6HEqthUIuMLb0oe9ydnxrBsp4RO54zjNfQiKDHuCrzOFVpsdIiOg
         uHfPi4TTcRg3slxMVz1aAmHHcYc9c1Fb7/VVjWHW3fQlDjKL+0hZP4k3sjLAhC9xZC
         pzlezjKQk1qDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE9475C092A; Tue, 27 Sep 2022 23:25:00 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:25:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Message-ID: <20220928062500.GZ4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220927201053.518736-1-broonie@kernel.org>
 <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
 <20220927212821.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <1d54d4ff-c8a3-145a-7ec5-f32107eda21e@infradead.org>
 <20220927224234.GY4196@paulmck-ThinkPad-P17-Gen-1>
 <ae367f0e-424c-d026-23fb-5eafec93cfb1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae367f0e-424c-d026-23fb-5eafec93cfb1@infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:27:13PM -0700, Randy Dunlap wrote:
> Hi Paul,
> 
> On 9/27/22 15:42, Paul E. McKenney wrote:
> > On Tue, Sep 27, 2022 at 02:33:19PM -0700, Randy Dunlap wrote:
> >>
> >>
> >> On 9/27/22 14:28, Paul E. McKenney wrote:
> >>> On Tue, Sep 27, 2022 at 02:13:29PM -0700, Randy Dunlap wrote:
> >>>>
> >>>>
> >>>> On 9/27/22 13:10, broonie@kernel.org wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> Changes since 20220923:
> >>>>>
> >>>>
> >>>> In file included from ../include/linux/notifier.h:16,
> >>>>                  from ../include/linux/memory_hotplug.h:7,
> >>>>                  from ../include/linux/mmzone.h:1244,
> >>>>                  from ../include/linux/gfp.h:7,
> >>>>                  from ../include/linux/slab.h:15,
> >>>>                  from ../include/linux/crypto.h:20,
> >>>>                  from ../arch/x86/um/shared/sysdep/kernel-offsets.h:5,
> >>>>                  from ../arch/um/kernel/asm-offsets.c:1:
> >>>> ../include/linux/srcu.h: In function ‘srcu_read_lock_nmisafe’:
> >>>> ../include/linux/srcu.h:181:26: error: implicit declaration of function ‘__srcu_read_lock_nmisafe’; did you mean ‘srcu_read_lock_nmisafe’? [-Werror=implicit-function-declaration]
> >>>>   181 |                 retval = __srcu_read_lock_nmisafe(ssp, true);
> >>>>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
> >>>>       |                          srcu_read_lock_nmisafe
> >>>> ../include/linux/srcu.h: In function ‘srcu_read_unlock_nmisafe’:
> >>>> ../include/linux/srcu.h:226:17: error: implicit declaration of function ‘__srcu_read_unlock_nmisafe’; did you mean ‘srcu_read_unlock_nmisafe’? [-Werror=implicit-function-declaration]
> >>>>   226 |                 __srcu_read_unlock_nmisafe(ssp, idx, true);
> >>>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>       |                 srcu_read_unlock_nmisafe
> >>>
> >>> Could you please send your .config or tell me how you generated it?
> >>
> >>
> >> For x86_64 SUBARCH, ARCH=um:
> >>
> >> mkdir UML64
> >> make ARCH=um SUBARCH=x86_64 O=UML64 tinyconfig
> >> make ARCH=um SUBARCH=x86_64 O=UML64 all
> > 
> > Thank you!  The diff shown below clears it up for me.  Does it cover it
> > for you as well?
> 
> Works for me. Thanks.
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thank you, Randy!

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 274d7200ce4e..565f60d57484 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -52,6 +52,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
> >  #else
> >  /* Dummy definition for things like notifiers.  Actual use gets link error. */
> >  struct srcu_struct { };
> > +int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
> > +void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
> >  #endif
> >  
> >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
> 
> -- 
> ~Randy
