Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927361F2AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiKGMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiKGMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:13:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB531090
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D931B81097
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A45C433D7;
        Mon,  7 Nov 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667823187;
        bh=jyZp84s/UN3ptagtvk0dIPM/X4vCsI1Emtls0QuZCLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SW5+/0iVzel03zo8a/PS//JMq0g2yRX5wc7bbEzfP18if8PtDyGLqRgzacJKNlFGg
         +6VC/9ZsNDpwQ9pC1o1IpDMv4Km6ZMbDWSc34ZiIJ6DfT4D11cqBsj5s1YOVCzpCGg
         eh3YglcQR1deU3x1gIVLwq47U/MLsl7Z9clA1dJ1aYuoE2ZRmI40k8WjSEI8ZLvmhe
         TQwEvi8pFB+9KVNyZAintZiAHvWAgzIS6XBE6RG0sHMDqSFTyRw3ZB8gtDbiRCyWw9
         yo5PJKmihNCIFjYFB2IOZdAm0mMAuvGBCLOKnm/iQkUpPDWXLPIWhT3xyLIv2L/AtF
         Dx/231GmiH0dQ==
Date:   Mon, 7 Nov 2022 13:13:01 +0100
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
Subject: Re: [PATCH v4 08/16] timer: Rename get_next_timer_interrupt()
Message-ID: <20221107121301.GB4588@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-9-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-9-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:29PM +0100, Anna-Maria Behnsen wrote:
> get_next_timer_interrupt() does more than simply getting the next timer
> interrupt. The timer bases are forwarded and also marked as idle when
> possible and the next timer interrupt information is required for this.

Right but the main role of that function is really to get the next timer
interrupt, the rest is rather about internal details of an API.

So I'm not sure about that change.

Thanks.
