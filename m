Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303FF6CD2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjC2HKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjC2HKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67467137
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c0DagGnX42QzeNj2UXakQh0Ab7J7fUDwI+PuwWFvT1M=; b=CMoMVBzCqLO5Ie7wpLeEHeRHt8
        Q8nSt/jQqGM7hBcPHpO1zbV4A++/lrsC9dr1x//dvOOuvPvfj8HWikRdviH2mgr9XjvQdk7lWtB3V
        A4RqfKlZsb/I0i2MT4c+fiTtWbZY1PEA/s06OXzEA3btiylpIeyW0+upd9lgx3rkhKescS3bJKmy4
        eeuS6jiqOhB7NA1AldYLIDtuJ/68GoCIw1inkQMffSm+n58RwjleegizG1lSQMr7Gdsd3NNPxJYsC
        CDX4+UgXhHWWq6sOPpRhPvXaxR7R+Nxj4EUfQYu16aH6gMtdCm56HNUpvJBEe6rpyVp5sEkrTtqlL
        ZqrhIvQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phPwn-009BuN-8A; Wed, 29 Mar 2023 07:10:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A4C83002A3;
        Wed, 29 Mar 2023 09:10:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 181A6201D9953; Wed, 29 Mar 2023 09:10:14 +0200 (CEST)
Date:   Wed, 29 Mar 2023 09:10:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wenyou Yang <WenYou.Yang@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, evan.quan@amd.com, mario.limonciello@amd.com,
        bp@suse.de, jpoimboe@kernel.org, kim.phillips@amd.com,
        tglx@linutronix.de, weiyuan2@amd.com, richardqi.liang@amd.com,
        ying.li@amd.com, kunliu13@amd.com, gpiccoli@igalia.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Message-ID: <20230329071014.GC7701@hirez.programming.kicks-ass.net>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329015149.870132-2-WenYou.Yang@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:51:48AM +0800, Wenyou Yang wrote:
> Add the notifier chain to notify the cpu SMT status changes
> 

Why!?!? What's the purpose of all this? IIRC this doesn't trigger if you
manually disable all the siblings. And because you didn't tell us why
you need this I can't tell you if that matters or not :/
