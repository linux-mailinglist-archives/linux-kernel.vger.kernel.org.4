Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050A4719C97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjFAMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjFAMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A281AE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC8760C39
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F3C433EF;
        Thu,  1 Jun 2023 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685623927;
        bh=OSttGPTMTa8eu2RYwPPeGmO/hhBRD7zpat45fqZqfsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poDAQh2E60c1msdlPr6bBmG25GxgzX1wv8MvvNmFjzsuu/DJ+lKEx+oKcJYKR+YUn
         oDodCJjKZ46P/Ps20WGOH9/kYcWtuHe9xgFe50lQqAEdk7YvuBDo4uXlfxB5GIJAiV
         vm2SSqXpGFDZ/FZvaJczCgJtglAJw26ZKZfe5aZt0bSJnkoYaWKU0RVZyvCzcFzt21
         heHLEYKGThFR+itkS5SzV3kU1Z91fWmL3cLEXrllmdpqyIzOFw6ceJyZbr2af9DwT8
         gEsgBqRIEbowMiiFiq/nJO5HSWxUzQrGt8T1vedoWct0VbA9deLqsCnZgpOXJei9HX
         pWjWbs3ID2ggg==
Date:   Thu, 1 Jun 2023 14:52:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 17/20] posix-timers: Clarify posix_timer_rearm() comment
Message-ID: <ZHiUdGKcT5qtJvek@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.724863461@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.724863461@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:22PM +0200, Thomas Gleixner wrote:
> Yet another incomprehensible piece of art.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
