Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780D6DFFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDLUey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDLUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C65FDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7796F62F97
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44938C433EF;
        Wed, 12 Apr 2023 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331677;
        bh=67RceTk9iSwCcam6USVoqFGSwvWQXiSRXpA39LXhjhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TosJA6oZVp3TfIEB52UrA1sxugd9lY1p2zLUYICVLfRcLpyov+zYM3bYiOBm88yU3
         PpoQLyMZR7UJTUYlopLeuWo5EnR27xBLAp9YmeiB/YVRjrqO6otGX99xckpvcOvsBq
         Hip/fis9jyygNuNg8wZZalaVkaXB2d4mNGlCEJnEbIYOrVMXaPMEeZdApSsZUHkdhc
         QfMeUZS4HA10bcxNb2+gN8C/R0e2uHzMUO22KjDIyM+cAxL8+YW4U67XW3XwfxXDZI
         FayDiLnfHj6YJxEKwkpAklJ0DaVm29YiC2JGW03JUg1pW/Kv2Zf8isRFnZDvvwM/SF
         xMgumReH6ykgA==
Date:   Wed, 12 Apr 2023 22:34:34 +0200
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
Subject: Re: [PATCH v5 11/18] timer: Split out "get next timer interrupt"
 functionality
Message-ID: <ZDcV2q2ddKFNdDkE@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-12-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301141744.16063-12-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 01, 2023 at 03:17:37PM +0100, Anna-Maria Behnsen a écrit :
> The functionallity for getting the next timer interrupt in
> get_next_timer_interrupt() is splitted into a separate function
> fetch_next_timer_interrupt() to be usable by other callsides.
> 
> This is preparatory work for the conversion of the NOHZ timer
> placement to a pull at expiry time model. No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
