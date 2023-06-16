Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60E733CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbjFPXSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbjFPXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC03AAD;
        Fri, 16 Jun 2023 16:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBF5623C4;
        Fri, 16 Jun 2023 23:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A503FC433C8;
        Fri, 16 Jun 2023 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686957507;
        bh=eqfQjVBkqIhbsWLbcoHQH2ayTph2A9fA/vwd+AocNwo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tVSd2apR26H5CYI9sKfCzcLhggGxL3pty6uGTh3o5dn9AABPmTpgPozhaRaa5jspw
         u4DE/8qWxldPVl2teVRM1EiKf6dddVK6bgZz5LRmsRyL6rT+AVo6Wchs95SZiyCkM5
         rSH2GxLKns+MDNvDhAgwgwMGm+KQsuvwpb6TZFOthbkiCOCFtzLWgJ1kj1artJeKq9
         e/R7JvnHfrW2+S3tHdPRPiHfd+N2OeogVnfHtkac6qwNq/TQGFac8Mr9w02tPAI1Vi
         0mw8D563sxPi1Fq/kH2SsyhqXQ+EjVXDj8ZWXcZrnli/ZTstTLPodZjr46zwZ5NlOs
         rOIg+ydMt0Yzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 459EFCE0BAE; Fri, 16 Jun 2023 16:18:27 -0700 (PDT)
Date:   Fri, 16 Jun 2023 16:18:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Docs/RCU/rculist_nulls: Specify type of the
 object in examples
Message-ID: <e55f9cd3-d0a3-40f0-9c5f-a0a4229a87b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <390935BF-9EC0-4D88-A277-7B37D68CC6C7@gmail.com>
 <20230616185411.85781-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616185411.85781-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:54:11PM +0000, SeongJae Park wrote:
> On Sat, 17 Jun 2023 01:46:16 +0800 Alan Huang <mmpgouride@gmail.com> wrote:
> 
> > 
> > > 2023年6月16日 02:10，SeongJae Park <sj@kernel.org> 写道：
> > > 
> > > The type of 'obj' in example code of rculist_nulls.rst is implicit.
> > > Provide the specific type of it before the example code.
> > > 
> > > Suggested-by: aul E. McKenney <paulmck@kernel.org>
> > 
> > Paul E. McKenney
> 
> Oops, thank you for finding, and sorry, Paul :)

Not a problem, just send new patches and I will replace those currently
in -rcu with those new patches.

							Thanx, Paul

> > > Link: https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop/
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > > Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
> > > 1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > > index 94a8bfe9f560..4b66e2fd2fb5 100644
> > > --- a/Documentation/RCU/rculist_nulls.rst
> > > +++ b/Documentation/RCU/rculist_nulls.rst
> > > @@ -18,7 +18,16 @@ to solve following problem.
> > > 
> > > Without 'nulls', a typical RCU linked list managing objects which are
> > > allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
> > > -algorithms:
> > > +algorithms.  Following examples assume 'obj' is a pointer to such
> > > +objects, which is having below type.
> > > +
> > > +::
> > > +
> > > +  struct object {
> > > +    struct hlist_node obj_node;
> > > +    refcount_t refcnt;
> > 
> > atomic_t
> 
> I just recalled the example code uses atomic_set_release() for this field.
> 
> Thank you, Alan!
> 
> I will fix these in the next spin.
> 
> 
> Thanks,
> SJ
> 
> > 
> > > +    unsigned int key;
> > > +  };
> > > 
> > > 1) Lookup algorithm
> > > -------------------
> > > @@ -142,6 +151,9 @@ the beginning. If the object was moved to the same chain,
> > > then the reader doesn't care: It might occasionally
> > > scan the list again without harm.
> > > 
> > > +Note that using hlist_nulls means the type of 'obj_node' field of
> > > +'struct object' becomes 'struct hlist_nulls_node'.
> > > +
> > > 
> > > 1) lookup algorithm
> > > -------------------
> > > -- 
> > > 2.25.1
> > > 
> > 
> > 
