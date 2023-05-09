Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D646FC357
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEIJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjEIJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A1AD09
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39424632C7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17710C433EF;
        Tue,  9 May 2023 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683626293;
        bh=jrVIqCQ5nGPEsUKslm+7VogNdpTlmSDKlRLxCzOSFl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQBaxbIaX/P3Vm1qlhkv9EAe2CYwWMRsLwnAoGzGeN9k5QJAPO3Vq0yUDqS2aYO58
         lIJc0wDlSxzJhYd/9e5X1i9iCH1gazR/fYOTjBXG9miFyWjD7Y+i8jF1LDN7Z4ib6q
         xCnXrJD8vtvuDdowkZw+dAwBV7QYuRgRFkM2pmp1jM4SiFbI9eBn7Wtpg5MT4Jbv79
         9Z17YvjYrBGC5xQdhHM+BbGbkcEwvuE70fivHtUghVIfbhZ3IL1BA99YRq/ReKPEFg
         SM7LEHDKiUla3Tzy5a4s3R9UheMcJa2xhFcLgt2pvnkTuipdsdyTvu6GDtO6DnVRMi
         pstblTZeF3r3g==
Date:   Tue, 9 May 2023 11:58:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 04/20] posix-timers: Cleanup comments about timer ID
 tracking
Message-ID: <ZFoZMvlDylAkbLox@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.038444551@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.038444551@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:01PM +0200, Thomas Gleixner wrote:
> Describe the hash table properly and remove the IDR leftover comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
