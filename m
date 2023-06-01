Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA4719917
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjFAKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjFAKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94463196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D84A641D5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DEC433D2;
        Thu,  1 Jun 2023 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685614380;
        bh=2vV3KsFpQXnvxiJ5ad1PXdDVo19KEWr3yQEP67ZxQXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9INwCh3ER7jkaTap9xXykpN2RyPVLwQYeEva2vNkTL+lvng+AYI/pkM16HkKYe2n
         +mcGVAvkMaqqO8ACzeTRTSQ0MDLREtAZ8tVjQIAlK/+uahYNPgMw3OeZThWKa3W0F5
         Lo4TxJrbwVRskWMhAUua34IpPTFdYWfKIJkEiSMcrVCLHhK7k/ugzZlKzxY/JmJpIg
         jtvPApGcyWmrvDtnBIXjzih8d05G4xQqjfHFRIpIFgbhZINb3wCSFE469kEcqjpFVn
         yizmBzt5D768PYr7VFyqsqRJ+tvy8z2ML5yOhvQRVEsUwsnEUmfpeAe7DM/3JM4TFI
         wj21+e/E7b0rQ==
Date:   Thu, 1 Jun 2023 12:12:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 08/20] posix-timers: Remove pointless irqsafe from
 hash_lock
Message-ID: <ZHhvKdlGdJrNl0sG@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.249063953@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.249063953@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:08PM +0200, Thomas Gleixner wrote:
> All usage of hash_lock is in thread context. No point in using
> spin_lock_irqsave()/irqrestore() for a single usage site.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
