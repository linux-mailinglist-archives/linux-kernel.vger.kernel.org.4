Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95220719C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjFAMrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjFAMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09412C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C209360D37
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA903C433D2;
        Thu,  1 Jun 2023 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685623625;
        bh=nHXuFA+ozG+RLfzTilY+ORFdnejTDvyoKouMzD9Wyvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBWIHu9FFFKk3mo2KHoeip1cKTr5ji3nwydPhaKncYu0LwgQdfo/L+lFCA/moCuyD
         bJqQzzexSkC/BcLnCrx5Lq7Yrrrs1z/U27zVdbRmcma8CKftNz1ULFExhFiR1dK0CG
         DC0OPe8rWCeq4U0cy/Ki/39gxmCImZO1m4uCEZ2XJ+oEy2HiTj06B+NOMZBHMCRCh8
         pSLAhJmrYDqBoyfEh+XgWk83vaLuvuVa1lmC4XP3q/WZteWOTnO8dijSw2xG18fY3A
         bUpK5Mryy29lwur8FG/ObuYrFuNuqZrrzgDGGyJ4056OorDIr+ngf9divvqe4qR1IA
         oXwHIwc1zAwhA==
Date:   Thu, 1 Jun 2023 14:47:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 16/20] posix-timers: Comment SIGEV_THREAD_ID properly
Message-ID: <ZHiTRsWrAd9SXh6x@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.672220780@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.672220780@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:20PM +0200, Thomas Gleixner wrote:
> Replace the word salad.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
