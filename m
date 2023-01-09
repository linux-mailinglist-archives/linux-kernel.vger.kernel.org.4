Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B8F6633A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjAIWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjAIWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483DF13F1E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7EA661331
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2981C433EF;
        Mon,  9 Jan 2023 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673301879;
        bh=LEsWdAx6VvZBVUKZIAwwyouf5pTB9sTOMhMVmgcE6dA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NdMzBj2ZMgcQHBX7k0LCAtZOsafEG53LjGSex5FI0tojIQLi6kbb5zpK+e7WHSpzM
         BjEdCDxjMG1PeZHRDIqCuqsQCCld1AJeyVd4TPQt2n+AXJOCkdrhNUHM7k247Vc6ZE
         Pm1TwDcGAXBIC6lyIpeDF3C1umxc1Lm1tWpSDnlJPSkuu0dN02YjUR7midqjstcJLc
         E9B9F2gg3MX30JAxipbf4Zu6Rnt5OTPAAg0h21Qu4rLPjK4/4uBxTIxfmd0lkxkECH
         O6a076x+VvEB7pl6K1kKG5lbn5CYvuNvotzFEf1MAnkMbtqNEIR1KkwEp/4a4ZcoIu
         x/g0mHW9ywJug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 957415C05C8; Mon,  9 Jan 2023 14:04:38 -0800 (PST)
Date:   Mon, 9 Jan 2023 14:04:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230109220438.GA1719328@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:15:34AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 09, 2023 at 09:09:06AM +0100, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > this series adds support for the s390x platform to nolibc and rcutorture,
> > reducing the init size from ~600kB to ~1kB. The work was contributed by
> > Sven Schnelle. It depends on the fixes series I sent previously:
> > 
> >   https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/
> > 
> > It passes the self-tests correctly and the patches are clean, please
> > consider queuing it.
> 
> "80 test(s) passed" and successful exit code.  I will assume that the
> decrease in tests from 81 to 80 is intended.  I have these queued,
> but it may be some hours before they are externally visible.

And I have now updated the -rcu "nolibc" branch to point to the fixes
and the s390 enablement.  Please let me know if I missed anything.

							Thanx, Paul
