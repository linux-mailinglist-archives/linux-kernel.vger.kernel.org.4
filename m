Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764C719C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFAMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA47124
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41EBC61BE0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6CCC433D2;
        Thu,  1 Jun 2023 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685623408;
        bh=BlOzt1IM/xk54Ug0kRYgwgUwLEEMOFafnbrXNCsrg+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3cJwyoUW6R+YpvEHneKtKKXHY8RQ+kkdpnIaunCvuzVcmwXrTCMq35ooRDrBGx75
         IfVqyVZ5bTJVkFSAD9bD1GYnu4RHVimDGlVfsN70mgn5wLQsYk/JdNuKDRQYkPYOpd
         bqzgl8tVm9mPbYM2R1O7aF2L0sK28q2TNmNAxszAXkAUKLMOiAkHCOzEYTFIKZ385W
         qHluIQV1ZJ8q7GACdvfR1gGBq3Jqw3j+NxEBPhMyW1nIkcv2M/f7VxXr8h44iwvMNr
         k2dNWmTE9QHOMPXDCup0nHJ8I1XP7G00nvDeSTp0SS61V7AEab9mCncyOiJqF3HRt0
         2sEs3ww6XWKTw==
Date:   Thu, 1 Jun 2023 14:43:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 15/20] posix-timers: Add proper comments in
 do_timer_create()
Message-ID: <ZHiSbZRudwyW81Nt@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.619897296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.619897296@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:19PM +0200, Thomas Gleixner wrote:
> The comment about timer lifetime at the end of the function is misplaced
> and uncomprehensible.
> 
> Make it understandable and put it at the right place. Add a new comment
> about the visibility of the new timer ID to user space.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
