Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB4731F04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjFORaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFORaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712372711;
        Thu, 15 Jun 2023 10:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04E4762CB3;
        Thu, 15 Jun 2023 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88EDC433C8;
        Thu, 15 Jun 2023 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686850202;
        bh=6k2E/HCymMi+Pobov+FDLKMTyKLdXmhmMMQubn2X9mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWwSxCgCLH0WUIpbjt58Uyggj9hwD7ibn43ARD2yu1I97/hU0ZofR+PX27bh1q1rs
         eqNvlr0mW4uM5wiLLXMRe1kEUln6sVWkIn8uIS0dTyVXJWUIMie8VSsbXcmj+Z6+rI
         Am8gsmkWNGEEA1vPdqPXJSnGQU1Rmda5NjXrJJzS/hI32y1aZZATBE2D79ygZFglEj
         RvYBqMQwINEURPhAo0YhNA5OozP7qbJUERMt6JaRxCZSkANgB0uQWt4sON84HZ2a3l
         cPZQFjRhH/0kK7k5jmg+rORLyWxRNw+ET+qHaTi+rJLRX1fr7dZc4xjnX9I0uawnLN
         W1a9CG2VTHXFA==
From:   SeongJae Park <sj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] Docs/RCU/rculist_nulls: Fix hlist_head field name of 'obj'
Date:   Thu, 15 Jun 2023 17:30:00 +0000
Message-Id: <20230615173000.84885-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 09:36:50 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Jun 13, 2023 at 06:24:33PM +0000, SeongJae Park wrote:
> > The example code snippets on rculist_nulls.rst are assuming 'obj' to
> > have the 'hlist_head' field named 'obj_node', but a sentence is wrongly
> > mentioning 'obj->obj_node.next' as 'obj->obj_next'.  Fix it.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  Documentation/RCU/rculist_nulls.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > index 94a8bfe9f560..5cd6f3f8810f 100644
> > --- a/Documentation/RCU/rculist_nulls.rst
> > +++ b/Documentation/RCU/rculist_nulls.rst
> > @@ -86,7 +86,7 @@ Quoting Corey Minyard::
> >  2) Insertion algorithm
> >  ----------------------
> >  
> > -We need to make sure a reader cannot read the new 'obj->obj_next' value
> > +We need to make sure a reader cannot read the new 'obj->obj_node.next' value
> 
> I do like this being more specific, but if we are going do add this
> level of specificity, shouldn't we refer to a definition of ->obj_node?

Agreed, I will add the example definition in the next spin.  I also found we
would better to further fix wrong 'member' field assumption, like below:

-       ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
+       ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });



Thanks,
SJ

> 
> (I queued and pushed 1/4 and 2/4, thank you, and stopped here.)
> 
> 							Thanx, Paul
> 
> >  and previous value of 'obj->key'. Otherwise, an item could be deleted
> >  from a chain, and inserted into another chain. If new chain was empty
> >  before the move, 'next' pointer is NULL, and lockless reader can not
> > -- 
> > 2.25.1
> > 
> 
