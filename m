Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA396F8530
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEEPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjEEPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105717DDF;
        Fri,  5 May 2023 08:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F03CD63E29;
        Fri,  5 May 2023 15:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12515C433D2;
        Fri,  5 May 2023 15:02:15 +0000 (UTC)
Date:   Fri, 5 May 2023 11:02:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] rculist.h: Fix parentheses around macro pointer
 parameter use
Message-ID: <20230505110214.697c495d@gandalf.local.home>
In-Reply-To: <D4B84962-D9A0-4405-BD07-22E9E2ACA243@joelfernandes.org>
References: <20230505100621.5d468f95@gandalf.local.home>
        <D4B84962-D9A0-4405-BD07-22E9E2ACA243@joelfernandes.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 10:35:39 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> >> Yeah it is not clear why anyone would ever want to use it like this.
> >> Why don't they just pass t1 to list_for_each_entry_rcu() ? I would
> >> rather it break them and they re-think their code ;).  
> > 
> > Remember interfaces should not be enforcing policy unless it's key to the
> > way the interface works.  
> 
> Oh yeah, 100% agree. I am not particularly against this particular patch
> but I also dont see it as solving any problem. Feel free to Ack the patch
> if you feel strongly about wanting it.

I agree that this isn't solving any real bugs, but it is a legitimate
cleanup.

And as someone that tends to push interfaces to their limits, I would
likely be the one that hits it ;-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
