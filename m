Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD3733877
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjFPSyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbjFPSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BFD3AA5;
        Fri, 16 Jun 2023 11:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B91163702;
        Fri, 16 Jun 2023 18:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6337AC4339A;
        Fri, 16 Jun 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941654;
        bh=nApWiSLLwWPLUkdMeB/M1atrM9iqgW2lKg+HjlxyPc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwabbwC4mvyWK/7j4PY4Zr4rJVtvU1GPKz+zf9pPFCmiw6QWOEPMVICo/RluUEt72
         NtcXfqUdXZ1D59dUQa2TDK2C4PaYH0qfaP2MbmLeL/mYWWdLHx9t7GaZPeaVOwGFf8
         IvlboVNbLceNS757JAtuE1z6mAXbksZYFEuofrhyTmYoKJ7F34VKhq4R5y0EAirGM+
         7lEKVPQ0KkTVmbWcm782gMOkQ5dmxzB2SIiWcoIOgWv2implFXNwv3rayc/qfZNIN+
         HVHML4CWujR8p8MF9r860/D5lYYtaIbjX14LpAZkGRj0Kzhe61nLSfPpnlh6X3Fw5d
         Zhvd5P3Nm9VRQ==
From:   SeongJae Park <sj@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, paulmck@kernel.org,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Docs/RCU/rculist_nulls: Specify type of the object in examples
Date:   Fri, 16 Jun 2023 18:54:11 +0000
Message-Id: <20230616185411.85781-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <390935BF-9EC0-4D88-A277-7B37D68CC6C7@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 01:46:16 +0800 Alan Huang <mmpgouride@gmail.com> wrote:

> 
> > 2023年6月16日 02:10，SeongJae Park <sj@kernel.org> 写道：
> > 
> > The type of 'obj' in example code of rculist_nulls.rst is implicit.
> > Provide the specific type of it before the example code.
> > 
> > Suggested-by: aul E. McKenney <paulmck@kernel.org>
> 
> Paul E. McKenney

Oops, thank you for finding, and sorry, Paul :)

> 
> > Link: https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop/
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
> > 1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > index 94a8bfe9f560..4b66e2fd2fb5 100644
> > --- a/Documentation/RCU/rculist_nulls.rst
> > +++ b/Documentation/RCU/rculist_nulls.rst
> > @@ -18,7 +18,16 @@ to solve following problem.
> > 
> > Without 'nulls', a typical RCU linked list managing objects which are
> > allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
> > -algorithms:
> > +algorithms.  Following examples assume 'obj' is a pointer to such
> > +objects, which is having below type.
> > +
> > +::
> > +
> > +  struct object {
> > +    struct hlist_node obj_node;
> > +    refcount_t refcnt;
> 
> atomic_t

I just recalled the example code uses atomic_set_release() for this field.

Thank you, Alan!

I will fix these in the next spin.


Thanks,
SJ

> 
> > +    unsigned int key;
> > +  };
> > 
> > 1) Lookup algorithm
> > -------------------
> > @@ -142,6 +151,9 @@ the beginning. If the object was moved to the same chain,
> > then the reader doesn't care: It might occasionally
> > scan the list again without harm.
> > 
> > +Note that using hlist_nulls means the type of 'obj_node' field of
> > +'struct object' becomes 'struct hlist_nulls_node'.
> > +
> > 
> > 1) lookup algorithm
> > -------------------
> > -- 
> > 2.25.1
> > 
> 
> 
