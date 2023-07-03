Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44247465D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGCWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGCWvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321DE59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC45B61053
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC3EC433C8;
        Mon,  3 Jul 2023 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688424679;
        bh=DCKujAYbOiZwD6uEb3a8HWGeMVdd3ljCBvs3VofC9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ut/iaMzfJ3SE4n6qwg6O3omjdTsIbIufQfWkJPy8y4FbYPu9lPH2vFI3oDRrZEfR6
         hH/SUh6zI1mIdqMX6Y8oodP1lI+47i5oUG1LUMXX33WKo/DVdwfuf9pX2O8XNYuuuc
         7ZGimlyOdmwLD7yeV2wTwIvs3c/rrUX3AYyhpGFmSle2pnnC3pyGAv6o/21LH6dxFj
         YpZ012yPmstOwNv4LSDS+kDYKWShWVNrzZURdR5ir4jjQtbLfVGUbzUCWIHQF3uJX6
         TPq7C88m/4TEDxjcv7k9ldz4V1aeRd071F/PhnUEHhse28afNSOdfu4tXzZvL1z22G
         yj5vgi088JKfw==
Date:   Tue, 4 Jul 2023 00:51:15 +0200
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
Subject: Re: [patch 18/45] posix-timers: Consolidate signal queueing
Message-ID: <ZKNQ42mlRXC15BpG@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142032.040938859@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142032.040938859@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:47PM +0200, Thomas Gleixner wrote:
> Rename posix_timer_event() to posix_timer_queue_signal() as this is what
> the function is about.
> 
> Consolidate the requeue pending and deactivation updates into that function
> as there is no point in doing this in all incarnations of posix timers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
