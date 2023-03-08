Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD646B1058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCHRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCHRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:42:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34175CE952;
        Wed,  8 Mar 2023 09:41:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B31AD618C4;
        Wed,  8 Mar 2023 17:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286C6C4331D;
        Wed,  8 Mar 2023 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678297266;
        bh=Kn0eUKxHPSCBRMlkmHZWaweIytQ+/uV149fnveUbL6Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e3Vmu22kQ/egEmVgWklHwgy7yNmeNgSJVTnz1qHTiOkAkSJVo2QmSi4nZlwa7dXfF
         i7+Yh88C9amqjTYuk8hsgzFHCjkA+F0Sg2jqbulyZMghr1aGr7mVreY0iQNkdrDoP3
         QAxzPY4hequR0ROdfZClvu4SqM4Q2WFOowmW9LwdZbW2XvCt3Z8GXq4l6IuWsU3daV
         0N3MsE9gpfBO6OUhst+B+ulWnY+jZQFiVLvRNOc6bXMbJQ2jxVdmVFfse7GmpVeFIc
         YAy+4AAonfnCIecaqZKKJVTOea0AYolA4f3rfJ/pXpJlRNhjNC8fmpjqiLroRxE3F5
         iu/73G1DgTa5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C37965C01E4; Wed,  8 Mar 2023 09:41:05 -0800 (PST)
Date:   Wed, 8 Mar 2023 09:41:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20230308174105.GU1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230308131621.4e554121@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308131621.4e554121@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 01:16:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   e4beed6287ce ("Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits as well.

Apologies, and fixed.  Hopefully, the infiniband guys get that commit
back into -next that would make this revert unnecessary...

							Thanx, Paul
