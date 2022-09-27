Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A575ED05E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiI0Wmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiI0Wmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:42:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B9F8FAA;
        Tue, 27 Sep 2022 15:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7123AB81DA3;
        Tue, 27 Sep 2022 22:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365D9C433C1;
        Tue, 27 Sep 2022 22:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664318555;
        bh=EMZ4EJLSSXCzYJ/1qe8HYWK+/2iKKTctb53QFJThtP8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HwyV0d0r93EtpZQ23gTMPw59FUeAbbzKvYdffOwzRl7sC6CUghWy1+tpBJ+IvzKv/
         AA/nQOMmnEN6NS+1EYdunn+Z73t72bC2nri4A6PJBczXeGFfOPt7xMaU7BwOxWtFwQ
         5ZvTp/bJ/ExRsVFwFvXMcltkowClsalurFRpTlQkg3mvLFaFS3tmHvZsQYgoG3Gfh/
         QYA8xLcKoayhkYrIW+CiIY2/IR7l7IVCQ1VslgAhqrtEgvZSuxsDX97PK8LKGj8kzJ
         YQAbSDG9ZYO2lMKb7ZI9mbwXYOmly6VFXel9xt6TqUmUJDQaA3lSHpc4Ni1SFHRov1
         rEYwD77hn9TGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C52B15C0AC7; Tue, 27 Sep 2022 15:42:34 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:42:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Message-ID: <20220927224234.GY4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220927201053.518736-1-broonie@kernel.org>
 <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
 <20220927212821.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <1d54d4ff-c8a3-145a-7ec5-f32107eda21e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d54d4ff-c8a3-145a-7ec5-f32107eda21e@infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:33:19PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/27/22 14:28, Paul E. McKenney wrote:
> > On Tue, Sep 27, 2022 at 02:13:29PM -0700, Randy Dunlap wrote:
> >>
> >>
> >> On 9/27/22 13:10, broonie@kernel.org wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20220923:
> >>>
> >>
> >> In file included from ../include/linux/notifier.h:16,
> >>                  from ../include/linux/memory_hotplug.h:7,
> >>                  from ../include/linux/mmzone.h:1244,
> >>                  from ../include/linux/gfp.h:7,
> >>                  from ../include/linux/slab.h:15,
> >>                  from ../include/linux/crypto.h:20,
> >>                  from ../arch/x86/um/shared/sysdep/kernel-offsets.h:5,
> >>                  from ../arch/um/kernel/asm-offsets.c:1:
> >> ../include/linux/srcu.h: In function ‘srcu_read_lock_nmisafe’:
> >> ../include/linux/srcu.h:181:26: error: implicit declaration of function ‘__srcu_read_lock_nmisafe’; did you mean ‘srcu_read_lock_nmisafe’? [-Werror=implicit-function-declaration]
> >>   181 |                 retval = __srcu_read_lock_nmisafe(ssp, true);
> >>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
> >>       |                          srcu_read_lock_nmisafe
> >> ../include/linux/srcu.h: In function ‘srcu_read_unlock_nmisafe’:
> >> ../include/linux/srcu.h:226:17: error: implicit declaration of function ‘__srcu_read_unlock_nmisafe’; did you mean ‘srcu_read_unlock_nmisafe’? [-Werror=implicit-function-declaration]
> >>   226 |                 __srcu_read_unlock_nmisafe(ssp, idx, true);
> >>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |                 srcu_read_unlock_nmisafe
> > 
> > Could you please send your .config or tell me how you generated it?
> 
> 
> For x86_64 SUBARCH, ARCH=um:
> 
> mkdir UML64
> make ARCH=um SUBARCH=x86_64 O=UML64 tinyconfig
> make ARCH=um SUBARCH=x86_64 O=UML64 all

Thank you!  The diff shown below clears it up for me.  Does it cover it
for you as well?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 274d7200ce4e..565f60d57484 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,6 +52,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #else
 /* Dummy definition for things like notifiers.  Actual use gets link error. */
 struct srcu_struct { };
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
 #endif
 
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
