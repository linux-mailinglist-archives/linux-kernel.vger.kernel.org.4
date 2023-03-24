Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543256C884B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCXWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjCXWYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:24:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4116B768D;
        Fri, 24 Mar 2023 15:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7720B82612;
        Fri, 24 Mar 2023 22:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E372AC433D2;
        Fri, 24 Mar 2023 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679696665;
        bh=178pfsB66t/h8ExkXB5D4TkF5hm2FX5yIg6OFgWiyhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaL0BkC1oH35B0+YSTB9ercVMLa7GQBKwBZ1xTq2+5hi5U4r5FgDcXIabtkwCnfkI
         CZavmCBnI/XL6TnxOjltwNDH8pwYVrN7xUp8Zcsh4zSa63/mGa2ph2CLPtHt6Krlxp
         LHsB4vCLFYt7q5EvypE/b0fIwXpzYl89lzOmZv+dpGUrktmLy/qHfeSLazJvbRUnvS
         4Q45nBiAo5666E4US8MfhGENbNqtnkMYNkYceIsCBIBSbfMJmKtgk0Qyt6sDGRkds9
         tSBEYNGj/4R+uT7d4OioTyyHIysVB34HqLK1HjUNAwhFkFyg7rDHr1pR6nbZf6qk4+
         Be+r/YbYZ9Y4A==
Date:   Fri, 24 Mar 2023 23:24:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove RCU_NONIDLE()
Message-ID: <ZB4jFXpMPxXke1K7@localhost.localdomain>
References: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 20, 2023 at 06:37:51PM +0100, Peter Zijlstra a écrit :
> 
> Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
> away before someone else decides to (ab)use it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for all the hard work leading to that!

	Acked-by: Frederic Weisbecker <frederic@kernel.org>
