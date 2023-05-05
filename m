Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C76F88B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjEESjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEESj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FE1AEC7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08024612BE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F2C433EF;
        Fri,  5 May 2023 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311965;
        bh=Dh7G9B1wiGWf3GmFb0fdhL0vZbXH9ywECZDZ4w6wpbs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LqIZ7b2vIi5pchCnETaZENGZ7lGaUGNszx+jCFOHb8r+wO9WDv2IyMEiCjEUMWPjZ
         FZAKeZleKNUVCUpQ7vHs/pNohVXRZMmRydnOR/wVuLEI4asjLV6lacMf1G1exr9Wfd
         Pqzcm93QW7qBEwVla0HssOq8823uaL8kY0cHT6Lze3Uj3z4p/Wi2I5pSbv3+Jg7FYa
         l9My0LT/7wguyI7K19FbzZXtNx6ykPnCS3KVgDM0NjwFLx0+KCFVdYp1s1rWvMZM9Y
         6SwfpPzLjcm0/l0ze+b0HbVVprNuNh2NiW0VqHWXVq8ROJn/Q/bHgHkdrULIoiAwb6
         FwXRka7G8ijww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BF48F15405AC; Fri,  5 May 2023 11:39:24 -0700 (PDT)
Date:   Fri, 5 May 2023 11:39:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [RFC PATCH] rcu: rcupdate.h: Add missing parentheses around
 macro pointer dereference
Message-ID: <41c82bac-014f-49a8-8223-683db77e8671@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
 <20230503180640.630f3006@gandalf.local.home>
 <5b102a66-f88c-4a77-887e-1b41f8064454@paulmck-laptop>
 <34b873b0-93e5-d492-9c30-9d6b5c022ace@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b873b0-93e5-d492-9c30-9d6b5c022ace@efficios.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 09:15:12AM -0400, Mathieu Desnoyers wrote:
> On 2023-05-04 20:28, Paul E. McKenney wrote:
> > On Wed, May 03, 2023 at 06:06:40PM -0400, Steven Rostedt wrote:
> > > On Wed,  3 May 2023 16:32:36 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > 
> > > > linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
> > > > 
> > > >    typeof(*p)
> > > > 
> > > > rather than
> > > > 
> > > >    typeof(*(p))
> > > > 
> > > > The following test-case shows how it can generate confusion due to C
> > > > operator precedence being reversed compared to the expectations:
> > > > 
> > > >      #define m(p) \
> > > >      do { \
> > > >              __typeof__(*p) v = 0; \
> > > >      } while (0)
> > > > 
> > > >      void fct(unsigned long long *p1)
> > > >      {
> > > >              m(p1 + 1);      /* works */
> > > >              m(1 + p1);      /* broken */
> > > >      }
> > > > 
> > > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Zqiang <qiang1.zhang@intel.com>
> > > > ---
> > > >   include/linux/rcupdate.h | 18 +++++++++---------
> > > >   1 file changed, 9 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index dcd2cf1e8326..1565012fa47f 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
> > > >   #ifdef __CHECKER__
> > > >   #define rcu_check_sparse(p, space) \
> > > > -	((void)(((typeof(*p) space *)p) == p))
> > > > +	((void)(((typeof(*(p)) space *)p) == p))
> > > 
> > > Hmm, should we have that be:
> > > 	((void)(((typeof(*(p)) space *)(p)) == (p)))
> > > 
> > > In case of the 1 + p1, which would end up as:
> > > 
> > > 	((void)(((typeof(*(1 + p1)) __rcu *)1 + p1 == 1 + p1;
> > > 
> > > I don't know how that __rcu get's passed around via the + statement there,
> > > so it may be fine. May not even make sense to have that. But I like to
> > > error on more parenthesis. ;-)
> > > 
> > > The rest looks fine.
> > > 
> > > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Thank you all!  I applied Steve's suggested change with attribution
> > as shown below.  Please let me know if I messed anything up.
> 
> Hi Paul,
> 
> I've done a new version of that patch which fixes other issues in rcupdate.h
> in the next round. Can you hold merging this until I remove the "RFC PATCH"
> tag please ? My goal is to gather feedback first to make sure everyone is OK
> with the overall changes across headers, so everything can become
> consistent.

Hello, Mathieu,

Very well, I have removed it.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit d3d734216c88fb7c13205dc62178ff5011da415b
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Wed May 3 16:32:36 2023 -0400
> > 
> >      rcu: Add missing parentheses around rcu_dereference() "p" parameter
> >      linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
> >        typeof(*p)
> >      rather than
> >        typeof(*(p))
> >      The following test-case shows how it can generate confusion due to C
> >      operator precedence being reversed compared to the expectations:
> >          #define m(p) \
> >          do { \
> >                  __typeof__(*p) v = 0; \
> >          } while (0)
> >          void fct(unsigned long long *p1)
> >          {
> >                  m(p1 + 1);      /* works */
> >                  m(1 + p1);      /* broken */
> >          }
> >      [ paulmck: Apply Steve Rostedt additional () feedback. ]
> >      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >      Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >      Cc: Joel Fernandes <joel@joelfernandes.org>
> >      Cc: Josh Triplett <josh@joshtriplett.org>
> >      Cc: Boqun Feng <boqun.feng@gmail.com>
> >      Cc: Steven Rostedt <rostedt@goodmis.org>
> >      Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >      Cc: Zqiang <qiang1.zhang@intel.com>
> >      Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >      Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >      Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index ddd42efc6224..cb938a89a923 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -405,16 +405,16 @@ static inline void rcu_preempt_sleep_check(void) { }
> >   #ifdef __CHECKER__
> >   #define rcu_check_sparse(p, space) \
> > -	((void)(((typeof(*p) space *)p) == p))
> > +	((void)(((typeof(*(p)) space *)(p)) == (p)))
> >   #else /* #ifdef __CHECKER__ */
> >   #define rcu_check_sparse(p, space)
> >   #endif /* #else #ifdef __CHECKER__ */
> >   #define __unrcu_pointer(p, local)					\
> >   ({									\
> > -	typeof(*p) *local = (typeof(*p) *__force)(p);			\
> > +	typeof(*(p)) *local = (typeof(*(p)) *__force)(p);		\
> >   	rcu_check_sparse(p, __rcu);					\
> > -	((typeof(*p) __force __kernel *)(local)); 			\
> > +	((typeof(*(p)) __force __kernel *)(local));			\
> >   })
> >   /**
> >    * unrcu_pointer - mark a pointer as not being RCU protected
> > @@ -427,29 +427,29 @@ static inline void rcu_preempt_sleep_check(void) { }
> >   #define __rcu_access_pointer(p, local, space) \
> >   ({ \
> > -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
> >   	rcu_check_sparse(p, space); \
> > -	((typeof(*p) __force __kernel *)(local)); \
> > +	((typeof(*(p)) __force __kernel *)(local)); \
> >   })
> >   #define __rcu_dereference_check(p, local, c, space) \
> >   ({ \
> >   	/* Dependency order vs. p above. */ \
> > -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
> >   	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
> >   	rcu_check_sparse(p, space); \
> > -	((typeof(*p) __force __kernel *)(local)); \
> > +	((typeof(*(p)) __force __kernel *)(local)); \
> >   })
> >   #define __rcu_dereference_protected(p, local, c, space) \
> >   ({ \
> >   	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
> >   	rcu_check_sparse(p, space); \
> > -	((typeof(*p) __force __kernel *)(p)); \
> > +	((typeof(*(p)) __force __kernel *)(p)); \
> >   })
> >   #define __rcu_dereference_raw(p, local) \
> >   ({ \
> >   	/* Dependency order vs. p above. */ \
> >   	typeof(p) local = READ_ONCE(p); \
> > -	((typeof(*p) __force __kernel *)(local)); \
> > +	((typeof(*(p)) __force __kernel *)(local)); \
> >   })
> >   #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
