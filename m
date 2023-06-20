Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDD73766F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFTVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B52D7;
        Tue, 20 Jun 2023 14:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5423B61042;
        Tue, 20 Jun 2023 21:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97BC433C8;
        Tue, 20 Jun 2023 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687295522;
        bh=dGKpkqnJnVdfufwSQkdHUCe8nxQNTJDDP/cMBgRtCJk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K6J8H0yh7WwE/eCMoCNyz9fFo+FXSV7sMumrFJMl5yXarxfDz1Uw/o47GBh+8EXPx
         0eiJbdia6qZ2p91DrkTp+lsWMTd/GC7FJLiTmcFaAkbddR2OySlWviFFaSV1M6VOYz
         /P2orr792c8QBgnqEAy/Xili8zaZklwF15dCS4dW41/b9W3aMPRoI499IVsUNDR4Z8
         WAdpfGkYlnx1DWVrjPPv8K20oeNAdo2jxfJlsjXgGJoq5bI1BolpXsVKhtk40VY9rd
         6XMa6MmLP9MeazZL2aDzVde9s7jPowLq6KqRj+OTjUwKH2ZAk9n+vAYGN3aEwhvpwZ
         Ai5kLs2rsIzqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C1BFCE17BC; Tue, 20 Jun 2023 14:12:02 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:12:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     joel@joelfernandes.org, mmpgouride@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Docs/RCU/rculist_nulls: Minor fixup
Message-ID: <2df7d40d-2e80-46f7-9193-5e116fd0f265@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230616233626.83906-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616233626.83906-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:36:23PM +0000, SeongJae Park wrote:
> Changes from v3
> (https://lore.kernel.org/rcu/20230615181004.86850-1-sj@kernel.org/)
> - Fix Paul's name on 'Suggested-by:' tag
> - Use 'atomic_t' for refcnt field of 'struct object'
> 
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

I am replacing the earlier versions with this version, thank you!!!

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
