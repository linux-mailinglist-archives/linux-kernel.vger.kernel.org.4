Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF30719A06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjFAKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFAKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E207CD7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B852640C5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74766C433D2;
        Thu,  1 Jun 2023 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685616246;
        bh=5jcSWMWc4SV+na2MsxSB2GyOVnRit4I3ywESDLCzuAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nghb8Z22TRhIm14bGsPadLWrXlSCmA5WCub6FGvBjPnLuPTl5MnPyXm+c+Gy7BQlD
         rWY/S41vqetrsKFkffPB0MxFLdp7wnp/9qnclgsOHKfb13LIJywR5kBRP3ee2Np8nh
         AkEaQGIFLfMeA7nAzqfJDRToo8PUPxF0uamz4qwOB92gN5M13UccGSGcu/P+Gr/zmD
         5BbfPSEJ9GNPWmDgkfG5LdNKVtgUt8kgZkwIe1bD+bl/iXbUv4HFnsV3RGYYQ7W6r9
         6WVGHt24h2ZHDlEoBqRmV/WL/1dVsO/ZpffHCpr9l5UKATb8PCHToyHmbKxdVbJlsn
         HVQXkQesO7yug==
Date:   Thu, 1 Jun 2023 12:44:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [patch 10/20] posix-timers: Document sys_clock_getres() correctly
Message-ID: <ZHh2cwLYb1pH8UBB@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.356427330@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.356427330@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:11PM +0200, Thomas Gleixner wrote:
> +/**
> + * sys_clock_getres - Get the resolution of a clock
> + * @which_clock:	The clock to get the resolution for
> + * @tp:			Pointer to a a user space timespec64 for storage
                                           ^^^
a_a

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
