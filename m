Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F317666757
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjALABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjALABg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:01:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A81DF1F;
        Wed, 11 Jan 2023 16:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F056B81D79;
        Thu, 12 Jan 2023 00:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA52CC433D2;
        Thu, 12 Jan 2023 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673481692;
        bh=gp3ixmSzBGJy8uTYxS5ADZZFIL2F1SvM+d/vmQgSrEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sxkg91jNJBJYH7USijDsMpk3B7Rh+pgZSq9kVREeqMKTlsIraCQc2xugar4BcIY30
         15TqShLgLOsylkvcbhLbEEJwOcyf5HWdcJDQ98MpdAb2iHVzT3VnL7QQN8I6kGoENx
         4q4cAn1LtVbSg7wtPN53/Nh1vkJIHkv/3GxRmrt4X9ISye/UhBm+6tPDO5SrSmj1f3
         HxWA1nht/9YSii1cMJY2yU0gamKhpuNX4A9PJDk2XEvyJ8pWnG+iHFn1X4pAIk4GIj
         rB0wg+LRmAMlFp/jZocqp/R42AFuuzFxU1xtYyiYY1NpsBi3yBRg/jX0fJZZzTNDMk
         zUmgANE3Zsj4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C4965C0AF8; Wed, 11 Jan 2023 16:01:32 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:01:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH rcu 04/27] arch/powerpc/kvm: Remove "select SRCU"
Message-ID: <20230112000132.GC4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-4-paulmck@kernel.org>
 <87h6wwhbtb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6wwhbtb.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:49:04AM +1100, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: <linuxppc-dev@lists.ozlabs.org>
> > ---
> >  arch/powerpc/kvm/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thank you!  I will apply on the next rebase.

							Thanx, Paul

> cheers
> 
> > diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> > index a9f57dad6d916..902611954200d 100644
> > --- a/arch/powerpc/kvm/Kconfig
> > +++ b/arch/powerpc/kvm/Kconfig
> > @@ -22,7 +22,6 @@ config KVM
> >  	select PREEMPT_NOTIFIERS
> >  	select HAVE_KVM_EVENTFD
> >  	select HAVE_KVM_VCPU_ASYNC_IOCTL
> > -	select SRCU
> >  	select KVM_VFIO
> >  	select IRQ_BYPASS_MANAGER
> >  	select HAVE_KVM_IRQ_BYPASS
> > -- 
> > 2.31.1.189.g2e36527f23
