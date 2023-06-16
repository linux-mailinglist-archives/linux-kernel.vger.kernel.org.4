Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722847336BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbjFPQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjFPQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C649E7;
        Fri, 16 Jun 2023 09:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 034B461E8F;
        Fri, 16 Jun 2023 16:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF43C433C8;
        Fri, 16 Jun 2023 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686934328;
        bh=N4xrbSWZmu3T5AgIRbp2PfwRes6IHyCFb+zWM/SdIvE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LbQTTNjKskMaw6acz5LDT6qOFMAnHCX5c38KxWj21xDjipbYdYPjPZljHNajsJI9n
         We7QyGPbkN5fPmP1pxOtxK1kb1qUQgQxei6ZzIO3LDjCp5HqAiI3e/wCVckY5OTYYE
         BFzUfErdi26Q1p9bmhRNzbJv7+xh/dB6jrlUhT0bXKw9ZhC0zGV+2bIKcsaG+AAXS+
         tDDHKRcMoC3arXcs09DiBka4WUMblRkLQpRbloy4Mow9rV44JlMk7TwmosH9OO0B/H
         pzcXC9EbtRMXkX4HJvq9TBbXscbRvWAJx0DVPG4+rLmBwmymPoXdq+LDK4ApHAWKfM
         6IlohYq6/7LOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1164CE0BB2; Fri, 16 Jun 2023 09:52:07 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:52:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     joel@joelfernandes.org, mmpgouride@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Docs/RCU/rculist_nulls: Minor fixup
Message-ID: <6126d55b-a80d-4ee6-8b80-980ebbf44320@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230615181004.86850-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615181004.86850-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:10:01PM +0000, SeongJae Park wrote:
> Changes from v2
> (https://lore.kernel.org/rcu/20230613182434.88317-1-sj@kernel.org/)
> - Drop first two patches that merged to Paul's tree
> - Add definition of 'obj' (Paul E. McKenney)
> - Fix more wrong hlist_[nulls]_head field name mentions
> 
> Changes from v1
> (https://lore.kernel.org/rcu/20230518224008.2468-1-sj@kernel.org/)
> - Add Reviewed-by tags from Joel Fernandes for first three patches
> - Fix the text for wrong extra _release()
> 
> ---
> 
> Fix minor problems in example code snippets and the text of
> rculist_nulls.rst file.

Queued, thank you!

							Thanx, Paul

> SeongJae Park (3):
>   Docs/RCU/rculist_nulls: Specify type of the object in examples
>   Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
>   Docs/RCU/rculist_nulls: Fix text about atomic_set_release()
> 
>  Documentation/RCU/rculist_nulls.rst | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1
> 
