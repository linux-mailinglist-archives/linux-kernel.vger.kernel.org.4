Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8056FC334
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjEIJuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjEIJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F0D9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE41B631FA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD6BC433EF;
        Tue,  9 May 2023 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683625826;
        bh=BHlWS+cPabMXBXgk9ZZcDAXwRhb+MsLz13vT5XOg6yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6faBSeeTcx2tO4FZTsq4m9uOgLYY/RDtvM1RUUaKSDwPM4e0QZUk6bZuBW1hGVuj
         nSebwrcNTSyA2KyiY4HfYPuecbEJxu3DKbGalX6PGTO88DMKAtv1iIkrEpwYrUpBA4
         xGhm2pOEDDEViGTLNjNhipb4Cjv/YwYi6Zz18RLKOqQlG/G7uCjMGReZTXmUMuxh+D
         EvfI01VG/qlcZgU4gytkdhyLUiHF45tsFrZJWeRZtrpogDD8yVqg+tz1G54uvRwIyf
         oW068oz8TJM5NW8eB6Y2leerDCegkqlFT3YPIQEwoxPKoWud4VCH88SPi3D38I9I7P
         IHOjiiio7MYrw==
Date:   Tue, 9 May 2023 11:50:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 03/20] posix-timers: Clarify timer_wait_running() comment
Message-ID: <ZFoXX52bQFCM8s+V@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.985681995@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183312.985681995@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:00PM +0200, Thomas Gleixner wrote:
> Explain it better and add the CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y aspect
> for completeness.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
