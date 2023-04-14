Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106F6E1B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDNEqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794603A9C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0045561631
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BBC433EF;
        Fri, 14 Apr 2023 04:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681447562;
        bh=wfEym8qro7dg1p5z3tQuWfgisOPWGwMEyT0HNXn36IY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sZHa33Wdmt9133vX3Iq0cgWEIGSP5M850b4HIXZpsYs3XwJV4jtGQn0RTBWc3dTZT
         BdYH5bny0Ltni0Lo2x8+pBvW7znxqiuNcCaxWNQyN4LHWfcGkI/+wweXKEALoqOCr3
         exaYOilkneGd0KfGip4K17aysfSVPgRRn1lWNF+/2EP8EiEDguUcWb1JttiMpx/vmg
         T3+fsJyA24qQfl2PHPrZ4DQj2gwAKYP9Rp1MHsOwM8vRHcsyYVFnN/Jh06x1lvPd6A
         QWuD22/Q9l52WPnNfekxcksBmhWnvWkWiDxMemsku/1Dq+LE/ZTzK5i0Wy/MhcQyFf
         1F9hz/Ue8Ds6g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA5D015404B5; Thu, 13 Apr 2023 21:46:01 -0700 (PDT)
Date:   Thu, 13 Apr 2023 21:46:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     quic_neeraju@quicinc.com, urezki@gmail.com, frederic@kernel.org,
        joel@joelfernandes.org, boqun.feng@gmail.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: RCU coverage for this coming week
Message-ID: <9299136a-4c49-4638-b2ce-523cc3329bfd@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

I will be on travel next week, and will likely have limited Internet
access at times.  RCU is unlikely to have much trouble at this point
in the cycle, but Murphy says otherwise.  So, just in case, for the
components of RCU that have had the most recent changes:

o	Neeraj Upadhyay is covering Tasks RCU.

o	Uladzislau Rezki is covering kfree_rcu().

o	Frederic Weisbecker is covering offloaded callbacks.

o	Joel Fernandes is covering SRCU.

o	Boqun Feng is "batting cleanup" with RCU-related memory-ordering
	issues.

They have been through much of the code, as you can see here:

https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYutdSIajfpLA/edit?usp=sharing

Have a great week, and I will be back Monday April 17!

							Thanx, Paul
