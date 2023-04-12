Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3678F6DF3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDLLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDLLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DDC2D55
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFFD62B77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6089C4339B;
        Wed, 12 Apr 2023 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681299132;
        bh=PTKhNcYe1iojcRLZ+LhMt54O2nFlQcnA7Yglg0khFKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hn6sqa8i4a7hwY6fePN3Gj8afXMNY2uDIMg/i04WS7ZrZNxiCGOJ0ZHYxP9P6Fjkr
         QrrzgSx0vKmv3IM/Um1ysohC1obhGOOvaiEhIiFFxuiRLe9p/4rCimOeXqq4Tn4cyF
         OVETto8cBanXhv82C6gDmxHuUlF/TZ77LEDKVZtS1FpWhaU5aG+MixH+A4XADBKQgS
         ILj5am5P4ULOALRztfNPi0a8J6Y/078bBGb5wrrATewTg+M2lvAlkMLs7PM29X946d
         PG8H+cfigyLyoITagWOdHT7lKPZdqLsFGe0RmrxCA8S2cPVttgc7TgU0xIxhIfn12f
         4JMPGl2L433gw==
Date:   Wed, 12 Apr 2023 13:32:08 +0200
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
Subject: Re: [PATCH v5 03/18] timer: Move store of next event into
 __next_timer_interrupt()
Message-ID: <ZDaWuCctfK1rn+Ja@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-4-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301141744.16063-4-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 01, 2023 at 03:17:29PM +0100, Anna-Maria Behnsen a écrit :
> Both call sides of __next_timer_interrupt() store return value directly in
> base->next_expiry. Move the store into __next_timer_interrupt() and to make
> purpose more clear, rename function to next_expiry_recalc().
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Aside Peter's remarks:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
