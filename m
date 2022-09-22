Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED05E6458
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiIVNzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiIVNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:55:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9BCDF382;
        Thu, 22 Sep 2022 06:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 385E7B81E5E;
        Thu, 22 Sep 2022 13:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE27C433C1;
        Thu, 22 Sep 2022 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854933;
        bh=JCvHpyPsKzJCtpMbsDdiMt9Y8zlCMwuocJyYy+K7OLw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U61WAQaLaG/LMMhYIZAYrKwrmloJ5QrbOrtUaBZiEFwgRl0H3i5bl+QBNkBjZ3Krr
         4MLl69B0E5FLgn4C0ft8pQb4oax4KD/DS5J+tAHcW3NJDsvTJQE5Zmfb3xf9EgEAXW
         yqPyNhdRblQT8RVtXrygzGiCw61fRqaOVonj7ASA6VoHyPYUa5OOxQO6SeVFpFZNMF
         rRfzJzMm3Kf0keQb24vayWOyHMvOpdyannQJucQ+J6CBqj+dx8e8+7pt226IaGU+tu
         DoDvotGCnGynsA2xJBu4uUrjvieG26q72m3s9H5PJP+zo49Q0grmiWHi2KVgOhcSVk
         B5SRg9dGdWvYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A34B45C06D0; Thu, 22 Sep 2022 06:55:32 -0700 (PDT)
Date:   Thu, 22 Sep 2022 06:55:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20220922135532.GI4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220922201222.01e0f2f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922201222.01e0f2f5@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:12:35PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   a3450c5ce1df ("Revert "rcu: Simplify rcu_init_nohz() cpumask handling"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits, too.

Apologies, missed a rebase to drop the revert and the original commit,
will fix!

							Thanx, Paul
