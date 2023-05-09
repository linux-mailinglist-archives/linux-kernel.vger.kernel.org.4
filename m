Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D96FC45A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEIK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEIK6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C874497
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D7662373
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E6C433EF;
        Tue,  9 May 2023 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683629891;
        bh=Vxcp+NMoZjIIp7YlhHV3yLafE3IbciOFphZBoEikfKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nwz7p76Qjg+Y20MMqX/G6yfU+9ekEV3bl67VXQNJ1VrvlITlV3pQYc+b0ayfDUC7N
         QSYzTx/hCDaCYSKqti+AyF4o6fgHagWJi2SYqsmvKKodpu2laNNuc9mXaL0p0hHn7P
         EyKUWcZjQJ86ALBdkoq0NCkMPPy9/jRMPDsUz7fTebS3xOIvrKoGyihoSv3i+m+bwD
         9K488wktXmnJk3fz85YR2gkeVaGdDLQ6pz2baOW2vVKBlM5PGusVo9hpwMDR3XP3NO
         8K4WQwcGFgPLmYovGoesw+/MeLYBR+SIfZDRa3DPIizw4vi7QHpkbHtFscZ54AeZiH
         HCWZpdTROafHQ==
Date:   Tue, 9 May 2023 12:58:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 05/20] posix-timers: Add comments about timer lookup
Message-ID: <ZFonQIDHlG1uPTCj@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.091081515@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.091081515@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:03PM +0200, Thomas Gleixner wrote:
> Document how the timer ID validation in the hash table works.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
