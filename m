Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB36FF7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjEKQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjEKQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C51DB;
        Thu, 11 May 2023 09:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE6764FC7;
        Thu, 11 May 2023 16:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EEC433EF;
        Thu, 11 May 2023 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823967;
        bh=Dm+RlKgCwz+CgrjqtEonz66OOpNh41qLfE91J2nx3J4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ecKrCRDd1K6yvX3sial6KzAfjGMvRNdQ/j0j0h+lgQsBMUi0lln1Mi+p+p+rI8Kbx
         J3os12Dcql5nItT8bVy7CSDkSRIlrsFwDjLzwRcNSID1PBZyYzpBfLiIKDqGoajqxQ
         WTWERh7cq/9x1+izPRa3hdGc/218ezB6ShPAsjmur8R328hIZ+FVEA7V110+vNyO/a
         Igowo839gLvulcJrMnuO6+sDytQwCTEUv77Qck7YzbiDcpnV2qeXbf375X7bNt41Fi
         hlfM+CynVbMuNaVh+lYqbI+nIdLx/PxgWcadNovaLCsgdGoeQp/h1qo6Oid9fi2HUV
         t9tLmKwdZYOQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A0A2CE0FED; Thu, 11 May 2023 09:52:47 -0700 (PDT)
Date:   Thu, 11 May 2023 09:52:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <59c2fd36-6920-47d8-a79c-9ff3fcf7c7ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230511090010.2916e9d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511090010.2916e9d7@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:00:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the kselftest-fixes tree as a different
> commit (but the same patch):
> 
>   6d9ed63d8bc3 ("tools/nolibc: Fix build of stdio.h due to header ordering")
> 
> This is commit
> 
>   d7eafa64a158 ("tools/nolibc: Fix build of stdio.h due to header ordering")
> 
> in the kselftest-fixes tree.

I can currently cleanly remove this commit from the rest of the nolibc
commits in -rcu.

However, I might need to re-introduce it in some way or another, for
example, if there are dependencies on it by future nolibc patches.
(I expect another batch in a few days.)

So how would you like to proceed?

							Thanx, Paul
