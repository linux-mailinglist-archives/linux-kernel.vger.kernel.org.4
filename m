Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF461F248
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKGL7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKGL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:58:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE142707
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:58:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E40C3B8108C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA0AC433C1;
        Mon,  7 Nov 2022 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667822332;
        bh=es4gUOGyq+ZUo41E71jSSSpSseN8tte7NkG9OOIl39U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbOcqPNjwgeMLQimH3QfvwifEPaLYbTGvU199ayK1pN8UwofnTMkxNjelJ4rZar30
         cw3jiaJgq065IwOi0msO6RnkcRHXAqPCk4g3mBVDnZc4Q23eimrNup8N7nUhkD2Qsk
         MBV6qUMLQT7geT7nxW1azgUSID75i+cYNLdIMzaKstQz8sYs0r0u7xe2x542lhaGpO
         7vqKDqnkKM5vusSB+CWXIarLaZGCf/TZ+qHRpEKQskt4K8jzs2Ljhj+aQa9iQyN2wp
         u95cF+xmO4e5KYPDGeO53IjOMn6DI4qgm9mzAGh6SJ+rqcQk3k8SNGd3Sxa7Aorwrp
         M+5IvrpVaB7mg==
Date:   Mon, 7 Nov 2022 12:58:48 +0100
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
        Rik van Riel <riel@surriel.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v4 07/16] timer: Retrieve next expiry of
 pinned/non-pinned timers seperately
Message-ID: <20221107115848.GA4588@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-8-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-8-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:28PM +0100, Anna-Maria Behnsen wrote:
> For the conversion of the NOHZ timer placement to a pull at expiry time
> model it's required to have seperate expiry times for the pinned and the
> non-pinned (movable) timers. Therefore struct timer_events is introduced.
> 
> No functional change
> 
> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
