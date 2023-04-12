Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2C6DF88E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDLOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7557DAC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEF062CDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31CAC4339B;
        Wed, 12 Apr 2023 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681309970;
        bh=cpKWTTzoWnvvks2iof+xY2NBdJSH0J2YI4VLc78O7iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImZNjL+kkFg3r9ZtsmTHJLnBxkjlxW1hw+RcMnS78NMemv81QQwuZrTf9ylfUPofW
         j2pdR4AbA2lWrD+luQAm4blEX9wZWmquOTAEAmdBwsJDjSLzs2UcFJFrko6oAa9x9H
         9A1/ykPolaJ7XmBBb0ib0Iqp7rFcVqDF02Ek78eJi3YFZB7rrJK2MiTEu+NH342Jne
         ygJ+Y4Aj/s/4p1/bJP37KO2O6+LObAAFozMg35MsSipHsagBjiJRmSTeyF2ZlA92lv
         C7IQCG6OdQ3V5X9xj4gUxtvJ4BhA3xyxt3efBa5WtmaqZcsWU14CTxPqT+YG3RvrSY
         gQAyg5yPD+Bhg==
Date:   Wed, 12 Apr 2023 16:32:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 07/18] timers: Ease code in run_local_timers()
Message-ID: <ZDbBD59SVwFFvNag@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-8-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-8-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:33PM +0100, Anna-Maria Behnsen wrote:
> The logic for raising a softirq the way it is implemented right now, is
> readable for two timer bases. When increasing numbers of timer bases, code
> gets harder to read. With the introduction of the timer migration
> hierarchy, there will be three timer bases.
> 
> Therefore ease the code. No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
