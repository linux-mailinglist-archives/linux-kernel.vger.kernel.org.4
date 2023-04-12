Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD996DF8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjDLOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE49EDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61920635F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BA4C433EF;
        Wed, 12 Apr 2023 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681310413;
        bh=oS8NoeHwEule3xlB1kNei9Hw+cl492D8IrXobipzFTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3FD+NMHAqQRjdCyAtipxsp9pdEfDJgpNSq9mX3ph1bzlKblEJX5vJkpRb3chuxVZ
         gxBIf1cbb464dTWYK4vM63HpTL6sDzCrvEd5cT9XQP3BwNZKugO0nGVSDrsumOsYz/
         eeqK4i+oDZ1k0V/uJpgNP68BP+r/G7/PPc381QNzMMSs3WWj6d88kVOG2oC+XpQiQD
         gjGTRC75uqCn7iYP6WcPO2Kobg2fvsst48LMstv1B7mrMaDTHHAa6nigSRHdfwmpsD
         WzGL2wmsavyNiPsK1NrRpdsHbbjzGpbGNsLifp6YKEdaghE6zbZOcHi2h+QrUzlEBU
         jqXUQpIITMHLg==
Date:   Wed, 12 Apr 2023 16:40:11 +0200
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
Subject: Re: [PATCH v5 08/18] timers: Create helper function to forward timer
 base clk
Message-ID: <ZDbCy4/k/QCndUD9@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-9-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-9-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:34PM +0100, Anna-Maria Behnsen wrote:
> The logic for forwarding timer base clock is splitted into a separte
> function to make it accessible for other call sites.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
