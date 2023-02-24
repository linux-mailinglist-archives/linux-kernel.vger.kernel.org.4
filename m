Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6246A2194
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBXSgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBXSf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:35:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89C6C1B8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C64761961
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F0C433EF;
        Fri, 24 Feb 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677263757;
        bh=7j9WC4noci54aqadfdjbKrvLdE5NQyaDBNjXtB5N7lo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JXYRMqGurCpBip3+BGkEPElvr2UdzksRIUbw1Jp0aR0twaqMi+v0YGhnzy/vZu+ZZ
         fYfOQVPeQLYG4V+8aj4BSmkrw0LDiMpZT09TpJgHpu/kSyYJYsBv8ENpY3owoYHbKN
         u+wxGWOKhaHXD4PmLlkSsek+eq0RCbcE6Y2NgcbrC3RAWmblaJ9BDfKEHizHi0DFx+
         fIXLi0iUu4dKW9ZU8j9CWjvxbeuhV5fx36RNFY+V0fk2+TAuB74AQz/xBDPTd1JTL8
         OjEOMtgaBEFxfTg/TLoKd8bKlnsAl07IXB9H/ey7SMp0utSVd7t2U1A2hp81Fz1V1h
         yQTTl2TqLam8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 34B725C0BE7; Fri, 24 Feb 2023 10:35:57 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:35:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Zqiang <qiang1.zhang@intel.com>, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230224183557.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224012035.2693610-1-qiang1.zhang@intel.com>
 <20230224031232.mivsss3ofifbagsb@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224031232.mivsss3ofifbagsb@offworld>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 07:12:32PM -0800, Davidlohr Bueso wrote:
> On Fri, 24 Feb 2023, Zqiang wrote:
> 
> > In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
> > to sleepable rt_spin_lock().  This means that the interrupt related suffix
> > for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
> > interrupt state. This commit therefore adds raw spin-lock torture tests.
> > This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Queued replacing the previous version, thank you both!

							Thanx, Paul
