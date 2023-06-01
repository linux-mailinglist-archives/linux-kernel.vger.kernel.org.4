Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4747C719A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjFALAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjFALAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7928119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC55164387
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E230CC433EF;
        Thu,  1 Jun 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685617228;
        bh=qOE5heA1T/TKl48MXE5Tyk8QWU1s3FGNzoPVhOrT9do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkrLv1JPOCNmegxh7IRZkoV3jf4P+K1pQTCQK2pVTyGZdFcEs6YyoAmKWH1wpV7v1
         /dA9APS5x07AxHlq96LonbZQDXaM7bvneyGZJfTJwSyfwo9U9d0XxI/0r94pXz0Mfa
         aJHiJXmaPm+nCIuadZM3RzwB5Fw2w1VUZ4KstkSy4xaYO/TDsRcCFdpsDZAyUorhkQ
         ff8FNg+go3+nHwP1Ugwkmynvm0Vq80Vtws9s3slhTG7vOgBrQz9FkwCH0heY4uJexB
         ulgIecIiYG+BwL/V2dEoIfUQCHcThtsolv9DvN28fkfw63XECwwiwTrn+yXrWoPmPt
         eiPUyYbdNFmfg==
Date:   Thu, 1 Jun 2023 13:00:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 11/20] posix-timers: Document common_clock_get() correctly
Message-ID: <ZHh6SMqutEIYBsbj@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.409169321@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.409169321@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:12PM +0200, Thomas Gleixner wrote:
> Replace another confusing and inaccurate set of comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
