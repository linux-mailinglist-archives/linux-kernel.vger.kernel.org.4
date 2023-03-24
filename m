Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5456C887D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCXWhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjCXWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F594AF3F;
        Fri, 24 Mar 2023 15:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28BBC62C64;
        Fri, 24 Mar 2023 22:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB71C433D2;
        Fri, 24 Mar 2023 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679697466;
        bh=zCjOBve0OE8SFI1d70jAlWQJ6T367yhvshzkiyAdcWU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h/fFIhIaI9bhLtgJO59ab5f6KXu163T5kopfrEVULEcb5LBk8TGfvFypoSEEEP14s
         BywakFz5DHtgRcitJFywWVvkpvpwNQqXDIyYdhnGI/qpvtGMT0Nwr4s/7/xf1LyI/b
         JSNqcwhVL27AtjTpj7d3Tc2MfjR3QupxVXccCt0E1wuBiPzB+YDhV84wtw/TkF00e/
         fZh29Zgh+BrHrt+HclYEW7ZlCXgBY4n+Q9lUq7oXdZNOicxNw67SwmKmLrb3ttje3J
         TWi8omvP7/1vPuq7Z/XLpRaFQcdEMU8nFVFK0WaeH5QoVYm+HqYqd7WN2VTdKX2iiM
         NhMbAsQ6ztmCA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09F581540432; Fri, 24 Mar 2023 15:37:46 -0700 (PDT)
Date:   Fri, 24 Mar 2023 15:37:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove RCU_NONIDLE()
Message-ID: <a42dbb35-e737-4aec-86f3-a26ef638fe67@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
 <ZB4jFXpMPxXke1K7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZB4jFXpMPxXke1K7@localhost.localdomain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:24:21PM +0100, Frederic Weisbecker wrote:
> Le Mon, Mar 20, 2023 at 06:37:51PM +0100, Peter Zijlstra a écrit :
> > 
> > Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
> > away before someone else decides to (ab)use it.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for all the hard work leading to that!
> 
> 	Acked-by: Frederic Weisbecker <frederic@kernel.org>

What Frederic said!  I will apply this ack on my next rebase.

							Thanx, Paul
