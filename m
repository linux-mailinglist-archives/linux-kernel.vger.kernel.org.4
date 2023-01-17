Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2A670C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjAQW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjAQW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:57:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4963577C7;
        Tue, 17 Jan 2023 13:41:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4DF6155C;
        Tue, 17 Jan 2023 21:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F27C433D2;
        Tue, 17 Jan 2023 21:40:33 +0000 (UTC)
Date:   Tue, 17 Jan 2023 16:40:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230117164029.434a2336@gandalf.local.home>
In-Reply-To: <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
References: <20230112005223.2329802-1-joel@joelfernandes.org>
        <20230115162504.08ef72b0@rorschach.local.home>
        <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
        <20230117143224.6fbf7da8@gandalf.local.home>
        <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 11:37:34 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > The reason for the export should have been mentioned in the change log if
> > the patch is not obvious to why it is being exported.  
> 
> Would something like this suffice?  With attribution, of course.
> 
> 	Export rcu_async_should_hurry(), rcu_async_hurry(), and
> 	rcu_async_relax() for later use by rcutorture.

Yes thanks. That way, at least a git blame will give some rationale for the
export.

-- Steve
