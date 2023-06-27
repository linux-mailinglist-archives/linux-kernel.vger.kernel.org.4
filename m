Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B873F92F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjF0Jyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjF0JyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03630F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 802B161090
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6CCC433C8;
        Tue, 27 Jun 2023 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687859622;
        bh=nNsZ+ZuUFJdXMsEeGaRoxgtH3zn2j6lnzZFeyTyKSJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjgTJkZWzbmv7aWajz+ulBenmFYVU/WRQGpqAdUg7naBwSbKMXK4reV/6AELiBBWq
         7WOkUY7D9eqSXEBeTDXgr1btoxnJzN2J1dpEpFjHVKrxE2AS1Vpezzu+NPMqACBWvL
         LbxSgf200CyqzmSDh5LSX/SIfmxiHr1qGg7M/YCUCZ9m9Zpa4ka82CmZWQ9pnGiNU8
         WMQgFI2mx/3cVFE7oYUDJoY2ya2ujsshoLysByOliPsoGFBkTqzuEzuX0QyOPCgEB6
         Im2yKGlpJ/gdZAue1++3hdhfz30JDsROqGmOsFGVJIHXTr+P0LNp9l4riA9RC2dNwM
         VJhh7LemjFqew==
Date:   Tue, 27 Jun 2023 11:53:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 10/45] posix-cpu-timers: Use @now instead of @val for
 clarity
Message-ID: <ZJqxpBh3ppSkugd9@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.591764431@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.591764431@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:34PM +0200, Thomas Gleixner wrote:
> posix_cpu_timer_set() uses @val as variable for the current time. That's
> confusing at best.
> 
> Use @now as anywhere else and rewrite the confusing comment about clock
> sampling.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
