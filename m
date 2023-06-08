Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7040B728767
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjFHSl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFHSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604019E;
        Thu,  8 Jun 2023 11:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E54756504F;
        Thu,  8 Jun 2023 18:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45677C4339B;
        Thu,  8 Jun 2023 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686249710;
        bh=/XC56gk/QbgREe0xAI2tn4FfsDa1kINSQp93sc9KMmY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a5HX1cvs2lh+CKT1AoGiz2HamfaHGe9HhWnhN8t5KBxob3N2HvUDkV2nTmXfQr8cV
         BWSSvKv5ZxaUcU5xl7XuRI00G/Q/iMcC0Vc9tzy3VAIt4GwBAH5fz3Q7C/l6bO2O6e
         liErzoucstRS74wiolAg90/s2zIo7K6/7CyE6FuE6E7zjv064gkuajS5YxPL+WV4lU
         QjFKREg3YWqcHbsjpSrzi9dU9b9mmhKJ81WUpScx50A2oAAwcOQyKMkXIhCVN9tFI7
         28I9kHUDbbENTUu5hdEiAoan/DB2CKtcVW4f24bJxwHI+n6h4JhjwTEhDmeVQZLMOe
         qSjjhXMiaUbdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C3721CE3A30; Thu,  8 Jun 2023 11:41:49 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:41:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] documentation/rcu: fix typo
Message-ID: <4d9430d4-735e-4da9-891b-7cff41a5b3de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230607141521.539828-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607141521.539828-1-tycho@tycho.pizza>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:15:21AM -0600, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>

Good eyes, queued, thank you!

Build a fence out of all those lockdep-RCU slats?  ;-)

							Thanx, Paul

> ---
>  Documentation/RCU/lockdep-splat.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/lockdep-splat.rst b/Documentation/RCU/lockdep-splat.rst
> index 2a5c79db57dc..bcbc4b3c88d7 100644
> --- a/Documentation/RCU/lockdep-splat.rst
> +++ b/Documentation/RCU/lockdep-splat.rst
> @@ -10,7 +10,7 @@ misuses of the RCU API, most notably using one of the rcu_dereference()
>  family to access an RCU-protected pointer without the proper protection.
>  When such misuse is detected, an lockdep-RCU splat is emitted.
>  
> -The usual cause of a lockdep-RCU slat is someone accessing an
> +The usual cause of a lockdep-RCU splat is someone accessing an
>  RCU-protected data structure without either (1) being in the right kind of
>  RCU read-side critical section or (2) holding the right update-side lock.
>  This problem can therefore be serious: it might result in random memory
> 
> base-commit: a4d7d701121981e3c3fe69ade376fe9f26324161
> -- 
> 2.34.1
> 
